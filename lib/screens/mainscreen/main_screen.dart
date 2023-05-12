import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instagram_test/routes/nama_routes.dart';
import 'package:instagram_test/screens/mainscreen/add_screen.dart';
import 'package:instagram_test/screens/mainscreen/explore_screen.dart';
import 'package:instagram_test/screens/mainscreen/home_screen.dart';
import 'package:instagram_test/screens/mainscreen/notfication_screen.dart';
import 'package:instagram_test/screens/mainscreen/post_screen.dart';
import 'package:instagram_test/screens/userprofile_screen.dart';
import 'package:flutter/services.dart';

import '../../gen/assets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<NavigatorState> _homeScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _explorScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _notifiyScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileScreenKey = GlobalKey();
  // final GlobalKey<NavigatorState> _postScreenKey = GlobalKey();

  late final navigatorKeys = {
    BottomNavIndex.homeIndex: _homeScreenKey,
    BottomNavIndex.explorIndex: _explorScreenKey,
    BottomNavIndex.notifyIndex: _notifiyScreenKey,
    BottomNavIndex.userProfileIndex: _profileScreenKey,
  };

  int selectedIndex = 0;

  List<int> tablist = [0];

  Future<bool> _onWillPop() async {
    if (navigatorKeys[selectedIndex]!.currentState!.canPop()) {
      log("message${navigatorKeys[selectedIndex]!.currentState!.canPop()}");
      navigatorKeys[selectedIndex]!.currentState!.pop();
      log("${tablist}");
     
    } else if (tablist.length > 1) {
      setState(() {
        log("my last of tablist=${tablist.last}");
        tablist.remove(tablist.last);
        log("show my tablist=${tablist}");
      setState(() {  selectedIndex = tablist.last;});
        log("tablist${tablist}");
      });

    } 
    else if (tablist.length == 1) {
       MyExitDialoge().then((value) {
    if (value == true) {
      SystemNavigator.pop(); // Close the app
    }
  });
}
     {
      log("first page");
      return false;
    }
  }

  Future<dynamic> MyExitDialoge() {
    return showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Exit "),
      content: Text("Are you sure you want to exit the app?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("No"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("Yes"),
        ),
      ],
    );
  },
);
  }

 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 60,
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    Navigator(
                      key: _homeScreenKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    ),
                    Navigator(
                      key: _explorScreenKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const ExploreScreen()),
                    ),
                    Navigator(
                      key: _notifiyScreenKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => const NotificationScreen()),
                    ),
                    Navigator(
                        key: _profileScreenKey,
                        onGenerateRoute: (settings) => MaterialPageRoute(
                            builder: (context) => const UserProfile())),
                  ],
                ),
              ),
              Positioned(bottom: 0, left: 0, right: 0, child: btmNav(context))
            ],
          ),
        ),
      ),
    );
  }

  Container btmNav(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () => setState(() {
                    selectedIndex = BottomNavIndex.homeIndex;
                    if (!tablist.contains( BottomNavIndex.homeIndex)) {
                      tablist.add( BottomNavIndex.homeIndex);
                    }
                  }),
              icon: selectedIndex == BottomNavIndex.homeIndex
                  ? Assets.icons.homeSelected.svg()
                  : Assets.icons.home.svg()),
          IconButton(
              onPressed: () => setState(() {
                    selectedIndex = BottomNavIndex.explorIndex;
                    if (!tablist.contains( BottomNavIndex.explorIndex)) {
                      tablist.add( BottomNavIndex.explorIndex);
                    }
                  }),
              icon: selectedIndex == BottomNavIndex.explorIndex
                  ? Assets.icons.exploreSelected.svg()
                  : Assets.icons.explore.svg()),
          // IconButton(
          //     onPressed:()=>Navigator.pushNamed(context,NameRoutes.add_new ),
          //     icon: Assets.icons.addNew.svg()),
          IconButton(
              onPressed: () => setState(() {
                    selectedIndex = BottomNavIndex.notifyIndex;
                    if (!tablist.contains(BottomNavIndex.notifyIndex)) {
                      tablist.add(BottomNavIndex.notifyIndex);
                    }
                  }),
              icon: selectedIndex == BottomNavIndex.notifyIndex
                  ? Assets.icons.notifySelected.svg()
                  : Assets.icons.notify.svg()),
          IconButton(
              onPressed: () => setState(() {
                    selectedIndex = BottomNavIndex.userProfileIndex;
                    if (!tablist.contains(selectedIndex)) {
                      tablist.add(BottomNavIndex.userProfileIndex);
                    }
                  }),
              icon: selectedIndex == BottomNavIndex.userProfileIndex
                  ? const Icon(Icons.verified_user_sharp)
                  : const Icon(Icons.verified_user_outlined)),
        ],
      ),
    );
  }
}

class BottomNavIndex {
  BottomNavIndex._();
  static const int homeIndex = 0;
  static const int explorIndex = 1;
  static const int notifyIndex = 2;
  static const int userProfileIndex = 3;
}
