import 'package:diet/core/utls/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/scan_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const DietApp());
}

class DietApp extends StatelessWidget {
  const DietApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScanPage(),
      // routerConfig: AppRouter.router,
      title: 'diet',
      theme: ThemeData.light(),
    );
  }
}
