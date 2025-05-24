import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  final String? title;

  const ScanScreen({super.key, this.title});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.title ?? "")));
  }
}
