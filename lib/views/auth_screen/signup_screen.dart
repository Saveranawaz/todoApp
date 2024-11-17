import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false; //value is false at the start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image(image:AssetImage('lib/assets/AppImages/signup.jpg'),width: 200,height: 200,),
            ),
            //TextFormField for email address---------------
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30,0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Email',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //TextForm Field for password-------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(30,0,30,0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Password',
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            //Conatiner Button-----------------------
            isLoading
                ? const CircularProgressIndicator()
                : InkWell(
              onTap: () async {
                isLoading = true;
                setState(() {});
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim())
                    .then((value) {
                  //successful-------------
                  isLoading = false;
                  setState(() {});
                  Get.defaultDialog(
                      title: 'Successful',
                      content: const Text('Account created successfuly'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            //Get.back();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ]);
                  // Get.snackbar(
                  //   'Successful',
                  //   'Account created successfully',
                  //   backgroundColor: Colors.blue.shade400.withOpacity(0.8),
                  // );
                }).onError((error, value) {
                  isLoading = false;
                  setState(() {});
                  Get.snackbar('$error', '$value');
                });
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
