import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/calculator');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email e/ou senha inválidos.'),
          backgroundColor: Colors.deepOrange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[900],
                  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                        borderRadius: BorderRadius.circular(10),
                      ),
                  focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),

                  

                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[900],
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                      borderRadius: BorderRadius.circular(10),
                      ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Entrar", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text("Criar conta", style: TextStyle(color: Colors.deepOrange,fontSize: 16)),
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}
