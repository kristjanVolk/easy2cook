import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy2cook/screens/home/components/recipe_list.dart';
import 'package:easy2cook/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/RecipeBundle.dart';
import '../../../size_config.dart';
import  '../../wrapper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List _favoriteRecipes = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _getFavoriteRecipes();
  }

  void _navigateToRecipeCard(dynamic recipe){
    RecipeBundle rec = RecipeBundle(id: recipe["id"], pTime: recipe["pTime"], procedure: recipe["procedure"], name: recipe["name"], complexity: recipe["complexity"], img: recipe["img"], ingredients: recipe["ingredients"], category: recipe["category"]);
    print(rec.name);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeDetail(rec))
    );
  }

  Future<void> _getFavoriteRecipes() async {
    final CollectionReference recipesFav = _firestore
        .collection('favorites')
        .doc(_auth.currentUser?.uid)
        .collection('recipes');
    recipesFav.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((document) {
          setState(() {
            print(document.data());
            _favoriteRecipes.add(document.data());
            print(_favoriteRecipes.length);
          });
        });
      }
    });
  }

  Future<void> _posodobiPodatke(int indeks) async {
    final _favoritesCollection = _firestore.collection('favorites');
    int id = _favoriteRecipes[indeks]['id'];
    _favoriteRecipes[indeks]['isFavorite'] =
        !_favoriteRecipes[indeks]['isFavorite'];
    _favoriteRecipes.removeWhere((recept) => recept['id'] == id);
    QuerySnapshot snapshot = await _favoritesCollection
        .doc(_auth.currentUser!.uid)
        .collection('recipes')
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isNotEmpty) {
      print('dobim dokument');
      snapshot.docs.first.reference.delete();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        foregroundColor: textColorSecond,
      ),
      body: ListView.builder(
        itemCount: _favoriteRecipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              _navigateToRecipeCard(_favoriteRecipes[index]);
            },
            child: Card(
              key: ValueKey(_favoriteRecipes[index]["id"]),
              color: Colors.green,
              margin: EdgeInsets.all(defaultSize * 1.5),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultSize * 1.8),
              ),
              child: Container(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(defaultSize * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _posodobiPodatke(index);
                                    setState(() {});
                                  },
                                  child: Icon(Icons.favorite, color: Colors.red),
                                ),
                                SizedBox(width: defaultSize),
                                Text(
                                  _favoriteRecipes[index]['name'],
                                  style: TextStyle(
                                    fontSize: defaultSize * 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: defaultSize),
                            Row(
                              children: [
                                Icon(Icons.timelapse, color: Colors.black),
                                SizedBox(width: defaultSize),
                                Text(
                                  'Cook Time: ${_favoriteRecipes[index]['pTime']} minutes',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: defaultSize),
                            Row(
                              children: [
                                Icon(Icons.grade, color: Colors.black),
                                SizedBox(width: defaultSize),
                                Text(
                                  'Complexity: ${_favoriteRecipes[index]['complexity']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(defaultSize * 1.8),
                            bottomRight: Radius.circular(defaultSize * 1.8)),
                        child: Image.network(
                          _favoriteRecipes[index]['img'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
