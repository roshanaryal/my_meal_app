import 'package:flutter/material.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsDetailScreen extends StatelessWidget {
  const MealsDetailScreen({super.key, required this.meal,required this.onToggleFavourite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavourite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                onToggleFavourite(meal);
              },
              icon: Icon(Icons.star_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeInImage(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                placeholder: MemoryImage(
                  kTransparentImage,
                ),
                image: NetworkImage(
                  meal.imageUrl,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              for (final ingred in meal.ingredients)
                Text(
                  ' $ingred',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    ' $step',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
