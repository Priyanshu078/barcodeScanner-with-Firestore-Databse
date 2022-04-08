import 'package:barcodescanner/file.dart';
import 'package:flutter/material.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({Key? key}) : super(key: key);

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  TextEditingController urlController = TextEditingController();
  final SaveUrl _saveUrl = SaveUrl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Barcode Scanner")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Enter url here",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: urlController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Url",
                    hintText: "Url"),
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 3 / 4,
                height: MediaQuery.of(context).size.height / 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  if (urlController.text.isNotEmpty) {
                    _saveUrl.saveUrl(urlController.text.toString());
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Url Saved \nPlease restart the app to Scan")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("please enter the url !!!")));
                  }
                },
                color: Colors.blue,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Default Url",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SelectableText(
                      "url/",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

// Future<List> getAlldata() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   var snapshot = await firestore.collection('UID').get();
//   List<String> scannedUids = [];
//   for (int i = 0; i < snapshot.docs.length; i++) {
//     scannedUids.add(snapshot.docs[i].data()["studentUID"]);
//   }
//   return scannedUids;
// }
