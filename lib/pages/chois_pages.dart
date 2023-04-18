import 'package:flutter/material.dart';
import 'package:ts2_app/pages/sing_in.dart';
import 'package:ts2_app/pages/sing_up.dart';

class ChoiseApp extends StatefulWidget {
  const ChoiseApp({super.key});

  @override
  State<ChoiseApp> createState() => _ChoiseAppState();
}

class _ChoiseAppState extends State<ChoiseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingInPage(),
                  ),
                );
                print("Patyh");
              },
              child: Text("Login"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingUpPages(),
                    settings: RouteSettings(arguments: "Admin"),
                  ),
                );
                print("Patyh");
              },
              child: Text("Singup with Admin"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingUpPages(),
                    settings: RouteSettings(arguments: "Manager"),
                  ),
                );
                print("Patyh");
              },
              child: Text("Singup with Manager"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingUpPages(),
                    settings: RouteSettings(arguments: "Clerk"),
                  ),
                );
                print("Patyh");
              },
              child: Text("Singup with Clerk"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingUpPages(),
                    settings: RouteSettings(arguments: "Employee"),
                  ),
                  
                );
                print("Patyh");
              },
              child: Text("Singup with Employee"),
            ),
          ],
        ),
      ),
    );
  }
}
