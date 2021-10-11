import '../../food-shop/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/auth/services/auth.dart';
import 'package:login_ui/auth/screens/sign_up_screen.dart';
import 'package:login_ui/auth/utils/build_text_footer.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 100,
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
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
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
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text("Forget Password?"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('LOGIN'),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      await auth.signInOrCreate(
                          context, email, password, Home(), "SIGNIN");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text(
                    'SIGN WITH GOOGLE',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    await auth.signInWithGoogle(
                      context,
                      Home(),
                    );
                  },
                ),
              ),
              SizedBox(height: 100,),
              buildTextFooter(
                context,
                "Don't have an account?",
                "Sign up",
                SignUpScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
