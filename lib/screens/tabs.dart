import 'package:flutter/material.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filter_screen.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

import '../model/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeal = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeal.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeal.remove(meal);
      });
      _showInfoMessage('${meal.title} has been removed from favourite');
    } else {
      setState(() {
        _favouriteMeal.add(meal);
      });
      _showInfoMessage('${meal.title} has been added to favourite');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FilterScreen()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? 'Category' : 'Favourites'),
      ),
      body: _selectedPageIndex == 0
          ? CategoryScreen(
              onToggleFavourite: _toggleMealFavouriteStatus,
            )
          : MealsScreen(
              title: "",
              meal: _favouriteMeal,
              onToggleFavourite: _toggleMealFavouriteStatus,
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
