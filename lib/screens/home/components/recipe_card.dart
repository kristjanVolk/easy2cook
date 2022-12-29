import 'package:easy2cook/constants.dart';
import 'package:easy2cook/models/RecipeBundle.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/size_config.dart';
import 'package:easy2cook/screens/home/components/categories.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipeCard extends StatelessWidget {
  final RecipeBundle recipeBundle;
  final VoidCallback press;

  const RecipeCard(
      {super.key, required this.recipeBundle, required this.press});
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: press,
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
                      Spacer(),
                      Text(
                        recipeBundle.name,
                        style: TextStyle(
                          fontSize: defaultSize * 2.2,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      buildInfoRow(
                        defaultSize,
                        iconSrc: "assets/icons/time-clock.svg",
                        text: "${recipeBundle.pTime} minut",
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      buildInfoRow(
                        defaultSize,
                        iconSrc: "assets/icons/star_rate.svg",
                        text: "${recipeBundle.complexity}",
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
                  child: Image.asset(
                    /// spremeni sliko
                    ///
                    ///
                    "assets/images/pasta.jpg",
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  )),
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
