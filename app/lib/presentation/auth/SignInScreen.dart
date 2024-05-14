import 'package:app/presentation/auth/AuthViewModel.dart';
import 'package:app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../components/Input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();

  late AuthViewModel viewModel;

  @override
  void initState() {
    super.initState();
    emailTextFieldController.addListener(() {
      viewModel.updateEmail(emailTextFieldController.text);
    });
    passwordTextFieldController.addListener(() {
      viewModel.updatePassword(passwordTextFieldController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AuthViewModel>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              context.go("/signup");
            },
          ),
        ),
        backgroundColor: AppColors.peachBg,
      ),
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
                    image: AssetImage("images/ic_hello.png"),
                  ),
                ),
                const SizedBox(
                  height: 32,
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
                        viewModel.login(successCallback: () {
                          context.go("/todoList");
                        }, errorCallback: (err) {
                          toastification.show(
                            context: context,
                            title: Text(err),
                            autoCloseDuration: const Duration(seconds: 2)
                          );
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)?.sign_in ?? "",
                        style: const TextStyle(
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
                      Text(AppLocalizations.of(context)?.register_title ??
                          "?" "?"),
                      TextButton(
                        onPressed: () {
                          context.go("/signup");
                        },
                        child: Text(
                          AppLocalizations.of(context)?.register ?? "",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.darkPink,
                              color: AppColors.darkPink,
                              fontWeight: FontWeight.bold),
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
