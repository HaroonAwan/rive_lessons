class RectangleModel {
  RectangleModel({
    required this.id,
    required this.height,
    required this.width,
    required this.text,
    required this.x,
    required this.y,
    required this.ex,
    required this.ey,
  });

  factory RectangleModel.fromJson(Map<String, dynamic> json) => RectangleModel(
        id: json['id'] as String,
        height: (json['height'] as num).toDouble(),
        width: (json['width'] as num).toDouble(),
        text: json['text'] as String,
        x: (json['x'] as num).toDouble(),
        y: (json['y'] as num).toDouble(),
        ex: (json['ex'] as num).toDouble(),
        ey: (json['ey'] as num).toDouble(),
      );

  final String id;
  double x;
  double y;
  double ex;
  double ey;
  double height;
  double width;
  String text;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'x': x,
        'y': y,
        'ex': ex,
        'ey': ey,
        'height': height,
        'width': width,
        'text': text,
      };
}
