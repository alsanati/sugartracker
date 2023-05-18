import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/models/meals.dart';

class NutritionStats extends StatelessWidget {
  final List<Meal> mealsData;
  const NutritionStats({
    Key? key,
    required this.mealsData,
  }) : super(key: key);

  double calculateSum(List<Meal> meals, String nutrient) {
    if (meals.isEmpty) return 0;

    double sum = 0.0;

    for (var meal in meals) {
      if (nutrient == "carbs") {
        sum += meal.carbs.toDouble();
      } else if (nutrient == "protein") {
        sum += meal.protein.toDouble();
      } else {
        sum += meal.fat.toDouble();
      }
    }

    return sum;
  }

  @override
  Widget build(BuildContext context) {
    double averageCarbs = calculateSum(mealsData, "carbs");
    double averageProtein = calculateSum(mealsData, "protein");
    double averageFat = calculateSum(mealsData, "fat");

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          height: 150,
          width: 400,
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Makros",
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: buildCircleStat(
                        context, 'Carbs', averageCarbs.toStringAsFixed(0)),
                  ),
                  Center(
                    child: buildCircleStat(
                        context, 'Protein', averageProtein.toStringAsFixed(0)),
                  ),
                  Center(
                      child: buildCircleStat(
                          context, 'Fat', averageFat.toStringAsFixed(0))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCircleStat(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2)),
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
