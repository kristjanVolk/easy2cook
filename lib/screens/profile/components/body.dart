import 'package:easy2cook/constants.dart';
import 'package:easy2cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import 'info.dart';
import 'profile_menu_item_dart.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            image: "assets/images/pasta.jpg",
            name: "John Doe",
            email: "jd@gmail.com",
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
        ],
      ),
    );
  }
}
