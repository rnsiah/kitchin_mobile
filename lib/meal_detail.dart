import 'package:flutter/material.dart';
import 'api.dart';

class Meal_Detail extends StatelessWidget {
  final Meal meal;
  const Meal_Detail({Key key, this.meal}) : super (key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text(meal.name),
      ) ,
    );
  }
}


