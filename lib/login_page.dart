import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devgold/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password.dart';
import 'my_home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text)
          .then((currentUser) => FirebaseFirestore.instance.collection("Users").doc(currentUser.user!.uid).get()
          .then((DocumentSnapshot result) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(
          //uidd: currentUser.user!.uid,
        ))),
      }));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDD835),  Colors.white, Colors.white,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderSide: BorderSide()
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 10),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 10),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool("isLoggedIn", true);
                          userLogin();
                          }
                        },
                        child: Text('Login', style: TextStyle(fontSize: 18.0, color: Colors.white),),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPwd(),
                          ),
                          )
                        },
                        child: Text('Forgot Password?', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account? "),
                      TextButton(
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, a, b) => Register(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                                  (route) => false)
                        },
                        child: Text('Sign Up', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
