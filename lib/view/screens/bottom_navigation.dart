import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ikimono_zukan/view/components/custom_appbar.dart';
import 'package:my_ikimono_zukan/view/screens/account_screen.dart';
import 'package:my_ikimono_zukan/view/screens/capture_screen.dart';
import 'package:my_ikimono_zukan/view/screens/home_screen.dart';
import 'package:my_ikimono_zukan/view/theme/theme_mode_provider.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  // 各画面のリスト
  static const _screens = [
    HomeScreen(),
    CaptureScreen(),
    AccountScreen(),
  ];
  // 選択されている画面のインデックス
  int _selectedIndex = 0;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final themeModeState = ref.watch(themeModeNotifierProvider);
    return Scaffold(
      appBar: CustomAppBar(
        themeModeProvider: themeModeState,
        context: context,
        toggle: (_) {
          ref.read(themeModeNotifierProvider.notifier).toggle();
        },
      ),
      body: PageView(
        controller: controller,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          controller.jumpToPage(index);
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: const Color(0xffc9f082),
        selectedIndex: _selectedIndex,
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
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
