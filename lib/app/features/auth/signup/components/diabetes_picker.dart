import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../stepper_page_state.dart';

class DiabetesTypeSelection extends ConsumerWidget {
  const DiabetesTypeSelection({Key? key, required this.diabetesTypes})
      : super(key: key);

  final List<String> diabetesTypes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diabetesType = ref.watch(diabetesTypeProvider);

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
        value: diabetesType,
        onChanged: (String? value) {
          ref.read(diabetesTypeProvider.notifier).update((state) => value!);
        },
        items: diabetesTypes.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    ]);
  }
}
