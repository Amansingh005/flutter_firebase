import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:winsome/pages/phoneauth/LoginPage.dart';
import 'package:winsome/pages/post/post.dart';
import 'package:winsome/utills/utills.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "home page",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Loginpage()))
                        .onError((error, stackTrace) {
                      utills.toastmessage(error.toString());
                    });
                  });
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const post()));
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color.fromARGB(255, 238, 229, 241),
        body: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return ListTile(
                    title: Text(snapshot.child('comment').value.toString()),
                    subtitle: Text(snapshot.child('time').value.toString()),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
