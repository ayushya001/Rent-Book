import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rent_books/Models/Mydata..dart';

import 'Mainpage.dart';



class rentORrequest extends StatefulWidget {
  const rentORrequest({Key? key}) : super(key: key);

  @override
  State<rentORrequest> createState() => _rentORrequestState();

}

class _rentORrequestState extends State<rentORrequest> {
  bool _isVisible = false;
  bool _isVisibleRequest = true;

  final currentUser = FirebaseAuth.instance.currentUser;
  final storage = FlutterSecureStorage();



  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _price = TextEditingController();

  late String name;
  late String email;
  late String year;
  late String stream;
  @override
  Widget build(BuildContext context) {
    return Material(

          child :Form(
            key: _formKey,

            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
              child: Column(
                children: [
                  TextFormField(

                    controller: _emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Enter The Books name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                    ),
                    textAlignVertical: TextAlignVertical.bottom,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "BookName cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0,),

                  Visibility(
                    visible: _isVisible,
                    child: TextFormField(

                      controller: _price,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        hintText: "Enter The Price For Per Month",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Price cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = true;
                        _isVisibleRequest = false;
                      });
                       if (_formKey.currentState!.validate()) {
                         final Book = _price.text.toString();

                         if(Book.isNotEmpty){
                           String child = "ForRent";
                           savetodb(child,Book);

                         }






                       }

                  },
                    child:Text(
                    "Rent Your book",
                    style: TextStyle(fontSize: 18),
                  ),
                style: TextButton.styleFrom(
                    minimumSize: Size(350, 40),
                    backgroundColor: Colors.blue),

                      ),
                  SizedBox(height: 20.0,),
                  Visibility(
                    visible: _isVisibleRequest,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = false;
                        });
                          if (_formKey.currentState!.validate()) {
                              String child = "Request";
                              String price = "0";
                              savetodb(child,price);
                              print("ayushhh");
                          }


                      },
                      child:Text(
                        "Request Book",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                          minimumSize: Size(350, 40),
                          backgroundColor: Colors.blue),

                    ),
                  ),


                ],
              ),



              ),
          ),






    );
  }

  Future<void> savetodb(String child, String book) async {
    String? email = await storage.read(key: 'email');
    String? year = await storage.read(key: 'year');
    String? name = await storage.read(key: 'name');
    String? stream = await storage.read(key: 'Stream');

    if (currentUser != null) {
      final uid = currentUser?.uid;
      // print(uid);
      // final userr = Users(name, email, password);
      final Book = _emailController.text.toString();
      // final price = _price.text.toString();
      //
      Map<String, dynamic> users= {
        'by': uid,
        'name':name,
        'Book': Book,
        'year': year,
        'stream': stream,
        'price':book,
        'email': email,
      };
      FirebaseDatabase.instance.ref().child(child).child(Book).set(users);
      _price.clear();
      _emailController.clear();

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Mainpage(MyData("",""))),
      // );


    }

  }

}
