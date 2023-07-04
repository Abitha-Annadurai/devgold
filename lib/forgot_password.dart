import 'package:devgold/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class ForgotPwd extends StatefulWidget {
  ForgotPwd({Key? key}) : super(key: key);

  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text('Password Reset Email has been sent!',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text('No user found for that email.',
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
                  margin: EdgeInsets.only(left: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                            });
                            resetPassword();
                          }
                        },
                        child: Text('Send Email', style: TextStyle(fontSize: 18.0, color: Colors.white),),
                      ),
                      TextButton(
                        onPressed: () => {Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                          pageBuilder: (context, a, b) => LoginPage(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                                (route) => false)
                        },
                        child: Text('Login',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                                color: Colors.black54)
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
                            Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                              pageBuilder: (context, a, b) => Register(),
                              transitionDuration:
                              Duration(seconds: 0),
                            ),
                                    (route) => false)
                          },
                          child: Text('Sign Up',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                              color: Colors.black54)))
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
