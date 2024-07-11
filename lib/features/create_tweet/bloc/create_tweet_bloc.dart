import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workshop_tweet_app/features/create_tweet/repos/create_tweet_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'create_tweet_event.dart';
part 'create_tweet_state.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetState> {
  CreateTweetBloc() : super(CreateTweetInitial()) {
    on<CreateTweetPostEvent>((event, emit) async {
      emit(CreateTweetLoadingStatae());
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final uuid = Uuid().v1();
      bool success = await CreateTweetRepo.postTweetRepo(
        uuid,
        uid,
        event.content,
        DateTime.now(),
      );

      if (success) {
        emit(CreateTweetSuccessStatae());
      } else {
        emit(CreateTweetErrorStatae());
      }
    });
  }
}
