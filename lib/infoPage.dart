import 'package:flutter/material.dart';
import 'file.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Information")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CachedNetworkImage(
              imageUrl: widget.student.photo!,
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(
              widget.student.uid!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(widget.student.name!,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Text(widget.student.branch!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Text(widget.student.year!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
