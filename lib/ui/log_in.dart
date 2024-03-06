import 'package:expense_tracker/helping_widget/firebase_services.dart';
import 'package:expense_tracker/ui/expenses.dart';
import 'package:expense_tracker/ui/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  Future<String> onTapGoogleLogIn() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text("Loading...")),
              ],
            ),
          );
        });

    String accessToken = "";

    GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email,phone']).signIn();

    try {
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      accessToken = credential.idToken.toString();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Expenses()));
    } on PlatformException {
      throw PlatformException(code: 'Not found');
    } catch (e) {
      Navigator.pop(context);
    }

    return accessToken;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF162534),
              Color.fromARGB(255, 26, 70, 110)
            ])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log in",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        "with your Google Account",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ]),
              ),
              sizebox(40, 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Color(0xFFAFD45E),
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: textFieldBorder(),
                        focusedBorder: textFieldBorder(),
                        border: textFieldBorder(),
                        floatingLabelStyle: const TextStyle(
                            color: Color(0xFFAFD45E), fontSize: 20),
                        labelText: "Email",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ),
                    sizebox(20, 0),
                    TextFormField(
                      cursorColor: Color(0xFFAFD45E),
                      style: const TextStyle(color: Colors.white),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: textFieldBorder(),
                        focusedBorder: textFieldBorder(),
                        border: textFieldBorder(),
                        floatingLabelStyle: const TextStyle(
                            color: Color(0xFFAFD45E), fontSize: 20),
                        labelText: "Password",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              sizebox(40, 0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: _signin,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFAFD45E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  MaterialButton(
                      onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Sign-up',
                        style: TextStyle(
                            color: Color(0xFFAFD45E),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFAFD45E), width: 1),
        borderRadius: BorderRadius.circular(15));
  }

  _signin() async {
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;

    User? user = await _auth.signInWithEmailandPassword(email, password);
    if (user != null) {
      debugPrint('User is successfully Logged In');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Expenses()));
    } else {
      debugPrint('Error happened.');
    }
  }

  SizedBox sizebox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
