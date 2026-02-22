import 'package:flutter/material.dart';
import '2_download_app/ui/providers/theme_color_provider.dart';
import '2_download_app/ui/screens/downloads/downloads_screen.dart';
import '2_download_app/ui/screens/settings/settings_screen.dart';

void main() {
  themeColorProvider = ThemeColorProvider();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeColorProvider,
      builder: (context, child) {
        return Scaffold(
          body: _currentIndex == 0 ? DownloadsScreen() : SettingsScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: themeColorProvider.currentThemeColor.color,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.download),
                label: 'Downloads',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
