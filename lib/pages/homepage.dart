import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Helper/dbhelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: StreamBuilder(
        stream: Dbhlper.db.collection("allUser").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? k = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> data = k!.docs;

            return (roll != 'Admin')
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Text("${index + 1}"),
                          title: Text("${data[index]['email']}"),
                          subtitle: Text("${data[index]['pass']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Edit only Admin..."),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Delete only Admin..."),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Text("${index + 1}"),
                          title: Text("${data[index]['email']}"),
                          subtitle: Text("${data[index]['pass']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  getUpdata(data[index].id, data[index].data());
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  Dbhlper.dbhlper.Delete(id: data[index].id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Delete Suucfully..."),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  getUpdata(String id, Map<String, dynamic> k) {
    Email.text = k['email'];
    pass.text = k['pass'];

    email = k['email'];
    password = k['pass'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _globalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  Email.clear();
                  pass.clear();

                  email = "";
                  password = "";
                });
              },
              child: Text("Clar"),
            ),
            OutlinedButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                  Map<String, dynamic> k1 = {
                    'email': email,
                    'pass': password,
                    'rol': k['rol'],
                  };
                  await Dbhlper.dbhlper.update(id: id, k: k1);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Updata Data..."),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  setState(() {
                    Email.clear();
                    pass.clear();

                    email = "";
                    password = "";
                  });
                }
              },
              child: Text("Updata"),
            ),
          ],
        );
      },
    );
  }
}
