import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 300,
            height: 300,
            // color: Colors.white54,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(170)),
                boxShadow: [
                  BoxShadow(
                      color: (Colors.grey[600])!,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: (Colors.grey[200])!,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 10.0,
                      spreadRadius: 1.0)
                ]),
          ),
        ),
        Center(
          child: Container(
            width: 100,
            height: 100,
            // color: Colors.white54,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                      color: (Colors.grey[600])!,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: (Colors.grey[200])!,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 10.0,
                      spreadRadius: 1.0)
                ]),
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  var radius = 150;

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var dotBrush = Paint()..color = Color.fromARGB(255, 0, 0, 0);

    var secBrush = Paint()
      ..color = (Color.fromARGB(255, 255, 0, 0))!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minBrush = Paint()
      ..color = (Colors.grey[500])!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var hrBrush = Paint()
      ..color = (Colors.grey[600])!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var dashBrush = Paint()
      ..color = (Colors.grey[600])!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var inDashBrush = Paint()
      ..color = (Colors.grey[500])!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var neuShadow = Path()
      ..addOval(Rect.fromCircle(center: center, radius: 100));

    // canvas.drawCircle(center, 50, inNeuCircle);o
    // canvas.drawShadow(neuShadow, ui.Color.fromARGB(255, 255, 255, 255), 10.0, false);
    // final outerShadowRect = Rect.fromCircle(center: center, radius: 10);
    // final outerShadowPaint = Paint()
    //   ..color = darkColor.withOpacity(0.2)
    //   ..maskFilter = ui.MaskFilter.blur(BlurStyle.normal, 10.0);
    // canvas.drawCircle(center, outerShadowRect.width / 2, outerShadowPaint);

    var secHandX = centerX + 90 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 90 * sin(dateTime.second * 6 * pi / 180);
    // canvas.drawLine(Offset(secHandX, secHandY), Offset(secHandX, secHandY), secBrush);
    canvas.drawCircle(Offset(secHandX, secHandY), 3, secBrush);

    var minuteHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minuteHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minBrush);
    // canvas.drawCircle(Offset(minuteHandX, minuteHandY), 5, minBrush);

    var hrHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hrHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hrHandX, hrHandY), hrBrush);
    // canvas.drawCircle(Offset(hrHandX, hrHandY), 5, hrBrush);

    for (double i = 0; i <= 360; i += 6) {
      var x1 = centerX + 130 * cos(i * pi / 180);
      var y1 = centerX + 130 * sin(i * pi / 180);

      var x2 = centerX + 128 * cos(i * pi / 180);
      var y2 = centerX + 128 * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), inDashBrush);
    }

    for (double i = 0; i <= 360; i += 30) {
      var x1 = centerX + 130 * cos(i * pi / 180);
      var y1 = centerX + 130 * sin(i * pi / 180);

      var x2 = centerX + 120 * cos(i * pi / 180);
      var y2 = centerX + 120 * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
