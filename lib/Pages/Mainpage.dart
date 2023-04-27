import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rent_books/Models/Mydata..dart';
import 'RentORrequest.dart';
import 'availableScreen.dart';
import 'RequestedScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Mainpage extends StatefulWidget {

  @override
  State<Mainpage> createState() => _MainpageState();
  final MyData data;
  Mainpage(this.data);

}

class _MainpageState extends State<Mainpage> with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  PageController _pageController = PageController();
  final currentuser = FirebaseAuth.instance.currentUser;
  final storage = FlutterSecureStorage();
  late String name;
  late String email;
  late String year;
  late String stream;
  @override
  void initState() {
    super.initState();
    savetodatabase();
    // _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Rent Books',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white), // replace back arrow with menu icon
          onPressed: () {
            // handle menu button press
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          onTap: (int index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          tabs: [
            Tab(text: 'Available Books'),
            Tab(text: 'Requested Books'),
          ],
        ),
      ),


      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            _tabController.animateTo(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (details.primaryVelocity! < 0) {
            _tabController.animateTo(
              1,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            _tabController.index = index;
          },
          children: [
            AvailableScreen(),
            RequestScreen(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => rentORrequest()),
          );
          // handle the button press
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> savetodatabase() async {
    await storage.write(key: 'college', value: "ayush");

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final uid = currentUser.uid;
      // final userr = Users(name, email, password);
      Map<String, dynamic> users = {
        'Year': widget.data.year,
        'Stream': widget.data.Stream,
      };
      if (widget.data.Stream =="" || widget.data.Stream==""){
        final ref = FirebaseDatabase.instance.ref();
        final snapshot = await ref.child('Users').child(uid).get();
        if (snapshot.exists) {
          print(snapshot.value);

           year = (snapshot.value as Map<dynamic, dynamic>)['Year'];
           stream = (snapshot.value as Map<dynamic, dynamic>)['Stream'];
           name = (snapshot.value as Map<dynamic, dynamic>)['name'];
           email = (snapshot.value as Map<dynamic, dynamic>)['email'];

          await storage.write(key: 'year', value: year);
          await storage.write(key: 'name', value: name);
          await storage.write(key: 'email', value: email);
          await storage.write(key: 'Stream', value: stream);








        } else {
          print('No data available.');
        }


      }else {
        FirebaseDatabase.instance.ref().child("Users").child(uid).update(users);
        await storage.write(key: 'year', value: widget.data.year);
        await storage.write(key: 'stream', value: widget.data.Stream);
        // await storage.write(key: 'email', value: widget.data.email);
      }
      // FirebaseDatabase.instance.ref().child("Year").child(widget.data.year).child(widget.data.Stream)

    }

  }







}