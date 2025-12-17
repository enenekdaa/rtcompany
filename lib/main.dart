import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/services_page.dart';
import 'pages/free_consultation_page.dart';
import 'pages/contact_page.dart';

void main() {
  runApp(const RTCompanyApp());
}

class RTCompanyApp extends StatelessWidget {
  const RTCompanyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '너구리공작단 | RT Company',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F2937),
          primary: const Color(0xFF1F2937),
          secondary: const Color(0xFF374151),
        ),
        useMaterial3: true,
        fontFamily: 'Pretendard',
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = -1; // -1 = HomePage (default)

  final List<String> _titles = [
    '회사소개',
    '서비스',
    '무료상담',
    '고객센터',
  ];

  void _navigateToPage(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget get _currentPage {
    if (_selectedIndex == -1) {
      return HomePage(
        onNavigateToAbout: () => _navigateToPage(0),
        onNavigateToServices: () => _navigateToPage(1),
        onNavigateToConsultation: () => _navigateToPage(2),
        onNavigateToContact: () => _navigateToPage(3),
      );
    }
    final pages = [
      AboutPage(
        onNavigateToAbout: () => _navigateToPage(0),
        onNavigateToServices: () => _navigateToPage(1),
        onNavigateToConsultation: () => _navigateToPage(2),
        onNavigateToContact: () => _navigateToPage(3),
      ),
      ServicesPage(
        onNavigateToAbout: () => _navigateToPage(0),
        onNavigateToServices: () => _navigateToPage(1),
        onNavigateToConsultation: () => _navigateToPage(2),
        onNavigateToContact: () => _navigateToPage(3),
      ),
      FreeConsultationPage(
        onNavigateToAbout: () => _navigateToPage(0),
        onNavigateToServices: () => _navigateToPage(1),
        onNavigateToConsultation: () => _navigateToPage(2),
        onNavigateToContact: () => _navigateToPage(3),
      ),
      ContactPage(
        onNavigateToAbout: () => _navigateToPage(0),
        onNavigateToServices: () => _navigateToPage(1),
        onNavigateToConsultation: () => _navigateToPage(2),
        onNavigateToContact: () => _navigateToPage(3),
      ),
    ];
    return pages[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: GestureDetector(
          onTap: () => _navigateToPage(-1),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRaccoonLogo(),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'RT COMPANY',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '너구리공작단',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: isMobile
            ? null
            : [
                ...List.generate(_titles.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                      onPressed: () => _navigateToPage(index),
                      style: TextButton.styleFrom(
                        foregroundColor: _selectedIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : const Color(0xFF1F2937),
                      ),
                      child: Text(
                        _titles[index],
                        style: TextStyle(
                          fontWeight: _selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(width: 16),
              ],
      ),
      body: _currentPage,
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              currentIndex: _selectedIndex + 1, // -1 -> 0 (홈), 0 -> 1 (회사), ...
              onTap: (index) => _navigateToPage(index - 1), // 0 -> -1 (홈), 1 -> 0 (회사), ...
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: const Color(0xFF6B7280),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business_outlined),
                  activeIcon: Icon(Icons.business),
                  label: '회사',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_outline),
                  activeIcon: Icon(Icons.work),
                  label: '서비스',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_support_outlined),
                  activeIcon: Icon(Icons.contact_support),
                  label: '무료상담',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.support_agent_outlined),
                  activeIcon: Icon(Icons.support_agent),
                  label: '고객센터',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildRaccoonLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/logo.png',
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
    );
  }
}
