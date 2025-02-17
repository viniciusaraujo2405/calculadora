import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart'; 
import '../screens/calculator.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp( 
  options: DefaultFirebaseOptions.currentPlatform, 
  ); 
   runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/calculator': (context) => Calculator(),
    },
  ));
  
      
      
  }