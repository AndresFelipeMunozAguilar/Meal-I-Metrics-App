import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'styles/color_scheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Sales',
      theme: ThemeData(
        colorScheme: MyColorScheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(
        supabaseUrl: 'https://ddyveuettsjaxmdbijgb.supabase.co/',
        supabaseKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRkeXZldWV0dHNqYXhtZGJpamdiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMzA1MDgzNCwiZXhwIjoyMDI4NjI2ODM0fQ.FoRjsJj9d7R-XSkNN4hokmfmTG-mEcr2QuWWT9RFnxc',
      ),
    );
  }
}
