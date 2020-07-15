import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signupapp/login.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final uidController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  controller: uidController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Full name is required';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter email id';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter Password';
                    }
                  },
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        highlightedBorderColor: Colors.black,
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Checking, please wait",
                              ),
                            ),
                          );
                          _submit(uidController.text, emailController.text,
                              passwordController.text);
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(String uid, String email, String password) {
    if (_formKey.currentState.validate() == true) {
      // firebase code
      final FirebaseAuth _register = FirebaseAuth.instance;
      _register
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((currentUser) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration Successful",
            ),
          ),
        );
      }).catchError((err) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration Unsuccessful",
            ),
          ),
        );
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}
