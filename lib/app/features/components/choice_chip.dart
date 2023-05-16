import 'package:flutter/material.dart';

class ChoiceChipDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;

  const ChoiceChipDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showDialog<T>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: items
                  .map((item) => SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, item);
                        },
                        child: Text(labelBuilder(item)),
                      ))
                  .toList(),
            );
          },
        );
        onChanged(result);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          labelBuilder(value),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
