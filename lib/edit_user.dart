import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/models/UserModel.dart';
import 'package:movies/repos/user_repository.dart';
import 'package:movies/userslist.dart';

class UpdateUser extends StatefulWidget {
  final UserModel user;
  const UpdateUser({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  String success = "";
  String _imgPath='';
  File? _image;
  var nameCont = TextEditingController();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
  _imgPath=widget.user.img!=null?widget.user.img!:"";

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    nameCont.text = widget.user.name!;
    passwordCont.text = widget.user.password!;
    emailCont.text = widget.user.email!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.user.name}'s profile"),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
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
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter your name!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Upload Image (Unchanged)",
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

                              final ImagePicker _picke = ImagePicker();

                              var frd=await  _picke.pickImage(source: ImageSource.gallery);
                              if(frd!=null){
                                setState(() {
                                  _imgPath=frd.path;
                                  _image=File(_imgPath);
                                });
                                // res.first.
                              }
                              // ImagePicker img=ImagePicker.platform()
                            },),
                          SizedBox(height: MediaQuery.of(context).size.width*0.05),
                          _imgPath.isNotEmpty?
                          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)), child: Image.file(
                            File(_imgPath),width: MediaQuery.of(context).size.width*0.4, height: MediaQuery.of(context).size.height*0.4,)):
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    TextFormField(
                      controller: emailCont,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter your email!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    TextFormField(
                      controller: passwordCont,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter a password!';
                        }
                        return null;
                      },
                    ),
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
                              "Email": emailCont.text,
                              "Password": passwordCont.text,
                              'Img':_imgPath.trim()
                            };
                            widget.user.name = nameCont.text;
                            widget.user.email = emailCont.text;
                            widget.user.password = passwordCont.text;
                            var addRes = await UserRepository().editUser(data, widget.user.id);
                            if(addRes>0){
                              setState(() {
                                loading = false;
                                isSuccess = true;
                                isError = false;
                                error = "";
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsersList(),
                                  ),
                                );
                              });
                            }
                            else{
                              setState(() {
                                print("no it doesnt");
                                loading = false;
                                isSuccess = false;
                                isError = true;
                                error = "Registration failed";
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
                    isSuccess? Text('Successfully Registered!', style:TextStyle(color: Colors.green),):SizedBox(),
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
