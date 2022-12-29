import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/RecipeBundle.dart';

// ta class vsebuje vse metode, ki so rabljene za Firebase podatkovno bazo

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  // 2x rabimo - > prvič ko se prijavi in drugič ko gre pod favorites
  Future updateUserData(List recipes) async {
    return await favoritesCollection.doc(uid).set({
      'recipes': recipes,
    });
  }

  // recipes

  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('recipes');

  // recipe list from snapshot
  List<RecipeBundle> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RecipeBundle(
        name: doc.get('name') ?? '',
        pTime: doc.get('pTime') ?? 0,
        procedure: doc.get('procedure') ?? '',
        complexity: doc.get('complexity') ?? '',
      );
    }).toList();
  }

  // get recipe updates
  Stream<List<RecipeBundle>>? get recipes {
    return recipesCollection.snapshots().map(_recipeListFromSnapshot);
  }
}
