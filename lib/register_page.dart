import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _selectGender = "Male";


  var name = "";
  var date = "";
  var phone = "";
  var email = "";
  var pan = "";
  var aadhar = "";
  var pin = "";
  var gender = "";
  var address = "";
  var password = "";
  var confirmPassword = "";

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final panController = TextEditingController();
  final aadhaarController = TextEditingController();
  final pinController = TextEditingController();
  final addrController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    phoneController.dispose();
    emailController.dispose();
    panController.dispose();
    pinController.dispose();
    addrController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  int _countWords({required String text}) {
    final TrimmedText = text.trim();
    if(TrimmedText.isEmpty){
      return 0;
    } else {
      return TrimmedText.split(RegExp('\\s+')).length;
    }
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text)
            .then((currentUser) => FirebaseFirestore.instance.collection("Users").doc(currentUser.user!.uid)
            .set({
          "uid": currentUser.user!.uid,
          "name": nameController.text,
          "date": dateController.text,
          "phone": phoneController.text,
          "email": emailController.text,})
            .then((result) => {FirebaseAuth.instance.signOut().then((result) => {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
        }).catchError((err) => print(err)),
        }).catchError((err) => print(err)))
            .catchError((err) => print(err));
        UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        print(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text("Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        );
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageArtist(),),);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              content: Text("Account Already exists",
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          );
        }
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text("Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      );
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                //name
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderSide: BorderSide()
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 10),),
                    controller: nameController,
                    validator: (value) { if (value == null || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return 'Please Enter Name';
                    }
                    return null;
                    },),),

                //dob
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Select Date of Birth';
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                      labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now());
                      if (pickedDate != Null) {
                        dateController.text = DateFormat("dd-MM-yyyy").format(pickedDate!);
                      }
                    },
                  ),

                ),

                //phone
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent,
                            fontSize: 10),),
                      //inputFormatters: <TextInputFormatter>[MaskedInputFormatter('##########')],
                      validator: (value) {
                        if (value == null || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      }
                  ),
                ),

                //email
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

                //pan
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: panController,
                      decoration: const InputDecoration(
                        labelText: 'Pan Number',
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent, fontSize: 10),),
                      validator: (value) {
                        if (value == null ||
                            !RegExp( r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(
                                value)) {
                          return 'Please Enter Pan Number';
                        }
                        return null;
                      }
                  ),
                ),

                //aadhar
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: aadhaarController,
                      decoration: const InputDecoration(
                        labelText: 'Aadhar Number',
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent, fontSize: 10),),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(
                                value)) {
                          return 'Please Enter Aadhar Number';
                        }
                        return null;
                      }
                  ),
                ),

                //pincode
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      controller: pinController,
                      decoration: const InputDecoration(
                        labelText: 'Pincode',
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent, fontSize: 10),),
                      validator: (value) {
                        if (value == null || !RegExp(r"^[1-9]{1}[0-9]{2}\s{0,1}[0-9]{3}$").hasMatch(
                                value)) {
                          return 'Please Enter Pincode';
                        }
                        return null;
                      }
                  ),
                ),

                //gender
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                        leading: Radio<String>(
                          value: 'Male',

                          groupValue: _selectGender,
                          onChanged: (value) {
                            setState(() {
                              _selectGender = value!;
                            });
                          },
                        ), title: Text('Male')
                    ),
                    ListTile(
                        leading: Radio<String>(
                          value: 'Female',
                          groupValue: _selectGender,
                          onChanged: (value) {
                            setState(() {
                              _selectGender = value!;
                            });
                          },
                        ), title: Text('Female')
                    ),
                  ],
                ),

                //address
                Container(
              child: TextFormField(
                controller: addrController,
                maxLines: 10,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  counterText: '${_countWords(text: this.addrController.text)}',
                  labelText: 'Enter Address',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please Enter Address';
                    }
                    return null;
                  }
              ),
            ),

                //password
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
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderSide: BorderSide()
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 10),
                    ),
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              name = nameController.text;
                              date = dateController.text;
                              phone = phoneController.text;
                              email = emailController.text;
                              pan = panController.text;
                              pin = pinController.text;
                              gender = _selectGender;
                              address = addrController.text;
                              password = passwordController.text;
                              confirmPassword = confirmPasswordController.text;
                            });
                            registration();
                          }
                        },
                        child: Text('Sign Up', style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an Account?"),
                      TextButton(
                          onPressed: () => {Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:
                              (context, animation1, animation2) => LoginPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                          )
                          },
                          child: Text('Login Here', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                              color: Colors.black54),))
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
