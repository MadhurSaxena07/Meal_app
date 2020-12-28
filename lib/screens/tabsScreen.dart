import '../widgets/main_drawer.dart';
import '../models/meal.dart';
import './Categories_Screen.dart';
import './favouritesScreen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoutiteMeals;
  TabsScreen(this.favoutiteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages ;
  
  @override
  void initState(){
    _pages =[
    {
      'body': CategoryScreen(), 
      'title': 'Categories'
    },
    {
      'body': FavouriteScreen(widget.favoutiteMeals),
      'title': 'My Favs are my favs none of ur fav!'
    }
  ];

    super.initState();
  }

  int _selectedPageIdx = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*DefaultTabController(
      length: 2,
      child: */
        Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIdx]['title']),
      ),
      drawer: MainDrawer(),
      /*bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              )
            ])),*/
      body: _pages[_selectedPageIdx]['body'],
      /*TabBarView(children: <Widget>[
              CategoryScreen(),
              FavouriteScreen()
            ]*/

      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIdx,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text(
                  'Categories',
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text(
                  'Favorites',
                ))
          ]),
    );
  }
}
