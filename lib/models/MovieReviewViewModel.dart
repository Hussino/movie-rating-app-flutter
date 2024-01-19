import 'package:movies/models/MovieModel.dart';
import 'package:movies/models/ReviewModel.dart';

class MovieReviewViewModel{
  MovieModel movie;
  List<ReviewModel> movieReviews;

  MovieReviewViewModel(
    this.movie,
    this.movieReviews
  );
}

MovieModel emptyMovie = MovieModel();

List<ReviewModel> emptyReviews = [];

MovieReviewViewModel emptyExample = MovieReviewViewModel(emptyMovie, emptyReviews);