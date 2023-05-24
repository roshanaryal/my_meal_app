import 'package:flutter/material.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/screens/meals_detail.dart';
import 'package:mealsapp/widgets/meals_list_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meal,required this.onToggleFavourite});

  final List<Meal> meal;
  final String title;
  final void Function(Meal meal) onToggleFavourite;

  void _onMealTapped(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MealsDetailScreen(meal: meal,onToggleFavourite: onToggleFavourite,);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? mainContent = ListView.builder(
      itemCount: meal.length,
      itemBuilder: (
        ctx,
        index,
      ) =>
          MealsListItem(
        meal: meal[index],
        onMealTapped: () {
          _onMealTapped(context, meal[index]);
        },
      ),
    );

    if (meal.isEmpty) {
      mainContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Opps...No meals available",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting another category",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: mainContent,
    );
  }
}
