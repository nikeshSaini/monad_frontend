import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monad/screen/HomePage.dart';
import 'package:monad/splashScreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
  print('yay');
  print(prefs.getString('token'));
}

// (JwtDecoder.isExpired(token.toString()) == false)
//           ? HomePage(token: token)
//           : const
class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const MyApp({@required this.token, super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        applyElevationOverlayColor: true,
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(color: Color(0xFF888888))),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Muli",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: (token != '') ? HomePage(token: token) : const splashScreen(),
      // home: HomePage(),
    );
  }
}
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//         applyElevationOverlayColor: true,
//         appBarTheme: const AppBarTheme(
//             color: Colors.white,
//             elevation: 0,
//             systemOverlayStyle: SystemUiOverlayStyle.light,
//             iconTheme: IconThemeData(
//               color: Colors.black,
//             ),
//             titleTextStyle: TextStyle(color: Color(0xFF888888))),
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: "Muli",
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: ( JwtDecoder.isExpired(token) splashScreen()),
//       // home: HomePage(),
//     );
//   }
// }
