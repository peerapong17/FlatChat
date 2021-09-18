import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../food-shop/main_route.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final _formKey = GlobalKey<FormState>();
bool userNameValidate = false;

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xffffabce),
                    Color(0xffff9ecb),
                    Color(0xffffabce),
                  ])),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "MooShop Register",
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.blue,
                              fontFamily: 'AkayaTelivigala'),
                        ),
                      ),
                      SizedBox(height: 150),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextFormField(
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email...',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            )
                          ],
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: TextFormField(
                              validator: MultiValidator([
                                MinLengthValidator(8,
                                    errorText:
                                        'password must be at least 8 digits long'),
                                RequiredValidator(
                                    errorText: 'password is required'),
                              ]),
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password...',
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  border: InputBorder.none),
                              keyboardType: TextInputType.emailAddress,
                            )),
                      ),
                      SizedBox(
                        height: 90,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pinkAccent,
                                  offset: Offset(2, 2),
                                  blurRadius: 10),
                            ],
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () async {
                            var newUser;
                            try {
                              if (_formKey.currentState!.validate()) {
                                newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                                if (newUser != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainRoute()),
                                  );
                                }
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text("REGISTER"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
