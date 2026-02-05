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
      body: Center(
        child: Form(
          key: _formKey,
          child:ListView(
            padding: const EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType:TextInputType.emailAddress ,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.email),
                    labelText: "Email Address"
                  ),
                  validator: (value) {
                    if(value==null|| value.isEmpty){
                      return 'Provide a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                    labelText: "Password (atleast 6 characters)"
                  ),
                  validator: (value) {
                    if(value==null|| value.isEmpty||value.length<6){
                      return 'Provide a valid password';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(onPressed: _authenticate
              , child: Text("Login as Admin")),
              Text(_errMsg,style: TextStyle(fontSize: 18,color: Colors.red),)
            ],
          )
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