import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/servicies/userService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';

class AdminScreenLoginWeb extends StatefulWidget {
  const AdminScreenLoginWeb({super.key});

  @override
  State<AdminScreenLoginWeb> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<AdminScreenLoginWeb> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool erro_login = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 40,
              ),
              MyInputField(
                label: "Email",
                placeholder: "Email adress",
                textEditingController: emailController,
                isPasswordField: false,
              ),
              const SizedBox(
                height: 20,
              ),
              MyInputField(
                label: "Password",
                placeholder: "Password",
                textEditingController: passwordController,
                isPasswordField: true,
              ),
              const SizedBox(
                height: 20,
              ),
              loading
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, '/admin');
                        setState(() {
                          loading = true;
                          email = emailController.text;
                          password = passwordController.text;
                        });
                        var code =
                            await UserService().loginUser(email, password);

                        if (code == 200) {
                        } else {
                          setState(() {
                            erro_login = true;
                            loading = false;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
              if (erro_login)
                const Text(
                  "Erro ao fazer login tente novamente",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Nao tem conta?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/admin");
                    },
                    child: const Text(
                      " Clique aqui!",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
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
