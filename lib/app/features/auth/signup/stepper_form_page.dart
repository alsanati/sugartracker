import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/date_picker.dart';
import 'components/diabetes_picker.dart';
import 'components/pulsating_button.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int _index = 0;
  List<String> types = ['Type 1', 'Type 2', 'Gestational Diabetes', 'Other'];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();

  Widget _buildDataStorageInfo() {
    return const Text(
      'We will not share or sell your personal data to any third parties for marketing or promotional purposes without your consent. Your data will be stored on Supabase AWS Cloud in Frankfurt.',
      style: TextStyle(fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account information',
          style: TextStyle(color: primaryColor),
        ),
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
          if (_index <= 0) {
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
            return const Align(
                alignment: Alignment.bottomLeft, child: PulsatingRoundButton());
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
              style:
                  TextStyle(color: secondaryColor, fontWeight: FontWeight.w900),
            ),
            content: Container(
                alignment: Alignment.centerLeft,
                child: Form(
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              iconColor: tertiaryColor,
                              hintText: "First name",
                            ),
                            controller: _firstNameController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              iconColor: tertiaryColor,
                              hintText: "Last name",
                            ),
                            controller: _lastNameController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0)),
                                iconColor: tertiaryColor,
                                prefixIcon: const Icon(Icons.numbers),
                                hintText: "City code",
                              ),
                              keyboardType: TextInputType.number,
                              controller: _cityCodeController),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0)),
                                iconColor: tertiaryColor,
                                hintText: "City",
                                prefixIcon: const Icon(FontAwesomeIcons.city,
                                    size: 15)),
                            controller: _cityController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            hintText: "Address",
                            prefixIcon:
                                const Icon(FontAwesomeIcons.addressBook)),
                        controller: _adressController),
                    const SizedBox(height: 10),
                    const MyDatePicker()
                  ]),
                )),
          ),
          Step(
              title: Text(
                'Health information',
                style: TextStyle(
                    color: secondaryColor, fontWeight: FontWeight.w900),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DiabetesTypeSelection(
                    diabetesTypes: types,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Choose diagnosis date",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  const MyDatePicker(),
                  const PulsatingRoundButton()
                ],
              )),
          Step(
            title: Text(
              'Privacy and Data Protection',
              style:
                  TextStyle(color: secondaryColor, fontWeight: FontWeight.w900),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildDataStorageInfo(),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
