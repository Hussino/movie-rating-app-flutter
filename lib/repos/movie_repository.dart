import 'package:movies/db/db_helper.dart';
import 'package:movies/home.dart';
import 'package:movies/models/MovieModel.dart';

class MovieRepository
{
  Future<List<MovieModel>> getAll()async{
    try{
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().getAll(DbTables.Movies);
      List<MovieModel> movielist = [];
      if(result != null)
      {
        for(var item in result)
          {
            movielist.add(MovieModel.fromJson(item));
          }
      }
      return movielist;
    }
    catch(e){
      rethrow;
    }
  }
  Future<MovieModel> getByMovieId(int Id)async
  {
    try {
      var result = await DbHelper().getById(DbTables.Movies, Id);
      MovieModel Movie = MovieModel.fromJson(result);
      return Movie;
    }
    catch(e){
      rethrow;
    }
  }

  Future<int> addMovie(Map<String, dynamic>obj)async
  {
    try
    {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().add(DbTables.Movies, obj);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }

  Future<int> editMovie(Map<String, dynamic>obj, id)async
  {
    try
    {
      var result = await DbHelper().update(DbTables.Movies, obj, id);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }

  Future<int> deleteMovie(int Id)async
  {
    try
    {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().delete(DbTables.Movies, Id);
      var resultReview = await DbHelper().delete(DbTables.Reviews, Id, pkName: "movieId");
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }
}