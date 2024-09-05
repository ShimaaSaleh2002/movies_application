/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

TopRatedMoviesResponse topRatedMoviesResponseFromJson(String str) => TopRatedMoviesResponse.fromJson(json.decode(str));

String topRatedMoviesResponseToJson(TopRatedMoviesResponse data) => json.encode(data.toJson());

class TopRatedMoviesResponse {
    TopRatedMoviesResponse({
        required this.page,
        required this.totalPages,
        required this.results,
        required this.totalResults,
    });

    int page;
    int totalPages;
    List<Result> results;
    int totalResults;

    factory TopRatedMoviesResponse.fromJson(Map<dynamic, dynamic> json) => TopRatedMoviesResponse(
        page: json["page"],
        totalPages: json["total_pages"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["total_results"],
    );

    Map<dynamic, dynamic> toJson() => {
        "page": page,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_results": totalResults,
    };
}

class Result {
    Result({
        required this.overview,
        required this.originalLanguage,
        required this.originalTitle,
        required this.video,
        required this.title,
        required this.genreIds,
        required this.posterPath,
        required this.backdropPath,
        required this.releaseDate,
        required this.popularity,
        required this.voteAverage,
        required this.id,
        required this.adult,
        required this.voteCount,
    });

    String overview;
    String originalLanguage;
    String originalTitle;
    bool video;
    String title;
    List<int> genreIds;
    String posterPath;
    String backdropPath;
    DateTime releaseDate;
    double popularity;
    double voteAverage;
    int id;
    bool adult;
    int voteCount;

    factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
        overview: json["overview"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        video: json["video"],
        title: json["title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        popularity: json["popularity"]?.toDouble(),
        voteAverage: json["vote_average"]?.toDouble(),
        id: json["id"],
        adult: json["adult"],
        voteCount: json["vote_count"],
    );

    Map<dynamic, dynamic> toJson() => {
        "overview": overview,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "video": video,
        "title": title,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "popularity": popularity,
        "vote_average": voteAverage,
        "id": id,
        "adult": adult,
        "vote_count": voteCount,
    };
}
