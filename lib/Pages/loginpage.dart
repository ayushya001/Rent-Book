import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_books/Pages/ChooseYear.dart';
import 'package:rent_books/Pages/Mainpage.dart';
import 'package:rent_books/Utils/flutterToast.dart';

import '../Models/Mydata..dart';
import '../Utils/routes.dart';

import 'package:firebase_database/firebase_database.dart';


class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool loading = false;
  final database = FirebaseDatabase.instance.ref("Users");
  final mauth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  MyData defaultData = MyData("", "");


  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
      return Mainpage(MyData("",""));
    }

    return Material(

        color: Colors.white,
        child: SingleChildScrollView(

          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                Image.asset("assets/images/un_login.png",
                  width: 300,
                  height: 250,
                ),
                SizedBox(height: 20.0,),
                Text("Welcome"
                  ,style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _emailController,
                            obscureText: true,
                            decoration:  InputDecoration(
                                hintText: "Enter Users name",
                                labelText: "Username"

                            ),

                            validator: (value){
                              if(value==null || value.isEmpty){

                                return "Username cannot be empty";
                              }
                              else{
                                return null;
                              }
                            }
                        ),
                        TextFormField(
                          controller: _passwordController,

                          obscureText: true,
                          decoration:  InputDecoration(
                              hintText: "Enter your Password",
                              labelText: "Password"
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              flutterToast().toastMessage("Password cannot be empty");
                            }else if(value.length<6){
                              flutterToast().toastMessage("Password length should atleast 6");
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),






                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              final email = _emailController.text.toString();
                              final password = _passwordController.text.toString();

                              try {
                                UserCredential userCredential = await mauth.signInWithEmailAndPassword(email: email,
                                    password: password);
                                flutterToast().onSuccesstoastMessage("Welcome");
                                // User has been created successfully.
                                // User user = userCredential.user.
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Mainpage(defaultData)),
                                );




                              } on FirebaseAuthException catch (e) {
                               flutterToast().toastMessage(e.code);
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
                              "Doesn't have account ? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("clicked");
                                
                                
                                Navigator.pushNamed(context, MyRoutes.SignupRoute);
                              },
                              child: Text(
                                'Signup now',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal),
                              ),

                            ),
                          ],
                        ),



                      ],
                    )
                ),

              ],
            ),
          ),
        )


    );
  }
}
