import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_01/Controller/Service/api_service.dart';
import 'package:project_01/Model/registration_response.dart';
import 'package:project_01/Model/signup_response_model.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController avatarController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  SignUpResponseModel signUpResponseModel = SignUpResponseModel();
  RegistrationModel registrationModel = RegistrationModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/user_img.png"),
                        ),
                        Positioned(
                            bottom: 0,
                            right: -25,
                            child: RawMaterialButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (image != null) {
                                  Uint8List bytes = await image.readAsBytes();

                                  ApiService()
                                      .postUploadImage(bytes, image.name)
                                      .then((value) {
                                    print(value.toString());
                                  }).onError((error, stackTrace) {
                                    print(error.toString());
                                  });
                                }
                              },
                              elevation: 2.0,
                              fillColor: const Color(0xFFF5F6F9),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.blue,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: usernameController,
                    showCursor: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter User Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your User Name',
                      labelText: 'Enter Your User Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Email TextForm
                  TextFormField(
                    controller: emailController,
                    showCursor: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@') ||
                          !value.contains('.')) {
                        return 'Enter Vaild Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email Id',
                      labelText: 'Enter Your Email Id',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Password TextForm
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 4) {
                        return 'Must be more than 5 charater';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      labelText: 'Enter Your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Login Button
                  InkWell(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      //   _signUp();
                      _registration();
                    },
                    child: Container(
                      //width: 100.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signUp() {
    ApiService()
        .userSignUp(usernameController.text.toString(),
            emailController.text.toString(), passwordController.text.toString())
        //  avatarController.text.toString())
        .then((value) {
      setState(() {
        isLoading = false;
        signUpResponseModel = value!;
        print('name ' + signUpResponseModel.name.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Registered Successfully'),
            action: SnackBarAction(
                label: 'name:- ' + signUpResponseModel.name.toString(),
                onPressed: () {}),
          ),
        );
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
        var snackBar = SnackBar(content: Text('Registration Failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      print(error);
    });
  }

  _registration() {
    ApiService()
        .userRegistration(
            emailController.text.toString(), passwordController.text.toString())
        .then((value) {
      setState(() {
        isLoading = false;
        registrationModel = value!;
        print('Token ' + registrationModel.token.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Registered Successfully'),
            action: SnackBarAction(
                label: 'Token:- ' + registrationModel.token.toString(),
                onPressed: () {}),
          ),
        );
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
        var snackBar = SnackBar(content: Text('Registration Failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      print(error);
    });
  }
}
