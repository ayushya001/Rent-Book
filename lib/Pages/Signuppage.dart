import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rent_books/Models/User.dart';
import 'package:rent_books/Pages/ChooseYear.dart';
import 'package:rent_books/Utils/flutterToast.dart';

import '../Utils/routes.dart';
import 'package:rent_books/Pages/loginpage.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  // final db = FirebaseDatabase.instance.ref("Users");

  final _EmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Image.asset("assets/images/un_signup.png",
                width: 300.0,
                height: 250.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: "Enter Users name",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _EmailController,

                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        } else if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return "Please enter a valid email address";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "Password length should be at least 6";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final email = _EmailController.text.toString();
                          final password = _passwordController.text.toString();
                          final name = _usernameController.text.toString();

                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            flutterToast().onSuccesstoastMessage("Welcome");
                            // Users userr = new Users(name, email, password);
                            // DatabaseReference userRef = db.child('Users').child(userCredential.user!.uid);
                            // await userRef.set(userr.toJson());
                            final currentUser = FirebaseAuth.instance.currentUser;

                              if (currentUser != null) {
                                final uid = currentUser.uid;
                                // final userr = Users(name, email, password);
                                Map<String, dynamic> users= {
                                  'name': name,
                                  'email': email,
                                  'password': password
                                };
                                FirebaseDatabase.instance.ref().child("Users").child(uid).set(users);
                                 // .child('Users').child(uid).set(userr);

                              }




                            // User has been created successfully.
                            // User user = userCredential.user.
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => chooseYear()),
                            );




                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: loading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : Text(
                        "Signup",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                          minimumSize: Size(130, 40),
                          backgroundColor: Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("clicked");
                            Navigator.pushNamed(context, MyRoutes.loginRoute);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal),
                          ),

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
