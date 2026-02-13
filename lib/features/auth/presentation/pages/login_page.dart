import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 24),
                LoginForm(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

