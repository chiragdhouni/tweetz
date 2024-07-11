part of 'tweet_bloc.dart';

@immutable
sealed class TweetEvent {}

class TweetInitialFetchEvent extends TweetEvent {}
