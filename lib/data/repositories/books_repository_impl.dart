import 'package:aziz_bookstore/core/error/exception.dart';
import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/datasources/remote_data_source/books_remote_data_source.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class BooksRepositoryImpl implements BooksRepository {
  final BooksRemoteDataSource _booksDataSource;

  BooksRepositoryImpl(this._booksDataSource);

  @override
  Future<Either<Failure, BookList>> getBooks(BookRequestModel filter) async {
    try {
      final books = await _booksDataSource.getBooks(filter);
      return Right(books);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }
}
