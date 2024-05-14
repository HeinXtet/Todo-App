import 'package:app/presentation/di.dart';
import 'package:app/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.peachBg,
      body: Container(
        margin: const EdgeInsets.only(top: 36),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                width: 300,
                height: 300,
                image: AssetImage("images/ic_calendar.png"),
                fit: BoxFit.fill,
              ),
              Text(
                AppLocalizations.of(context)?.manage_your ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
              ),
              Text(
                AppLocalizations.of(context)?.daily_todo ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)?.onboarding_desc ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              RawMaterialButton(
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.black,
                onPressed: () {
                  var pref = getIt.get<SharedPreferences>();
                  pref.setBool("loggedIn", true).whenComplete(() {
                    debugPrint("Saved");
                    context.go(
                      "/signup",
                    );
                  });
                },
                padding: const EdgeInsets.all(15.0),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
