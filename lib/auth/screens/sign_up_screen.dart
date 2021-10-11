import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_ui/auth/services/auth.dart';
import 'package:login_ui/utils/show_snackbar.dart';
import 'package:login_ui/auth/screens/sign_in_screen.dart';
import 'package:login_ui/auth/utils/build_text_footer.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Auth auth = new Auth();

  String email = '';
  String password = '';
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(17),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Email is required"),
                  EmailValidator(errorText: "Email is not a valid Email")
                ]),
                onSaved: (String? value) {
                  email = value!;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Password is required"),
                  MinLengthValidator(6,
                      errorText: "Password should be at least 6 characters")
                ]),
                onSaved: (String? value) {
                  password = value!;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('SIGN UP'),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      await auth.signInOrCreate(
                          context, email, password, SignInScreen(), "SIGNUP");
                    }
                  },
                ),
              ),
              Spacer(),
              buildTextFooter(
                context,
                "Already have an account?",
                "Sign in",
                SignInScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
