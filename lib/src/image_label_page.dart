import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';
import 'package:rive/rive.dart';
import 'package:rive_lessons/src/outputs_dialog.dart';
import 'package:rive_lessons/src/rectangle_model.dart';
import 'package:rive_lessons/src/rectangle_widget.dart';

class ImageLabelController extends ChangeNotifier {
  ImageLabelController({
    required this.url,
  });

  final String url;

  String? image;

  List<RectangleModel> rectangles = <RectangleModel>[];

  void startNew(DragStartDetails details, double width, double height) {
    final global = details.localPosition;
    rectangles.add(
      RectangleModel(
        id: DateTime.now().toIso8601String(),
        height: 0,
        width: 0,
        text: '',
        x: global.dx / width,
        y: global.dy / height,
        ex: global.dx / width,
        ey: global.dy / height,
      ),
    );
    notifyListeners();
  }

  void updateNew(DragUpdateDetails details, double width, double height) {
    final x = details.localPosition.dx / width;
    final y = details.localPosition.dy / height;

    rectangles.last.ex = x;
    rectangles.last.ey = y;
    notifyListeners();
  }
}

class ImageLabelWidget extends ControlledWidget<ImageLabelController> {
  const ImageLabelWidget({
    required this.imageLabelController,
    super.key,
  }) : super(controller: imageLabelController);

  final ImageLabelController imageLabelController;

  @override
  State<ImageLabelWidget> createState() => _ImageLabelPageState();
}

class _ImageLabelPageState extends State<ImageLabelWidget>
    with ControlledStateMixin {
  double aspectRatioX = 0;
  double aspectRatioY = 0;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();

    RiveFile.network(widget.controller.url).then((value) {
      for (final artBoard in value.artboards) {
        aspectRatioX = artBoard.height / artBoard.width;
        aspectRatioY = artBoard.width / artBoard.height;
      }
      _isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(children: [
      ElevatedButton(
        onPressed: () async {
          final rec =
              widget.controller.rectangles.map((e) => e.toJson()).toList();
          final encodedData = jsonEncode(rec);
          await OutputDialog(encodedData).show(context);
        },
        child: const Text('Output'),
      ),
      Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            var width = aspectRatioY * constraints.maxHeight;
            var height = aspectRatioX * constraints.maxWidth;
            if (height / width < aspectRatioX) {
              width = aspectRatioY * height;
            }
            height = aspectRatioY * constraints.maxHeight;
            if (width / height < aspectRatioY) {
              height = aspectRatioX * width;
            }
            return Stack(children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: height,
                  maxWidth: width,
                ),
                child: GestureDetector(
                  onPanStart: (details) =>
                      widget.controller.startNew(details, width, height),
                  onPanUpdate: (details) =>
                      widget.controller.updateNew(details, width, height),
                  child: RiveAnimation.network(
                    widget.controller.url,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              for (var rec in widget.controller.rectangles) ...[
                Positioned(
                  left: width * rec.x,
                  top: height * rec.y,
                  child: RectangleWidget(
                    rec: rec,
                    width: width,
                    height: height,
                    onChange: () => setState(() {}),
                  ),
                ),
              ],
            ]);
          },
        ),
      ),
    ]);
  }
}
