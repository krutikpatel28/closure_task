import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_signupapp/main.dart';
import 'package:login_signupapp/login.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List storedData = ['', '', ''];
  var emailID;
  var userID;
  var pass;

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedData = prefs.getStringList('my_string_list_key');
      emailID = storedData[0];
      pass = storedData[1];
      userID = storedData[2];
      if (emailID == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Container(
        color: Colors.lightGreen,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Email:$emailID",
                    style: TextStyle(
                      fontSize: 18,
                      color:Colors.black,
                      backgroundColor: Colors.lightBlue,
                      ),
                    
                  ),
                ],
              ),

            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                  child : Center(
                    child:Text(
                    "                             UID              "
                    "               $userID     ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),
                    ),
                  ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      color: Color(00000),
                      splashColor: Colors.black,
                      hoverColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                      highlightedBorderColor: Colors.black,
                      borderSide:BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.red,
                        width: 2.0,
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                        changeBrightness();
                      },
                      child: const Text(
                        'Log   Out',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // backgroundColor: Colors.black,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
