import 'dart:convert'; // Digunakan untuk konversi JSON

class Person {
  int? birthYear;
  int? deathYear;
  String? name;

  Person({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      birthYear: json['birth_year'],
      deathYear: json['death_year'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'birth_year': birthYear,
      'death_year': deathYear,
      'name': name,
    };
  }

  static Person fromMap(Map<String, dynamic> map) {
    return Person(
      birthYear: map['birth_year'],
      deathYear: map['death_year'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'birth_year': birthYear,
      'death_year': deathYear,
      'name': name,
    };
  }
}

class Format {
  final String textHtml;
  final String applicationEpubZip;
  final String applicationMobipocketEbook;
  final String applicationRdfXml;
  final String imageJpeg;
  final String textPlainCharsetUsAscii;
  final String applicationOctetStream;

  Format({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationMobipocketEbook,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.textPlainCharsetUsAscii,
    required this.applicationOctetStream,
  });

  factory Format.fromJson(Map<String, dynamic> json) {
    return Format(
      textHtml: json['text/html'] ?? '',
      applicationEpubZip: json['application/epub+zip'] ?? '',
      applicationMobipocketEbook: json['application/x-mobipocket-ebook'] ?? '',
      applicationRdfXml: json['application/rdf+xml'] ?? '',
      imageJpeg: json['image/jpeg'] ?? '',
      textPlainCharsetUsAscii: json['text/plain; charset=us-ascii'] ?? '',
      applicationOctetStream: json['application/octet-stream'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text/html': textHtml,
      'application/epub+zip': applicationEpubZip,
      'application/x-mobipocket-ebook': applicationMobipocketEbook,
      'application/rdf+xml': applicationRdfXml,
      'image/jpeg': imageJpeg,
      'text/plain; charset=us-ascii': textPlainCharsetUsAscii,
      'application/octet-stream': applicationOctetStream,
    };
  }

  static Format fromMap(Map<String, dynamic> map) {
    return Format(
      textHtml: map['text_html'] ?? '',
      applicationEpubZip: map['application_epub_zip'] ?? '',
      applicationMobipocketEbook: map['application_mobipocket_ebook'] ?? '',
      applicationRdfXml: map['application_rdf_xml'] ?? '',
      imageJpeg: map['image_jpeg'] ?? '',
      textPlainCharsetUsAscii: map['text_plain_charset_us_ascii'] ?? '',
      applicationOctetStream: map['application_octet_stream'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text_html': textHtml,
      'application_epub_zip': applicationEpubZip,
      'application_mobipocket_ebook': applicationMobipocketEbook,
      'application_rdf_xml': applicationRdfXml,
      'image_jpeg': imageJpeg,
      'text_plain_charset_us_ascii': textPlainCharsetUsAscii,
      'application_octet_stream': applicationOctetStream,
    };
  }
}

class Book {
  int id;
  String title;
  List<String> subjects;
  List<Person> authors;
  List<Person> translators;
  List<String> bookshelves;
  List<String> languages;
  bool? copyright;
  String mediaType;
  Format formats;
  int downloadCount;

  Book({
    required this.id,
    required this.title,
    required this.subjects,
    required this.authors,
    required this.translators,
    required this.bookshelves,
    required this.languages,
    this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subjects: json['subjects'] != null ? List<String>.from(json['subjects']) : [],
      authors: json['authors'] != null ? List<Person>.from((json['authors']).map((e) => Person.fromJson(e))) : [],
      translators:
          json['translators'] != null ? List<Person>.from(json['translators'].map((e) => Person.fromJson(e))) : [],
      bookshelves: json['bookshelves'] != null ? List<String>.from(json['bookshelves']) : [],
      languages: json['languages'] != null ? List<String>.from(json['languages']) : [],
      copyright: json['copyright'] ?? false,
      mediaType: json['media_type'] ?? '',
      formats: json['formats'] != null
          ? Format.fromJson(json['formats'])
          : Format(
              textHtml: '',
              applicationEpubZip: '',
              applicationMobipocketEbook: '',
              applicationRdfXml: '',
              imageJpeg: '',
              textPlainCharsetUsAscii: '',
              applicationOctetStream: '',
            ),
      downloadCount: json['download_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subjects': subjects,
      'authors': authors.map((e) => e.toJson()).toList(),
      'translators': translators.map((e) => e.toJson()).toList(),
      'bookshelves': bookshelves,
      'languages': languages,
      'copyright': copyright,
      'media_type': mediaType,
      'formats': formats.toJson(),
      'download_count': downloadCount,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      subjects: jsonDecode(map['subjects']).cast<String>(),
      authors: (jsonDecode(map['authors']) as List).map((i) => Person.fromMap(i)).toList(),
      translators: (jsonDecode(map['translators']) as List).map((i) => Person.fromMap(i)).toList(),
      bookshelves: jsonDecode(map['bookshelves']).cast<String>(),
      languages: jsonDecode(map['languages']).cast<String>(),
      copyright: map['copyright'] == 1,
      mediaType: map['media_type'],
      formats: Format.fromMap(jsonDecode(map['formats'])),
      downloadCount: map['download_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subjects': jsonEncode(subjects),
      'authors': jsonEncode(authors.map((e) => e.toMap()).toList()),
      'translators': jsonEncode(translators.map((e) => e.toMap()).toList()),
      'bookshelves': jsonEncode(bookshelves),
      'languages': jsonEncode(languages),
      'copyright': copyright == true ? 1 : 0,
      'media_type': mediaType,
      'formats': jsonEncode(formats.toMap()),
      'download_count': downloadCount,
    };
  }
}

class BookList {
  List<Book> books;
  int count;
  String? next;
  String? previous;

  BookList({required this.books, required this.count, this.next, this.previous});

  factory BookList.fromJson(Map<String, dynamic> json) {
    return BookList(
      books: List<Book>.from(json['results'].map((e) => Book.fromJson(e))),
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'books': books.map((book) => book.toJson()).toList(),
      'count': count,
      'next': next,
      'previous': previous,
    };
  }

  static BookList fromMap(Map<String, dynamic> map) {
    return BookList(
      books: List<Book>.from((jsonDecode(map['books']) as List).map((e) => Book.fromMap(e))),
      count: map['count'],
      next: map['next'],
      previous: map['previous'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'books': jsonEncode(books.map((book) => book.toMap()).toList()),
      'count': count,
      'next': next,
      'previous': previous,
    };
  }
}
