import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/breakpoints.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textFieldController = TextEditingController();
  late final TabController _tabController =
      TabController(length: tabs.length, vsync: this);
  bool _isShowClear = false;

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });
    _textFieldController.addListener(() {
      setState(() {
        if (_textFieldController.text.isEmpty) {
          _isShowClear = false;
        } else {
          _isShowClear = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 1,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.sliders),
                onPressed: () => {},
              ),
            ),
          ),
        ],
        // title: CupertinoSearchTextField(
        //   controller: _textFieldController,
        //   onChanged: _onSearchChanged,
        //   onSubmitted: _onSearchSubmitted,
        // ),
        title: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: Breakpoints.sm,
          ),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _textFieldController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                ),
                suffixIcon: AnimatedOpacity(
                  opacity: _isShowClear ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 150),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: GestureDetector(
                      onTap: _isShowClear ? _textFieldController.clear : null,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        color: Colors.grey.shade700,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
          isScrollable: true,
          splashFactory: NoSplash.splashFactory,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16,
          ),
          indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
          tabs: [
            for (var tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(Sizes.size6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).size.width > Breakpoints.lg ? 5 : 2,
              crossAxisSpacing: Sizes.size10,
              mainAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/placeholder.png",
                          image:
                              "https://images.unsplash.com/photo-1600340053706-32d1278206ef?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "This is a very long caption for my tiktok that im upload just now currently",
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size2,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  AssetImage("assets/images/cyber-kitty.jpg"),
                            ),
                            Gaps.h4,
                            const Expanded(
                              child: Text(
                                "My avatar is going to be very long",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text("2.5M"),
                          ],
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(tab),
            ),
        ],
      ),
    );
  }
}
