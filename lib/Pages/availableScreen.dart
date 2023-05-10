import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Fetchdata/Working.dart';

class AvailableScreen extends StatefulWidget {
  @override
  State<AvailableScreen> createState() => _AvailableScreenState();
}

class _AvailableScreenState extends State<AvailableScreen> {
  Working? working;

  // final databaseReference = FirebaseDatabase.instance.ref().child("ForRent");


  @override
  void initState() {
    startApp();
    // TODO: implement initState
    super.initState();
  }

  void startApp() async {
    working = Working();
    await working!.getDataStream().listen((dataList) {
      print(dataList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: working!.getDataStream().first,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final dataList = snapshot.data!;
            return Center(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final data = dataList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: 16.0, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "${data['name']}",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                  ),
                                  TextSpan(text: " wants to rent "),
                                  TextSpan(text: "${data['Book']}",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: 16.0, color: Colors.black),
                                children: [
                                  TextSpan(text: "Price:- "),
                                  TextSpan(
                                    text: "${data['price']}",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  TextSpan(text: " /month. "),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 50),
                                ),

                                onPressed: () {
                                  print("ayush");
                                },
                                child: Text("Interested"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child:  Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: SpinKitWave(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}