import 'package:flutter/material.dart';
import 'package:mamamia_pizzaria/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mamamia Pizzaria',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String emailError = '';
  String passwordError = '';

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      emailError = '';
      passwordError = '';
    });

    if (email == "usuario" && password == "senha") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciais inválidas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0FC27D), // Azul
              Color(0xFFFFFE6), // Branco
              Color(0xFFFE1A2C), // Vermelho
            ],
            stops: [0.0, 0.5, 1.0], // Divisão das faixas na bandeira
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/logo.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email ou telefone',
                  icon: Icons.email,
                  errorText: emailError,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  icon: Icons.lock,
                  obscureText: true,
                  errorText: passwordError,
                ),
                const SizedBox(height: 30),
                _buildButton(
                  label: 'ENTRAR',
                  onPressed: () {
                    final input = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (input.isEmpty || password.isEmpty) {
                      setState(() {
                        if (input.isEmpty) emailError = 'Preencha o email/telefone';
                        if (password.isEmpty) passwordError = 'Preencha a senha';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (_isValidEmail(input) || _isValidPhoneNumber(input)) {
                      if (password == '123456') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        setState(() {
                          passwordError = 'Senha incorreta!';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Senha incorreta!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        emailError = 'Insira um e-mail ou telefone válido!';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Insira um e-mail válido ou um telefone com DDD e 9 dígitos!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                _buildButton(
                  label: 'MENU',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  isLarger: true,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Recuperação de senha em breve!'),
                      ),
                    );
                  },
                  child: const Text(
                    'Recuperar Senha',
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    bool obscureText = false,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.brown),
        hintText: hintText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  bool _isValidEmail(String input) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(input);
  }

  bool _isValidPhoneNumber(String input) {
    final phoneRegex = RegExp(r'^\(\d{2}\)\d{9}$'); // Ex.: (99)999999999
    return phoneRegex.hasMatch(input);
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    bool isLarger = false,
  }) {
    return SizedBox(
      width: isLarger ? 250 : 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: isLarger
              ? const EdgeInsets.symmetric(vertical: 15)
              : null,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
