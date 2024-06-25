import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetListBookUsecae {
  final BooksRepository _bookRepository;

  GetListBookUsecae(this._bookRepository);

  Future<Either<Failure, BookList>> execute(BookRequestModel filter) async {
    return await _bookRepository.getBooks(filter);
  }
}
