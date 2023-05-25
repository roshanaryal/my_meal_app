import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/category_grid.dart';

import '../model/category.dart';
import '../model/meal.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, 
  // required this.onToggleFavourite,
  required this.filteredMeal});

  // final void Function(Meal meal) onToggleFavourite;
  final List<Meal> filteredMeal;

  void _selectCategory(BuildContext buildContext, Category category) {
    final selectedMealList = filteredMeal
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.push(
      buildContext,
      MaterialPageRoute(
        builder: (buildContext) => MealsScreen(
          title: category.title,
          meal: selectedMealList,
          // onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   drawer: const Drawer(
        //     child:  Column(
        //       children: [Text("My Meals app")],
        //     ),
        //   ),
        //   appBar: AppBar(
        //     title: const Text("Meals app"),
        //   ),
        //   body:
        GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final cat in availableCategories)
          CategoryGridItem(
            category: cat,
            onTapGridItem: () {
              _selectCategory(context, cat);
            },
          )
      ],
    );
    // );
  }
}
