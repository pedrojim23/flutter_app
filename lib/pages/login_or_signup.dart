import 'package:flutter/material.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/sign_up_page.dart';

class LoginAndSignUp extends StatefulWidget {
  const LoginAndSignUp({super.key});

  @override
  State<LoginAndSignUp> createState() => _LoginAndSignUpState();
}

class _LoginAndSignUpState extends State<LoginAndSignUp> {
  // Variable que indica si la página actual es de inicio de sesión (true) o registro (false).
  bool islogin = true;

  // Función para cambiar entre la página de inicio de sesión y la página de registro.
  void tooglePage() {
    setState(() {
      islogin = !islogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (islogin) {
      // Si islogin es true, muestra la página de inicio de sesión.
      return LoginPage(
        onPressed: tooglePage, // Pasa la función para cambiar la página.
      );
    } else {
      // Si islogin es false, muestra la página de registro.
      return SignUP(
        onPressed: tooglePage, // Pasa la función para cambiar la página.
      );
    }
  }
}
