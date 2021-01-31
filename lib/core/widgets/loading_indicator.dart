import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitecope'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
