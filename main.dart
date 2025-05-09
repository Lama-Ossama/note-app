import 'package:flutter/material.dart';
import 'pages/notes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.dark(),
      home: NotesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}