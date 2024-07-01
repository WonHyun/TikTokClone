import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/repo/user_repository.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
    UserCredential credential,
    String name,
    String birthday,
  ) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: name,
      bio: "undefined",
      link: "undefined",
      birthday: birthday,
    );
    await _repository.createProfile(profile);
    state = AsyncData(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
