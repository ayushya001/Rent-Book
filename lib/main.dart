import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rent_books/Pages/Homepage.dart';
import 'package:rent_books/Pages/Signuppage.dart';
import 'package:rent_books/Pages/loginpage.dart';
import 'package:rent_books/Pages/ChooseYear.dart';

import 'Theme/themes.dart';
import 'Utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      // home: HomePage(),
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.homeRoute,
      routes: {
        // "/":(context) => Signuppage(),
        // MyRoutes.logInRoute: (context)=>  Signuppage(),
        MyRoutes.homeRoute: (context)=> Homepage(),
        MyRoutes.loginRoute: (context)=>  loginpage(),
        MyRoutes.SignupRoute: (context)=>  Signuppage(),
        MyRoutes.chooseYearRoute: (context)=>  chooseYear(),

      },

    );
  }

}


