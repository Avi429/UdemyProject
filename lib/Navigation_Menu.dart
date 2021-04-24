import 'package:Sample/Dashboard.dart';
import 'package:Sample/main.dart';
import 'package:Sample/profile.dart';
import 'package:get/get.dart';
import 'package:Sample/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sample/searchbar.dart';
import 'constants.dart';
enum MenuState { featured, search, mycourses, wishlist, profile }

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.star_border, size: 30.0,
                    color: MenuState.featured == selectedMenu
                        ? kBestSellerColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        if (MenuState.featured != selectedMenu)
                          {
                            Get.off(HomePage()),
                          }
                      }),
              IconButton(
                  icon: Icon(Icons.search, size: 30.0,
                    color: MenuState.search == selectedMenu
                        ? kBestSellerColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        if (MenuState.search != selectedMenu)
                          {
                            Get.off(MyHomePage()),
                          }
                      }),
              IconButton(
                  icon: Icon(Icons.play_circle_filled, size: 30.0,
                    color: MenuState.mycourses == selectedMenu
                        ? kBestSellerColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        if (MenuState.mycourses != selectedMenu)
                          {
                            Get.off(Dashboard()),
                          }
                      }),
              IconButton(
                icon: Icon(Icons.favorite_border, size: 30.0,
                  color: MenuState.wishlist == selectedMenu
                      ? kBestSellerColor
                      : inActiveIconColor,
                ),
                onPressed: () => {
                  if (MenuState.wishlist != selectedMenu) {
                    Get.off(Wishlist()),
                  }
                },
              ),
              IconButton(
                  icon: Icon(Icons.supervised_user_circle, size: 30.0,
                    color: MenuState.profile == selectedMenu
                        ? kBestSellerColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        if (MenuState.profile != selectedMenu)
                          {
                            Get.off(Profile()),
                          }
                      }),
            ],
          )),
    );
  }
}


/*class Navigation_Menu extends StatefulWidget {
//     int number;
// // number;
//   Navigation_Menu(this.number);
  @override
  _Navigation_MenuState createState() => _Navigation_MenuState();
}
enum MenuState { featured, search, mycourses, wishlist, profile }
class _Navigation_MenuState extends State<Navigation_Menu> {
  // _Navigation_MenuState(this.number);
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Navigator.pushReplacement(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => HomePage(),
        //   ),
        // );
        Get.off(HomePage());
      }
      if (index == 1) {
        // Navigator.pushReplacement(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => MyHomePage(),
        //   ),
        // );
        Get.off(MyHomePage());
      }
      if (index == 2) {
        // Navigator.pushReplacement(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => Dashboard(),
        //   ),
        // );
        Get.off(Dashboard());
      }
      if (index == 3) {
        // Navigator.pushReplacement(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => Wishlist(),
        //   ),
        // );
        Get.off(Wishlist());
      }
      if (index == 4) {
        // Navigator.pushReplacement(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => Profile(),
        //   ),
        // );
        Get.off(Profile());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:Color(0xFFffffff),
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border, size: 30.0,color: ,),
          title: Text("Featured"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 30.0),
          title: Text("Search"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_filled, size: 30.0),
          title: Text("My Courses"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border, size: 30.0),
          title: Text("Wishlist"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle, size: 30.0),
          title: Text("Account"),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kBestSellerColor,
      onTap: _onItemTapped,

    );
  }
}*/
