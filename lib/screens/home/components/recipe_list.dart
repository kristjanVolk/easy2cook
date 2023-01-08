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

class RecipeList extends StatefulWidget {
  static const routeName = '/recipe-list';
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    List<RecipeBundle> recipes = Provider.of<List<RecipeBundle>>(context);
    final cat = Provider.of<MyChangeNotifier>(context);

    if (recipes != null) {
      recipes = getRecipeDiet(recipes, cat.index);
    }

    return recipes == null
        ? Container()
        : SafeArea(
            child: Column(
              children: <Widget>[
                Categories(),
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
          );
  }

  List<RecipeBundle> getRecipeDiet(List<RecipeBundle> recipes, int cat) {
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
  }
}

// recipe details
class RecipeDetail extends StatelessWidget {
  final RecipeBundle recipe;
  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    List<dynamic> recIngred = recipe.ingredients;
    recIngred.sort();

    for (int i = 0; i < recIngred.length; i++) {
      recIngred[i] = "\u2022 " + recIngred[i];
    }

    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize * 2,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      recipe.img,
                      width: 350,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 2,
                        ),
                        child: Text(
                          recipe.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 2,
                        vertical: SizeConfig.defaultSize * 2,
                      ),
                      child: Text(
                        'Ingredients:',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 3,
                      ),
                      child: Text(
                        recipe.ingredients.join('\n'),
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 2,
                        vertical: SizeConfig.defaultSize * 2,
                      ),
                      child: Text(
                        'Procedure:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 3,
                        ),
                        child: Text(
                          recipe.procedure,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                      child: Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.defaultSize * 2,
                          ),
                          child: Text(
                            'ENJOY!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
