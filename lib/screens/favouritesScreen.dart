import 'package:Meal_app/models/meal.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favMeal;
  FavouriteScreen(this.favMeal);
  @override
  Widget build(BuildContext context) {
    if(favMeal.isEmpty){
      return Center(
      child: Text('You have no Favourites yet- start adding some!'),
    );
    }
    else{
       return ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            id: favMeal[idx].id,
            title: favMeal[idx].title,
            imgurl: favMeal[idx].imageUrl,
            duration: favMeal[idx].duration,
            complexity: favMeal[idx].complexity,
            affordability: favMeal[idx].affordability,
          );
        },
        itemCount: favMeal.length,
      );
    }
    
  }
}