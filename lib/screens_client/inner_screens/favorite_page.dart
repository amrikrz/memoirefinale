import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
    static const routeName = "/FavoritePage";

  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late TextEditingController searchTextController;
  @override
  void iniState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
