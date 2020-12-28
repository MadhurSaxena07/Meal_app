
import 'package:flutter/material.dart';
import '../dummyCategories.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function togglefav;
  final Function isFav;
  MealDetailScreen(this.togglefav,this.isFav);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget container(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String mealId = routeArg['id'];
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                )),
            buildSectionTitle(context, 'Ingredients!'),
            container(ListView.builder(
                itemBuilder: (ctx, idx) => Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(selectedMeal.ingredients[idx]),
                      ),
                    ),
                itemCount: selectedMeal.ingredients.length)),
            buildSectionTitle(context, 'Steps!'),
            container(
              ListView.builder(
                  itemBuilder: (ctx, idx) => Column(
                    children: <Widget>[
                      ListTile(
                            leading: CircleAvatar(child: Text('#${idx + 1}')),
                            title: Text(
                              selectedMeal.steps[idx],
                            ),
                          ),
                          Divider()
                    ],
                  ),
                  itemCount: selectedMeal.steps.length),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(isFav(mealId)?Icons.star:Icons.star_border) ,onPressed: ()=>togglefav(mealId)
        ),
    );
  }
}
