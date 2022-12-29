import 'package:easy2cook/screens/auth/authenticate.dart';
import 'package:easy2cook/screens/wrapper.dart';
import 'package:easy2cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:easy2cook/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/NavItem.dart';

import 'package:easy2cook/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavItems(),
      child: StreamProvider<FUser?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          title: 'easy2cook',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            // Bar na vrhu
            appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          ),
          home: Wrapper(id: 0),
        ),
      ),
    );
  }

  /*return StreamProvider<FUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: ChangeNotifierProvider(
        create: (context) => NavItems(),
        child: MaterialApp(
          title: 'easy2cook',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            // Bar na vrhu
            appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          ),
          home: Wrapper(),
        ),
      ),
    );
  }*/
}
