import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/views/home_screen/update-data-scren/update-todo-data.dart';

import '../../constant/colors/app-colors.dart';
import '../auth_screen/login_screen.dart';
import 'inset-data-scren/insert-todp-data.dart';
// import 'loginscreen.dart'; // Corrected typo: 'loginscren' to 'loginscreen'
// import 'insert_data.dart'; // Assuming this is the file for InsertData widget

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userId = '';
  String userEmail = '';

  // Fetch user data
  getUserData() async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      userId = user!.uid;
      userEmail = user.email ?? "";
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoDialogRoute(
              builder: (context) => InsertData(userEmail: userEmail),
              context: context,
            ),
          );
        },
        backgroundColor: AppColors.appPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(userEmail),
        backgroundColor: AppColors.appPrimaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                CupertinoDialogRoute(
                  builder: (context) => LoginScreen(), // Corrected typo: 'LoginSCreen' to 'LoginScreen'
                  context: context,
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(userEmail).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              String docid = data.docs[index]['id'];
              String title = data.docs[index]['title'];
              String description = data.docs[index]['description'];

              return Card(
                color: AppColors.appPrimaryColor,
                child: ListTile(
                  onLongPress: () {
                    Navigator.push(
                      context,
                      CupertinoDialogRoute(
                        builder: (context) => UpadtetData(
                          userEmail: userEmail,
                          title: title,
                          descriptions: description,
                          docid: docid,
                        ),
                        context: context,
                      ),
                    );
                  },
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection(userEmail)
                        .doc(docid)
                        .delete();
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      docid, // Displaying document ID as the avatar
                      style: TextStyle(color: AppColors.appPrimaryColor),
                    ),
                  ),
                  title: Text(title),
                  subtitle: Text(description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
