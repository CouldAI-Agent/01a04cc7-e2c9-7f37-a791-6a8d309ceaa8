import 'package:flutter/material.dart';

void main() {
  runApp(const ReYdeXApp());
}

class ReYdeXApp extends StatelessWidget {
  const ReYdeXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReYdeX Game Booster',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00FFCC),
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFCC),
          secondary: Color(0xFFFF003C),
          surface: Color(0xFF1A1A24),
          background: Color(0xFF0D0D12),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0D12),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavigationScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const GameLibraryScreen(),
    const OptimizationScreen(),
    const PermissionCenterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1A1A24),
        indicatorColor: const Color(0xFF00FFCC).withOpacity(0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: Color(0xFF00FFCC)),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.games_outlined),
            selectedIcon: Icon(Icons.games, color: Color(0xFF00FFCC)),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.speed_outlined),
            selectedIcon: Icon(Icons.speed, color: Color(0xFF00FFCC)),
            label: 'Controls',
          ),
          NavigationDestination(
            icon: Icon(Icons.security_outlined),
            selectedIcon: Icon(Icons.security, color: Color(0xFF00FFCC)),
            label: 'Permissions',
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReYdeX Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00FFCC), letterSpacing: 1.2)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF00FFCC)),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQuickBoostSection(context),
              const SizedBox(height: 24),
              const Text(
                'SYSTEM MONITORING',
                style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Adaptive grid for metrics
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildMetricCard('CPU', '45%', Icons.memory, const Color(0xFF00FFCC)),
                      _buildMetricCard('RAM', '2.4 GB', Icons.storage, const Color(0xFF00FFCC)),
                      _buildMetricCard('TEMP', '38°C', Icons.thermostat, const Color(0xFFFF003C)),
                      _buildMetricCard('BATTERY', '82%', Icons.battery_charging_full, const Color(0xFF00FFCC)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'SESSION INFO',
                style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 12),
              _buildSessionTimer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickBoostSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00FFCC).withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FFCC).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.rocket_launch, size: 64, color: Color(0xFF00FFCC)),
          const SizedBox(height: 16),
          const Text(
            'SYSTEM STATUS: OPTIMAL',
            style: TextStyle(color: Color(0xFF00FFCC), fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FFCC),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 8,
              shadowColor: const Color(0xFF00FFCC).withOpacity(0.5),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Quick Boost Initiated! Clearing RAM...'),
                  backgroundColor: Color(0xFF1A1A24),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('QUICK BOOST', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accentColor, size: 28),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSessionTimer() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00FFCC).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.timer, color: Color(0xFF00FFCC)),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Session', style: TextStyle(color: Colors.white54, fontSize: 14)),
              SizedBox(height: 4),
              Text('02:45:12', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }
}

class GameLibraryScreen extends StatelessWidget {
  const GameLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Library')),
      body: const Center(child: Text('Game Library (Coming Soon)')),
    );
  }
}

class OptimizationScreen extends StatelessWidget {
  const OptimizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Optimization Controls')),
      body: const Center(child: Text('System Optimization Controls (Coming Soon)')),
    );
  }
}

class PermissionCenterScreen extends StatelessWidget {
  const PermissionCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permission Center')),
      body: const Center(child: Text('Permissions (Coming Soon)')),
    );
  }
}
