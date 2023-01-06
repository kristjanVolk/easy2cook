import 'package:easy2cook/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/size_config.dart';
import 'package:easy2cook/constants.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
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

            // Set state when category selected
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  Provider.of<MyChangeNotifier>(context, listen: false)
                      .setCategory(selectedIndex);
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize * 2,
                  vertical: SizeConfig.defaultSize * 0.5,
                ),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Color(0xFFEFF3EE)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.defaultSize * 1.6,
                    )),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index
                        ? primaryColor
                        : Color(0xFFC2C2B5),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
