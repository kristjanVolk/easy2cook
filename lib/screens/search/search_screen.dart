import 'package:flutter/foundation.dart';

import 'package:easy2cook/screens/search/components/body.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
//Import firestore database

import '../../components/my_bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy2cook/models/RecipeBundle.dart';
import 'package:easy2cook/screens/auth/authenticate.dart';
import 'package:easy2cook/screens/wrapper.dart';
import 'package:easy2cook/services/auth.dart';
import 'package:easy2cook/services/database.dart';
import 'package:easy2cook/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy2cook/screens/home/components/recipe_list.dart';
import 'package:provider/provider.dart';
import 'package:easy2cook/models/IngredientsBundle.dart';
import 'package:easy2cook/models/RecipeBundle.dart';

class SearchScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return StreamProvider<List<RecipeBundle>?>.value(
      value: DatabaseService().recipes,
      initialData: null,
      child: StreamProvider<List<IngredientsBundle>?>.value(
        value: DatabaseService().ingredients,
        initialData: null,
        child: Scaffold(
          appBar: buildAppBar(),
          body: Search(),
          bottomNavigationBar: MyBottomNavBar(),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            width: 24,
          ),
          onPressed: null),
      centerTitle: true,
      title: Image.asset("assets/images/logo.png", width: 170),
    );
  }
}
