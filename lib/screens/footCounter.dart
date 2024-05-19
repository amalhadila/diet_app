import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sensors_plus/sensors_plus.dart';

class FootCounter extends StatefulWidget {
  const FootCounter({Key? key}) : super(key: key);

  @override
  _FootCounterState createState() => _FootCounterState();
}

class _FootCounterState extends State<FootCounter> {
  double X = 0.0;
  double Y = 0.0;
  double Z = 0.0;
  int steps = 0;
  double DeltaDistance = 0.0;
  double burnedcalories=0.0;
  double previousDistance = 0.0;
  late StreamSubscription _accelerometerSubscription;
  final storage = GetStorage();

  @override
   void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await ReturnPreviousDistance();
    await ReturnPrevioussteps();
    calcburnedcalories(steps);
    startListening();
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription.cancel(); 
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
            children:[ Text(
              "Steps: ${steps}",
              style: const TextStyle(
                fontSize: 22,
                            fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),Text(
              "clrs: ${burnedcalories}",
              style: const TextStyle(
                fontSize: 22,
                            fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),]
        
        ),
      ],
    );
  }
   checkAndResetValues() {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      final now = DateTime.now();
      final lastResetTimeInt = storage.read('lastResetTime') ?? 0;
      final lastResetTime = DateTime.fromMillisecondsSinceEpoch(lastResetTimeInt);
      final twentyFourHoursInMilliseconds = 24*60*60* 1000;
      if (now.difference(lastResetTime).inMilliseconds >= twentyFourHoursInMilliseconds) {
        resetValues();
        storage.write('lastResetTime', now.millisecondsSinceEpoch);
        t.cancel();
      }
    });
  }
  void resetValues() {
    savePresteps(0);
    savepreviousDistance(0.0);
  }
  void startListening() {
    _accelerometerSubscription = SensorsPlatform.instance.accelerometerEventStream().listen((event) {
      setState(() {
        X = event.x;
        Y = event.y;
        Z = event.z;
        DeltaDistance = calcDelta(X, Y, Z);
        if (DeltaDistance > 3) {
          steps++;
          savePresteps(steps);
          calcburnedcalories(steps);
        }
      });
    });
  }

  double calcDelta(double x, double y, double z) {
    double Newdistance = sqrt(x * x + y * y + z * z);
    double MagnitudeDelta  = Newdistance - previousDistance;
    previousDistance = Newdistance;
    savepreviousDistance(previousDistance);
    return MagnitudeDelta ;
  }

  double calcburnedcalories(int steps) {
     burnedcalories=(steps*.07);
    burnedcalories = (burnedcalories * 100).roundToDouble() / 100;

    return burnedcalories ;
  }
  
  Future<void> savePresteps(int steps) async {
       await checkAndResetValues();

    await storage.write("previoussteps", steps);
  }

  Future ReturnPrevioussteps() async {
    final previousSteps = await storage.read("previoussteps")?? 0;
      steps = previousSteps;
  }


  Future<void> savepreviousDistance(double predistance) async {
    await storage.write("previousDistance", previousDistance);
  }

  Future ReturnPreviousDistance() async {
     previousDistance = await storage.read("previousDistance") ?? 0;
  }
}