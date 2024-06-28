import 'package:aziz_bookstore/data/models/book_model.dart';

final BookList books = BookList(
  books: testBooks,
  count: 2,
  previous: "",
  next: "",
);

final List<Book> testBooks = [
  Book(
    id: 1,
    title: "Book 1",
    subjects: ["Subject 1"],
    authors: [Person(name: "Author 1")],
    translators: [],
    bookshelves: ["Bookshelf 1"],
    languages: ["en"],
    copyright: false,
    mediaType: "text",
    formats: Format(
      textHtml: "textHtml",
      applicationEpubZip: "applicationEpubZip",
      applicationMobipocketEbook: "applicationMobipocketEbook",
      applicationRdfXml: "applicationRdfXml",
      imageJpeg: "imageJpeg",
      textPlainCharsetUsAscii: "textPlainCharsetUsAscii",
      applicationOctetStream: "applicationOctetStream",
    ),
    downloadCount: 100,
  ),
  Book(
    id: 2,
    title: "Book 2",
    subjects: ["Subject 2"],
    authors: [Person(name: "Author 2")],
    translators: [],
    bookshelves: ["Bookshelf 2"],
    languages: ["en"],
    copyright: false,
    mediaType: "text",
    formats: Format(
      textHtml: "textHtml",
      applicationEpubZip: "applicationEpubZip",
      applicationMobipocketEbook: "applicationMobipocketEbook",
      applicationRdfXml: "applicationRdfXml",
      imageJpeg: "imageJpeg",
      textPlainCharsetUsAscii: "textPlainCharsetUsAscii",
      applicationOctetStream: "applicationOctetStream",
    ),
    downloadCount: 200,
  ),
];
