import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/home.dart';
import 'package:movies/repos/movie_repository.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  String success = "";
  String _imgPath = "";
  File? _image;
  var nameCont = TextEditingController();
  var imgCont = TextEditingController();
  var detailsCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a movie"),
        backgroundColor: Colors.red.shade900,
        centerTitle: false,
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
                      controller: nameCont,
                      decoration: InputDecoration(
                        labelText: 'Movie title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter the movie title!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload Movie Poster",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                Icon(
                                  Icons.image,
                                  color: Colors.red.shade600,
                                )
                              ],
                            ),
                          ),
                          onTap: ()async{

                            final ImagePicker _picker = ImagePicker();

                            var img =await  _picker.pickImage(source: ImageSource.gallery);
                            if(img!=null){
                              setState(() {
                                _imgPath=img.path;
                                _image=File(_imgPath!);
                              });
                              // res.first.
                            }
                            // ImagePicker img=ImagePicker.platform()
                          },),
                        SizedBox(width: MediaQuery.of(context).size.width*0.05),
                        _image!=null?
                        ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(_image!,width: MediaQuery.of(context).size.width*0.5, height: MediaQuery.of(context).size.height*0.5,)):
                        SizedBox()
                      ],
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    // TextFormField(
                    //   controller: imgCont,
                    //   decoration: InputDecoration(
                    //     labelText: 'Image',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   validator: (value){
                    //     if(value!.isEmpty){
                    //       return 'Please enter an image name!';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    TextFormField(
                      controller: detailsCont,
                      decoration: InputDecoration(
                        labelText: 'Movie Synopsis',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter a synopsis for the movie!';
                        }
                        return null;
                      },
                    ),
                    //SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    SizedBox(height: MediaQuery.of(context).size.height*0.075),
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
                              "Name": nameCont.text,
                              "Img": _imgPath.trim(),
                              "Details": detailsCont.text,
                            };
                            var addRes = await MovieRepository().addMovie(data);
                            if(addRes>0){
                              setState(() {
                                loading = false;
                                isSuccess = true;
                                isError = false;
                                error = "";
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
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
