import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/servicies/userService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool erro_login = true;
  String email = '';
  String password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Loading = CircularProgressIndicator.strokeAlignCenter;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Center(
                //child: Image(image: AssetImage("assets/logoisutc-1.png")),

                ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(64))),
              child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ignore: prefer_const_constructors
                              Center(
                                  child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 28),
                              )),
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
                              loading == true
                                  ? CircularProgressIndicator()
                                  : GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          loading = true;
                                          email = emailController.text;
                                          password = passwordController.text;
                                        });
                                        var code = await UserService()
                                            .loginUser(email, password);

                                        if (code == 200) {
                                          Navigator.pushNamed(context, '/main');
                                          setState(() {
                                            loading = false;
                                          });
                                        } else {
                                          setState(() {
                                            erro_login = true;
                                          });
                                        }

                                        loading = false;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                bottomLeft: Radius.circular(14),
                                                bottomRight:
                                                    Radius.circular(14))),
                                        child: const Center(
                                            child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )),
                                      ),
                                    ),

                              if (erro_login)
                                const Text(
                                  "Erro ao fazer login tente novamente",
                                  style: TextStyle(color: Colors.white),
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
                                      Navigator.pushNamed(
                                          context, "/registration");
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: const Text(" Clique aqui!",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
