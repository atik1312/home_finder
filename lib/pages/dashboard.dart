import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_find/auth/auth_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const String routeName='/';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle:  true,
        actions: [
          IconButton(onPressed: ()async{
            await AuthService.logout();
            context.goNamed(DashboardPage.routeName);
          }, 
          icon: Icon(Icons.logout))
        ],
      ),
      body: Center(child: Text("dashboard"),),
    );
  }
}