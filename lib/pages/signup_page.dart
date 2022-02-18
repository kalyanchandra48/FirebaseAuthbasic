import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put_state.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  String email = '';
  String password = '';
  String fullname = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final emailTab = Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextFormField(
        maxLength: 25,
        onChanged: (value) {
          email = value;
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            counterText: "",
            fillColor: Color(0xff45FFC4),
            filled: true,
            prefixIcon: Icon(Icons.email, color: Colors.green.shade900),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );

    final passwordTab = Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextFormField(
        maxLength: 10,
        onChanged: (value) {
          password = value;
        },
        textAlign: TextAlign.center,
        obscureText: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            counterText: "",
            fillColor: Color(0xff45FFC4),
            filled: true,
            prefixIcon:
                Icon(Icons.password_outlined, color: Colors.green.shade900),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
    final fullnameTab = Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextFormField(
        maxLength: 20,
        onChanged: (value) {
          fullname = value;
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            counterText: "",
            fillColor: Color(0xff45FFC4),
            filled: true,
            prefixIcon: Icon(Icons.account_circle_outlined,
                color: Colors.green.shade900),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3),
            ),
            labelText: 'Full Name',
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an New Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  emailTab,
                  SizedBox(
                    height: 15,
                  ),
                  passwordTab,
                  SizedBox(
                    height: 15,
                  ),
                  fullnameTab,
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  signUp(email, password);
                },
                child: Text('SignUp'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Already Have an account.Login!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
              })
          .catchError((e) {
        return ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: Text(e!.message)));
      });
    }
  }
}
