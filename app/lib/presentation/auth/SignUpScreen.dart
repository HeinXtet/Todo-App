import 'package:app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../components/Input.dart';
import 'AuthViewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameTextFieldController = TextEditingController();
  final emailTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  final confirmPasswordTextFieldController = TextEditingController();

  late AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    nameTextFieldController.addListener(() {
      authViewModel.updateName(nameTextFieldController.text);
    });
    emailTextFieldController.addListener(() {
      authViewModel.updateEmail(emailTextFieldController.text);
    });
    passwordTextFieldController.addListener(() {
      authViewModel.updatePassword(passwordTextFieldController.text);
    });
    confirmPasswordTextFieldController.addListener(() {
      authViewModel
          .updateConfirmPassword(confirmPasswordTextFieldController.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      authViewModel = context.read<AuthViewModel>();
      debugPrint("SIGN_UP_INIT_STATE");
      authViewModel.registerStreamController.stream.listen((value) {
        if (value) {
          context.go("/signup/signin");
        }
      });
    });
  }

  @override
  void dispose() {
    nameTextFieldController.dispose();
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
    confirmPasswordTextFieldController.dispose();
    authViewModel.loginStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.peachBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)?.welcome ?? "",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 32, color: AppColors.primaryBlack),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)?.signup_desc ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.darkPink),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Image(
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                    image: AssetImage("images/ic_signup.png"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)?.register_title ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.darkPink),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Input(
                    controller: nameTextFieldController,
                    hint: AppLocalizations.of(context)?.enter_name ?? "",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Input(
                    controller: emailTextFieldController,
                    hint: AppLocalizations.of(context)?.enter_email ?? "",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Input(
                    controller: passwordTextFieldController,
                    hint: AppLocalizations.of(context)?.create_password ?? "",
                    isPassword: true,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Input(
                    controller: confirmPasswordTextFieldController,
                    hint: AppLocalizations.of(context)?.confirm_password ?? "",
                    isPassword: true,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      height: 45,
                      disabledColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      color: AppColors.primaryBlack,
                      onPressed: () {
                        authViewModel.register(successCallback: () {
                          context.go("/signup/signin");
                        }, errorCallback: (err) {
                          toastification.show(
                              context: context,
                              title: Text(err),
                              autoCloseDuration: const Duration(seconds: 2));
                        });
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)?.have_account_desc ??
                          ""),
                      TextButton(
                        onPressed: () {
                          context.go("/signup/signin");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            AppLocalizations.of(context)?.sign_in ?? "",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.darkPink,
                                color: AppColors.darkPink,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
