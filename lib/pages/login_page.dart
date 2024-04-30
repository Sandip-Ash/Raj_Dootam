import 'package:flutter/material.dart';
import 'package:raj_dootam/auth/auth_services.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../constants/colors/colors.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap
  });

  // email and password text editing controller
  TextEditingController _emailController = TextEditingController();

  TextEditingController _pwController = TextEditingController();

  // Login funtion
  void login(BuildContext context) async {
    // Auth service
    final authService = AuthServices();

    // try login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }
    catch(e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Credentials!!'),
            content: Text('If you don\'t have account, register first'),
            contentTextStyle: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
            ),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            // Welcome back message
            Text(
              'Welcome back, you have been missed!!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // Email Textfield
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(
              height: 10,
            ),

            // Password Textfield
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _pwController,
            ),

            const SizedBox(
              height: 25,
            ),

            // Login button
            MyButton(
              buttonText: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(
              height: 25,
            ),

            // Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member? ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text('Register Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tdBlue
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
