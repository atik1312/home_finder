import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_find/auth/auth_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const String routeName = '/';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        // elevation:4,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.logout();
              context.goNamed(DashboardPage.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade200,
              Colors.amber.shade100,
              Colors.grey.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 15,mainAxisSpacing: 15),
        children: [
          GestureDetector(
            onTap: () {
              
            },
            child: Card(
              elevation: 10,
              shadowColor: Colors.white,
              color: Colors.amber.shade100,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people,color: Colors.white,size: 60,),
                  Text("User Data",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),),
            ),
          ),
           GestureDetector(
            onTap: () {
              
            },
            child: Card(
              elevation: 10,
              shadowColor: Colors.white,
              color: Colors.amber.shade100,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt,color: Colors.white,size: 60,),
                  Text("All posts",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),),
            ),
          ),
            GestureDetector(
            onTap: () {
              
            },
            child: Card(
              elevation: 10,
              shadowColor: Colors.white,
              color: Colors.amber.shade100,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.report,color: Colors.white,size: 60,),
                  Text("Reports",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),),
            ),
          ),
             GestureDetector(
            onTap: () {
              
            },
            child: Card(
              elevation: 10,
              shadowColor: Colors.white,
              color: Colors.amber.shade100,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.report,color: Colors.white,size: 60,),
                  Text("Actions",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),),
            ),
          ),
          
        ],
        ),

      ),
    );
  }
}
