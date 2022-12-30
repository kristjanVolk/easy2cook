import 'package:flutter/material.dart';
import 'package:easy2cook/size_config.dart';
import 'package:easy2cook/constants.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "All",
    "Vegan",
    "Vegeterian",
    "Lactose Free",
    "Gluten Free"
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
      child: SizedBox(
          height: SizeConfig.defaultSize * 3.5,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategoryItem(index),
          )),
    );
  }

  Widget buildCategoryItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        // Print selected category
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2,
          vertical: SizeConfig.defaultSize * 0.5,
        ),
        decoration: BoxDecoration(
            color:
                selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6,
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? primaryColor : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}
