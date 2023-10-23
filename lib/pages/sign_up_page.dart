import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUP extends StatefulWidget {
  final void Function()? onPressed;
  const SignUP({Key? key, required this.onPressed});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  // Llave global para identificar y validar el formulario.
  final _formKey = GlobalKey<FormState>();

  // Variable para controlar el estado de carga.
  bool isLoading = false;

  // Controladores para los campos de correo y contraseña.
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // Función para crear un nuevo usuario con correo y contraseña.
  createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      // Llama a Firebase Authentication para crear un usuario.
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'weak-password') {
        // Muestra un mensaje de error si la contraseña es débil.
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("La contraseña es muy débil."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        // Muestra un mensaje de error si el correo ya está en uso.
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ya existe un usuario con ese correo."),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Registrarse"),
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
                        // Si el formulario es válido, llama a la función de registro.
                        createUserWithEmailAndPassword();
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Registrarse"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: widget.onPressed,
                    child: const Text("Iniciar sesión"),
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
