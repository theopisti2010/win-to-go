import 'package:flutter/material.dart';
import 'services/session.dart';
import 'models/role.dart';

// Σελίδες
import 'pages/home.dart';
import 'pages/search.dart';
import 'pages/create.dart';
import 'pages/my.dart';
import 'pages/profile.dart';
import 'strings.dart';

class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _index = 0;
  UserRole _role = UserRole.consumer;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final r = await SessionService().getRole();
    if (mounted) {
      setState(() {
        _role = r;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final isPro = _role == UserRole.pro;

    final pages = <Widget>[
      HomePage(),
      SearchPage(),
      if (isPro) CreatePage(), // μόνο για επαγγελματία
      MyPage(),
      ProfilePage(),
    ];

    final destinations = <NavigationDestination>[
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: AppStrings.tabHome,
      ),
      const NavigationDestination(
        icon: Icon(Icons.search),
        label: AppStrings.tabSearch,
      ),
      if (isPro)
        const NavigationDestination(
          icon: Icon(Icons.add_box_outlined),
          selectedIcon: Icon(Icons.add_box),
          label: AppStrings.tabCreate,
        ),
      const NavigationDestination(
        icon: Icon(Icons.confirmation_num_outlined),
        selectedIcon: Icon(Icons.confirmation_num),
        label: AppStrings.tabMy,
      ),
      const NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: AppStrings.tabProfile,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        destinations: destinations,
        onDestinationSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}
