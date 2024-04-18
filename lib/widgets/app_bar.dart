import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/provider/theme_provider.dart';

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
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  },
                  icon: Provider.of<ThemeProvider>(context).themeIcon),
                  
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
