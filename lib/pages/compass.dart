import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  MagnetometerEvent _magnetometerEvent = MagnetometerEvent(0, 0, 0);
  StreamSubscription? subscription;

  //Initiation of the compass

  @override
  void initState() {
    super.initState();
    subscription = magnetometerEvents.listen((event) {
      setState(() {
        _magnetometerEvent = event;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  //Calculation of the direction.

  double calculateDegrees(double x, double y) {
    double heading = atan2(x, y);
    heading = heading * 180 / pi;

    if (heading > 0) {
      heading -= 360;
    }
    return heading * -1;
  }

  @override
  Widget build(BuildContext context) {
    final degrees = calculateDegrees(_magnetometerEvent.x, _magnetometerEvent.y);
    final angle = -1 * pi / 180 * degrees;

    //The compass (diplay of the direction)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass'),
      ),
      body:  Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Rotated at ${degrees.toStringAsFixed(0)} degree(s)'),
            Expanded(
                child: Center(
              child: Transform.rotate(
                angle: angle,
                child: Image.asset('images/compass.png',height: MediaQuery.of(context).size.height * 0.8,),
                
              ),
            ))
          ],
        ),
      ),
    );
  }
}
