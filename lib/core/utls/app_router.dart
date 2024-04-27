import 'package:diet/screens/diet_page.dart';
import 'package:diet/screens/footCounter.dart';
import 'package:diet/screens/info_page.dart';
import 'package:diet/screens/scan_page.dart';
import 'package:diet/screens/step_counter.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
     
            GoRoute(path: '/mm', builder: (context, state)=>  ScanPage()),
            GoRoute(path: '/', builder: (context, state)=>  InfoPage()),
                        GoRoute(path: '/DietPage', builder: (context, state)=>  DietPage()),

                               
    ],
  );
}
