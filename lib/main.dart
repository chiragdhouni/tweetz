import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop_tweet_app/app.dart';
import 'package:flutter_workshop_tweet_app/core/local_db/shared_pref_manager.dart';
import 'package:flutter_workshop_tweet_app/design/app_theme.dart';

import 'package:flutter_workshop_tweet_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Decidepage(),
    );
  }
}
