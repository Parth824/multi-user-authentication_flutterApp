import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Dbhlper {
  Dbhlper._();

  static final Dbhlper dbhlper = Dbhlper._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insert({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection("counter").doc("allusercounter").get();
    int id = k['id'];
    int len = k['len'];

    await db.collection("allUser").doc("${++id}").set(data);

    await db.collection("counter").doc("allusercounter").update({'id': id});

    await db
        .collection("counter")
        .doc("allusercounter")
        .update({'len': ++len});
  }

  Future<void> update(
      {required String id, required Map<String, dynamic> k}) async {
    await db.collection("allUser").doc("$id").update(k);
  }

  Future<void> Delete({required String id}) async {
    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection("counter").doc("allusercounter").get();

    int len = k['len'];
    await db.collection("allUser").doc(id).delete();
    await db
        .collection("counter")
        .doc("allusercounter")
        .update({'len': --len});
  }
}
