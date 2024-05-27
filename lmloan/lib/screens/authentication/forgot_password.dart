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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviderImpl>(builder: (context, stateModel, child) {
      return BusyOverlay(
        show: stateModel.state == ViewState.Busy,
        title: stateModel.message,
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: AppTheme.headerStyle(color: greenColor),
                    ),
                    40.height(),
                    Image.asset('assets/images/Resetpassword-pana.png', height: 160, width: 160,),
                    80.height(),
                    Text(
                      'Please provide your current Email.',
                      style: AppTheme.subTitleStyle(color: greenColor),
                    ),
                    20.height(),
                    CustomTextField(
                      stateModel.emailController,
                      hint: 'Email',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    100.height(),
                    CustomButton(
                      onPressed: () async {
                        if (!FlutterUtilities().isEmailValid(stateModel.emailController.text.trim())) {
                          showMessage(context, "Invalid email provided", isError: true);
                          return;
                        }

                        await stateModel.resetPassword();

                        if (stateModel.state == ViewState.Error) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message, isError: true);
                          }
                          return;
                        }
                        if (stateModel.state == ViewState.Success) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message);
                            context.go('/login_screen');
                          }
                        }
                      },
                      text: 'Reset Password',
                    ),
                    50.height(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Remember Password? ",
                        style: AppTheme.titleStyle(isBold: true),
                      ),
                      TextSpan(
                        text: "Log in",
                        style: AppTheme.titleStyle(color: primaryColor, isBold: true),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/login_screen');
                          },
                      )
                    ]))
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
