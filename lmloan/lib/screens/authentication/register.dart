import 'package:lmloan/config/extensions.dart';
import 'package:lmloan/enums/enums.dart';
import 'package:lmloan/provider/authentication/auth_provider.dart';
import 'package:lmloan/shared/utils/message.dart';
import 'package:lmloan/shared/widgets/busy_overlay.dart';
import 'package:lmloan/shared/widgets/custom_button.dart';
import 'package:lmloan/styles/color.dart';
import 'package:lmloan/styles/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviderImpl>(builder: (context, stateModel, child) {
      return BusyOverlay(
        show: stateModel.state == ViewState.Busy,
        title: stateModel.message,
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register Here',
                      style: AppTheme.headerStyle(color: greenColor),
                    ),
                    Text(
                        'Get Access to instant Cash Loans.',
                        style: AppTheme.subTitleStyle(color: greenColor),
                      ),
                    20.height(), 
                    Image.asset('assets/images/Signuppana.png', height: 120, width: 120,),
                    50.height(),
                    CustomTextField(
                      stateModel.userNameController,
                      hint: 'Username',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    20.height(),
                    CustomTextField(
                      stateModel.emailController,
                      hint: 'Email',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    20.height(),
                    CustomTextField(
                      stateModel.passwordController,
                      hint: 'Password',
                      password: true,
                      border: Border.all(color: greyColor),
                    ),
                    100.height(),
                    CustomButton(
                      onPressed: () async {
                        if (stateModel.userNameController.text.isEmpty ||
                            stateModel.passwordController.text.isEmpty) {
                          showMessage(context, 'All fields are required', isError: true);
                          return;
                        }
                        if (!FlutterUtilities().isEmailValid(stateModel.emailController.text.trim())) {
                          showMessage(context, "Invalid email provided", isError: true);
                          return;
                        }

                        await stateModel.registerUser();

                        if (stateModel.state == ViewState.Error) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message, isError: true);
                          }
                          return;
                        }
                        if (stateModel.state == ViewState.Success) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message);
                            context.go('/loan_dashboard');
                          }
                        }
                      },
                      text: 'Register',
                    ),
                    50.height(),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: AppTheme.titleStyle2(isBold: true),
                          ),
                          TextSpan(
                            text: "Sign In",
                            style: AppTheme.titleStyle(color: primaryColor, isBold: true),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/login_screen');
                              },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
