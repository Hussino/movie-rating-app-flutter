import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies/addreview.dart';
import 'package:movies/models/MovieModel.dart';
import 'package:movies/models/MovieReviewViewModel.dart';
import 'package:movies/profile.dart';
import 'package:movies/repos/movie_repository.dart';
import 'package:movies/repos/review_repository.dart';

import 'delete_review.dart';
import 'models/ReviewModel.dart';

class MovieScore extends StatefulWidget {
  //const MovieScore({Key? key}) : super(key: key);
  final int movieId;
  MovieScore({required this.movieId});



  @override
  State<MovieScore> createState() => _MovieScoreState();
}

class _MovieScoreState extends State<MovieScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      drawer: MovieDrawer(),
      body: FutureBuilder<MovieReviewViewModel>(
        future: ReviewRepository().getMovieReview(widget.movieId),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.connectionState == ConnectionState.done)
            {
              if(snapshot.hasData)
                {
                  print("tha length is ${snapshot.data?.movieReviews.length} and the name and ID is: ${snapshot.data?.movie.name}, and ${snapshot.data?.movie.id}");
                   MovieReviewViewModel? movieData = snapshot.data;
                   //List<ReviewModel> filteredReviews = [];
                   int reviewCounter=0;
                   int scoresTotal = 0;
                   int finalScore = 0;
                   double boxWidth = 60;
                   var scoreColor = Colors.grey.shade500;
                   String badge;
                   //filteredReviews = [];
                     for (var item in movieData!.movieReviews) {
                       if (item.movieId == widget.movieId) {
                         scoresTotal += item.score!.toInt();
                         reviewCounter++;
                       }
                     }
                     print("Review Counter and Total Scores is: ${reviewCounter} and ${scoresTotal}");
                     finalScore = reviewCounter==0? 0 : ((scoresTotal * 10) / reviewCounter).floor();
                     boxWidth = finalScore==100? 90 : 65.0;
                   if(finalScore >= 75)
                     {
                       scoreColor = Colors.green.shade500;
                       badge = "Universal acclaim";
                     }
                   else if(finalScore <75 && finalScore >= 50)
                     {
                       scoreColor = Colors.yellow.shade600;
                       badge = "Mostly Positive";
                     }
                   else if(finalScore <50 && finalScore >=1)
                   {
                     scoreColor = Colors.red.shade500;
                     badge = "Mostly Negative";
                   }
                   else
                     {
                       scoreColor = Colors.grey;
                       badge = "No reviews yet";
                     }
                   //movieData.movieReviews = filteredReviews;
                   for(var item in movieData!.movieReviews){
                     print(item.reviewerName);
                   }
                  return RefreshIndicator(
                    onRefresh: ()async {
                        setState(() {
                          movieData.movieReviews = [];
                          //filteredReviews = [];
                          scoresTotal = 0;
                          reviewCounter = 0;
                        });
                      },
                    child: SingleChildScrollView(
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.03),
                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: movieData.movie.img!=null?Image.file(File(movieData.movie.img!,),

                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset('assets/images/wp.jpg', height: 200,);
                                    },):Image.asset('assets/images/wp.jpg'),
                                ),
                              ) ,
                              SizedBox(height: MediaQuery.of(context).size.height*0.02),
                              Text(
                                '${movieData?.movie.name}',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: boxWidth,
                                    decoration: BoxDecoration(
                                      color: scoreColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${finalScore}', // Replace with the actual aggregate score
                                      style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        '${badge}',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        'From ${reviewCounter} Reviews',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: MediaQuery.of(context).size.width*0.92,
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "Synopsis",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(

                                width: MediaQuery.of(context).size.width*0.95,
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Text("${movieData.movie.details}SynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsisSynopsis")
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                              Container(
                                width: MediaQuery.of(context).size.width*0.95,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.red,
                                              width: 2
                                          ),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      backgroundColor: Colors.white

                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddReview(movieId: widget.movieId),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add Review",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.red
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                      Icon(
                                        Icons.add,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Review Roundup:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: MediaQuery.of(context).size.height*0.38,
                                child: ReviewRoundup(reviews: movieData.movieReviews),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.01)
                            ],
                          ),
                        ),
                    ),
                  );
                }
              else{
                return Center(child: CircularProgressIndicator());
              }
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


class ReviewRoundup extends StatefulWidget {
  final List<ReviewModel> reviews;

  const ReviewRoundup({
   required this.reviews,
});

  @override
  State<ReviewRoundup> createState() => _ReviewRoundupState();
}

class _ReviewRoundupState extends State<ReviewRoundup> {
  @override

  Widget build(BuildContext context) {
    return ListView(
      children: widget.reviews.map((review){
        return ListTile(
          title: Row(
            children: [
              Text(
                '${review.reviewerName} - ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(4),
                alignment: Alignment.center,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '${review.score}', // Replace with the actual aggregate score
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          subtitle: Text('${review.review}'),
          trailing: IconButton(
            onPressed: ()async{
              var delRes = await showDialog(context: context, builder: (context){
                return DeleteReviewView(reviewId: review.id??0);
              });
              if(delRes != null && delRes ==true)
              {
                setState(() {

                });
              }
            },
            icon: Icon(Icons.delete),
          ),
        );
      }).toList(),
    );
  }
}

