import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to SuperAdmin Dashboard!'),
      ),
    );
  }
}
