import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies/models/UserModel.dart';
import 'package:movies/repos/user_repository.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      drawer: MovieDrawer(),
      body: FutureBuilder<UserModel?>(
        future: UserRepository().getUserById(1),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              UserModel? user = snapshot.data;
              return     Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.05),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                       // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                       //  width: 200,
                       //  height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(160),
                      //    borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: user?.img!=null?CircleAvatar(
                            radius: 80,
                            child: Image.file(File((user?.img!).toString(), ),
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/wp.jpg',);
                              },height: 175,
                              width: 175,
                            fit: BoxFit.cover,),
                          ):Image.asset('assets/images/wp.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,),
                        ),
                      ) ,
                      SizedBox(height: MediaQuery.of(context).size.height*0.05),
                      Text(
                        '${user?.name}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.015),
                      Text(
                        '${user?.email}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.1),
                      Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      CardItem(name: 'Oppenheimer', subtitle: 'In 1945, Robert Oppenhimer invented the nuclear...'),
                      CardItem(name: 'Barbie', subtitle: 'A movie about Barbie and Ken.'),
                      CardItem(name: 'Split', subtitle: 'Kevin suffers from a multi personality disorder and is locked...'),
                    ],
                  ),
                ),
              );

          }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}

class MovieDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage("assets/images/wp.jpg"),
              ),

            ),
            child: Text(
              'Hussein Alshami',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),

          ),
          ListTile(
            leading: Icon(
                Icons.home,
                color: Colors.black,
            ),
            title: Text(
                'Home',
                style: TextStyle(fontSize: 17.5),),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(
                Icons.person,
                color: Colors.black,
            ),
            title: Text(
                'Profile',
                style: TextStyle(fontSize: 17.5),),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.movie,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     'Movie',
          //     style: TextStyle(fontSize: 17.5),),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/movie');
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.list,
              color: Colors.black,
            ),
            title: Text(
              'Users',
              style: TextStyle(fontSize: 17.5),),
            onTap: () {
              Navigator.pushNamed(context, '/userslist');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text(
              'Movies list',
              style: TextStyle(fontSize: 17.5),),
            onTap: () {
              Navigator.pushNamed(context, '/movieslist');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.red.shade600,
            ),
            title: Text(
              'About us',
              style: TextStyle(fontSize: 17.5),),
            onTap: () {
              Navigator.of(context).pushNamed('/aboutus');
            },
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String name;
  final String subtitle;

  const CardItem({required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ListTile(
        title: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        subtitle: Text(subtitle),
      ),
    );
  }
}