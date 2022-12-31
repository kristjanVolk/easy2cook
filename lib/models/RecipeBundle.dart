import 'package:flutter/material.dart';

class RecipeBundle {
  final int pTime;
  final String procedure;
  final String name;
  final String complexity;
  String img;
  final List<dynamic> ingredients;
  final List<dynamic> category;

  RecipeBundle(
      {required this.pTime,
      required this.procedure,
      required this.name,
      required this.complexity,
      required this.img,
      required this.ingredients,
      required this.category});
}
