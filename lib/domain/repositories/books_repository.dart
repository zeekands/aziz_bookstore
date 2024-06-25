import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepository {
  Future<Either<Failure, BookList>> getBooks(BookRequestModel filter);
}
