// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:light_sensor/light_sensor.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   late StreamSubscription<int> _lightSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//           });
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     double containerOpacity =
//         1 - (_lightIntensity / 40000);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Positioned(
//               top: 26,
//               left: 100,
//               child: Container(
//                 width: 196,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color.fromARGB(255, 255, 221, 1)
//                       .withOpacity(containerOpacity),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(255, 255, 221, 1)
//                           .withOpacity(containerOpacity),
//                       blurRadius: 10,
//                       spreadRadius: 10,
//                       offset: Offset(0, 0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';

class LightSensorPage extends StatefulWidget {
  @override
  _LightSensorPageState createState() => _LightSensorPageState();
}

class _LightSensorPageState extends State<LightSensorPage> {
  double _lightIntensity = 0.0;
  late StreamSubscription<int> _lightSubscription;

  @override
  void initState() {
    super.initState();
    _startListeningToLightSensor();
  }

  @override
  void dispose() {
    _lightSubscription.cancel();
    super.dispose();
  }

  void _startListeningToLightSensor() {
    LightSensor.hasSensor().then((hasSensor) {
      if (hasSensor) {
        _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
          setState(() {
            _lightIntensity = luxValue.toDouble();
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.hintColor,
        title: Text(
          'Light Sensor',
          style: TextStyle(color: theme.primaryColor),
        ),
        iconTheme: IconThemeData(
          color: theme.primaryColor,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: 100,
              color: Colors.yellow[800],
            ),
            SizedBox(height: 20),
            Text(
              'Light Intensity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${_lightIntensity.toStringAsFixed(2)} lux',
              style: TextStyle(
                fontSize: 20,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
