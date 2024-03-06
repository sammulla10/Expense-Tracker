import 'package:expense_tracker/helping_widget/firebase_services.dart';
import 'package:expense_tracker/ui/expenses.dart';
import 'package:expense_tracker/ui/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // try {
    //   final credential =
    //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: email.text.toString(),
    //     password: password.text.toString(),
    //   );
    //   FirebaseAuth.instance.authStateChanges().listen((user) {
    //     if (FirebaseAuth.instance.currentUser == user) {
    //       Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => Expenses()));
    //     } else {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text('Not authenticated.')));
    //     }
    //   });
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF162534),
              Color.fromARGB(255, 26, 70, 110)
            ])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up!",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        "Create your account!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Color(0xFFAFD45E),
                      style: const TextStyle(color: Colors.white),
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: textFieldBorder(),
                        focusedBorder: textFieldBorder(),
                        border: textFieldBorder(),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        labelText: "Username",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ),
                    sizebox20(),
                    TextFormField(
                      cursorColor: Color(0xFFAFD45E),
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: textFieldBorder(),
                        focusedBorder: textFieldBorder(),
                        border: textFieldBorder(),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        labelText: "Email",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ),
                    sizebox20(),
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
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        labelText: "Password",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ),
                    sizebox20(),
                    TextFormField(
                      cursorColor: Color(0xFFAFD45E),
                      style: const TextStyle(color: Colors.white),
                      controller: cpasswordController,
                      validator: (value) {
                        if (kDebugMode) {
                          print(value != passwordController.text);
                          print(value);
                          print(passwordController.text);
                        }
                        if ((value == null || value.isEmpty) ||
                            value != passwordController.text) {
                          return 'Password not same';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: textFieldBorder(),
                        focusedBorder: textFieldBorder(),
                        border: textFieldBorder(),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ),
                    sizebox20(),
                    MaterialButton(
                      onPressed: _signup,
                      minWidth: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xFFAFD45E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account? ",
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        ),
                        MaterialButton(
                            onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // color: const Color(0xFFAFD45E),
                            child: const Text(
                              'LogIn',
                              style: TextStyle(
                                  color: const Color(0xFFAFD45E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _signup() async {
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;

    User? user = await _auth.signUpWithEmailandPassword(email, password);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Successfully Signed Up!',
        ),
        backgroundColor: Colors.green,
      ));
      debugPrint('User is successfully Logged In');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      debugPrint('Error happened.');
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
  }

  SizedBox sizebox20() {
    return const SizedBox(
      height: 20,
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFAFD45E), width: 1),
        borderRadius: BorderRadius.circular(15));
  }
}
