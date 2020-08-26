import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Meal{
  final int id;
  final String name;
  final String description;
  final String image_url;
  final String price;
  final int kitchen;

  Meal({this.id, this.price, this.name, this.description, this.image_url, this.kitchen});

  factory Meal.fromJson(Map<String, dynamic> json){
    return Meal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image_url: json['image_url'],
      price: json['price'],
      kitchen: json['kitchen']
    );
  }

}



