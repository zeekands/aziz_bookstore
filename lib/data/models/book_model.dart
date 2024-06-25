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
      authors: json['authors'] != null ? List<Person>.from(json['authors'].map((e) => Person.fromJson(e))) : [],
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
}
