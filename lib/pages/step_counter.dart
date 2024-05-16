// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';

// String formatDate(DateTime d) {
//   return d.toString().substring(0, 19);
// }

// class StepCounter extends StatefulWidget {
//   @override
//   _StepCounterState createState() => _StepCounterState();
// }

// class _StepCounterState extends State<StepCounter> {
//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;
//   String _status = '?', _steps = '?';
//   bool _isCounting = false;

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//   }

//   _requestPermission() async {
//     PermissionStatus status = await Permission.activityRecognition.request();
//     if (status.isGranted) {
//       initPlatformState();
//     } else {
//       print('Permission denied');
//       // Handle denied permission
//     }
//   }

//   void onStepCount(StepCount event) {
//     print(event);
//     setState(() {
//       _steps = event.steps.toString();
//     });
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print(event);
//     setState(() {
//       _status = event.status;
//     });
//   }

//   void onPedestrianStatusError(error) {
//     print('onPedestrianStatusError: $error');
//     setState(() {
//       _status = 'Pedestrian Status not available';
//     });
//   }

//   void onStepCountError(error) {
//     print('onStepCountError: $error');
//     setState(() {
//       _steps = 'Step Count not available';
//     });
//   }

//   void initPlatformState() {
//     _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//     _pedestrianStatusStream
//         .listen(onPedestrianStatusChanged)
//         .onError(onPedestrianStatusError);

//     _stepCountStream = Pedometer.stepCountStream;
//     _stepCountStream.listen(onStepCount).onError(onStepCountError);
//   }

//   void startCounting() {
//     initPlatformState();
//     setState(() {
//       _isCounting = true;
//     });
//   }

//   void stopCounting() {
//     _pedestrianStatusStream.drain();
//     _stepCountStream.drain();
//     setState(() {
//       _isCounting = false;
//       _steps = '?';
//       _status = '?';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Step Counter'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'Steps Taken',
//                 style: TextStyle(fontSize: 30),
//               ),
//               Text(
//                 _steps,
//                 style: const TextStyle(fontSize: 60),
//               ),
//               const Divider(
//                 height: 100,
//                 thickness: 0,
//                 color: Colors.white,
//               ),
//               const Text(
//                 'Pedestrian Status',
//                 style: TextStyle(fontSize: 30),
//               ),
//               Icon(
//                 _status == 'walking'
//                     ? Icons.directions_walk
//                     : _status == 'stopped'
//                         ? Icons.accessibility_new
//                         : Icons.error,
//                 size: 100,
//               ),
//               Center(
//                 child: Text(
//                   _status,
//                   style: _status == 'walking' || _status == 'stopped'
//                       ? const TextStyle(fontSize: 30)
//                       : const TextStyle(fontSize: 20, color: Colors.red),
//                 ),
//               )
//             ],
//           ),
//         ),
        
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  bool _isCounting = false;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {
    PermissionStatus status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      initPlatformState();
    } else {
      print('Permission denied');
      // Handle denied permission
    }
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void startCounting() {
    initPlatformState();
    setState(() {
      _isCounting = true;
    });
  }

  void stopCounting() {
    _pedestrianStatusStream.drain();
    _stepCountStream.drain();
    setState(() {
      _isCounting = false;
      _steps = '0';
      _status = '?';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Step Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Steps Taken',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                _steps,
                style: const TextStyle(fontSize: 60),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isCounting ? null : startCounting,
                child: Text('Start'),
              ),
              ElevatedButton(
                onPressed: _isCounting ? stopCounting : null,
                child: Text('Stop'),
              ),
              ElevatedButton(
                onPressed: _isCounting ? null : () => setState(() => _steps = '0'),
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
