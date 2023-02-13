import 'package:flutter/material.dart';
import 'package:rive_lessons/src/input_text_dialog.dart';
import 'package:rive_lessons/src/rectangle_model.dart';

class RectangleWidget extends StatefulWidget {
  const RectangleWidget({
    super.key,
    required this.rec,
    required this.width,
    required this.height,
    required this.onChange,
  });

  final double width;
  final double height;
  final RectangleModel rec;
  final VoidCallback onChange;

  @override
  State<RectangleWidget> createState() => _RectangleWidgetState();
}

class _RectangleWidgetState extends State<RectangleWidget> {
  @override
  Widget build(BuildContext context) {
    final width = widget.width * widget.rec.ex - widget.width * widget.rec.x;
    final height = widget.height * widget.rec.ey - widget.height * widget.rec.y;

    return GestureDetector(
      onTap: () async {
        final text = await InputTextDialog(
          fieldController: TextEditingController(text: widget.rec.text),
        ).show(context);
        widget.rec.text = text;
        setState(() {});
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Stack(children: [
          _CropWidget(
            align: Alignment.topLeft, onUpdate: (details) {},
            //   final global = details.globalPosition;
            //   if (global.dx >= (widget.rec.ex - 25) &&
            //       global.dy > (widget.rec.ey - 25 + widget.topHeight)) {
            //     return;
            //   } else if (global.dx >= (widget.rec.ex - 25)) {
            //     widget.rec.y = global.dy - widget.topHeight;
            //     widget.rec.height = widget.rec.ey - widget.rec.y;
            //   } else if (global.dy >
            //       (widget.rec.ey - 25 + widget.topHeight)) {
            //     widget.rec.x = global.dx;
            //     widget.rec.width = widget.rec.ex - widget.rec.x;
            //   } else {
            //     widget.rec.x = global.dx;
            //     widget.rec.y = global.dy - widget.topHeight;
            //     widget.rec.width = widget.rec.ex - widget.rec.x;
            //     widget.rec.height = widget.rec.ey - widget.rec.y;
            //   }
            //   widget.onChange();
            // },
          ),
          _CropWidget(
            align: Alignment.topRight, onUpdate: (details) {},
            //   final global = details.globalPosition;
            //   if (global.dx <= (widget.rec.x + 25) &&
            //       global.dy > (widget.rec.ey - 25 + widget.topHeight)) {
            //     return;
            //   } else if (global.dx <= (widget.rec.x + 25)) {
            //     widget.rec.y = global.dy - widget.topHeight;
            //     widget.rec.height = widget.rec.ey - widget.rec.y;
            //   } else if (global.dy >
            //       (widget.rec.ey - 25 + widget.topHeight)) {
            //     widget.rec.ex = global.dx;
            //     widget.rec.width = widget.rec.ex - widget.rec.x;
            //   } else {
            //     widget.rec.ex = global.dx;
            //     widget.rec.y = global.dy - widget.topHeight;
            //     widget.rec.width = widget.rec.ex - widget.rec.x;
            //     widget.rec.height = widget.rec.ey - widget.rec.y;
            //   }
            //   widget.onChange();
            // },
          ),
          _CropWidget(
            align: Alignment.bottomLeft,
            onUpdate: (details) {
              // final global = details.globalPosition;
              // if (global.dx >= (widget.rec.ex - 25) &&
              //     global.dy < (widget.rec.y + 25 + widget.topHeight)) {
              //   return;
              // } else if (global.dx >= (widget.rec.ex - 25)) {
              //   widget.rec.ey = global.dy - widget.topHeight;
              //   widget.rec.height = widget.rec.ey - widget.rec.y;
              // } else if (global.dy < (widget.rec.y + 25 + widget.topHeight
              // ))
              // {
              //   widget.rec.x = global.dx;
              //   widget.rec.width = widget.rec.ex - widget.rec.x;
              // } else {
              //   widget.rec.x = global.dx;
              //   widget.rec.ey = global.dy - widget.topHeight;
              //   widget.rec.width = widget.rec.ex - widget.rec.x;
              //   widget.rec.height = widget.rec.ey - widget.rec.y;
              // }
              // widget.onChange();
            },
          ),
          _CropWidget(
            align: Alignment.bottomRight,
            onUpdate: (details) {
              // final global = details.globalPosition;
              // if (global.dx <= (widget.rec.x + 25) &&
              //     global.dy < (widget.rec.y + 25 + widget.topHeight)) {
              //   return;
              // } else if (global.dx <= (widget.rec.x + 25)) {
              //   widget.rec.ey = global.dy - widget.topHeight;
              //   widget.rec.height = widget.rec.ey - widget.rec.y;
              // } else if (global.dy < (widget.rec.y + 25 + widget.topHeight
              // )) {
              //   widget.rec.ex = global.dx;
              //   widget.rec.width = widget.rec.ex - widget.rec.x;
              // } else {
              //   widget.rec.ex = global.dx;
              //   widget.rec.ey = global.dy - widget.topHeight;
              //   widget.rec.width = widget.rec.ex - widget.rec.x;
              //   widget.rec.height = widget.rec.ey - widget.rec.y;
              // }
              // widget.onChange();
            },
          ),
          Center(
            child: Text(
              widget.rec.text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
      ),
    );
  }
}

class _CropWidget extends StatelessWidget {
  const _CropWidget({
    required this.align,
    required this.onUpdate,
  });

  final AlignmentGeometry align;
  final void Function(DragUpdateDetails) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: GestureDetector(
          onPanUpdate: onUpdate,
          child: Container(
            height: 10,
            width: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
