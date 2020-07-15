import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_signupapp/profile.dart';
import 'package:login_signupapp/register.dart';
import 'package:login_signupapp/forgotpassword.dart';
import 'package:login_signupapp/main.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),

      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  List<String> data = ['', '', ''];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void changeColor() {
    DynamicTheme.of(context).setThemeData(new ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.blue? Colors.blue: Colors.pink
    ));
  }



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
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(
                    labelText: 'Email ID',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(
                    labelText: 'Password',

                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Forgot Password ? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassPage()),
                        );
                        changeBrightness();
                      },
                      child: Text(
                        "Click Here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
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
                          _logIn(userController.text, passController.text);
                          changeBrightness();
                          changeColor();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                        changeBrightness();
                      },
                      child: Text(
                        "Click Here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(" to register"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logIn(String user, String pass) {
    if (_formKey.currentState.validate() == true) {
      // firebase code
      FirebaseAuth _login = FirebaseAuth.instance;
      _login
          .signInWithEmailAndPassword(email: user, password: pass)
          .then((currentUser) async {
        data[0] = user;
        data[1] = pass;
        data[2] = currentUser.user.uid;
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login Successful",
            ),
          ),
        );
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('my_string_list_key', data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }).catchError((err) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login Unsuccessful",
            ),
          ),
        );
      });
    }
  }
}
