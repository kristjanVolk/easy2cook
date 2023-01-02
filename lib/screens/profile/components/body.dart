import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy2cook/constants.dart';
import 'package:easy2cook/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/user.dart';
import '../../../size_config.dart';
import 'info.dart';
import 'profile_menu_item_dart.dart';

class Body extends StatelessWidget {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    /*Future<String> name = getCurrentUserName(_auth.currentUser!.uid.toString());

    name.then((String name) {
      print(name);
    });*/

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: getCurrentUserName(_auth.currentUser!.uid.toString()),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Info(
                  image: "assets/images/avatar.jpg",
                  name: snapshot.data!,
                  email: _auth.currentUser!.email.toString(),
                );
              }
              return Container();
            }),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 2,
          ),
          /*ProfileMenuItem(
            iconSrc: "assets/icons/favorite.svg",
            title: "Favorites",
            press: () {},
          ),*/
          ProfileMenuItem(
            iconSrc: "assets/icons/question_answer.svg",
            title: "Propose Ingredients",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/mode_edit.svg",
            title: "Edit profile",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Help",
            press: () {},
          ),
          ProfileMenuItem(
              iconSrc: "assets/icons/logout.svg",
              title: "Logout",
              press: () async {
                await _auth.signOut();
              })
        ],
      ),
    );
  }

  Future<String> getCurrentUserName(String user) async {
    var collection = FirebaseFirestore.instance.collection('usernames');
    var ds = await collection.doc(user).get();
    if (ds.exists) {
      Map<String, dynamic>? data = ds.data();
      var value = data?['username'];
      return value;
    }
    return "";
  }
}
