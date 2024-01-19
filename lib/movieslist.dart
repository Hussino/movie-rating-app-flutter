import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies/edit_movie.dart';
import 'package:movies/repos/movie_repository.dart';

import 'delete_movie.dart';
import 'models/MovieModel.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies list"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/addmovie');
        },
        child: Icon(
          Icons.add,

        ),
      ),
      body: Container(
        child: FutureBuilder<List<MovieModel>>(
          future: MovieRepository().getAll(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return Center(child: Text("Error: ${snapshot.error.toString()}"));
              }
              else if(snapshot.hasData){
                var list = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: ()async{
                    setState(() {

                    });
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text("${list[index].name}"),
                          leading: Container(
                            // decoration: BoxDecoration(borderRadius: BorderRadiusdius.circular(20)),

                            // radius: 30,
                            // backgroundColor: Colors.black,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100) ,
                              child: list[index].img!=null?Image.file(File(list[index].img!),

                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/images/wp.jpg', width: 75, height: 75, scale: 0.5,);
                                },):Image.asset('assets/images/wp.jpg'),
                            ) ,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: ()async{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditMovie(movie: list[index]),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              Container(
                                width: 1.0, // Width of the line
                                height: 30.0, // Height of the line
                                color: Colors.grey.shade700, // Color of the line
                              ),
                              IconButton(
                                onPressed: ()async{
                                  var delRes = await showDialog(context: context, builder: (context){
                                    return DeleteMovieView(movieId: list[index].id??0);
                                  });
                                  if(delRes != null && delRes ==true)
                                  {
                                    setState(() {

                                    });
                                  }
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                          subtitle: Text("${list[index].details}"),

                        );
                      },
                      separatorBuilder: (context, index){
                        return Divider();
                      },
                      itemCount: list.length),
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
