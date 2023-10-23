import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({Key? key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // Función para realizar el inicio de sesión con correo y contraseña.
  signInWithEmailAndPassword() async {
    try {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = true;
      });

      // Llama a Firebase Authentication para iniciar sesión.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
      });

      if (e.code == 'user-not-found') {
        // Muestra un mensaje de error si el usuario no se encuentra con ese correo.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuario no encontrado con ese email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Muestra un mensaje de error si la contraseña es incorrecta.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Contraseña inválida."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                TextFormField(
                  controller: _email,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      // Valida que el campo de correo no esté vacío.
                      return 'Email vacío';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  controller: _password,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      // Valida que el campo de contraseña no esté vacío.
                      return 'Contraseña vacía';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Contraseña"),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Si el formulario es válido, llama a la función de inicio de sesión.
                        signInWithEmailAndPassword();
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Login"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: widget.onPressed,
                    child: const Text("SignUp"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
