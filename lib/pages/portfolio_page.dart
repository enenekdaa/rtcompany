import 'package:flutter/material.dart';
import '../widgets/footer.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<Map<String, dynamic>> _projects = [
    {
      'title': '쇼핑몰 앱 개발',
      'client': 'A 패션 브랜드',
      'category': '앱',
      'description': 'iOS/Android 크로스 플랫폼 쇼핑몰 앱',
      'tech': ['Flutter', 'Firebase', 'REST API'],
    },
    {
      'title': '기업 홈페이지 제작',
      'client': 'B 건설사',
      'category': '웹',
      'description': '반응형 웹사이트 및 관리자 페이지',
      'tech': ['React', 'Next.js', 'Tailwind CSS'],
    },
    {
      'title': 'ERP 시스템 구축',
      'client': 'C 제조업체',
      'category': '솔루션',
      'description': '맞춤형 전사적 자원 관리 시스템',
      'tech': ['Java', 'Spring Boot', 'PostgreSQL'],
    },
    {
      'title': '신제품 리뷰 캠페인',
      'client': 'D 전자기기',
      'category': '리뷰',
      'description': '블로그/SNS 체험단 리뷰 마케팅',
      'tech': ['네이버', '인스타그램', '유튜브'],
    },
    {
      'title': '예약 관리 앱',
      'client': 'E 뷰티샵',
      'category': '앱',
      'description': '고객 예약 및 스케줄 관리 앱',
      'tech': ['Flutter', 'Node.js', 'MongoDB'],
    },
    {
      'title': '포트폴리오 웹사이트',
      'client': 'F 스타트업',
      'category': '웹',
      'description': '인터랙티브 포트폴리오 사이트',
      'tech': ['Vue.js', 'GSAP', 'Three.js'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            height: isMobile ? 600 : 500,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
            ),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/hero_port.jpg'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: isMobile ? _buildMobileHero() : _buildDesktopHero(),
                ),
              ),
            ),
          ),

          // Projects Grid
          Container(
            padding: const EdgeInsets.only(bottom: 80, left: 40, right: 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: _projects
                      .map((project) => Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: _buildProjectCard(context, project),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          // Footer
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        Widget buildImageWidget({bool isFixedHeight = true}) {
          return Container(
            height: isFixedHeight ? (isMobile ? 250 : 300) : null,
            constraints: !isFixedHeight ? const BoxConstraints(minHeight: 300) : null,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getCategoryColor(project['category']),
                  _getCategoryColor(project['category']).withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                _getCategoryIcon(project['category']),
                size: 80,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          );
        }

        final contentWidget = Padding(
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getCategoryColor(project['category'])
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  project['category'],
                  style: TextStyle(
                    color: _getCategoryColor(project['category']),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                project['title'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),

              // Client
              Text(
                project['client'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                project['description'],
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 24),

              // Tech Stack
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: (project['tech'] as List<String>)
                    .map((tech) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        );

        if (isMobile) {
          // Mobile: Vertical layout (Image / Content)
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: buildImageWidget(isFixedHeight: true),
                ),
                contentWidget,
              ],
            ),
          );
        }

        // Desktop: Horizontal layout (Image | Content)
        return Container(
          constraints: const BoxConstraints(minHeight: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image (40%)
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: buildImageWidget(isFixedHeight: false),
                  ),
                ),
                // Content (60%)
                Expanded(
                  flex: 6,
                  child: contentWidget,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case '앱':
        return const Color(0xFF2563EB);
      case '웹':
        return const Color(0xFF7C3AED);
      case '솔루션':
        return const Color(0xFF059669);
      case '리뷰':
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '앱':
        return Icons.phone_android;
      case '웹':
        return Icons.web;
      case '솔루션':
        return Icons.business_center;
      case '리뷰':
        return Icons.rate_review;
      default:
        return Icons.folder;
    }
  }

  Widget _buildMobileHero() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Our PORTFOLIO',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.2,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text(
          'RT Company의 프로젝트 실적을 확인해보세요. 다양한 산업 분야에서 성공적으로 수행한 웹사이트, 모바일 앱, 리뷰 마케팅 캠페인 - 전문성과 창의성이 만들어낸 결과물들입니다.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFD1D5DB),
            height: 1.8,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: -1,
                  ),
                  children: [
                    TextSpan(text: 'Our '),
                    TextSpan(
                      text: 'PORTFOLIO',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'RT Company의 프로젝트 실적을 확인해보세요.\n다양한 산업 분야에서 성공적으로 수행한 웹사이트, 모바일 앱, 리뷰 마케팅 캠페인 -\n우리의 전문성과 창의성이 만들어낸 결과물들을 만나보실 수 있습니다.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFD1D5DB),
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
