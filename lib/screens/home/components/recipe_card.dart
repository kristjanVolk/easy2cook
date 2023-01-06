import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy2cook/models/RecipeBundle.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeCard extends StatefulWidget {
  final RecipeBundle recipeBundle;
  final VoidCallback press;
  RecipeCard({
    required this.recipeBundle,
    required this.press,
  }):super(key: ValueKey(recipeBundle.id));

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? user;
  bool isFavorite = false;
  Future<String> getUserID() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return 'null';
  }

  @override
  void initState() {
    super.initState();

   _firestore
    .collection('favorites')
    .doc(_auth.currentUser?.uid)
    .collection('recipes')
    .where('id', isEqualTo: widget.recipeBundle.id)
    .get()
    .then((querySnapshot) {
      print('Recipe ID: ${widget.recipeBundle.id}');
      print(querySnapshot.toString());
      querySnapshot.docs.forEach((doc) {
        setState(() {
          isFavorite = doc.data()['isFavorite'];  
        });
        
      });
    });
  }

  Future<void> zapisiPodatke() async {
    final _favoritesCollection = _firestore.collection('favorites');
    widget.recipeBundle.isFavorite = isFavorite;
    user = await getUserID();
    if (user == 'null') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You must be signed in to add to favorites'),
      ));
    } else {
      QuerySnapshot snapshot = await _favoritesCollection
          .doc(_auth.currentUser!.uid)
          .collection('recipes')
          .where('id', isEqualTo: widget.recipeBundle.id)
          .get();

      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.delete();
      } else {
        DocumentReference favoriteDocument =
            _favoritesCollection.doc(user).collection('recipes').doc();
        Map<String, dynamic> data = {
          'id': widget.recipeBundle.id,
          'pTime': widget.recipeBundle.pTime,
          'name': widget.recipeBundle.name,
          'img' : widget.recipeBundle.img,
          'complexity': widget.recipeBundle.complexity,
          'procedure' : widget.recipeBundle.procedure,
          'ingredients': widget.recipeBundle.ingredients,
          'category': widget.recipeBundle.category,
          'isFavorite': widget.recipeBundle.isFavorite,
        };
        favoriteDocument.set(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      key: widget.key,
      onTap: widget.press,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(defaultSize * 1.8),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultSize * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //tukaj on tap na ikono srček kličemo metodo zapisiPodatke
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            zapisiPodatke();
                          },
                          icon: isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                          color: isFavorite ? Colors.red : null,
                          ),
                      Spacer(),
                      Text(
                        widget.recipeBundle.name,
                        style: TextStyle(
                          fontSize: defaultSize * 2.2,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      buildInfoRow(
                        defaultSize,
                        iconSrc: "assets/icons/time-clock.svg",
                        text: "${widget.recipeBundle.pTime} minutes",
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      buildInfoRow(
                        defaultSize,
                        iconSrc: "assets/icons/star_rate.svg",
                        text: "${widget.recipeBundle.complexity}",
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: defaultSize * 0.5,
              ),
              AspectRatio(
                aspectRatio: 0.7,
                child: Image.network(
                  /// spremeni sliko
                  //"assets/images/beef.jpg",
                  widget.recipeBundle.img,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ],
          )),
    );
  }

  Row buildInfoRow(double defaultSize, {required String iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc),
        SizedBox(width: defaultSize),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
