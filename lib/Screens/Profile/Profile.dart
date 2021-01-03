import 'package:acm_web/Authentication/Login/login.dart';
import 'package:acm_web/Screens/Events/Events.dart';
import 'package:acm_web/Screens/Leadershipboard/LeadershipBoard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  static const String route = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User currUser;
  String userUid;

  void retrieveUid() {
    currUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userUid = currUser.uid;
    });
  }

  Future<DocumentSnapshot> getUserDoc() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .get();
  }

  @override
  void initState() {
    super.initState();
    retrieveUid();
    getUserDoc();
  }

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width < 600){
      return mobileDisplay();
    }
    return webDisplay();
  }

  Widget mobileDisplay(){
    return SafeArea(
        child: Scaffold(
        body: FutureBuilder(
        future: getUserDoc(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage: snapshot.data.data()['profile'] != null ? 
                          NetworkImage(snapshot.data.data()['profile']) : Icon(Icons.account_circle),
                      //An optional error callback for errors emitted when loading backgroundImage
                    //   onBackgroundImageError: (exception, stackTrace) {
                    //   print(
                    //   'flutter: ══╡ EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE ╞════════════════════════════════════════════════════\nflutter: The following ArgumentError was thrown resolving an image codec:\nflutter: Invalid argument(s): No host specified in URI file:///profile');
                    // },
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 60,
                  ), //openSans
                  Text(
                    snapshot.data.data()['name'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Class Standing: ' + snapshot.data.data()['classStanding'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Major: ' + snapshot.data.data()['major'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Email: ' + snapshot.data.data()['email'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    //height: 240,
                    width: 200,
                    child: GestureDetector(
                      onTap: () {
                        if (canLaunch(
                                'https://acm-calstatela.com/membership') !=
                            null) {
                          launch('https://acm-calstatela.com/membership');
                        }
                      },
                      child: Text(
                        "Membership: We are reviewing you account. If you haven't bought a membership click here",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ));
  }

  Widget webDisplay() {
    if(userUid == null){
      {Navigator.of(context).pushReplacementNamed("/login");}
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset('assets/acmlogo1.png', width: 100),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Events()));
              },
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text(
                    " Events",
                    style: GoogleFonts.roboto(),
                  )
                ],
              )),
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => LeadershipBoard()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.leaderboard,
                  ),
                  Text(
                    " Leadership Board",
                    style: GoogleFonts.roboto(),
                  )
                ],
              )),
          FlatButton(
              onPressed: null,
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                  ),
                  Text(
                    " Profile",
                    style: GoogleFonts.roboto(),
                  )
                ],
              ))
        ],
      ),
      body: FutureBuilder(
        future: getUserDoc(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundImage: snapshot.data.data()['profile'] != null ? 
                          NetworkImage(snapshot.data.data()['profile']) : Icon(Icons.account_circle),
                      //An optional error callback for errors emitted when loading backgroundImage
                    //   onBackgroundImageError: (exception, stackTrace) {
                    //   print(
                    //   'flutter: ══╡ EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE ╞════════════════════════════════════════════════════\nflutter: The following ArgumentError was thrown resolving an image codec:\nflutter: Invalid argument(s): No host specified in URI file:///profile');
                    // },
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 60,
                  ), //openSans
                  Text(
                    snapshot.data.data()['name'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Class Standing: ' + snapshot.data.data()['classStanding'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Major: ' + snapshot.data.data()['major'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Email: ' + snapshot.data.data()['email'],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal, fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    //height: 240,
                    width: 200,
                    child: GestureDetector(
                      onTap: () {
                        if (canLaunch(
                                'https://acm-calstatela.com/membership') !=
                            null) {
                          launch('https://acm-calstatela.com/membership');
                        }
                      },
                      child: Text(
                        "Membership: We are reviewing you account. If you haven't bought a membership click here",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ));
  }
}
