import 'dart:ui'; // Necesario para el filtro borroso
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore para la BD
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Método para iniciar sesión validando con Firestore
  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Consulta en Firestore
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection('usuarios')
            .where('correo', isEqualTo: _emailController.text.trim())
            .where('contraseña', isEqualTo: _passwordController.text.trim())
            .get();

        if (query.docs.isNotEmpty) {
          // Credenciales correctas
          var usuario = query.docs.first.data() as Map<String, dynamic>;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("¡Bienvenido, ${usuario['nombre']}!")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Credenciales incorrectas
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Correo o contraseña incorrectos")),
          );
        }
      } catch (e) {
        // Manejo de errores
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo con filtro oscuro
          Image.asset(
            'assets/images/fondo_login.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Oscurecer la imagen
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, size: 80, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Inicia sesión para continuar",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  // Contenedor con filtro borroso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Correo electrónico",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.email,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value!.contains("@")
                                    ? null
                                    : "Ingrese un correo válido",
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Contraseña",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) => value!.length >= 6
                                    ? null
                                    : "Mínimo 6 caracteres",
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 119, 111, 86),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Iniciar sesión"),
                              ),
                              const SizedBox(height: 15),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                },
                                child: const Text(
                                  "¿No tienes cuenta? Regístrate",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "FUTURETECH© 2025 TODOS LOS DERECHOS RESERVADOS",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
