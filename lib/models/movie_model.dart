class MovieModel {
  final bool adult, video;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;
  final double popularity, voteAverage;
  final List genreIds;
  final int id, voteCount;

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json["adult"],
        backdropPath = json["backdrop_path"],
        genreIds = json["genre_ids"],
        id = json["id"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        overview = json["overview"],
        popularity = json["popularity"],
        posterPath = json["poster_path"],
        releaseDate = json["release_date"],
        title = json["title"],
        video = json["video"],
        voteAverage = json["vote_average"],
        voteCount = json["vote_count"];
}
