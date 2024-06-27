// import 'package:equatable/equatable.dart';

// class Person extends Equatable {
//   final int? birthYear;
//   final int? deathYear;
//   final String? name;

//   const Person({
//     required this.name,
//     this.birthYear,
//     this.deathYear,
//   });

//   factory Person.fromJson(Map<String, dynamic> json) {
//     return Person(
//       birthYear: json['birth_year'],
//       deathYear: json['death_year'],
//       name: json['name'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'birth_year': birthYear,
//       'death_year': deathYear,
//       'name': name,
//     };
//   }

//   factory Person.fromMap(Map<String, dynamic> map) {
//     return Person(
//       birthYear: map['birth_year'],
//       deathYear: map['death_year'],
//       name: map['name'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'birth_year': birthYear,
//       'death_year': deathYear,
//       'name': name,
//     };
//   }

//   @override
//   List<Object?> get props => [birthYear, deathYear, name];
// }

// class Format extends Equatable {
//   final String textHtml;
//   final String applicationEpubZip;
//   final String applicationMobipocketEbook;
//   final String applicationRdfXml;
//   final String imageJpeg;
//   final String textPlainCharsetUsAscii;
//   final String applicationOctetStream;

//   const Format({
//     required this.textHtml,
//     required this.applicationEpubZip,
//     required this.applicationMobipocketEbook,
//     required this.applicationRdfXml,
//     required this.imageJpeg,
//     required this.textPlainCharsetUsAscii,
//     required this.applicationOctetStream,
//   });

//   factory Format.fromJson(Map<String, dynamic> json) {
//     return Format(
//       textHtml: json['text/html'] ?? '',
//       applicationEpubZip: json['application/epub+zip'] ?? '',
//       applicationMobipocketEbook: json['application/x-mobipocket-ebook'] ?? '',
//       applicationRdfXml: json['application/rdf+xml'] ?? '',
//       imageJpeg: json['image/jpeg'] ?? '',
//       textPlainCharsetUsAscii: json['text/plain; charset=us-ascii'] ?? '',
//       applicationOctetStream: json['application/octet-stream'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'text/html': textHtml,
//       'application/epub+zip': applicationEpubZip,
//       'application/x-mobipocket-ebook': applicationMobipocketEbook,
//       'application/rdf+xml': applicationRdfXml,
//       'image/jpeg': imageJpeg,
//       'text/plain; charset=us-ascii': textPlainCharsetUsAscii,
//       'application/octet-stream': applicationOctetStream,
//     };
//   }

//   factory Format.fromMap(Map<String, dynamic> map) {
//     return Format(
//       textHtml: map['text_html'] ?? '',
//       applicationEpubZip: map['application_epub_zip'] ?? '',
//       applicationMobipocketEbook: map['application_mobipocket_ebook'] ?? '',
//       applicationRdfXml: map['application_rdf_xml'] ?? '',
//       imageJpeg: map['image_jpeg'] ?? '',
//       textPlainCharsetUsAscii: map['text_plain_charset_us_ascii'] ?? '',
//       applicationOctetStream: map['application_octet_stream'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'text_html': textHtml,
//       'application_epub_zip': applicationEpubZip,
//       'application_mobipocket_ebook': applicationMobipocketEbook,
//       'application_rdf_xml': applicationRdfXml,
//       'image_jpeg': imageJpeg,
//       'text_plain_charset_us_ascii': textPlainCharsetUsAscii,
//       'application_octet_stream': applicationOctetStream,
//     };
//   }

//   @override
//   List<Object?> get props => [
//         textHtml,
//         applicationEpubZip,
//         applicationMobipocketEbook,
//         applicationRdfXml,
//         imageJpeg,
//         textPlainCharsetUsAscii,
//         applicationOctetStream,
//       ];
// }

// class Book extends Equatable {
//   final int id;
//   final String title;
//   final List<String> subjects;
//   final List<Person> authors;
//   final List<Person> translators;
//   final List<String> bookshelves;
//   final List<String> languages;
//   final bool? copyright;
//   final String mediaType;
//   final Format formats;
//   final int downloadCount;

