import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/wrapper.dart';

// Firebase configuration for web
const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyAJoYMiZSYrPl-jGzpw2itYjDwxrj_X8ZE",
  authDomain: "projet-flutter-89eaf.firebaseapp.com",
  projectId: "projet-flutter-89eaf",
  storageBucket: "projet-flutter-89eaf.appspot.com",
  messagingSenderId: "513916063721",
  appId: "1:513916063721:android:cfb625a97894fa3aae4578",
  measurementId: "10084906257",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
