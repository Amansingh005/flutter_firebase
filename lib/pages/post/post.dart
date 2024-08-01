import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:winsome/utills/utills.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('post');
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("post"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 238, 229, 241),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'enter what in your mind !',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 6),
            child: SizedBox(
              child: TextFormField(
                controller: postcontroller,
                maxLength: 20,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                databaseref
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set(({
                      'comment': postcontroller.text.toString(),
                      'time': DateTime.now().millisecondsSinceEpoch.toString(),
                    }))
                    .then((value) {
                  setState(() {
                    loading = false;
                  });
                  utills.toastmessage('post added');
                }).onError(
                  (error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    utills.toastmessage(error.toString());
                  },
                );
              },
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Colors.blue,
                    )
                  : const Text(
                      'submit',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))
        ],
      ),
    );
  }
}
