import 'package:flutter/material.dart';
import 'package:inso_chat/component/assets/colors.dart';
import 'package:inso_chat/component/inputField.dart';
import 'package:inso_chat/component/roundnutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

enum Gender { male, female }

Gender? _selectedGender;

class _SignUpState extends State<SignUp> {
  var selectedDate;

  void pickedDate() async {
    DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        selectedDate = "${value!.day}/${value.month}/${value.year}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var fName = TextEditingController();
    var lName = TextEditingController();
    var email = TextEditingController();
    var password = TextEditingController();
    var confirmPassword = TextEditingController();
    var phone = TextEditingController();
    var formKey = GlobalKey<FormState>();

    var height = MediaQuery.of(context).size.height * .1;
    var width = MediaQuery.of(context).size.width * .1;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Clr.primaryButton,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "/ Log In",
                      style: TextStyle(
                        color: Clr.alterlogin,
                        fontSize: 28,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: inputField(
                        icon: Icons.person,
                        controller: fName,
                        hint: "First Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "First Name is required";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: width * .3,
                    ),
                    Expanded(
                      child: inputField(
                        icon: Icons.person,
                        controller: lName,
                        hint: "Last Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Last Name is required";
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .15,
                ),
                inputField(
                  icon: Icons.phone,
                  controller: phone,
                  hint: "Phone",
                  keyType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone is required";
                    }
                  },
                ),
                SizedBox(
                  height: height * .15,
                ),
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Clr.inputfieldFiller,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Gender>(
                              title: const Text('Male'),
                              value: Gender.male,
                              groupValue: _selectedGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Gender>(
                              title: const Text('Female'),
                              value: Gender.female,
                              groupValue: _selectedGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: pickedDate,
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Clr.inputfieldFiller,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                SizedBox(
                                  width: width * .3,
                                ),
                                const Text(
                                  "Date of Birth :",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: width * .3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      selectedDate == null
                                          ? const Text(
                                              "Selecte your DOB",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            )
                                          : Text(
                                              selectedDate.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .15,
                ),
                inputField(
                  icon: Icons.alternate_email,
                  controller: email,
                  hint: "Email",
                  keyType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                  },
                ),
                SizedBox(
                  height: height * .15,
                ),
                inputField(
                  icon: Icons.lock_outline,
                  controller: password,
                  hint: "Password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                  },
                ),
                SizedBox(
                  height: height * .15,
                ),
                inputField(
                  icon: Icons.lock_outline,
                  controller: confirmPassword,
                  hint: "Confirm Password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm Password is required";
                    }
                  },
                ),
                SizedBox(
                  height: height * .15,
                ),
                roundButton(
                    hint: "Sign Up",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print("Validated");
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 15,
                              color: Clr.primaryButton,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    ));
  }
}