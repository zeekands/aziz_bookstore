class Person {
  int? birthYear;
  int? deathYear;
  String name;

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
  Map<String, String> formats;

  Format(this.formats);

  factory Format.fromJson(Map<String, dynamic> json) {
    return Format(
      Map<String, String>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return formats;
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
      id: json['id'],
      title: json['title'],
      subjects: List<String>.from(json['subjects']),
      authors: List<Person>.from(json['authors'].map((e) => Person.fromJson(e))),
      translators: List<Person>.from(json['translators'].map((e) => Person.fromJson(e))),
      bookshelves: List<String>.from(json['bookshelves']),
      languages: List<String>.from(json['languages']),
      copyright: json['copyright'],
      mediaType: json['media_type'],
      formats: Format.fromJson(json['formats']),
      downloadCount: json['download_count'],
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
}
