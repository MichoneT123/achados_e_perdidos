import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(64))),
              child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ignore: prefer_const_constructors
                          Center(
                              child: const Text(
                            "SignUp",
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
                            isEmailField: true,
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      bottomLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14))),
                              child: const Center(
                                  child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
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
                                onTap: () {},
                                child: const Text(" Clique aqui!",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
