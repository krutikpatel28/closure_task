import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_signupapp/profile.dart';
import 'package:login_signupapp/login.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data:(brightness) =>new ThemeData(
        // brightness: Brightness.dark,
        // accentColorBrightness: ,
        // colorScheme: ColorScheme.light({Color primary: const Color(0xff6200ee), Color primaryVariant: const Color(0xff3700b3), Color secondary: const Color(0xff03dac6), Color secondaryVariant: const Color(0xff018786), Color surface: Colors.white, Color background: Colors.white, Color error: const Color(0xffb00020), Color onPrimary: Colors.white, Color onSecondary: Colors.black, Color onSurface: Colors.black, Color onBackground: Colors.black, Color onError: Colors.white, Brightness brightness: Brightness.light}),
        // backgroundColor: Colors.lime,
        primaryColor: Colors.black,
        accentColor: Colors.black,
        //  primarySwatch: Colors.indigoAccent,
        brightness :brightness,
        scaffoldBackgroundColor: Colors.black,
        textSelectionHandleColor: Colors.amber,
        textSelectionColor: Colors.lime,
        cursorColor: Colors.black,
        toggleableActiveColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      themedWidgetBuilder: (context,theme){
        return new MaterialApp(
          title: "Sign-up Forms",
          theme: theme,
          home: HomePage(), 
        );
      }
    );
}
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List storedData = ['', '', ''];
  bool visited = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedData = prefs.getStringList('my_string_list_key');
      if (storedData[0] != '') {
        visited = true;
      }
    });
    
  }

  

  @override
  Widget build(BuildContext context) {
    return visited ? ProfilePage() : LoginPage();

  }
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }


  void changeColor() {
    DynamicTheme.of(context).setThemeData(new ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.indigo? Colors.red: Colors.indigo
    ));
  }
}


