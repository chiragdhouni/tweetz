// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop_tweet_app/features/create_tweet/ui/create_tweet_page.dart';
import 'package:flutter_workshop_tweet_app/features/tweet/bloc/tweet_bloc.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  State<TweetsPage> createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  TweetBloc tweetBloc = TweetBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTweetPage()));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.blue),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BlocConsumer<TweetBloc, TweetState>(
          bloc: tweetBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case TweetSuccessState:
                final successState = state as TweetSuccessState;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(40, 50, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 120,
                        child: Center(
                            child: Text(
                          "Tweetz",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: successState.tweets.length,
                              itemBuilder: (context, index) {
                                return Container();
                              }))
                    ],
                  ),
                );

              case TweetLoadState():
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return SizedBox();
            }
          },
        ));
  }
}
