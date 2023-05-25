import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/category_grid.dart';

import '../model/category.dart';
import '../model/meal.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(
      {super.key,
      // required this.onToggleFavourite,
      required this.filteredMeal});

  // final void Function(Meal meal) onToggleFavourite;
  final List<Meal> filteredMeal;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext buildContext, Category category) {
    final selectedMealList = widget.filteredMeal
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
        AnimatedBuilder(
            animation: _animationController,
            child: GridView(
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
            ),
            builder: (context, chil) => SlideTransition(
                  position: Tween(
                    begin: const Offset(0, .5),
                    end: const Offset(0, 0),
                  ).animate(CurvedAnimation(
                      parent: _animationController, curve: Curves.easeInOut)),
                  child: chil,
                ));
    // );
  }
}
