import 'package:chat_route/Components/custom_button.dart';
import 'package:chat_route/my_theme.dart';
import 'package:chat_route/Components/custom_text_form_field.dart';
import 'package:chat_route/auth/Register/connector.dart';
import 'package:chat_route/auth/Register/register_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements Connector {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: 'Mariam');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');
  bool isLoading = false;
  bool isObscure = true;
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void initState() {
    viewModel.connector = this;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(
          children: [
            Container(
              color: MyTheme.whiteColor,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Scaffold(
              //resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .25,
                            ),
                            CustomTextFormField(
                              label: 'User name',
                              controller: nameController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'Please Enter Your Name';
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField(
                                label: 'E-mail',
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return 'please enter  e-mail';
                                  }
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);
                                  if (!emailValid) {
                                    return 'please enter valid e-mail';
                                  }
                                  return null;
                                }),
                            CustomTextFormField(
                                obscureText: isObscure,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    isObscure == true
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: MyTheme.primary,
                                  ),
                                ),
                                label: 'password',
                                controller: passwordController,
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return ' Please Enter Your password';
                                  }
                                  if (text.length < 6) {
                                    return 'password Should be at least 6 char';
                                  }
                                  return null;
                                }),
                            CustomTextFormField(
                                obscureText: isObscure,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    isObscure == true
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: MyTheme.primary,
                                  ),
                                ),
                                label: 'Confirm password',
                                controller: confirmPasswordController,
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return ' please enter confirm password';
                                  }
                                  if (text != passwordController.text) {
                                    return "Confirm password doesn't match password";
                                  }
                                  return null;
                                }),
                          ],
                        )),
                    CustomButton(
                      text: 'Create Account',
                      onPressed: () {
                        validateRegister();
                        setState(() {
                          
                        });
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          Future<UserCredential> signInWithGoogle() async {
                            // Trigger the authentication flow
                            final GoogleSignInAccount? googleUser =
                                await GoogleSignIn().signIn();

                            // Obtain the auth details from the request
                            final GoogleSignInAuthentication? googleAuth =
                                await googleUser?.authentication;

                            // Create a new credential
                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth?.accessToken,
                              idToken: googleAuth?.idToken,
                            );
                            print(credential.idToken);
                            // Once signed in, return the UserCredential
                            return await FirebaseAuth.instance
                                .signInWithCredential(credential);
                          }
                        },
                        icon: Icon(
                          Icons.facebook_outlined,
                          size: 50,
                          color: MyTheme.primary,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void validateRegister() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
    setState(() {});
  }

  @override
  hideLoading() {
    isLoading = false;
    setState(() {});
  }

  @override
  showLoading() {
    isLoading = true;
    setState(() {});
  }
}
