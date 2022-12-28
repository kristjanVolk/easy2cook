import 'package:easy2cook/screens/auth/authenticate.dart';
import 'package:easy2cook/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy2cook/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dostop do uporabnika
    final FUser? user = Provider.of<FUser?>(context);

    // user not logged in

    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
