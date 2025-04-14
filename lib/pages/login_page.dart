import 'package:flutter/material.dart';
import 'package:projet_tcm/bloc/login/login_event.dart';
import 'package:projet_tcm/bloc/login/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginState = LoginState(false);

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isSigning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(Icons.account_circle_sharp, size: 100),

              const SizedBox(height: 25),

              // welcome back
              Text(
                "Ravi de vous revoir ! Vous nous avez manqué.",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 25),

              // username
              MyTextField(
                controller: _usernameController,
                hintText: "Nom d'utilisateur",
                obscureText: false,
              ),

              const SizedBox(height: 25),

              // password
              MyTextField(
                controller: _passwordController,
                hintText: "Mot de passe",
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // login button
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isSigning = true;
                  });

                  LoginButtonPressed();

                  if (loginState.loggedIn == true) {
                    SnackBar(
                      content: Center(
                        child: Text(
                          "Connecté",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.red,
                    );
                  }

                  setState(() {
                    _isSigning = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(25.0),
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: _isSigning ? Colors.cyan : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      _isSigning ? "Connexion en cours..." : "Se connecter",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
