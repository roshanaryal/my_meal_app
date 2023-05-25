import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/provider/favourite_provide.dart';
import 'package:mealsapp/provider/filters_provider.dart';
import 'package:mealsapp/provider/meals_provider.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filter_screen.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

import '../model/meal.dart';

final kInitialFilters = {
  Filters.guttenFree: false,
  Filters.lactoseFree: false,
  Filters.vegeterian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // Map<Filters, bool> _selectedFilters = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // v

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterScreen(),
        ),
      );

      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final availableMeals = ref.watch(filterMealProvider);

    Widget activePage = CategoryScreen(
      filteredMeal: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favMeal = ref.watch(favouriteMealProvider);
      activePage = MealsScreen(
        title: "",
        meal: favMeal,
        // onToggleFavourite: _toggleMealFavouriteStatus,
        isFromFavourite: true,
      );
    }

    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? 'Category' : 'Favourites'),
      ),
      body: activePage,
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
