import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ts2_app/pages/homepage.dart';

import '../Helper/dbhelper.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      email = newValue;
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
                  onSaved: (newValue) {
                    setState(() {
                      password = newValue;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Email..";
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
                ElevatedButton(
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      int l = 0;
                      String ro = '';
                      QuerySnapshot<Map<String, dynamic>> documents =
                          await Dbhlper.db.collection('allUser').get();
                      print('j');
                      List<QueryDocumentSnapshot<Map<String, dynamic>>> k =
                          await documents.docs;
                      for (int i = 0; i < k.length; i++) {
                        if (k[i]['email'] == email &&
                            k[i]['pass'] == password) {
                          l++;
                          ro = k[i]['rol'];
                        }
                      }
                      if (l == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("No Have Account or Check Password..."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Login Succfully..."),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),settings:RouteSettings(arguments: ro) ,
                          ),
                        );
                      }
                      setState(() {
                        Email.clear();
                        pass.clear();

                        email = "";
                        password = "";
                      });
                    }
                  },
                  child: Text("SingUp"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
