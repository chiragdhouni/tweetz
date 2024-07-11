import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_tweet_event.dart';
part 'update_tweet_state.dart';

class UpdateTweetBloc extends Bloc<UpdateTweetEvent, UpdateTweetState> {
  UpdateTweetBloc() : super(UpdateTweetInitial()) {
    on<UpdateTweetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
