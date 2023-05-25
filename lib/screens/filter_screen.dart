import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/provider/filters_provider.dart';

enum Filters {
  guttenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });
  // final Map<Filters, bool> selectedFilter;

//   @override
//   ConsumerState<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends ConsumerState<FilterScreen> {
//   var _guttenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegeterianFilterSet = false;
//   var _veganFilterSet = false;

//   @override
//   void initState() {
//     super.initState();
//     final selectedFilter = ref.read(filtersProvider);
//     _guttenFreeFilterSet = selectedFilter[Filters.guttenFree]!;
//     _lactoseFreeFilterSet = selectedFilter[Filters.lactoseFree]!;
//     _vegeterianFilterSet = selectedFilter[Filters.vegeterian]!;
//     _veganFilterSet = selectedFilter[Filters.vegan]!;
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Filters, bool> activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.pop(context);
      //   if (identifier == 'meals') {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => TabsScreen()));
      //   }
      // }),
      appBar: AppBar(
        title: const Text("Your filter"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filters.guttenFree]!,
            onChanged: (bol) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.guttenFree, bol);
            },
            title: Text(
              'Gluten free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include guttenfree meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 34),
          ),
          SwitchListTile(
            value: activeFilters[Filters.lactoseFree]!,
            onChanged: (bol) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.lactoseFree, bol);
            },
            title: Text(
              'Lactose free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 34),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegeterian]!,
            onChanged: (bol) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.vegeterian, bol);
            },
            title: Text(
              'Vegeterian meal',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegeterian meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 34),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegan]!,
            onChanged: (bol) {
              ref.read(filtersProvider.notifier).setFilter(Filters.vegan, bol);
            },
            title: Text(
              'Vegan meal',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegan meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 34),
          ),
        ],
      ),
    );
  }
}
