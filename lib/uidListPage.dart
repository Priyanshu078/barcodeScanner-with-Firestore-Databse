import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UIDList extends StatefulWidget {
  const UIDList({Key? key}) : super(key: key);

  @override
  State<UIDList> createState() => _UIDListState();
}

class _UIDListState extends State<UIDList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanned Uids")),
      body: FutureBuilder(
        future: getAlldata(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: ((context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 186, 209, 250),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data[index],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 2, 2),
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Future<List> getAlldata() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var snapshot = await firestore.collection('UID').get();
  List<String> scannedUids = [];
  for (int i = 0; i < snapshot.docs.length; i++) {
    scannedUids.add(snapshot.docs[i].data()["studentUID"]);
  }
  return scannedUids;
}
