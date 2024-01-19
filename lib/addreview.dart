import 'package:flutter/material.dart';
import 'package:movies/movie.dart';
import 'package:movies/repos/review_repository.dart';

class AddReview extends StatefulWidget {
  final int movieId;

  AddReview({required this.movieId});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  String success = "";
  int selectedValue = 10;
  var reviewerNameCont = TextEditingController();
  var reviewCont = TextEditingController();
  var scoreCont = TextEditingController();
  var moveIdConfCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Review"),
        backgroundColor: Colors.red.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.1),
                    TextFormField(
                      controller: reviewerNameCont,
                      decoration: InputDecoration(
                        labelText: 'Reviewer Outlet',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter the Reviewer Name!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    TextFormField(
                      controller: reviewCont,
                      decoration: InputDecoration(
                        labelText: 'Review',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter the movie review!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Movie Rating (out of 10)",
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                            DropdownButton<int>(
                                value: selectedValue,
                                onChanged: (int? newValue){
                                  setState(() {
                                    selectedValue = newValue!.toInt();
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                      child: Text('1'),
                                      value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text('2'),
                                      value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('3'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('4'),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('5'),
                                    value: 5,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('6'),
                                    value: 6,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('7'),
                                    value: 7,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('8'),
                                    value: 8,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('9'),
                                    value: 9,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('10'),
                                    value: 10,
                                  ),
                                ]
                                ),
                          ],
                        ),
                        SizedBox(width: MediaQuery.of(context).size.height*0.16),
                        //SizedBox(height: MediaQuery.of(context).size.height*0.075),
                        loading?CircularProgressIndicator() : ElevatedButton(
                          onPressed: ()async {
                            if(formKey.currentState!.validate()){
                              try
                              {
                                setState(() {
                                  loading = true;
                                  isSuccess = false;
                                  isError = false;
                                });
                                var data = {
                                  "ReviewerName": reviewerNameCont.text,
                                  "Review": reviewCont.text,
                                  "Score": selectedValue,
                                  "movieId": widget.movieId,
                                };

                                var addRes = await ReviewRepository().addReview(data);
                                if(addRes>0){
                                  setState(() {
                                    loading = false;
                                    isSuccess = true;
                                    isError = false;
                                    error = "";
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieScore(movieId: widget.movieId),
                                      ),
                                    );
                                  });
                                }
                                else{
                                  setState(() {
                                    loading = false;
                                    isSuccess = false;
                                    isError = true;
                                    error = "Addition failed";
                                  });
                                }
                              }
                              catch(e)
                              {
                                setState(() {
                                  loading = false;
                                  isSuccess = false;
                                  isError = true;
                                  error = "Exp: ${e.toString()}";
                                });
                              }
                            }
                            else
                            {

                            }

                          },

                          // },
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(fixedSize: const Size(100,40)),

                        ),
                      ],
                    ),
                    isError? Text('Error: $error', style:TextStyle(color: Colors.red),):SizedBox(),
                    isSuccess? Text('Successfully Added!', style:TextStyle(color: Colors.green),):SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


