// ignore_for_file: avoid_print

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authentication/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    print(user);
    // return either Home or Authenticate Widget
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
