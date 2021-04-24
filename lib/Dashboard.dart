import 'dart:collection';

import 'package:Sample/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Dashboarad_Details.dart';
import 'package:Sample/Navigation_Menu.dart';
import 'package:flutter/material.dart';
import 'package:Sample/model/category.dart';
import 'package:Sample/LecturesList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Category> Categories = [];
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String UserId = '';
    int Len = 0;
    void getCurrentUser() async {
      final FirebaseUser user = await auth.currentUser();
      final uid = user.uid;
      // Similarly we can get email as well
      //final uemail = user.email;
      UserId = uid;
      //Useremail = uemail;
      //print('User ID:  '+UserId);

      //print(uemail);
      final fb =
          FirebaseDatabase.instance.reference().child("Students").child(UserId);

      fb.once().then((DataSnapshot snap) {
        print(snap);
        var data = snap.value;
        // var lecture = snap.value.keys;
        print(data);
        Categories.clear();

        data.forEach((key, value) {
          Categories.add(new Category(value['Course'], value['image'],value['authname']));
        });
        Len = Categories.length;
        setState(() {});
      });
    }

    getCurrentUser();
    print(UserId);

    // List<Category> result = LinkedHashSet<String>.from(Categories).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFffffff),
        elevation: 0,
        title: Text(
          "My Courses",
          style: TextStyle(
            fontWeight:FontWeight.bold,
            fontSize: 24,
            letterSpacing: 0.8,
          ),),
      ),
      backgroundColor: Color(0xFFffffff),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                //  SvgPicture.asset("icons/menu.svg")
                //Icon(Icons.menu),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 1,
                itemCount: Categories.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Dashboard_Details(Categories[index].name)),
                      );
                    },
                    child: InkWell(
                      child: Container(
                        height: 125.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                            SizedBox(width: 15.0),
                            Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width -155,
                              child: ListView(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      Categories[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Categories[index].authname != null?Categories[index].authname :'Jeff Bezos',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.blueGrey[300],
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          /*children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(Categories[index].image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Categories[index].name,
                              style: kTitleTextStyle,
                            ),
                          ),
                        ),
                        // Text(
                        //   '${categories[index].Instructor}',
                        //   style: TextStyle(
                        //     color: kTextColor.withOpacity(.5),
                        //   ),
                        // )
                      ],*/
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.mycourses),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dash();
  }
}
