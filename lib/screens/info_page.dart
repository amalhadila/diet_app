import 'package:diet/screens/cal_calculator.dart';
import 'package:diet/screens/detect_age_model.dart';
import 'package:diet/screens/footCounter.dart';
import 'package:diet/screens/scan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoPage extends StatelessWidget {
  final DetectAgeModel? detectAgeModel;
  const InfoPage({super.key, this.detectAgeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom:28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 200,
                    width: 310,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(360),
                          bottomRight: Radius.circular(10)),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        '         Face\n Age Estimator',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
           
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ScanPage()));
              },
              child: Container(
                width: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: const Color.fromARGB(255, 255, 109, 170),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 95,
                        width: 95,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/img/people_11433145.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       Text(
                        'Age ${detectAgeModel?.data.result ?? ""} ',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
             GestureDetector(
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CalCalculator()));
              },
              
                child: CalCalculator(),
         
              
            ),
           
            Container(
              width: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: const Color.fromARGB(211, 28, 119, 194),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 95,
                      width: 95,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/img/feet_9718538.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const FootCounter(),                    
                  ],
                ),
              ),
            ),
           
            GestureDetector(
              onTap: () => GoRouter.of(context).push('/DietPage'),
              child: Container(
                width: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: const Color.fromARGB(220, 235, 111, 9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 95,
                        width: 95,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/img/diet_7924064.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Your Diet',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
