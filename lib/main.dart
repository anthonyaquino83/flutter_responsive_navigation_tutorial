import 'package:flutter/material.dart';

//* p1 - criar BodyWidget
//* p2 - criar bottomNavigationBar
//* p3 - criar classe Destination
//* p4 - criar lista de Destinations
//* (para converter em NavigationDestination e NavigationRailDestination)
//* p5 - criar lista de navigationdestination
//* p6 - criar variável selectedIndex
//* p7 - criar variável onDestinationSelected
//* p8 - colocar BodyWidget dentro de uma row e dentro de um Expanded
//* p9 - criar NavigationRail dentro da row
//* p10 - criar lista de navigationraildestination
//* p11 - criar variável onDestinationSelected do NavigationRail
//* p12 - deixar a navegação responsiva com o MediaQuery na row e no bottomnavigationbar
//* p13 - extrair o NavigationRail como SideNavRail
//* p14 - extrair o NavigationBar como BottomNavBar

void main() {
  runApp(const MyApp());
}

class Destination {
  final IconData icon;
  final String label;
  Destination({required this.icon, required this.label});
}

List<Destination> destinations = [
  Destination(icon: Icons.home, label: 'Home'),
  Destination(icon: Icons.settings, label: 'Settings'),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final useSideNavRail = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          if (useSideNavRail)
            SideNavRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                }),
          const Expanded(child: BodyWidget()),
        ],
      ),
      bottomNavigationBar: useSideNavRail
          ? null
          : BottomNavBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: destinations.map(
        (e) {
          return NavigationDestination(
            icon: Icon(e.icon),
            label: e.label,
          );
        },
      ).toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}

class SideNavRail extends StatelessWidget {
  const SideNavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: destinations.map(
        (e) {
          return NavigationRailDestination(
            icon: Icon(e.icon),
            label: Text(e.label),
          );
        },
      ).toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello',
      ),
    );
  }
}
