import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutputDialog extends StatelessWidget {
  const OutputDialog(
    this.output, {
    super.key,
  });

  final String output;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 45),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: min(500, width)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF3282B8)),
                      onPressed: Navigator.of(context).pop,
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 7,
                  initialValue: output,
                  readOnly: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: output));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  child: const Text('Copy'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => this,
    );
  }
}
