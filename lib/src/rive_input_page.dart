import 'package:flutter/material.dart';
import 'package:rive_lessons/src/image_label_page.dart';

class RiveInputPage extends StatefulWidget {
  const RiveInputPage({Key? key}) : super(key: key);

  @override
  State<RiveInputPage> createState() => _RiveInputPageState();
}

class _RiveInputPageState extends State<RiveInputPage> {
  final _textController = TextEditingController();
  var _input = true;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (_input) {
      child = Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter rive link',
              labelText: 'Rive link',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.isEmpty) {
                return;
              }
              _input = false;
              setState(() {});
            },
            child: const Text('Input'),
          ),
        ]),
      );
    } else {
      child = ImageLabelWidget(
        imageLabelController: ImageLabelController(
          url: _textController.text.trim(),
        ),
      );
    }
    return Scaffold(body: child);
  }
}
