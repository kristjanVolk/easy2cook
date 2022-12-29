import 'package:easy2cook/components/my_bottom_nav_bar.dart';
import 'package:easy2cook/constants.dart';
import 'package:easy2cook/screens/profile/components/body.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      leading: SizedBox(),
      centerTitle: true,
    );
  }
}
