import 'package:flutter/material.dart';

class InputTextDialog extends StatelessWidget {
  const InputTextDialog({
    super.key,
    required this.fieldController,
  });

  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input Label'),
      content: TextField(
        controller: fieldController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(fieldController.text);
          },
          child: const Text('Change'),
        ),
      ],
    );
  }

  Future<String> show(BuildContext context) async {
    return (await showDialog<String>(
          context: context,
          builder: (ctx) => this,
        )) ??
        '';
  }
}
