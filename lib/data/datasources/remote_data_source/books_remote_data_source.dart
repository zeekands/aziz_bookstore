import 'package:aziz_bookstore/core/services/network_service.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';

abstract class BooksRemoteDataSource {
  Future<BookList> getBooks(BookRequestModel filter);
}

class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  @override
  Future<BookList> getBooks(BookRequestModel filter) async {
    final response = await httpService.dio.get('/books', queryParameters: filter.toJson());
    if (response.statusCode == 200) {
      return BookList.fromJson(response.data);
    } else {
      throw Exception('Failed to load books');
    }
  }
}
