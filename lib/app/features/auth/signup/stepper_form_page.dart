import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
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
                          ),
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
                          prefixIcon: const Icon(FontAwesomeIcons.addressBook)),
                    ),
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

class DiabetesTypeSelection extends StatefulWidget {
  const DiabetesTypeSelection({Key? key, required this.diabetesTypes})
      : super(key: key);

  final List<String> diabetesTypes;

  @override
  State<DiabetesTypeSelection> createState() => _DiabetesTypeSelectionState();
}

class _DiabetesTypeSelectionState extends State<DiabetesTypeSelection> {
  String selectedType = 'Type 1';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Choose diabetes type',
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.ticket),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
        dropdownColor: Theme.of(context).colorScheme.primaryContainer,
        style:
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
        value: selectedType,
        onChanged: (String? value) {
          setState(() {
            selectedType = value!;
            debugPrint(selectedType);
          });
        },
        items:
            widget.diabetesTypes.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    ]);
  }
}

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key}) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
      onTap: () {
        _selectDate(context);
      },
      controller: TextEditingController(
          text:
              "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
    );
  }
}

class PulsatingRoundButton extends StatefulWidget {
  const PulsatingRoundButton({super.key});

  @override
  State<PulsatingRoundButton> createState() => _PulsatingRoundButtonState();
}

class _PulsatingRoundButtonState extends State<PulsatingRoundButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _rotationAnimation;
  bool _arrowTapped = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOutExpo,
    ));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(
        begin: Colors.transparent, end: Theme.of(context).colorScheme.error);

    return GestureDetector(
      onTap: () {
        setState(() {
          _arrowTapped = true;
        });
        if (_arrowTapped) {
          _animationController!.addListener(() {
            setState(() {});
          });
          context.go("/home");
        }
      },
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          final Color shadowColor = colorTween.evaluate(_animationController!)!;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 10.0,
                  spreadRadius: _animationController!.value * 10,
                ),
              ],
            ),
            child: child,
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Transform.rotate(
            angle: _arrowTapped ? _rotationAnimation!.value : 0,
            child: Icon(
              FontAwesomeIcons.arrowRight,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
