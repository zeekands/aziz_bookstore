import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class ErrorHandling {
  static Either<Failure, T> handleException<T>(exception) {
    if (exception is ServerException) {
      return const Left(ServerFailure('Server Failure', 500));
    } else if (exception is SocketException) {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } else if (exception is HttpException) {
      return const Left(ServerFailure('Http Exception', 500));
    } else if (exception is FormatException) {
      return const Left(ServerFailure('Format Exception', 500));
    } else if (exception is DioException) {
      return Left(
        ServerFailure(
          exception.response?.data['message'] ?? exception.message ?? 'Unknown Dio Exception',
          exception.response?.statusCode ?? 500,
        ),
      );
    } else {
      return Left(ServerFailure(exception.toString(), 500));
    }
  }
}
