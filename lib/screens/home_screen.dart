import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies =
      ApiService.getPopularMovies("popular");
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getPopularMovies("now-playing");
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getPopularMovies("coming-soon");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "MOVIEFLEX",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Color(0xffDE0913),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildMovieList('Popular Movies', popularMovies),
            const SizedBox(
              height: 20,
            ),
            buildMovieList('Now in Cinemas', nowPlayingMovies),
            const SizedBox(
              height: 20,
            ),
            buildMovieList('Coming Soon', comingSoonMovies),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMovieList(String title, Future<List<MovieModel>> movieFuture) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 420, // Set a fixed height for the horizontal ListView
          child: FutureBuilder<List<MovieModel>>(
            future: movieFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No Movies Found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var movie = snapshot.data![index];
                    return Movie(
                      title: movie.title,
                      posterPath: movie.posterPath,
                      id: movie.id,
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
