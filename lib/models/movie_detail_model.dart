class MovieDetailModel {
  final bool adult, video;
  final String backdropPath,
      homepage,
      imdbId,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      status,
      tagline,
      title;
  dynamic belongsToCollection;
  final int budget, id, revenue, runtime, voteCount;
  final List<Map<String, dynamic>> genres,
      productionCompanies,
      productionCountries,
      spokenLanguages;
  final double popularity, voteAverage;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : adult = json["adult"],
        video = json["video"],
        backdropPath = json["backdrop_path"],
        homepage = json["homepage"],
        imdbId = json["imdb_id"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        overview = json["overview"],
        posterPath = json["poster_path"],
        releaseDate = json["release_date"],
        status = json["status"],
        tagline = json["tagline"],
        title = json["title"],
        belongsToCollection = json["belongs_to_collection"],
        budget = json["budget"],
        id = json["id"],
        revenue = json["revenue"],
        runtime = json["runtime"],
        voteCount = json["vote_count"],
        genres = List<Map<String, dynamic>>.from(json["genres"]),
        productionCompanies =
            List<Map<String, dynamic>>.from(json["production_companies"]),
        productionCountries =
            List<Map<String, dynamic>>.from(json["production_countries"]),
        spokenLanguages =
            List<Map<String, dynamic>>.from(json["spoken_languages"]),
        popularity = json["popularity"].toDouble(),
        voteAverage = json["vote_average"].toDouble();
}
