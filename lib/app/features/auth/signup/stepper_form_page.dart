import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sugar_tracker/app/features/auth/signup/stepper_page_state.dart';
import 'package:sugar_tracker/app/modules/supabase_modules.dart';
import 'package:sugar_tracker/app/utils/constants.dart';

import 'components/date_picker.dart';
import 'components/pulsating_button.dart';

class StepperPage extends ConsumerStatefulWidget {
  const StepperPage({super.key});

  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends ConsumerState<StepperPage> {
  int _index = 0;
  List<String> types = ['Type 1', 'Type 2', 'Gestational Diabetes', 'Other'];

  Widget _buildDataStorageInfo() {
    return const Text(
      'We will not share or sell your personal data to any third parties for marketing or promotional purposes without your consent. Your data will be stored on Supabase AWS Cloud in Frankfurt.',
      style: TextStyle(fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final formControllers = ref.watch(formControllersProvider);
    final supabaseHelper = SupabaseHelpers(supabase);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account information',
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index < 3 - 1) {
            // changed this line
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          if (_index == 3 - 1) {
            return const Align(alignment: Alignment.bottomLeft);
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: details.onStepContinue,
                  child: const Text('Continue'),
                ),
              ],
            );
          }
        },
        steps: <Step>[
          Step(
            title: Text(
              'Basic Information',
              style: textTheme.titleLarge!.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
                alignment: Alignment.centerLeft,
                child: Form(
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: formControllers.firstNameController,
                            decoration: InputDecoration(
                              labelText: "First name",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: formControllers.lastNameController,
                            decoration: InputDecoration(
                              fillColor: colorScheme.tertiaryContainer,
                              labelText: "Last name",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: formControllers.cityCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "City code",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              prefixIcon: const Icon(Icons.numbers),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: formControllers.cityController,
                            decoration: InputDecoration(
                              labelText: "City",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              prefixIcon:
                                  const Icon(FontAwesomeIcons.city, size: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: formControllers.addressController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        prefixIcon: const Icon(FontAwesomeIcons.addressBook),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const MyDatePicker()
                  ]),
                )),
          ),
          Step(
            title: Text(
              'Health information',
              style: textTheme.titleLarge!.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Diabetes Type",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: types
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    // handle change here
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Choose diagnosis date",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24)),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary)),
                  child: Text(
                    DateFormat.yMMMd().format(ref.read(
                        selectedDateProvider)), // assuming this is the selected date
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: ref.read(selectedDateProvider),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (selectedDate != null) {
                      ref.read(selectedDateProvider.notifier).state =
                          selectedDate;
                    }
                  },
                ),
              ],
            ),
          ),
          Step(
            title: Text(
              'Privacy and Data Protection',
              style: textTheme.titleLarge!.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildDataStorageInfo(),
                const SizedBox(height: 150),
                PulsatingRoundButton(
                  onPressed: () async {
                    await supabaseHelper.insertPatientData(
                        formControllers.firstNameController.text,
                        formControllers.lastNameController.text,
                        formControllers.addressController.text,
                        ref.read(selectedDateProvider),
                        formControllers.cityCodeController.text,
                        formControllers.addressController.text,
                        formControllers.countryController.text,
                        int.parse(formControllers.cityCodeController.text),
                        123,
                        "email");
                  },
                  onFinished: () {
                    context.go("/home");
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
