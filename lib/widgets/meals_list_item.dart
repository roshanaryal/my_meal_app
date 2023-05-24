import 'package:flutter/material.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsListItem extends StatelessWidget {
  const MealsListItem({super.key, required this.meal,required this.onMealTapped});

  final Meal meal;

  final void Function() onMealTapped;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affortabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onMealTapped,
        child: Stack(
          children: [
            FadeInImage(
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(
                          width: 16,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affortabilityText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
