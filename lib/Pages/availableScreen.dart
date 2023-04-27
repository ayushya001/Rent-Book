import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AvailableScreen extends StatefulWidget {
  @override
  State<AvailableScreen> createState() => _AvailableScreenState();
}

class _AvailableScreenState extends State<AvailableScreen> {
  final databaseReference = FirebaseDatabase.instance.ref().child("ForRent");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(query: databaseReference,
                itemBuilder:(context, snapshot, animation, index) {
              return ListTile(
                title: Text(snapshot.child("Book").value.toString()),
                subtitle: Text(snapshot.child("price").value.toString()),
              );
                  
                }, ),
          ),
        ],
      ),
      
    );
  }
}