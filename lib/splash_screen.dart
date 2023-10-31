import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/main');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.png',
              height: 200,
              width: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Self-introduction',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
