import 'package:chat_now/helper/helper_function.dart';
import 'package:chat_now/screens/auth/login_page.dart';
import 'package:chat_now/screens/home.dart';
import 'package:chat_now/services/auth_services.dart';
import 'package:chat_now/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  // String email ='';
  // String password='';
  bool _isLoading = false;
  TextEditingController? emailController;
  TextEditingController? nameController;
  TextEditingController? passwordController;
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController!.dispose();
    nameController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Chat-Now",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Create your account now hang with your friend & family",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Image.asset("assets/register.png"),
                      CustomTextFormField(
                        validator: "name",
                        controller: nameController!,
                        iconData: Icons.person,
                        labelText: 'Full Name',
                      ),
                      SizedBox(
                        height: 15,
                      ),
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
                            register();
                          },
                          child: Text(
                            "Sign Up",
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
                          text: "Already have an account?",
                          children: [
                            TextSpan(
                                text: " Login now",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(LoginPage(),
                                        transition: Transition.fadeIn);
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

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(nameController!.value.text,
              emailController!.value.text, passwordController!.value.text)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailController!.value.text);
          await HelperFunctions.saveUserEmailSF(nameController!.value.text);
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
