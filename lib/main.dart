import './dummyCategories.dart';
import './models/meal.dart';

import './screens/filter_screen.dart';
import 'package:flutter/material.dart';
import './screens/Categories_Screen.dart';
import './screens/categormeals_screen.dart';
import './screens/meal-detail-screen.dart';
import './screens/tabsScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool>_filters={
    'gluten':false,
    'lactose':false,
    'vegetarian':false,
    'vegan':false
  };

  void _setFilter(Map<String,bool> filterdata){
      setState(() {
        _filters=filterdata;

        _availableMeals=DUMMY_MEALS.where((meal){
             if(_filters['gluten']&& !meal.isGlutenFree){
               return false;
             }
             if(_filters['lactose']&& !meal.isLactoseFree){
               return false;
             }
             if(_filters['vegan']&& !meal.isVegan){
               return false;
             }
             if(_filters['vegetarian']&& !meal.isVegetarian){
               return false;
             }
             return true;

        }).toList();
      });
  }

  void _toggleFavourite(String mealId){
    final existingIdx=_favouriteMeals.indexWhere((element) => element.id==mealId);
    if(existingIdx>=0){
      setState(() {
        _favouriteMeals.removeAt(existingIdx);
      });
    }
    else{
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id==mealId));
      });
    }
  }

  bool _isMealFav(String id){
    return _favouriteMeals.any((meal) => meal.id==id);
  }

  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favouriteMeals=[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.yellow,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            headline6: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: CategoryScreen(),
      initialRoute: '/1',// '/' is default
      routes:{
        '/1': (ctx)=> TabsScreen(_favouriteMeals),
        CategoryMealScreen.routeName:(ctx )=> CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx)=> MealDetailScreen(_toggleFavourite,_isMealFav), 
        FilterScreen.routeName: (ctx)=> FilterScreen(_filters,_setFilter),
      },
      onUnknownRoute:(settings){
        return MaterialPageRoute(builder: (ctx)=> CategoryScreen());}
    );
  }
}
