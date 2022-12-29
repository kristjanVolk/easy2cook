import 'package:easy2cook/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/NavItem.dart';
import '../size_config.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Consumer<NavItems>(
      builder: (context, navItems, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            offset: Offset(0, -7),
            blurRadius: 30,
            color: Color(0xFF4B1A39).withOpacity(0.2),
          ),
        ]),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              navItems.items.length,
              (index) => buildIconNavBarItem(
                isActive: navItems.selectedIndex == index ? true : false,
                icon: navItems.items[index].icon,
                press: () {
                  navItems.changeNavIndex(index: index);
                  // maybe destination checker is not needed samo zdej ce ga ni vrze error
                  if (navItems.items[index].destinationChecker()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => navItems.items[index].destination,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildIconNavBarItem(
      {required String icon,
      required VoidCallback press,
      bool isActive = false}) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        color: isActive ? primaryColor : Color(0xFFD1D4D4),
        height: 22,
      ),
      onPressed: press,
    );
  }
}
