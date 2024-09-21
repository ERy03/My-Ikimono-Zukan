import 'package:flutter/material.dart';
import 'package:my_ikimono_zukan/view/screens/account_screen.dart';
import 'package:my_ikimono_zukan/view/screens/capture_screen.dart';
import 'package:my_ikimono_zukan/view/screens/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // 各画面のリスト
  static const _screens = [
    HomeScreen(),
    CaptureScreen(),
    AccountScreen(),
  ];
  // 選択されている画面のインデックス
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      // 本題のNavigationBar
      bottomNavigationBar: NavigationBar(
        // タップされたタブのインデックスを設定（タブ毎に画面の切り替えをする）
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // 選択されているタブの色（公式サイトのまま黄色）
        indicatorColor: const Color(0xffc9f082),
        // 選択されたタブの設定（設定しないと画面は切り替わってもタブの色は変わらないです）
        selectedIndex: _selectedIndex,
        // タブ自体の設定（必須項目のため、書かないとエラーになります）
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Capture',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
