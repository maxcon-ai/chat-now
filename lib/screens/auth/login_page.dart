import 'package:chat_now/helper/helper_function.dart';
import 'package:chat_now/screens/auth/register_page.dart';
import 'package:chat_now/screens/home.dart';
import 'package:chat_now/services/auth_services.dart';
import 'package:chat_now/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading =false;
  AuthService authService =AuthService();
  // String email ='';
  // String password='';
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Chat-Now",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Login now to communicate with your friend",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Image.asset("assets/login.png"),
                CustomTextFormField(
                  validator: "email",
                  controller: emailController!,
                  iconData: Icons.email,
                  labelText: 'Email',
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  validator: "password",
                  controller: passwordController!,
                  iconData: Icons.lock,
                  labelText: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account?",
                    children: [
                      TextSpan(
                          text: " Register here",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(
                                RegisterPage(),
                                transition: Transition.fadeIn
                              );
                              print("object");
                            })
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async{
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.loginUserWithEmailandPassword(emailController!.value.text, passwordController!.value.text)
          
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailController!.value.text);

          Get.to(HomePage());
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
