import '../models/meal.dart';
import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  //final String catId;
  //final String catTitle;

  //CategoryMealScreen(this.catId,this.catTitle);
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String catTitle;
  List<Meal>categoryMeals;
  var loadedInitData=false;  

  @override
  void initState() {
   
    super.initState();
  }
      
   @override
  void didChangeDependencies() {
     final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    catTitle = routeArgs['title'];
    final catId = routeArgs['id'];
    categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(catId);
    }).toList();
    loadedInitData=true;

    super.didChangeDependencies();
  }
  /*void _removeMeal(String mealId){
    setState(() {
      categoryMeals.removeWhere((meal)=>meal.id==mealId );
    });
  }*/
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(catTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            id: categoryMeals[idx].id,
            title: categoryMeals[idx].title,
            imgurl: categoryMeals[idx].imageUrl,
            duration: categoryMeals[idx].duration,
            complexity: categoryMeals[idx].complexity,
            affordability: categoryMeals[idx].affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
