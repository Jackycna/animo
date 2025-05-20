import 'package:animo/auth/registation.dart';
import 'package:animo/pages/home_screen.dart';
import 'package:animo/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    emailcontroller.addListener(() {
      listener:
      (context);
    });
    passwordcontroller.addListener(() {
      listener:
      (context);
    });
    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.removeListener(() {
      listener:
      (context);
    });
    passwordcontroller.removeListener(() {
      listener:
      (context);
    });
    super.dispose();
  }

  @override
  final fromkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool text = true;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fromkey,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  child: Lottie.asset('assets/animation/naruto1.json'),
                ),
              ),
              Center(
                child: Text(
                  'Loging In',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Enter valid username and password',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color: Colors.orange),
                    ),
                    prefixIcon: Icon(Icons.mail),
                    suffixIcon:
                        emailcontroller.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                              onPressed: () {
                                emailcontroller.clear();
                              },
                              icon: Icon(Icons.close, color: Colors.orange),
                            ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: text,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color: Colors.orange),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon:
                        passwordcontroller.text.isEmpty
                            ? Container(width: 0)
                            : GestureDetector(
                              child: Icon(Icons.remove_red_eye_outlined),
                              onLongPress: () {},
                              onLongPressUp: () {},
                            ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  child: Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadingAnimatedButton(
                  child: Text('LogIn'),
                  onTap: () {
                    loginUser();
                    final form = fromkey.currentState!;
                    String email = emailcontroller.text;
                    String password = passwordcontroller.text;
                    if (form.validate()) {
                      final email = emailcontroller.text;
                      final password = passwordcontroller.text;
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Registation()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
    );
  }

  void loginUser() {
    if (passwordcontroller.text == "") {
      Fluttertoast.showToast(msg: 'Password cannot be blank');
    } else {
      String email = emailcontroller.text;
      String password = passwordcontroller.text;
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            ).catchError((e) {
              Fluttertoast.showToast(msg: '$e');
            });
          });
    }
  }
}
