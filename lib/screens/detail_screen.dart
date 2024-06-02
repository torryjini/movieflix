import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailScreen extends StatefulWidget {
  final String title, posterPath;
  final int id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.posterPath,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.id,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w500/${widget.posterPath}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          floatingActionButton: FutureBuilder(
            future: movie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () async {
                    await launchUrlString(snapshot.data!.homepage);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8D849),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 340,
                    height: 65,
                    child: const Center(
                      child: Text(
                        "Visit Homepage",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF8D849),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 340,
                height: 65,
                child: const Center(
                  child: Text(
                    "Loading Homepage",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: Colors.black.withOpacity(0.3),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: movie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          starRating(snapshot),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "${(snapshot.data!.runtime) ~/ 60}시간 ${(snapshot.data!.runtime) % 60}분 | ",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              for (var genre in snapshot.data!.genres)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    genre["name"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${snapshot.data!.releaseDate.substring(0, 4)}. ${snapshot.data!.releaseDate.substring(5, 7)}. | ",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              snapshot.data!.adult
                                  ? const Text(
                                      "청소년 관람불가",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  : const Text(
                                      "전체이용가",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Storyline",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.overview,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return const Text("none");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row starRating(AsyncSnapshot<MovieDetailModel> snapshot) {
    return Row(
      children: [
        for (var i = 0; i < (snapshot.data!.voteAverage / 2).floor(); i++)
          const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        (snapshot.data!.voteAverage / 2).remainder(1) > 0.5
            ? const Icon(
                Icons.star_half,
                color: Colors.yellow,
                size: 20,
              )
            : Icon(
                Icons.star,
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
        for (var j = 0; j < (5 - (snapshot.data!.voteAverage / 2).ceil()); j++)
          Icon(
            Icons.star,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
        const SizedBox(
          width: 10,
        ),
        Text(
          snapshot.data!.voteAverage.toStringAsFixed(2),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "(${snapshot.data!.voteCount})",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
