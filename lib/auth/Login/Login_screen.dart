import 'package:chat_route/Components/custom_button.dart';
import 'package:chat_route/Components/custom_text_form_field.dart';
import 'package:chat_route/Utils/dialog_utils.dart';
import 'package:chat_route/auth/Register/register_screen.dart';
import 'package:chat_route/auth/home/home_screen.dart';
import 'package:chat_route/my_theme.dart';
import 'package:chat_route/auth/Login/login_connector.dart';
import 'package:chat_route/auth/Login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginConnector {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController =
      TextEditingController(text: '123456');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isObscure = true;

  LoginViewModel viewModel = LoginViewModel();
@override
  void initState() {
    viewModel.connector=this;
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
                  'Login',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Welcome Back !',
                                style: Theme.of(context).textTheme.titleMedium),
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
                        ],
                      ),
                    ),
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        validateLogin();
                      },
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    }
                    , child: Text('Or Create Account',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyTheme.primary
                    ),))
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void validateLogin() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }
  showMessage(String message) {
    DialogUtils.showMessage(
      context: context,
      message: message,
    //   negAction:()=> Navigator.pop(context),
    // negActionName: 'Cancel',
    posAction: ()=>Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false),
    posActionName: 'Ok'
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
  
  @override
  void showErrorMessage(String message) {
  DialogUtils.showMessage(
      context: context,
      message: message,
      negAction:()=> Navigator.pop(context),
    negActionName: 'Cancel',
    // posAction: ()=> Navigator.pushNamed(context, HomeScreen.routeName),
    // posActionName: 'Ok'
    );
    // setState(() {}); 
     }


}
