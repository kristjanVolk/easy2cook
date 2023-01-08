import 'dart:ui';

import 'package:easy2cook/constants.dart';
import 'package:easy2cook/models/RecipeBundle.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/size_config.dart';
import 'package:easy2cook/screens/home/components/categories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy2cook/screens/home/components/recipe_card.dart';
import 'package:provider/provider.dart';
import 'package:easy2cook/services/database.dart';

import '../../wrapper.dart';

class SearchRecipeList extends StatefulWidget {
  const SearchRecipeList({super.key, required this.cI, required this.r});
  final List<String> cI;
  final List<RecipeBundle> r;
  @override
  State<SearchRecipeList> createState() => _SearchRecipeListState();
}

class _SearchRecipeListState extends State<SearchRecipeList> {
  @override
  Widget build(BuildContext context) {
    List<RecipeBundle> recipes = widget.r;
    List<String> chosenIngredients = widget.cI;
    debugPrint(chosenIngredients.toString());

    /*  if (recipes != null) {
      recipes = getRecipeDiet(recipes, 0);
    } */
    List<RecipeBundle> rec = [];
    for (int i = 0; i < recipes.length; i++) {
      if (recipes[i]
          .ingredients
          .toSet()
          .intersection(chosenIngredients.toSet())
          .isNotEmpty) rec.add(recipes[i]);
    }
    recipes = rec;

    return Scaffold(
      appBar: buildAppBar(),
      body: recipes == null
          ? Container()
          : SafeArea(
              child: Column(
                children: <Widget>[
                  //Categories(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 2),
                      child: recipes.length > 0
                          ? GridView.builder(
                              itemCount: recipes.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: SizeConfig.defaultSize,
                                childAspectRatio: 1.65,
                              ),
                              itemBuilder: (context, index) => RecipeCard(
                                recipeBundle: recipes[index],
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetail(recipes[index])));
                                },
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context)),
      centerTitle: true,
      title: Image.asset("assets/images/logo.png", width: 170),
    );
  }

  /* List<RecipeBundle> getRecipeDiet(List<RecipeBundle> recipes, int cat) {
    List<RecipeBundle> rb = [];
    List<String> categories = [
      "All",
      "Vegan",
      "Vegeterian",
      "Lactose Free",
      "Gluten Free"
    ];
    String category = categories[cat];
    if (category == "All") return recipes;

    for (int i = 0; i < recipes.length; i++) {
      if (recipes[i].category.contains(category)) {
        rb.add(recipes[i]);
      }
    }
    return rb;
  } */
}

// recipe details
class RecipeDetail extends StatelessWidget {
  final RecipeBundle recipe;
  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Image.network(
                      recipe.img,
                      width: 350,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      recipe.name,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Ingredients:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "\u2022 " + recipe.ingredients.join(', '),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      'Procedure:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 350,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, bottom: 30),
                      child: Text(
                        recipe.procedure,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: SvgPicture.asset(
        "assets/icons/arrow_back_ios.svg",
        width: 24,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    centerTitle: true,
    title: Image.asset("assets/images/logo.png", width: 170),
  );
}
