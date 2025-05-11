import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/models/usuario.dart';
import 'package:perdidos_e_achados/servicies/userService.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/MyInputField.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool loading = false;
  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Registo"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(64)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Registro",
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(height: 20),
                    MyInputField(
                      label: "First Name",
                      placeholder: "Enter your first name",
                      textEditingController: firstNameController,
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 20),
                    MyInputField(
                      label: "Last Name",
                      placeholder: "Enter your last name",
                      textEditingController: lastNameController,
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 20),
                    MyInputField(
                      label: "Email",
                      placeholder: "Enter your email address",
                      textEditingController: emailController,
                      isPasswordField: false,
                      isEmailField: true,
                    ),
                    const SizedBox(height: 20),
                    MyInputField(
                      label: "Phone",
                      placeholder: "Enter your phone number",
                      textEditingController: phoneController,
                      isPasswordField: false,
                      isPhoneField: true,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image == null
                            ? Text(
                                "Upload Photo",
                                style: TextStyle(fontSize: 16),
                              )
                            : Image.file(_image!),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyInputField(
                      label: "Password",
                      placeholder: "Enter your password",
                      textEditingController: passwordController,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    MyInputField(
                      label:
                          "Confirm Password", // Changed label to "Confirm Password"
                      placeholder: "Confirm your password",
                      textEditingController: confirmPasswordController,
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    loading == true
                        ? Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });

                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                UsuarioDto newUser = UsuarioDto(
                                  primeiroNome: firstNameController.text,
                                  segundoNome: lastNameController.text,
                                  email: emailController.text,
                                  telefone: phoneController.text,
                                  password: passwordController.text,
                                );
                                int? statusCode =
                                    await UserService().registerUser(newUser);
                                if (statusCode == 201) {
                                  // Navigator.pushNamed(context, '/main');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Sucesso"),
                                        content: Column(
                                          children: [],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "Registration failed. Please try again."),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Passwords do not match. Please try again."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              setState(() {
                                loading =
                                    false; // Set loading to true when tapped
                              });
                            },
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
                                "Registrar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
