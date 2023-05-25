import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/meals.dart';
import '../../../modules/meal_module.dart';

class MealBottomSheetPage extends StatelessWidget {
  const MealBottomSheetPage({Key? key}) : super(key: key);

  void _showMealBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const MealBottomSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _showMealBottomSheet(context),
        child: const Text('Add Meal'),
      ),
    );
  }
}

class MealBottomSheet extends StatefulWidget {
  const MealBottomSheet({super.key});

  @override
  _MealBottomSheetState createState() => _MealBottomSheetState();
}

class _MealBottomSheetState extends State<MealBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _isLoading = false;

  double _currentCarbValue = 20;
  double _currentProteinValue = 20;
  double _currentFatValue = 20;
  final _mealNameController = TextEditingController();

  MealType _selectedMealType = MealType.breakfast;

  final MealRepository mealRepository =
      MealRepository(Supabase.instance.client);

  Future<void> _addMeal() async {
    DateTime mealDateTime = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);

    // Here you can create a Meal object with the required properties
    Meal newMeal = Meal(
      mealType: _selectedMealType,
      mealTime: mealDateTime,
      carbs: _currentCarbValue,
      protein: _currentProteinValue,
      fat: _currentFatValue,
      calories: calculateTotalCalories(),
      mealName: _mealNameController.text.toString(),
      createdAt: DateTime.now(),
    );

    // Call the addMeal method from the MealRepository
    await mealRepository.addMeal(newMeal, context);
  }

  int calculateTotalCalories() {
    // Assuming carbs, proteins and fats are in grams
    // and using common nutritional values:
    // 1 gram of carbs = 4 calories
    // 1 gram of protein = 4 calories
    // 1 gram of fat = 9 calories
    double totalCalories = (_currentCarbValue * 4) +
        (_currentProteinValue * 4) +
        (_currentFatValue * 9);

    return totalCalories.round();
  }

  void _handleMealTypeChanged(MealType mealType) {
    setState(() {
      _selectedMealType = mealType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).colorScheme.onSecondaryContainer;
    final labelMediumStyle = Theme.of(context).textTheme.labelLarge;

    final buttonBackgroundColor =
        Theme.of(context).colorScheme.secondaryContainer;
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          SizedBox(
            width: 460,
            child: Center(
              child: Wrap(
                spacing: 10.0,
                children: [
                  ChoiceChip(
                    label: Text(
                      'Date: ${DateFormat.yMd().format(_selectedDate)}',
                      style: labelMediumStyle,
                    ),
                    selected: false,
                    onSelected: (bool _) async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020, 1),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text('Meal Time: ${_selectedTime.format(context)}'),
                    selected: false,
                    onSelected: (bool _) async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (pickedTime != null && pickedTime != _selectedTime) {
                        setState(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.black,
          ),
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: MealTypeChips(
                          onMealTypeChanged: _handleMealTypeChanged)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: screenWidth * 0.87,
                    height: 60,
                    child: TextFormField(
                      controller: _mealNameController,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          labelText: 'Meal Name',
                          labelStyle: labelMediumStyle),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a meal name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Carbs: ${_currentCarbValue.round().toString()}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    width: 400,
                    child: Slider(
                      value: _currentCarbValue,
                      min: 0,
                      max: 250,
                      divisions: 100,
                      label: _currentCarbValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentCarbValue = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Protein: ${_currentProteinValue.round().toString()}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    width: 400,
                    child: Slider(
                      value: _currentProteinValue,
                      min: 0,
                      max: 250,
                      divisions: 250,
                      label: _currentProteinValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentProteinValue = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Fat: ${_currentFatValue.round().toString()}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    width: 400,
                    child: Slider(
                      value: _currentFatValue,
                      min: 0,
                      max: 250,
                      divisions: 250,
                      label: _currentFatValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentFatValue = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Total calories: ${calculateTotalCalories().round()}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: screenWidth,
                child: Center(
                  child: ElevatedButton(
                    onPressed: _addMeal,
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      } else if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      return buttonBackgroundColor;
                    })),
                    child: Text(_isLoading ? 'Loading...' : 'Add meal',
                        style: TextStyle(color: buttonColor)),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MealTypeChips extends StatefulWidget {
  final ValueChanged<MealType> onMealTypeChanged;

  const MealTypeChips({super.key, required this.onMealTypeChanged});

  @override
  _MealTypeChipsState createState() => _MealTypeChipsState();
}

class _MealTypeChipsState extends State<MealTypeChips> {
  MealType _selectedMealType = MealType.breakfast;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: MealType.values.map((mealType) {
        return ChoiceChip(
          label: Text(
            mealType.toString().split('.').last,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          selected: _selectedMealType == mealType,
          onSelected: (bool selected) {
            setState(() {
              _selectedMealType = mealType;
            });
            widget.onMealTypeChanged(_selectedMealType);
          },
        );
      }).toList(),
    );
  }
}
