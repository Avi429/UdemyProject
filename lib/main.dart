import 'package:Sample/Navigation_Menu.dart';
import 'package:Sample/constants.dart';
import 'package:Sample/details_screen.dart';
import 'package:Sample/model/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:Sample/Dashboard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:Sample/SplashScreen.dart';
import 'login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sample/mock_data.dart';
import 'package:Sample/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample App',
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: SplashScreen(),
    );
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
bool isGoogleSignIn = false;
String errorMessage = '';
String successMessage = '';

Future<bool> _googleSignout() async {
  try {
    await FirebaseAuth.instance.signOut();
    await auth.signOut();
    await googleSignIn.signOut();
    print("Har Har Har Mahadev");
    return true;
  } catch (e) {
    print("Har Har Mahadev");
    print(e);
  }
  Get.off(LoginPage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String Username = "Avi";

  String User = " ";
  List<Category> Categories = [];
  void initState() {
    print("Har Har Mahadev");
    final fb = FirebaseDatabase.instance.reference().child("Subjects");

    fb.once().then((DataSnapshot snap) async {
      print(snap);
      var data = snap.value;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Username = prefs.getString('UserName');
      // var lecture = snap.value.keys;
      // print(data);
      Categories.clear();

      data.forEach((key, value) {
        Categories.add(new Category(key, value['image'],value['authname']));
      });
      User = "Hey " + Username + ",";
      print("Har Har Mahadev");
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Top Courses',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 220.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Categories.length,
                itemBuilder: (BuildContext context, int index) {
                  // Destination destination = destinations[index];

                  return FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                Categories[index].name,
                                Categories[index].image)),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          //height: index.isEven ? 200 : 240,
                          height: 120,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(Categories[index].image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                              height: 70.0,
                             width: 180,
                              child: ListView(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Categories[index].name,
                                      style: kTitleTextStyle,
                                      //maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Categories[index].authname != null?Categories[index].authname :'Jeff Bezos',
                                      style: kSubTextStyle,
                                      //maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Courses of Charusat',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 206.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Categories.length,
                itemBuilder: (BuildContext context, int index) {
                  // Destination destination = destinations[index];

                  return FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                Categories[index].name,
                                Categories[index].image)),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          //height: index.isEven ? 200 : 240,
                          height: 120,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(Categories[index].image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                              height: 50.0,
                             width: 180,
                              child: ListView(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Categories[index].name,
                                      style: kTitleTextStyle,
                                      //maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Categories[index].authname != null?Categories[index].authname :'Jeff Bezos',
                                      style: kSubTextStyle,
                                      //maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.featured),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class SearchBar extends SearchDelegate<String> {
  final Courses = [
    "Python",
    "Aws",
    "Computer Networking",
    "Java",
    "Operating System"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query, style: TextStyle(fontSize: 20)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final my_list = query.isEmpty
        ? Courses
        : Courses.where((str) =>
                str.startsWith(query[0].toUpperCase() + query.substring(1)))
            .toList();
    return my_list.isEmpty
        ? Text("No Course Found....", style: TextStyle(fontSize: 20))
        : ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                showResults(context);
              },
              title: Text(my_list[index]),
            ),
            itemCount: my_list.length,
          );
  }
}

/*class VideoPlayer extends StatelessWidget {
  String Link;

  // final String link;
  VideoPlayer(String link) {
    Link = link;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              ChewieListItem(
                videoPlayerController: VideoPlayerController.network(
                  Link,
                ),
                looping: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navigation_Menu(),
    );
  }
}*/