//   const Book({
//     required this.id,
//     required this.title,
//     required this.subjects,
//     required this.authors,
//     required this.translators,
//     required this.bookshelves,
//     required this.languages,
//     this.copyright,
//     required this.mediaType,
//     required this.formats,
//     required this.downloadCount,
//   });

//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       id: json['id'] ?? 0,
//       title: json['title'] ?? '',
//       subjects: json['subjects'] != null ? List<String>.from(json['subjects']) : [],
//       authors: json['authors'] != null ? List<Person>.from((json['authors']).map((e) => Person.fromJson(e))) : [],
//       translators:
//           json['translators'] != null ? List<Person>.from(json['translators'].map((e) => Person.fromJson(e))) : [],
//       bookshelves: json['bookshelves'] != null ? List<String>.from(json['bookshelves']) : [],
//       languages: json['languages'] != null ? List<String>.from(json['languages']) : [],
//       copyright: json['copyright'] ?? false,
//       mediaType: json['media_type'] ?? '',
//       formats: json['formats'] != null
//           ? Format.fromJson(json['formats'])
//           : const Format(
//               textHtml: '',
//               applicationEpubZip: '',
//               applicationMobipocketEbook: '',
//               applicationRdfXml: '',
//               imageJpeg: '',
//               textPlainCharsetUsAscii: '',
//               applicationOctetStream: '',
//             ),
//       downloadCount: json['download_count'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'subjects': subjects,
//       'authors': authors.map((e) => e.toJson()).toList(),
//       'translators': translators.map((e) => e.toJson()).toList(),
//       'bookshelves': bookshelves,
//       'languages': languages,
//       'copyright': copyright,
//       'media_type': mediaType,
//       'formats': formats.toJson(),
//       'download_count': downloadCount,
//     };
//   }

//   factory Book.fromMap(Map<String, dynamic> map) {
//     return Book(
//       id: map['id'] ?? 0,
//       title: map['title'] ?? '',
//       subjects: map['subjects'] != null ? List<String>.from(map['subjects'].split(',')) : [],
//       authors: map['authors'] != null ? List<Person>.from((map['authors']).map((e) => Person.fromMap(e))) : [],
//       translators:
//           map['translators'] != null ? List<Person>.from(map['translators'].map((e) => Person.fromMap(e))) : [],
//       bookshelves: map['bookshelves'] != null ? List<String>.from(map['bookshelves'].split(',')) : [],
//       languages: map['languages'] != null ? List<String>.from(map['languages'].split(',')) : [],
//       copyright: map['copyright'] == 1,
//       mediaType: map['media_type'] ?? '',
//       formats: map['formats'] != null
//           ? Format.fromMap(map['formats'])
//           : const Format(
//               textHtml: '',
//               applicationEpubZip: '',
//               applicationMobipocketEbook: '',
//               applicationRdfXml: '',
//               imageJpeg: '',
//               textPlainCharsetUsAscii: '',
//               applicationOctetStream: '',
//             ),
//       downloadCount: map['download_count'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'subjects': subjects.join(','),
//       'authors': authors.map((e) => e.toMap()).toList(),
//       'translators': translators.map((e) => e.toMap()).toList(),
//       'bookshelves': bookshelves.join(','),
//       'languages': languages.join(','),
//       'copyright': copyright != null ? (copyright! ? 1 : 0) : 0,
//       'media_type': mediaType,
//       'formats': formats.toMap(),
//       'download_count': downloadCount,
//     };
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         subjects,
//         authors,
//         translators,
//         bookshelves,
//         languages,
//         copyright,
//         mediaType,
//         formats,
//         downloadCount,
//       ];
// }

// class BookList extends Equatable {
//   final List<Book> books;
//   final int count;
//   final String? next;
//   final String? previous;

//   const BookList({
//     required this.books,
//     required this.count,
//     this.next,
//     this.previous,
//   });

//   factory BookList.fromJson(Map<String, dynamic> json) {
//     return BookList(
//       books: List<Book>.from(json['results'].map((e) => Book.fromJson(e))),
//       count: json['count'],
//       next: json['next'],
//       previous: json['previous'],
//     );
//   }

//   @override
//   List<Object?> get props => [books, count, next, previous];
// }
