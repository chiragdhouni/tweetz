part of 'create_tweet_bloc.dart';

@immutable
sealed class CreateTweetEvent {}

class CreateTweetPostEvent extends CreateTweetEvent {
  final String content;

  CreateTweetPostEvent(this.content);
}
