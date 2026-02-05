import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:home_find/auth/auth_service.dart';
import 'package:home_find/pages/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName="/login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  final _formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  String  _errMsg='';
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 224, 211, 248),const Color.fromARGB(255, 236, 234, 243)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Form(
              key: _formKey,
              child:ListView(
                padding: const EdgeInsets.all(10.0),
                shrinkWrap: true,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children:  [
                  //     Container(
                  //       padding: const EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         color: const Color.fromARGB(255, 235, 245, 192),
                  //         borderRadius: BorderRadius.circular(8.0)
                  //       ),
                  //       child: Text("Admin ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(10),      
                  //       decoration: BoxDecoration(
                  //         color: const Color.fromARGB(255, 235, 245, 192),
                  //         borderRadius: BorderRadius.circular(8.0)
                  //       ),               
                  //       child: Text("User ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType:TextInputType.emailAddress ,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Email Address",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 245, 192),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0)
                        )
                      ),
                      validator: (value) {
                        if(value==null|| value.isEmpty){
                          return 'Provide a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                        hintText: "Password (atleast 6 characters)",
                         fillColor: const Color.fromARGB(255, 235, 245, 192),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0)
                        )
                      ),
                      validator: (value) {
                        if(value==null|| value.isEmpty||value.length<6){
                          return 'Provide a valid password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(onPressed: _authenticate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 247, 198),
                      foregroundColor: Colors.black,  
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      )
                    ),
                    child: Text("Login")),
                  ),
                  SizedBox(height: 8.0,),
                  _errMsg.isNotEmpty? Text(_errMsg,style: TextStyle(fontSize: 18,color: Colors.red),):SizedBox.shrink()
                ],
              )
              ),
          ),
        ),
      ),
    );
  }

  void _authenticate() async{
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: "Please Wait");
      final email=_emailController.text;
      final password=_passwordController.text;
      try{
        final status=await AuthService.loginAdmin(email, password);
        EasyLoading.dismiss();
        context.goNamed(DashboardPage.routeName);
      } on FirebaseAuthException catch(error){
        EasyLoading.dismiss();
        setState(() {
          _errMsg=error.message!;
        });
      }
    }
    
  }
}