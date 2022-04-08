import 'dart:convert';
import 'package:barcodescanner/file.dart';
import 'package:barcodescanner/infoPage.dart';
import 'package:barcodescanner/urlPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "";

  @override
  void initState() {
    super.initState();
    getUrl();
  }

  void getUrl() async {
    url = await SaveUrl().readUrl();
    print(url);
    if (url == "") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Please add the url!!!",
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text("Add"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UrlPage()));
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UrlPage()));
              },
              child: const Text(
                "Add Url",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            ),
            const Text(
                "Designed and developed by Priyanshu Paliwal in guidance with Manish Gurdhe Sir and the TPDC department",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25))
          ],
        ));
  }

  void scanBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "CANCEL", true, ScanMode.DEFAULT);
    getInfo(barcodeScanRes);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(barcodeScanRes)));
  }

  // void saveDataInDatabase(String uid) async {
  //   CollectionReference reference = firestore.collection("UID");
  //   Map<String, dynamic> data = {"studentUID": uid};
  //   List uidList = await getAlldata();
  //   if (!uidList.contains(uid)) {
  //     showDialog(
  //         context: context,
  //         builder: (context) => dialog(Icons.check, "Get In", Colors.green));
  //     reference
  //         .add(data)
  //         .then((value) => print("UID added"))
  //         .catchError((error) => print("Failed to add uid $error"));
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (context) =>
  //             dialog(Icons.close, "Scanned Before!!!", Colors.red));
  //   }
  // }

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

  void getInfo(String uID) async {
    String url = this.url + uID;
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    Student student = Student(
        jsonData["uid"],
        jsonData["name"],
        jsonData["branch"],
        jsonData["cyear"],
        jsonData["status"],
        jsonData["photo"]);
    if (student.name != "") {
      if (int.parse(student.year!) > 2020) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => StudentInfo(student: student))));
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                dialog(Icons.close, "Scanned Before!!!", Colors.red));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              dialog(Icons.close, "Scanned Before!!!", Colors.red));
    }
  }
}
