import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account information'),
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
        steps: <Step>[
          Step(
            title: const Text('Basic Information'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: Form(
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter you name",
                          prefixIcon: Icon(Icons.input)),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter your age",
                          prefixIcon: Icon(Icons.numbers)),
                    )
                  ]),
                )),
          ),
          Step(
            title: const Text('Health data'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: Form(
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Diabetes type",
                          prefixIcon: Icon(Icons.input)),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Medication",
                          prefixIcon: Icon(Icons.medical_information)),
                    )
                  ]),
                )),
          ),
          Step(
            title: const Text('Medication data'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: Form(
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Diabetes type",
                          prefixIcon: Icon(Icons.input)),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Medication",
                          prefixIcon: Icon(Icons.medical_information)),
                    )
                  ]),
                )),
          ),
        ],
      ),
    );
  }
}
