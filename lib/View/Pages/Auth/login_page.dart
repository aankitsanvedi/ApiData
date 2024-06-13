import 'package:flutter/material.dart';
import 'package:project_01/Controller/Service/api_service.dart';
import 'package:project_01/Model/login_response.dart';
import 'package:project_01/View/Bottom_Navigation/bot_nav.dart';
import 'package:project_01/View/Pages/Auth/registration_page.dart';
import 'package:project_01/View/Pages/Home/home_page.dart';
import 'package:project_01/View/Pages/Home/home_screen.dart';
import 'package:project_01/View/Pages/Profile/user_Profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginResponse loginResponse = LoginResponse();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  Image.asset('assets/images/heading.png'),
                  const SizedBox(
                    height: 30,
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
                      if (value.length < 8) {
                        return 'Must be more than 8 charater';
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
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setString(
                          'access_token', loginResponse.accessToken.toString());
                      sp.setString('refresh_token',
                          loginResponse.refreshToken.toString());
                      _loginUser();
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
                                'Login',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already Have An Account'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegistrationPage()));
                        },
// Sign Up Button
                        child: const Text(
                          ' Sign Up',
                          style: TextStyle(fontSize: 16.0, color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginUser() async {
    ApiService()
        .userLogin(
            emailController.text.toString(), passwordController.text.toString())
        .then((value) {
      setState(() {
        isLoading = false;
        loginResponse = value!;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
            

        var snackBar = SnackBar(content: Text('Login Successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
        var snackBar = SnackBar(content: Text('Login Failed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });

      print(error);
    });
  }
}
