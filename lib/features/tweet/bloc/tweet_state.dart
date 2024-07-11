part of 'tweet_bloc.dart';

@immutable
sealed class TweetState {}

final class TweetInitial extends TweetState {}

class TweetLoadState extends TweetState {}

class TweetSuccessState extends TweetState {
  final List<TweetModel> tweets;

  TweetSuccessState(this.tweets);
}

class TweetErrorState extends TweetState {}
