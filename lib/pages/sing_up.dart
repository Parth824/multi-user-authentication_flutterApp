import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ts2_app/Helper/dbhelper.dart';
import 'package:ts2_app/pages/sing_in.dart';

class SingUpPages extends StatefulWidget {
  const SingUpPages({super.key});

  @override
  State<SingUpPages> createState() => _SingUpPagesState();
}

class _SingUpPagesState extends State<SingUpPages> {
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    String roll = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(" SingUp $roll"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email..";
                        }
                        return null;
                      },
                      controller: Email,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password..";
                        }
                        return null;
                      },
                      controller: pass,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "PassWord",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                  int l = 0;
                  Map<String, dynamic> data = {
                    'email': email,
                    'pass': password,
                    'rol': roll
                  };
                  QuerySnapshot<Map<String, dynamic>> documents =
                      await Dbhlper.db.collection('allUser').get();
                  print('j');
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> k =
                      await documents.docs;
                  for (int i = 0; i < k.length; i++) {
                    if (k[i]['email'] == email) {
                      l++;
                    }
                  }
                  if (l == 0) {
                    Dbhlper.dbhlper.insert(data: data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Inser Data..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SingInPage(),
                    ),);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Have User..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                      
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SingInPage(),
                    ),);
                    
                  }
                  setState(() {
                      Email.clear();
                      pass.clear();

                      email = "";
                      password = "";
                    });
                }
                //print('k');
                // Navigator.of(context).pop();
              },
              child: Text("SingUp"),
            ),
          ],
        ),
      ),
    );
  }
}
