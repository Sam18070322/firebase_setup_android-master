import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup_android/screens/landingpage.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:firebase_setup_android/components/background.dart';
import 'package:firebase_setup_android/screens/Homepage.dart';
import 'package:firebase_setup_android/screens/landingpage.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  Future<void> login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential authResult;

  void signIn(String email, String password) async {
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Account created for user ");
    } catch (e) {
      print("Account is already Exits");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Sign IN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF266AE5),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                onChanged: (value) {
                  _email = value;
                },
                // controller: _emailController,
                decoration: InputDecoration(
                  // icon: Icons.email,
                  labelText: "Email",
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Email can\t be Empty' : null,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                onChanged: (value) {
                  _password = value;
                },
                // controller: _passwordController,
                decoration: InputDecoration(
                  //icon: Icons.lock,
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Password can\t be Empty' : null,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Forgot Password ?",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2661FA),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
              child: RaisedButton(
                onPressed: login,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41),
                    ]),
                  ),
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "Sign IN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()))
                },
                child: Text(
                  "Don't You Have an account ? Sign up",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
