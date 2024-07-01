import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/breakpoints.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/settings/settings_screen.dart';
import 'package:tictok_clone/features/users/view_models/user_view_model.dart';
import 'package:tictok_clone/features/users/widgets/avatar.dart';
import 'package:tictok_clone/features/users/widgets/persistent_tab_bar.dart';

import 'widgets/profile_circle_avatar.dart';
import 'widgets/profile_follow_button.dart';
import 'widgets/profile_id_view.dart';
import 'widgets/profile_link_text.dart';
import 'widgets/profile_user_description.dart';
import 'widgets/profile_user_status_panel.dart';
import 'widgets/square_button.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  final String username;
  final String tab;

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  body: TabBarView(
                    children: [
                      Center(
                        child: GridView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width >
                                    Breakpoints.md
                                ? 5
                                : 3,
                            crossAxisSpacing: Sizes.size2,
                            mainAxisSpacing: Sizes.size2,
                            childAspectRatio: 9 / 14,
                          ),
                          itemCount: 20,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 9 / 14,
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/placeholder.png",
                                  image:
                                      "https://images.unsplash.com/photo-1600340053706-32d1278206ef?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 5,
                                top: 5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size6,
                                    vertical: Sizes.size4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size4),
                                  ),
                                  child: const Text(
                                    "Pinned",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 0,
                                bottom: 0,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.play_arrow_outlined,
                                      color: Colors.white,
                                    ),
                                    Gaps.h4,
                                    Text(
                                      "4.1M",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Center(
                        child: Text("2"),
                      ),
                    ],
                  ),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        centerTitle: true,
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > Breakpoints.md) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const ProfileCircleAvatar(
                                        imgPath:
                                            "https://avatars.githubusercontent.com/u/34933982?v=4",
                                      ),
                                      Gaps.h16,
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Gaps.v10,
                                            ProfileIdView(
                                                id: "@${data.name}",
                                                isCertified: true),
                                            Gaps.v10,
                                            const ProfileUserDescription(
                                              description:
                                                  "All highlights and where to watch live matches on FIFA+ I wonder how it would loook. All highlights and where to watch live matches on FIFA+ I wonder how it would loook.",
                                            ),
                                            Gaps.v10,
                                            const ProfileLinkText(
                                                link: "https://nomadcoders.co"),
                                          ],
                                        ),
                                      ),
                                      Gaps.h16,
                                      const Column(
                                        children: [
                                          ProfileUserStatusPanel(
                                            following: "97",
                                            follower: "10M",
                                            likes: "194.3M",
                                          ),
                                          Gaps.v10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ProfileFollowButton(
                                                width: 160,
                                              ),
                                              Gaps.h5,
                                              SquareButton(
                                                size: Sizes.size40,
                                                iconSize: Sizes.size18,
                                                icon: FontAwesomeIcons.youtube,
                                              ),
                                              Gaps.h5,
                                              SquareButton(
                                                size: Sizes.size40,
                                                iconSize: Sizes.size16,
                                                icon:
                                                    FontAwesomeIcons.caretDown,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Gaps.v20,
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Gaps.v20,
                                  Avatar(
                                    name: data.name,
                                    hasAvatar: data.hasAvatar,
                                    uid: data.uid,
                                    avatarUrl: data.avatarUrl,
                                  ),
                                  Gaps.v20,
                                  ProfileIdView(
                                      id: "@${data.name}", isCertified: true),
                                  Gaps.v24,
                                  const ProfileUserStatusPanel(
                                    following: "97",
                                    follower: "10M",
                                    likes: "194.3M",
                                  ),
                                  Gaps.v14,
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ProfileFollowButton(width: 160),
                                      Gaps.h5,
                                      SquareButton(
                                        size: Sizes.size40,
                                        iconSize: Sizes.size18,
                                        icon: FontAwesomeIcons.youtube,
                                      ),
                                      Gaps.h5,
                                      SquareButton(
                                        size: Sizes.size40,
                                        iconSize: Sizes.size16,
                                        icon: FontAwesomeIcons.caretDown,
                                      ),
                                    ],
                                  ),
                                  Gaps.v14,
                                  const ProfileUserDescription(
                                    description:
                                        "All highlights and where to watch live matches on FIFA+ I wonder how it would loook",
                                    textAlign: TextAlign.center,
                                  ),
                                  Gaps.v14,
                                  const ProfileLinkText(
                                      link: "https://nomadcoders.co"),
                                  Gaps.v20,
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                ),
              ),
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
