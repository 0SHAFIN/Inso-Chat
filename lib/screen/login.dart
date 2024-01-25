import 'package:flutter/material.dart';
import 'package:inso_chat/component/assets/colors.dart';
import 'package:inso_chat/component/inputField.dart';
import 'package:inso_chat/component/roundnutton.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/services/loginServices.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool checked = false;
  bool obscureText = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .1;
    var width = MediaQuery.of(context).size.width * .1;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        "assets/images/insoChat.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(color: Clr.alterlogin, fontSize: 28),
                    ),
                    Text(
                      "/ Log In",
                      style: TextStyle(
                          color: Clr.primaryButton,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 1.2,
                ),
                inputField(
                    controller: emailController,
                    hint: "Email",
                    keyType: TextInputType.emailAddress,
                    icon: Icons.alternate_email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                    }),
                SizedBox(
                  height: height * .15,
                ),
                inputField(
                  controller: passwordController,
                  hint: "Password",
                  obscureText: obscureText,
                  icon: Icons.lock_outline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                  },
                ),
                SizedBox(
                  height: height * .15,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: checked,
                            onChanged: (value) {
                              setState(() {
                                checked = value!;
                                if (checked == true) {
                                  obscureText = false;
                                } else {
                                  obscureText = true;
                                }
                              });
                            }),
                        const Text(
                          "Show Password",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 15,
                              color: Clr.primaryButton,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                SizedBox(
                  height: height * .15,
                ),
                ChangeNotifierProvider(
                    create: (context) => login(),
                    child: Consumer<login>(
                      builder: (context, value, child) => roundButton(
                          hint: "Login",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              value.logins(context, emailController.text,
                                  passwordController.text);
                            }
                          },
                          loading: value.loading),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.signupScreen);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 15,
                              color: Clr.primaryButton,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    ));
  }
}
