import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://cmvblwgzjsvauwzoadjn.supabase.co',
     anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtdmJsd2d6anN2YXV3em9hZGpuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1NTQwODIsImV4cCI6MjA0NzEzMDA4Mn0.OOAJMx3d4jQpARZGWYSRPDIgzc9gNXv7ERZXbnSk81U');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Library',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}