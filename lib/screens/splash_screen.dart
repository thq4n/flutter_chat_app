import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
      body: const Center(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
