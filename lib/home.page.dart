import 'dart:async';

import 'package:demo_cats/widgets/cats.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AlternScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Catbreeds',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage('assets/images/cats.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

class AlternScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catbreeds'),
      ),
      body: ListView(
        children: [CatsWidget()],
      ),
    );
  }
}
