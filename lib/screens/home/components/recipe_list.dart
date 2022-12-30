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

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<List<RecipeBundle>>(context);

    return recipes == null
        ? Container()
        : SafeArea(
            child: Column(
              children: <Widget>[
                Categories(),
                // Search
                //RecipeCard(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 2),
                    child: GridView.builder(
                      itemCount: recipes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: SizeConfig.defaultSize,
                        childAspectRatio: 1.65,
                      ),
                      itemBuilder: (context, index) => RecipeCard(
                        recipeBundle: recipes[index],
                        press: () {
                          print("RECEPTI" + index.toString());
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
