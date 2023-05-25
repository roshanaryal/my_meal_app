import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/provider/favourite_provide.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsDetailScreen extends ConsumerStatefulWidget {
  const MealsDetailScreen({super.key, required this.meal});
  final Meal meal;

  @override
  ConsumerState<MealsDetailScreen> createState() => _MealsDetailScreenState();
}

class _MealsDetailScreenState extends ConsumerState<MealsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final favMeal = ref.watch(favouriteMealProvider);

    bool isInFavourite = favMeal.contains(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              bool isFav = ref
                  .read(favouriteMealProvider.notifier)
                  .toggleMealFavouriteStatus(widget.meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFav
                      ? 'Meals added to favourite'
                      : 'meals removed from favourite'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: ((chil, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: chil,
                );
              }),
              child: Icon(
                isInFavourite ? Icons.star : Icons.star_outline,
                color: Colors.yellow,
                key: ValueKey(isInFavourite),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: widget.meal.id,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  placeholder: MemoryImage(
                    kTransparentImage,
                  ),
                  image: NetworkImage(
                    widget.meal.imageUrl,
                  ),
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
              for (final ingred in widget.meal.ingredients)
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
              for (final step in widget.meal.steps)
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

// class MealsDetailScreen extends ConsumerWidget {
//   const MealsDetailScreen({super.key, required this.meal
//       // ,required this.onToggleFavourite
//       });

//   final Meal meal;

//   // final void Function(Meal meal) onToggleFavourite;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool isMealInFavouriteList =
//         ref.watch(favouriteMealProvider.notifier).isInFavouriteList(meal);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(meal.title),
//         actions: [
//           IconButton(
//             onPressed: () {
//               bool isFav = ref
//                   .read(favouriteMealProvider.notifier)
//                   .toggleMealFavouriteStatus(meal);

//               ScaffoldMessenger.of(context).clearSnackBars();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(isFav
//                       ? 'Meals added to favourite'
//                       : 'meals removed from favourite'),
//                 ),
//               );
//             },
//             icon: Icon(
//               isMealInFavouriteList ? Icons.star : Icons.star_outline,
//               color: Colors.yellow,
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               FadeInImage(
//                 fit: BoxFit.cover,
//                 height: 200,
//                 width: double.infinity,
//                 placeholder: MemoryImage(
//                   kTransparentImage,
//                 ),
//                 image: NetworkImage(
//                   meal.imageUrl,
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 "Ingredients",
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               for (final ingred in meal.ingredients)
//                 Text(
//                   ' $ingred',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               const SizedBox(
//                 height: 32,
//               ),
//               Text(
//                 "Steps",
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               for (final step in meal.steps)
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Text(
//                     ' $step',
//                     textAlign: TextAlign.start,
//                     style: const TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
 
 
//   }
// }
