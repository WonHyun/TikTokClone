import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repo/authentication_repo.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/repo/user_repository.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository.findProfile(
        _authenticationRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

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
      hasAvatar: credential.user!.photoURL != null &&
          credential.user!.photoURL!.isNotEmpty,
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: name,
      bio: "undefined",
      link: "undefined",
      birthday: birthday,
      avatarUrl: credential.user!.photoURL ?? "",
    );
    await _userRepository.createProfile(profile);
    state = AsyncData(profile);
  }

  Future<void> onAvatarUpload(String avatarUrl) async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(
        hasAvatar: true,
        avatarUrl: avatarUrl,
      ),
    );
    await _userRepository.updateUser(
      state.value!.uid,
      {
        "hasAvatar": true,
        "avatarUrl": avatarUrl,
      },
    );
  }

  Future<void> updateProfile(UserProfileModel profile) async {
    state = const AsyncValue.loading();
    await _userRepository.updateProfile(profile);
    state = AsyncData(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
