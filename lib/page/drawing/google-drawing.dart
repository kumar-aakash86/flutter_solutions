import 'package:flutter/material.dart';
import 'dart:math';

class GoogleDrawing extends StatefulWidget {
  @override
  _GoogleDrawingState createState() => _GoogleDrawingState();
}

class _GoogleDrawingState extends State<GoogleDrawing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Drawing"),
      ),
      body: GridView.count(crossAxisCount: 2, children: <Widget>[
        Container(
          child: CustomPaint(
            child: Container(
              height: 100,
            ),
            painter: GoogleAddIcon(),
          ),
        ),
        Container(
              color: Colors.purple.shade100,
          child: CustomPaint(
            child: Container(
              height: 100,
            ),
            painter: GoogleIcon(),
          ),
        ),
        Container(
              color: Colors.purple.shade100,
          child: CustomPaint(
            child: Container(
              height: 100,
            ),
            painter: GoogleShadowIcon(),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: CustomPaint(
          child: Container(
            height: 100,
          ),
          painter: GoogleAddIcon(),
        ),
      ),
    );
  }
}

class GoogleShadowIcon extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    var halfWidth = size.width / 2;
    var halfHeight = size.height / 2;
    var center = Offset(halfWidth, halfHeight);

    var percentage = 2*pi* (32/100);

    paint.color = Colors.red;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 3.5, percentage, false, paint);

    
    percentage = 2*pi* (15/100);
    paint.color = Colors.yellow.shade400;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 2.7, percentage, false, paint);

    percentage = 2*pi* (27/100);
    paint.color = Colors.green;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 1, percentage, false, paint);

    percentage = 2*pi* (19/100);
    paint.color = Colors.blueAccent;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 6.12, percentage, false, paint);

    var drawHeight = 15.0;
    canvas.drawLine(center, Offset(halfWidth+29, halfHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}

class GoogleIcon extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    var halfWidth = size.width / 2;
    var halfHeight = size.height / 2;
    var center = Offset(halfWidth, halfHeight);

    var percentage = 2*pi* (32/100);

    paint.color = Colors.red;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 3.5, percentage, false, paint);

    
    percentage = 2*pi* (15/100);
    paint.color = Colors.yellow.shade400;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 2.7, percentage, false, paint);

    percentage = 2*pi* (27/100);
    paint.color = Colors.green;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 1, percentage, false, paint);

    percentage = 2*pi* (19/100);
    paint.color = Colors.blueAccent;
    canvas.drawArc(Rect.fromCenter(center: center, width: 50, height: 50), 6.12, percentage, false, paint);

    var drawHeight = 15.0;
    canvas.drawLine(center, Offset(halfWidth+29, halfHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}

class GoogleAddIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    var halfWidth = size.width / 2;
    var halfHeight = size.height / 2;
    var center = Offset(halfWidth, halfHeight);
    // canvas.drawCircle(center, 30, paint);

    var drawHeight = 15.0;
    paint.strokeWidth = 5;
    paint.color = Colors.red;
    canvas.drawLine(center,
        Offset(halfWidth, halfHeight - drawHeight), paint);

    paint.color = Colors.orange;
    canvas.drawLine(center,
        Offset(halfWidth - drawHeight, halfHeight), paint);

    paint.color = Colors.green;
    canvas.drawLine(center,
        Offset(halfWidth, halfHeight + drawHeight), paint);

    paint.color = Colors.blue;
    canvas.drawLine(center,
        Offset(halfWidth + drawHeight, halfHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
