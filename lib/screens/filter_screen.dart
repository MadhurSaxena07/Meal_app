import 'package:Meal_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '\filters';
  final Function setFilter;
  final Map<String,bool> currentFilters;
  FilterScreen(this.currentFilters,this.setFilter);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  initState(){
    _glutenFree=widget.currentFilters['gluten'];
    _lactoseFree=widget.currentFilters['lactose'];
    _vegan=widget.currentFilters['vegan'];
    _vegetarian=widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListView(
      String title, String des, bool currval, Function updateVal) {
    return SwitchListTile(
        title: Text(title), value: currval,subtitle: Text(des) , onChanged: updateVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),onPressed: (){
            final selectedFilters={
              'gluten':_glutenFree,
              'lactose':_lactoseFree,
              'vegan':_vegan,
              'vegetarian':_vegetarian
            };
            widget.setFilter(selectedFilters
            );},)
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection!',
                style: Theme.of(context).textTheme.headline5,
              )),
          Expanded(
              child: ListView(children: <Widget>[
            _buildSwitchListView(
                'Gluten-Free!', 'Only include gluten free meals', _glutenFree,
                (newVal){
                  setState(() {
                    _glutenFree=newVal;
                  });
                }),
            _buildSwitchListView('Lactose-Free!',
                'Only include lactose free meals', _lactoseFree,(newVal){
                  setState(() {
                    _lactoseFree=newVal;
                  });
                },
                ),
            _buildSwitchListView('Vegetarian', 'Only include vegetarian meals', _vegetarian,
            (newVal){
                  setState(() {
                    _vegetarian=newVal;
                  });
                }),
                _buildSwitchListView('Vegan', 'Only include vegan meals', _vegan,
                (newVal){
                  setState(() {
                    _vegan=newVal;
                  });
                })
          ]))
        ],
      ),
    );
  }
}
