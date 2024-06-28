import 'package:aziz_bookstore/data/models/book_request_model.dart';

class SeeAllArguments {
  final String? title;
  final BookRequestModel? topic;

  SeeAllArguments({
    required this.title,
    required this.topic,
  });
}
