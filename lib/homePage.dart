import 'package:barcodescanner/uidListPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UIDList()));
              },
              child: const Text(
                "Scanned Ids",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 6,
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Insight 2k22",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 40,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.height / 8,
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Scan Pressed")));
                scanBarCode();
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "Scan",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                )),
              ),
            )
          ],
        ));
  }

  void scanBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "CANCEL", true, ScanMode.DEFAULT);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(barcodeScanRes)));
    saveDataInDatabase(barcodeScanRes);
  }

  void saveDataInDatabase(String uid) async {
    CollectionReference reference = firestore.collection("UID");
    Map<String, dynamic> data = {"studentUID": uid};
    List uidList = await getAlldata();
    if (!uidList.contains(uid)) {
      showDialog(
          context: context,
          builder: (context) => dialog(Icons.check, "Get In", Colors.green));
      reference
          .add(data)
          .then((value) => print("UID added"))
          .catchError((error) => print("Failed to add uid $error"));
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              dialog(Icons.close, "Scanned Before!!!", Colors.red));
    }
  }

  Widget dialog(IconData icon, String text, Color color) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width * 3 / 4,
        child: Icon(
          icon,
          color: color,
          size: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
