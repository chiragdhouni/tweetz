part of 'create_tweet_bloc.dart';

@immutable
sealed class CreateTweetState {}

final class CreateTweetInitial extends CreateTweetState {}

abstract class CreateTweetActionState extends CreateTweetState {}

class CreateTweetLoadingStatae extends CreateTweetActionState {}

class CreateTweetSuccessStatae extends CreateTweetActionState {}

class CreateTweetErrorStatae extends CreateTweetActionState {}
