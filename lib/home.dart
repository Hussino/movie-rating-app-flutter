import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/models/MovieModel.dart';
import 'package:movies/movie.dart';
import 'package:movies/profile.dart';
import 'package:movies/repos/movie_repository.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text("Home Page"),
        centerTitle: false,
      ),
      drawer: MovieDrawer(),
      body: FutureBuilder<List<MovieModel>>(
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
                  var list2 = snapshot.data ?? [];
                  var list3 = list2;
                  list3.shuffle();
                  for(var Id in list)
                    print("the id of this is: ${Id.id}");
                  return RefreshIndicator(
                      onRefresh: ()async{
                        setState(() {

                        });
                      },
                    child: ListView.builder(
                        itemBuilder: (context, index){
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/theater2.JPG'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                            MoviesPage(
                                title: 'Latest Movies',

                                movies: list.map((list) {
                                  return Movie(
                                    Id: list.id!,
                                    imageUrl: list.img?? "",
                                    title: list.name?? "",
                                  );
                                }).toList(),
                            ),
                            SizedBox(height: 20.0),
                            MoviesPage(
                                title: 'Popular Movies',
                                movies: list2.reversed.map((list2) {
                                  return Movie(
                                    Id: list2.id!,
                                    imageUrl: list2.img?? "",
                                    title: list2.name?? "",
                                  );
                                }).toList(),
                            ),
                            SizedBox(height: 20.0),
                            MoviesPage(
                              title: 'Top Rated Movies',
                              movies: list3.map((list3) {
                                return Movie(
                                  Id: list3.id!,
                                  imageUrl: list3.img?? "",
                                  title: list3.name?? "",
                                );
                              }).toList(),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,)
                          ],
                        );
                    },
                      itemCount: 1,
                    )
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
          ),
    );
  }
}

class MoviesPage extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MoviesPage({
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movies.map((movie) {
              return MovieCard(
                Id: movie.Id,
                imageUrl: movie.imageUrl,
                title: movie.title,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int Id;

  const MovieCard({
    required this.imageUrl,
    required this.title,
    required this.Id
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieScore(movieId: Id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl!=null?Image.file(File(imageUrl!),
                height: 150,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/wp.jpg', height: 150, width: 100,);
                },):Image.asset('assets/images/wp.jpg'),
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final int Id;
  final String imageUrl;
  final String title;

  const Movie({
    required this.Id,
    required this.imageUrl,
    required this.title,
  });
}


