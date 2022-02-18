import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'mobile_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  Widget build(BuildContext context) {
    final emailfield = TextFormField(
      controller: _email,
      maxLength: 25,
      cursorColor: Color(0xFF0058B0),
      decoration: InputDecoration(
          fillColor: Color(0xff6AB5FF).withOpacity(0.3),
          filled: true,
          prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
          suffixIcon: GestureDetector(
            onTap: () {
              _email.clear();
            },
            child: Icon(Icons.clear, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            borderSide: BorderSide(width: 2, color: Color(0xFF0058B0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            borderSide: BorderSide(width: 2, color: Color(0xFF0058B0)),
          ),
          counterText: "",
          labelText: 'Enter Your Email',
          labelStyle: TextStyle(color: Colors.black)),
    );
    final passwordfield = TextFormField(
      obscureText: true,
      controller: _password,
      maxLength: 20,
      cursorColor: Color(0xFF0058B0),
      decoration: InputDecoration(
          fillColor: Color(0xff6AB5FF).withOpacity(0.3),
          filled: true,
          prefixIcon: Icon(Icons.password_outlined, color: Colors.black),
          suffixIcon: GestureDetector(
            onTap: () {
              _password.clear();
            },
            child: Icon(Icons.clear, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            borderSide: BorderSide(width: 2, color: Color(0xFF0058B0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            borderSide: BorderSide(width: 2, color: Color(0xFF0058B0)),
          ),
          counterText: "",
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black)),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/surfboard-website.appspot.com/o/brand_assets%2Flogos%2Fdeepbluesea%2Fsurfboard-payments.png?alt=media")))),
          SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                emailfield,
                SizedBox(
                  height: 25,
                ),
                passwordfield,
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              child: Text('Login'),
              onPressed: () {
                signIn(_email.text, _password.text);
              }),
          Text('OR'),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              child: Text('Login With OTP'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MobileLogin()),
                );
              }),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text("Don't Have an Account!. SignUp!"),
          ),
        ]),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  new SnackBar(
                    content: Text('Login Successful'),
                  ),
                ),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
              })
          .catchError((e) {
        return ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: Text(e!.message)));
      });
    }
  }
}
