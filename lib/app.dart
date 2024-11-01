import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/screens/homepage.dart';
import 'package:todoapp/screens/login.dart';

import 'providers.dart';

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    
  });


  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {


  @override
  Widget build(BuildContext context) {
    
    final userDao = ref.watch(authDaoProvider);
    return Scaffold(

      body: 
          Center(
            child: userDao.isLoggedIn() //
                ? const Home()
                : const Login(),
          ),  
    );
  }
}
