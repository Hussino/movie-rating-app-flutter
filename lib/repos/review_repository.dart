

import 'package:movies/models/ReviewModel.dart';
import 'package:movies/models/MovieReviewViewModel.dart';
import 'package:movies/repos/movie_repository.dart';

import '../db/db_helper.dart';

class ReviewRepository {
  Future<int> addReview(Map<String, dynamic>obj)async
  {
    try
    {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().add(DbTables.Reviews, obj);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }
  Future<List<ReviewModel>> getAllReviews(int movieId)async
  {
    try{
      var result = await DbHelper().getAll(DbTables.Reviews);
      List<ReviewModel> reviewlist = [];
      if(result != null)
        {
          for(var item in result)
            {
              reviewlist.add(ReviewModel.fromJson(item));
            }
        }
      return reviewlist;
    }
    catch(e){
      rethrow;
    }
  }
  Future<MovieReviewViewModel> getMovieReview(int movieId)async
  {
    try{
      var movie = await MovieRepository().getByMovieId(movieId);
      //List<ReviewModel> reviews = await getAllReviews(movieId);
      var reviews = await DbHelper().getListById(DbTables.Reviews, movieId, pkName: 'movieId');
      // List<ReviewModel> filteredReviews =
      // reviews.where((review) => review.movieId == movieId).toList();
      MovieReviewViewModel MovieAndReviews= emptyExample ;
      if(MovieAndReviews.movieReviews.isNotEmpty)
        MovieAndReviews.movieReviews = [];
      if(movie != null && reviews !=null)
        {
          MovieAndReviews.movie = movie;
          for(var item in reviews)
            {
              MovieAndReviews.movieReviews.add(ReviewModel.fromJson(item));
            }
        }
      return MovieAndReviews;
    }
    catch(e){
      rethrow;
    }
  }

  Future<int> deleteReview(int Id)async
  {
    try
    {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().delete(DbTables.Reviews, Id);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }
}