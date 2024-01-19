import 'package:flutter/material.dart';
import 'package:movies/repos/review_repository.dart';

class DeleteReviewView extends StatefulWidget {
  DeleteReviewView({Key? key, required this.reviewId}) : super(key: key);
  final int reviewId;
  @override
  State<DeleteReviewView> createState() => _DeleteReviewViewState();
}

class _DeleteReviewViewState extends State<DeleteReviewView> {
  String text = "Are you sure you want to delete this review?";
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  String success = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
          Icons.warning_amber_outlined,
        size: 60,
        color: Colors.red,
      ),
      content: Container(
        constraints: BoxConstraints(
          maxWidth: 300,
          minWidth: 150,
          maxHeight: 250,
          minHeight: 75,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            loading?CircularProgressIndicator() : Text("$text"),
            isError? Text('Error: $error', style:TextStyle(color: Colors.red),):SizedBox(),
            //isSuccess? Text('Successfully Registered!', style:TextStyle(color: Colors.green),):SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: ()async{
                  try
                  {
                    setState(() {
                      loading = true;
                      isSuccess = false;
                      isError = false;
                    });

                    var addRes = await ReviewRepository().deleteReview(widget.reviewId);
                    if(addRes>0){
                      setState(() {
                        loading = false;
                        isSuccess = true;
                        isError = false;
                        error = "";
                        text = "Review deleted";
                      });
                      Navigator.of(context).pop(true);
                    }
                    else{
                      setState(() {
                        loading = false;
                        isSuccess = false;
                        isError = true;
                        error = "Deletion failed";
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
                }, child: Row(
                  children: [
                    Icon(Icons.check_circle_outline_outlined),
                    SizedBox(width: 5),
                    Text("Yes"),
                  ],
                )),
                SizedBox(width: MediaQuery.of(context).size.width*0.25),
                TextButton(onPressed: (){
                  Navigator.of(context).pop(false);
                }, child: Row(
                  children: [
                    Icon(Icons.dangerous_outlined),
                    SizedBox(width: 5),
                    Text("No"),
                  ],
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
