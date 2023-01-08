import 'dart:ui';

import 'package:easy2cook/constants.dart';
import 'package:easy2cook/models/IngredientsBundle.dart';
import 'package:easy2cook/models/RecipeBundle.dart';
import 'package:easy2cook/screens/search/components/search_recipe_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy2cook/services/database.dart';
import 'package:easy2cook/screens/home/components/recipe_list.dart';

import '../../wrapper.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isValid = false;

  List<String> avalibleIngredients = [];
  List<String> allRecipes = [];
  List<String> chosenIngredients = [];
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    List<RecipeBundle> recipes = Provider.of<List<RecipeBundle>>(context);
    List<IngredientsBundle> ingredients =
        Provider.of<List<IngredientsBundle>>(context);
    final cat = Provider.of<MyChangeNotifier>(context);
    String searchValue = "";

    try {
      avalibleIngredients =
          (ingredients.map((ingredients) => ingredients.name)).toList();
      allRecipes = (recipes.map((recipes) => recipes.name)).toList();
    } catch (e) {}
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Container(
            width: screenWidth * 0.75,
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return avalibleIngredients.where((String option) {
                  searchValue = textEditingValue.text.toString();
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {},
            )),
        Container(
          child: ElevatedButton(
            child: Icon(Icons.add, color: Colors.white),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                primary: Colors.green[400]),
            onPressed: () {
              if (avalibleIngredients
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase())) {
                for (int i = 0; i < avalibleIngredients.length; i++) {
                  if (avalibleIngredients[i].toLowerCase() ==
                          searchValue.toLowerCase() &&
                      !chosenIngredients.contains(avalibleIngredients[i])) {
                    isValid = true;
                    searchValue = avalibleIngredients[i];

                    addItemToList(avalibleIngredients[i]);
                    debugPrint(chosenIngredients.toString());
                  }
                }
              }
            },
          ),
        ),
      ]),
      Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.green[400]),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchRecipeList(
                          cI: chosenIngredients,
                          r: recipes,
                        )),
              );
            },
            icon: Icon(
              Icons.search,
            ),
            label: Text('Search for recipes'), // <-- Text
          )),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: chosenIngredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key((chosenIngredients.length).toString()),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      debugPrint(index.toString());
                      deleteItemFromList(index);
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(chosenIngredients[index].toString()),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ));
              })),
    ]));
  }

  void addItemToList(String searchValue) {
    setState(() {
      chosenIngredients.add(searchValue);
    });
  }

  void deleteItemFromList(int index) {
    setState(() {
      chosenIngredients.removeAt(index);
    });
    debugPrint(chosenIngredients.toString());
  }
}
