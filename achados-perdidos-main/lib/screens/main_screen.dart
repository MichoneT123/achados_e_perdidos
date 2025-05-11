import 'package:flutter/material.dart';
import 'package:perdidos_e_achados/screens/ItemListScreen.dart';
import 'package:perdidos_e_achados/screens/formItemScreen.dart';
import 'package:perdidos_e_achados/screens/feed_screen.dart';
import 'package:perdidos_e_achados/screens/profile_screen.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/drawer_item.dart';
import 'package:perdidos_e_achados/widgets_reutilizaveis/postCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _paginaSelecionada = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _paginaSelecionada = index;
          });
        },
        children: [
          ItemListScreen(),
          FeedScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaSelecionada,
        onDestinationSelected: (int index) {
          setState(() {
            _paginaSelecionada = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.list_rounded),
            label: "Meus itens",
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Perfil",
            selectedIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
