import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;
import 'package:rhoshop/utils/regexps.dart' as RegExps;

/// Provides functionality for user signing in.
class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

/// Manages visibility for password input field.
class _SignInScreenState extends State<SignInScreen> {
  /// Controls whether or not to show the password in input field.
  var _obscureText = true;

  /// Sign in form key
  final _formKey = GlobalKey<FormState>();

  /// Email address from input field.
  String email;

  /// Password from input field.
  String password;

  /// Constructs the decoration for text fields in this screen.
  ///
  /// Customizes border colors and tet padding.
  InputDecoration constructTextFieldDecoration(String label, {suffixIcon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      alignLabelWithHint: true,
      labelText: label,
      suffixIcon: suffixIcon,
      suffixIconConstraints: BoxConstraints(minHeight: 30),
      labelStyle: TextStyle(
        color: AppColors.descriptionText,
        fontFamily: 'Nunito',
      ),
      errorStyle: TextStyle(height: 0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.descriptionText),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.descriptionText),
      ),
    );
  }

  /// Handles 'Sign In' button presses.
  void onSignInButtonPressed() {
    if (_formKey.currentState.validate()) {
      print(email);
      print(password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //title: Text(AppLocalization.of(context).loginScreenTitle),
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/left-arrow.svg",
                color: AppColors.primaryText,
                width: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalization.of(context).signInScreenTitle,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: constructTextFieldDecoration(
                                AppLocalization.of(context).email),
                            validator: (value) => (value.isEmpty ||
                                    !RegExp(RegExps.email).hasMatch(value))
                                ? ''
                                : null,
                            onChanged: (value) => email = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: _obscureText,
                            decoration: constructTextFieldDecoration(
                              AppLocalization.of(context).password,
                              suffixIcon: SizedBox(
                                height: 20,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.descriptionText,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            validator: (value) =>
                                (value.isEmpty || value.length < 6) ? '' : null,
                            onChanged: (value) => password = value,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          PrimaryButton(
                            onPressed: onSignInButtonPressed,
                            child: Text(
                              AppLocalization.of(context).signIn,
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {},
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            AppLocalization.of(context).noAccountText,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: AppColors.descriptionText),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            AppLocalization.of(context).signUp,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
