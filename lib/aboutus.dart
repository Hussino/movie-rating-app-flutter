import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0,10,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('assets/images/cinema.jpg'), // Replace with your logo image
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Welcome to Our Company',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We gather the movies you watch in this application!. '
                          'We collect all the ratings critics give to these movies '
                          'We calculate an aggregate score for each move! '
                          "The score is a great indicator of the movie's quality"
                          'You can also see the names of every critic  '
                          'as well as their score, and writted review on all movies!.',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                color: Colors.black,
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('assets/images/theater.jpg'), // Replace with your logo image
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Development Team',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Made by 2 student at Sanaa University, Faculty of Computers.'
                          'Credit to: Hussien Ali Alshami & Hamed Shihab Alsabri.'
                          'Development was done through flutter & sqflite.'
                          'Numerous templates have been used in the process. '
                          'sodales nibh. Cras euismod ultrices ligula, non varius '
                          'nunc condimentum sit amet. Nunc ac malesuada nisi.',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,

                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10,10,10,0),
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage('assets/images/theater2.JPG'), // Replace with your logo image
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'See ya',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                          'Nulla dignissim, neque id pretium suscipit, risus nisi '
                          'ornare orci, nec euismod leo orci non est. Donec lobortis '
                          'ipsum eget lectus efficitur sagittis. Mauris sit amet '
                          'sodales nibh. Cras euismod ultrices ligula, non varius '
                          'nunc condimentum sit amet. Nunc ac malesuada nisi.',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
