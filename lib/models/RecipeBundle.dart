import 'package:flutter/material.dart';

class RecipeBundle {
  final int pTime;
  final String procedure;
  final String name;
  final String complexity;
  String img;

  RecipeBundle({
    required this.pTime,
    required this.procedure,
    required this.name,
    required this.complexity,
    required this.img,
  });
}

/*class RecipeBundle {
  final int id, time;
  final String complexity, title, description, imageSrc;
  final Color color;

  RecipeBundle(
      {required this.id,
      required this.time,
      required this.complexity,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});
}

//final data = DatabaseService().getRecipes();

//List<RecipeBundle> recipeBundles = [];
List<RecipeBundle> recipeBundles = [
  RecipeBundle(
      id: 1,
      time: 25,
      complexity: "Zelo lahko",
      title: "Pasta",
      description: "Tvoja mama",
      imageSrc: "assets/images/pasta.jpg",
      color: Colors.green.shade600),
];*/
