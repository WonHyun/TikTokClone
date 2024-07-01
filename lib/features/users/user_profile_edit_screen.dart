import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/view_models/user_view_model.dart';
import 'package:tictok_clone/features/users/widgets/avatar.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  const UserProfileEditScreen({
    super.key,
    required this.userProfile,
  });

  final UserProfileModel userProfile;

  @override
  ConsumerState<UserProfileEditScreen> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditScreen> {
  late final TextEditingController _bioController =
      TextEditingController(text: widget.userProfile.bio);
  late final TextEditingController _linkController =
      TextEditingController(text: widget.userProfile.link);

  Future<void> _onDone() async {
    await ref.read(usersProvider.notifier).updateProfile(
          widget.userProfile.copyWith(
            bio: _bioController.text,
            link: _linkController.text,
          ),
        );
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile"),
          actions: [
            TextButton(
              onPressed: _onDone,
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: Column(
            children: [
              Gaps.v32,
              Text(
                widget.userProfile.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
              Center(
                child: Avatar(
                  name: widget.userProfile.name,
                  hasAvatar: widget.userProfile.hasAvatar,
                  uid: widget.userProfile.uid,
                  avatarUrl: widget.userProfile.avatarUrl,
                  isShowEditIcon: true,
                ),
              ),
              Gaps.v24,
              TextField(
                controller: _bioController,
                maxLines: 5,
                decoration: const InputDecoration(
                  label: Text(
                    "Desription",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              Gaps.v20,
              TextField(
                controller: _linkController,
                maxLines: 1,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  label: Text(
                    "Link",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
