import 'package:clozii/core/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTabScreen extends StatelessWidget {
  const MyTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('My Tab', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Logout',
            width: 140.0,
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
