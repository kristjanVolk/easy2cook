class RecipeBundle {
  final int id;
  final int pTime;
  final String procedure;
  final String name;
  final String complexity;
  String img;
  final List<dynamic> ingredients;
  final List<dynamic> category;
  bool isFavorite;

  RecipeBundle({
    required this.id,
    required this.pTime,
    required this.procedure,
    required this.name,
    required this.complexity,
    required this.img,
    required this.ingredients,
    required this.category,
    this.isFavorite = false,
  });

  int get getID {
    return id;
  }
}
