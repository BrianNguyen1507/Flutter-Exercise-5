class Movie {
  final String title, year, imdbID, poster;
  final String type;

  Movie(
      {required this.title,
      required this.year,
      required this.imdbID,
      required this.type,
      required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["Title"],
      year: json["Year"],
      imdbID: json["imdbID"],
      type: json["Type"],
      poster: json["Poster"],
    );
  }
}
