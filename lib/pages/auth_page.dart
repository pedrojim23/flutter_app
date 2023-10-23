import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/home_page.dart';
import 'package:login/pages/login_or_signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Utiliza un StreamBuilder para observar cambios en el estado de autenticación.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de progreso mientras se carga la información de autenticación.
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              // Si hay datos de usuario, significa que el usuario está autenticado, así que muestra la página de inicio.
              return HomePage();
            } else {
              // Si no hay datos de usuario, muestra la página de inicio de sesión y registro.
              return const LoginAndSignUp();
            }
          }
        },
      ),
    );
  }
}
