// lib/screens/auth/register.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.white),
            label: Text('Sign In', style: TextStyle(color: Colors.white)),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter an email';
                  }
                  // Basic email validation
                  bool emailValid = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(val);
                  return emailValid ? null : 'Enter a valid email';
                },
                onChanged: (val) => setState(() => email = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter a password';
                  }
                  if (val.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onChanged: (val) => setState(() => password = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Confirm your password';
                  }
                  if (val != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (val) => setState(() => confirmPassword = val),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var result = await authService.registerWithEmailPassword(
                        email,
                        password,
                      );
                      if (result == null) {
                        setState(() => error = 'Registration failed. Please try again.');
                      }
                    } catch (e) {
                      setState(() {
                        if (e.toString().contains('email-already-in-use')) {
                          error = 'This email is already registered';
                        } else {
                          error = 'Registration failed: ${e.toString()}';
                        }
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              if (error.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red[900], fontSize: 14.0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}