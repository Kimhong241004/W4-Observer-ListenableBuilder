import 'package:flutter/material.dart';

// Global ColorService instance
late ColorService colorService;

void main() {
  colorService = ColorService();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, green, yellow, blue }

// ColorService extends ChangeNotifier
class ColorService extends ChangeNotifier {
  int _redTapCount = 0;
  int _greenTapCount = 0;
  int _yellowTapCount = 0;
  int _blueTapCount = 0;

  int get redTapCount => _redTapCount;
  int get greenTapCount => _greenTapCount;
  int get yellowTapCount => _yellowTapCount;
  int get blueTapCount => _blueTapCount;

  void incrementRedTapCount() {
    _redTapCount++;
    notifyListeners();
  }

  void incrementGreenTapCount() {
    _greenTapCount++;
    notifyListeners();
  }

  void incrementYellowTapCount() {
    _yellowTapCount++;
    notifyListeners();
  }

  void incrementBlueTapCount() {
    _blueTapCount++;
    notifyListeners();
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
    return Scaffold(
      body:
          _currentIndex == 0
              ? ColorTapsScreen()
              : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ListenableBuilder(
            listenable: colorService,
            builder: (context, child) {
              return ColorTap(
                type: CardType.red,
                tapCount: colorService.redTapCount,
                onTap: colorService.incrementRedTapCount,
              );
            },
          ),
          ListenableBuilder(
            listenable: colorService,
            builder: (context, child) {
              return ColorTap(
                type: CardType.green,
                tapCount: colorService.greenTapCount,
                onTap: colorService.incrementGreenTapCount,
              );
            },
          ),
          ListenableBuilder(
            listenable: colorService,
            builder: (context, child) {
              return ColorTap(
                type: CardType.yellow,
                tapCount: colorService.yellowTapCount,
                onTap: colorService.incrementYellowTapCount,
              );
            },
          ),
          ListenableBuilder(
            listenable: colorService,
            builder: (context, child) {
              return ColorTap(
                type: CardType.blue,
                tapCount: colorService.blueTapCount,
                onTap: colorService.incrementBlueTapCount,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.green:
        return Colors.green;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.blue:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${colorService.redTapCount}', style: TextStyle(fontSize: 24)),
                Text('Green Taps: ${colorService.greenTapCount}', style: TextStyle(fontSize: 24)),
                Text('Yellow Taps: ${colorService.yellowTapCount}', style: TextStyle(fontSize: 24)),
                Text('Blue Taps: ${colorService.blueTapCount}', style: TextStyle(fontSize: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}
