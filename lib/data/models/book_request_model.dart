class BookRequestModel {
  final int? page;
  final String? sort;
  final String? topic;
  final String? languange;
  final String? search;
  final bool? copyright;
  final String? mimeType;
  final String? authorYearStart;
  final String? authorYearEnd;

  BookRequestModel({
    this.page,
    this.sort,
    this.topic,
    this.languange,
    this.search,
    this.copyright,
    this.mimeType,
    this.authorYearStart,
    this.authorYearEnd,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page ?? 1,
      'sort': sort ?? "",
      'topic': topic ?? "",
      'languanges': languange ?? "",
      'search': search ?? "",
      'author_year_start': authorYearStart ?? "",
      'author_year_end': authorYearEnd ?? "",
    };
  }

  BookRequestModel copyWith({
    int? page,
    String? sort,
    String? topic,
    String? languange,
    String? search,
    bool? copyright,
    String? mimeType,
    String? authorYearStart,
    String? authorYearEnd,
  }) {
    return BookRequestModel(
      page: page ?? this.page,
      sort: sort ?? this.sort,
      topic: topic ?? this.topic,
      languange: languange ?? this.languange,
      search: search ?? this.search,
      authorYearStart: authorYearStart ?? this.authorYearStart,
      authorYearEnd: authorYearEnd ?? this.authorYearEnd,
    );
  }
}
