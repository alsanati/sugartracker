import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sugar_tracker/app/utils/constants.dart';

class PostSugarLevels extends StatelessWidget {
  const PostSugarLevels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Add Sugar Levels'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const PostSugarLevelsBottomSheet(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PostSugarLevelsBottomSheet extends StatefulWidget {
  const PostSugarLevelsBottomSheet({Key? key}) : super(key: key);

  @override
  _PostSugarLevelsBottomSheetState createState() =>
      _PostSugarLevelsBottomSheetState();
}

class _PostSugarLevelsBottomSheetState
    extends State<PostSugarLevelsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _sugarLevelController = TextEditingController();

  int _mealGroupValue = 0;

  Future<void> upload() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userId = supabase.auth.currentUser?.id;
        final patientId = await supabase.patient.getCurrentPatientId();
        final sugarLevels = _sugarLevelController.text;
        final response = await supabase.from('diabetes_sugar').insert({
          'personId': userId,
          'sugar_level': sugarLevels,
          'patient_id': patientId
        });
        if (mounted) {
          context.showSnackBar(
              message: 'Successfully posted your sugar levels!');
        }

        debugPrint(response);
        _sugarLevelController.clear();
      } on AuthException catch (error) {
        context.showErrorSnackBar(message: error.message);
      } catch (error) {
        debugPrint(error.toString());
        context.showErrorSnackBar(message: 'Unexpected error occurred');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _sugarLevelController.dispose();
    super.dispose();
  }

  Widget _buildSugarLevelTextField(
      BuildContext context, String hintText, TextEditingController controller) {
    return SizedBox(
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a sugar level';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Enter blood sugar level",
          labelStyle: Theme.of(context).textTheme.labelMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final buttonBackgroundColor =
        Theme.of(context).colorScheme.primaryContainer;
    final screenWidth = MediaQuery.of(context).size.width;
    // Use the padding from the MediaQuery's viewInsets
    final EdgeInsets viewInsets = MediaQuery.of(context).viewInsets;
    return Padding(
      padding: EdgeInsets.only(
        left: viewInsets.left,
        right: viewInsets.right,
        bottom: viewInsets.bottom,
      ),
      child: Container(
        margin:
            const EdgeInsets.all(8.0), // Add consistent spacing from the edges
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Wrap(
                  spacing: 20.0,
                  children: List<Widget>.generate(
                    2,
                    (int index) {
                      return ChoiceChip(
                        label: Text(index == 0 ? 'Fasting' : 'After Meal'),
                        selected: _mealGroupValue == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _mealGroupValue =
                                selected ? index : _mealGroupValue;
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(height: 16),
              _buildSugarLevelTextField(
                  context, 'Enter your sugar level', _sugarLevelController),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth,
                child: Center(
                  child: ElevatedButton(
                    onPressed: upload,
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
                    child: Text(_isLoading ? 'Loading...' : 'Track Sugar Level',
                        style: TextStyle(color: buttonColor)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
