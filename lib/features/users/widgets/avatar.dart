import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tictok_clone/features/users/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
    required this.avatarUrl,
    this.isShowEditIcon = false,
    this.size = 50,
  });

  final String name;
  final bool hasAvatar;
  final String uid;
  final String avatarUrl;
  final bool isShowEditIcon;
  final double size;

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator.adaptive(),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    radius: size,
                    foregroundImage: NetworkImage(avatarUrl),
                    child: Text(name),
                  ),
                ),
                if (isShowEditIcon)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.inverseSurface,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 5,
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Theme.of(context).colorScheme.surface,
                        size: size / 3,
                      ),
                    ),
                  )
              ],
            ),
    );
  }
}
