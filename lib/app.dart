// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop_tweet_app/core/local_db/shared_pref_manager.dart';
import 'package:flutter_workshop_tweet_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter_workshop_tweet_app/features/tweet/ui/tweets_page.dart';

class Decidepage extends StatefulWidget {
  static StreamController<String?> authStream =
      StreamController<String>.broadcast();
  const Decidepage({super.key});

  @override
  State<Decidepage> createState() => _DecidepageState();
}

class _DecidepageState extends State<Decidepage> {
  @override
  void initState() {
    // TODO: implement initState

    getUid();

    super.initState();
  }

  getUid() async {
    String uid = await SharedPrefManager.getUid();
    if (uid.isEmpty) {
      Decidepage.authStream.add("");
    } else {
      Decidepage.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: Decidepage.authStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null || (snapshot.data!.isEmpty)) {
            return onBoardingScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else
            return TweetsPage();
        });
  }
}
