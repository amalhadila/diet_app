import 'package:diet/screens/footCounter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  height: 200,
                  width: 350,
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
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
          const SizedBox(
            height: 45,
          ),
          Container(
            height: 150,
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
                  const Text(
                    'Age',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Container(
            height: 150,
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
                  FootCounter(),                    
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          GestureDetector(
            onTap: () => GoRouter.of(context).push('/DietPage'),
            child: Container(
              height: 150,
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
    );
  }
}
