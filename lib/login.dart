import 'package:flutter/material.dart';
import 'package:movies/models/UserModel.dart';
import 'package:movies/repos/user_repository.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  String success = "";
  var userName = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.1),
                      TextFormField(
                        controller: userName,
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
                      TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter your password!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05),
                      loading? CircularProgressIndicator() : ElevatedButton(
                        onPressed: ()async {
                          if(formKey.currentState!.validate()){
                            try
                                {
                                  setState(() {
                                    loading = true;
                                    isSuccess = false;
                                    isError = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  );
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
                        child: Row(
                          children: [
                            Text("Login"),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
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
