import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitchin/meal_detail.dart';
import 'api.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static List<Meal>_meal = List<Meal>();
  static List <Meal> _mealsInApp = List<Meal>();
  Future<List<Meal>> incomingMeals() async {
    var url = 'https://kitchenkitchin.herokuapp.com/api/meals';
    var response = await http.get(url);
    var meals = List<Meal>();

    if (response.statusCode == 200) {
      var mealsJson = json.decode(response.body);
      for (var mealJson in mealsJson) {
        meals.add(Meal.fromJson(mealJson));
      }
    }
    return meals;
  }

  @override
  void initState() {
    incomingMeals().then((value){
      setState(() {
        _meal.addAll(value);
        _mealsInApp =_meal;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('KitchIn'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
          itemBuilder: (context,index){
            return ProductCard(
              meal: _mealsInApp[index],
              press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Meal_Detail(meal: _mealsInApp[index],)))
            );
          },
        itemCount: _mealsInApp.length,
          ),
    );
  }


}


class ProductCard extends StatelessWidget {
  final Meal meal;
  final Function press;

  const ProductCard({
    Key key,
    this.meal,
    this.press
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          height: 300 ,

          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(meal.image_url),
                  fit: BoxFit.cover
              )

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(meal.name, style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    backgroundColor: Colors.black12,
                    fontWeight: FontWeight.w600
                ),),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(meal.price, style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),),
              )

            ],
          ) ,
        ),
    );
  }
}
