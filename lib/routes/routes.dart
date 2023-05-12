import 'package:flutter/material.dart';
import 'package:instagram_test/routes/nama_routes.dart';
import 'package:instagram_test/screens/mainscreen/add_screen.dart';
import 'package:instagram_test/screens/mainscreen/explore_screen.dart';
import 'package:instagram_test/screens/mainscreen/notfication_screen.dart';
import 'package:instagram_test/screens/mainscreen/post_screen.dart';
import 'package:instagram_test/screens/userprofile_screen.dart';

import '../screens/mainscreen/home_screen.dart';

Map<String , Widget Function(BuildContext)> routs={

NameRoutes.HomeScreen :(contex)=>const HomeScreen(),
NameRoutes.ExploreScreen:(contex) =>const ExploreScreen(),
NameRoutes.AddScreen:(contex) => const AddScreen(),
NameRoutes.NotficationScreen:(contex) => const NotificationScreen(),
NameRoutes.PostScreen:(contex) => const PostScreen(),
NameRoutes.UserProfileScreen:(contex) => const UserProfile(),

};
