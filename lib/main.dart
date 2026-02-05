import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:home_find/auth/auth_service.dart';
import 'package:home_find/firebase_options.dart';
import 'package:home_find/pages/dashboard.dart';
import 'package:home_find/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final _router=GoRouter(
    redirect: (context, state) {
      if(AuthService.currentUser==null){
        return LoginPage.routeName;
      }
      return null;
    },
    debugLogDiagnostics: true,
    initialLocation: DashboardPage.routeName,
    routes: [
    GoRoute(
      name: DashboardPage.routeName,
      path: DashboardPage.routeName,
      builder: (context, state) => DashboardPage(),
      ),
      GoRoute(
      name: LoginPage.routeName,
      path: LoginPage.routeName,
      builder: (context, state) => LoginPage(),
      ),

  ]);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder:  EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}

