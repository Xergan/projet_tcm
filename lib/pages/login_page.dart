import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/bloc/login/login_bloc.dart';
import 'package:projet_tcm/pages/select_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

              // Logo
              const Icon(Icons.account_circle_sharp, size: 100),

              const SizedBox(height: 25),

              // Welcome back message
              const Text(
                "Ravi de vous revoir ! Vous nous avez manqué.",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 25),

              // Username field
              MyTextField(
                controller: _usernameController,
                hintText: "Nom d'utilisateur",
                obscureText: false,
              ),

              const SizedBox(height: 25),

              // Password field
              MyTextField(
                controller: _passwordController,
                hintText: "Mot de passe",
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // Login button
              GestureDetector(
                onTap: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  context.read<LoginBloc>().add(
                    LoginButtonPressed(username, password),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
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

              const SizedBox(height: 25),

              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    setState(() {
                      _isSigning = true;
                    });
                  } else {
                    setState(() {
                      _isSigning = false;
                    });

                    if (state is LoginSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectPage(),
                        ),
                      );
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  }
                },
                child: Container(),
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
