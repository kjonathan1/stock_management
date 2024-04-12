import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const MyAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(child: Text(appBarTitle)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_night_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.person_2_outlined)),
            ],
          )
        ],
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
