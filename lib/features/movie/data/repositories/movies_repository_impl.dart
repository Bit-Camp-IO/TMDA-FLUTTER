import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmda/core/error/exception.dart';
import 'package:tmda/core/error/failure.dart';
import 'package:tmda/core/util/data_source/local_data_source.dart';
import 'package:tmda/features/movie/data/datasources/movies_data_source.dart';
import 'package:tmda/features/movie/data/models/movie/movies_model.dart';
import 'package:tmda/features/movie/data/models/movie_details/movie_account_states_model.dart';
import 'package:tmda/features/movie/data/models/movie_details/movie_cast_model.dart';
import 'package:tmda/features/movie/data/models/movie_details/movie_review_model.dart';
import 'package:tmda/features/movie/domain/entities/movie_details/movie_details.dart';
import 'package:tmda/features/movie/domain/repositories/movies_repository.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource moviesDataSource;
  final LocalDataSource localDataSource;
  MoviesRepositoryImpl({
    required this.moviesDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<MoviesModel>>> getNowPlayingMovies() async {
    try {
      final result = await moviesDataSource.getNowPlayingMovies();
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, List<MoviesModel>>> getPopularMovies(
      int pageNumber) async {
    try {
      final result = await moviesDataSource.getPopularMovies(pageNumber);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, List<MoviesModel>>> getTopRatedMovies(
      int pageNumber) async {
    try {
      final result = await moviesDataSource.getTopRatedMovies(pageNumber);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, List<MoviesModel>>> getNewMovies(
      int pageNumber) async {
    try {
      final result = await moviesDataSource.getNewMovies(pageNumber);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      {required int movieId, required String sessionId}) async {
    try {
      final result = await moviesDataSource.getMovieDetails(
          movieId: movieId, sessionId: sessionId);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<String> getSessionKey() async {
      return await localDataSource.retrieveSessionId();
  }

  @override
  Future<Either<Failure, List<MovieCastModel>>> getMovieCast(int movieId) async {
    try {
      final result = await moviesDataSource.getMovieCast(movieId);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, List<MovieReviewsModel>>> getMovieReviews(
      int movieId) async {
    try {
      final result = await moviesDataSource.getMovieReviews(movieId);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, List<MoviesModel>>> getMoviesLikeThis(
      {required int movieId, required int pageNumber}) async {
    try {
      final result = await moviesDataSource.getMoviesLikeThis(
          movieId: movieId, pageNumber: pageNumber);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, void>> playMovieVideo(String movieVideoKey) async {
    try {
      final result = await moviesDataSource.playMovieVideo(movieVideoKey);
      return right(result);
    } on LaunchUrlException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }

  @override
  Future<Either<Failure, MovieAccountStatesModel>> addOrRemoveMovieFromWatchList({
    required int movieId,
    required bool isInWatchList,
    required String sessionId,
  }) async {
    try {
      final result = await moviesDataSource.addOrRemoveMovieFromWatchList(
          movieId: movieId, isInWatchList: isInWatchList, sessionId: sessionId);
      return right(result);
    } on ServerException catch (exception) {
      return left(
        Failure(exception.message!),
      );
    }
  }
}
