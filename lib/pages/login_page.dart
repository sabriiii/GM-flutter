import 'package:flutter/material.dart';
import 'package:gm/components/login_components.dart';
import 'package:gm/components/sign_In_Button.dart';
import 'package:gm/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in method

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              const SizedBox(height: 20),
              Image.asset(
                'lib/images/logo.png',
                height: 250, // Set height for a smaller logo
                width: 250,
              ),
              const SizedBox(height: 20),
              //Welcome back we hope your healyh is good
              Text(
                'Welcome back we hope you\'re healthy!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 25),

              //Username textfield

              MyLoginField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false),
              const SizedBox(height: 10),
              //password textfield
              MyLoginField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),
              //forgot password
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //sign in button
              SignInButton(
                onTap: signUserIn,
              ),
              const SizedBox(height: 50),

              //or continue with

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              //google+ apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 25),
                  //apple button
                  SquareTile(imagePath: 'lib/images/apple.png'),
                ],
              ),
              const SizedBox(height: 25),
              //not a member

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Register now ',
                    style: TextStyle(
                      color: Colors.green[300],
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
