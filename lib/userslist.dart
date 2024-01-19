import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies/delete_user.dart';
import 'package:movies/edit_user.dart';
import 'package:movies/models/UserModel.dart';
import 'package:movies/repos/user_repository.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users list"),
      ),
      body: Container(
        child: FutureBuilder<List<UserModel>>(
          future: UserRepository().getAll(),
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
                          leading:
                          Container(
                              // decoration: BoxDecoration(borderRadius: BorderRadiusdius.circular(20)),

                              // radius: 30,
                              // backgroundColor: Colors.black,
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(20) ,
                             child: list[index].img!=null?Image.file(File(list[index].img!),

                               errorBuilder: (context, error, stackTrace) {
                               return Image.asset('assets/images/wp.jpg');
                             },):Image.asset('assets/images/wp.jpg'),
                           ) ,
                          )

                          ,
                          // CircleAvatar(
                          //     radius: 30,
                          //     backgroundColor: Colors.black,
                          //     backgroundImage:
                          //     // AssetImage('assets/images/wp.jpg')
                          // ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: ()async{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateUser(user: list[index]),
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
                                    return DeleteUserView(userId: list[index].id??0);
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
                          subtitle: Text("${list[index].email}"),

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
