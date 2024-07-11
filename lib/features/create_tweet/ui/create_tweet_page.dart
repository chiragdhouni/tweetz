// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop_tweet_app/features/create_tweet/bloc/create_tweet_bloc.dart';

class CreateTweetPage extends StatefulWidget {
  const CreateTweetPage({super.key});

  @override
  State<CreateTweetPage> createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  TextEditingController tweetContentController = TextEditingController();
  bool loader = false;
  CreateTweetBloc createTweetBloc = CreateTweetBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateTweetBloc, CreateTweetState>(
        bloc: createTweetBloc,
        listenWhen: (current, previous) => current is CreateTweetActionState,
        buildWhen: (current, previous) => current is! CreateTweetActionState,
        listener: (context, state) {
          if (state is CreateTweetLoadingStatae) {
            setState(() {
              loader = true;
            });
          } else if (state is CreateTweetActionState) {
            setState(() {
              loader = false;
            });
            Navigator.pop(context);
          } else if (state is CreateTweetErrorStatae) {
            setState(() {
              loader = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('something went wrong')));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 50, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Tweet",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 30,
                  minLines: 1,
                  controller: tweetContentController,
                  decoration: InputDecoration(
                    hintText: "What's happening?",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60, // Match the ElevatedButton's height
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.green
                      ], // Your gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(
                        5), // Match ElevatedButton's border radius
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                      backgroundColor: Colors
                          .transparent, // Make the ElevatedButton's background transparent
                      shadowColor:
                          Colors.transparent, // Remove shadow if needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5), // Ensure it matches Container's border radius
                      ),
                    ),
                    onPressed: () {
                      createTweetBloc.add(CreateTweetPostEvent(
                        tweetContentController.text,
                      ));
                    },
                    child: Center(child: Text("Tweet")),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
