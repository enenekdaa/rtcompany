import 'package:flutter/material.dart';
import '../widgets/footer.dart';

class ServicesPage extends StatelessWidget {
  final VoidCallback onNavigateToAbout;
  final VoidCallback onNavigateToServices;
  final VoidCallback onNavigateToConsultation;
  final VoidCallback onNavigateToContact;

  const ServicesPage({
    super.key,
    required this.onNavigateToAbout,
    required this.onNavigateToServices,
    required this.onNavigateToConsultation,
    required this.onNavigateToContact,
  });

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
                image: AssetImage('assets/hero_service.jpg'),
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

          // Services Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 900;
                        if (isMobile) {
                          return Column(
                            children: [
                              _buildServiceCard(
                                context,
                                icon: Icons.rate_review_outlined,
                                title: '리뷰 체험단',
                                description:
                                    '네이버, 구글, SNS 등 주요 플랫폼의 리뷰 마케팅을 통해\n브랜드 인지도와 신뢰도를 높여드립니다.',
                                color: const Color(0xFF1F2937),
                              ),
                              const SizedBox(height: 40),
                              _buildServiceCard(
                                context,
                                icon: Icons.web,
                                title: '홈페이지 제작',
                                description:
                                    '최신 웹 기술을 활용한 반응형 웹사이트 제작으로\n고객의 비즈니스를 온라인에서 빛나게 합니다.',
                                color: const Color(0xFF374151),
                              ),
                              const SizedBox(height: 40),
                              _buildServiceCard(
                                context,
                                icon: Icons.phone_android,
                                title: '앱 개발',
                                description:
                                    'iOS/Android 크로스 플랫폼 앱 개발로\n모바일 시대에 맞는 혁신적인 서비스를 제공합니다.',
                                color: const Color(0xFF4B5563),
                              ),
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                icon: Icons.rate_review_outlined,
                                title: '리뷰 체험단',
                                description:
                                    '네이버, 구글, SNS 등 주요 플랫폼의 리뷰 마케팅을 통해\n브랜드 인지도와 신뢰도를 높여드립니다.',
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                icon: Icons.web,
                                title: '홈페이지 제작',
                                description:
                                    '최신 웹 기술을 활용한 반응형 웹사이트 제작으로\n고객의 비즈니스를 온라인에서 빛나게 합니다.',
                                color: const Color(0xFF374151),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                icon: Icons.phone_android,
                                title: '앱 개발',
                                description:
                                    'iOS/Android 크로스 플랫폼 앱 개발로\n모바일 시대에 맞는 혁신적인 서비스를 제공합니다.',
                                color: const Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer
          AppFooter(
            onNavigateToAbout: onNavigateToAbout,
            onNavigateToServices: onNavigateToServices,
            onNavigateToConsultation: onNavigateToConsultation,
            onNavigateToContact: onNavigateToContact,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 36,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111111),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF6B7280),
                height: 1.7,
              ),
            ),
          ],
      ),
    );
  }

  Widget _buildMobileHero() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Our SERVICES',
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
          'RT Company가 제공하는 전문 서비스로 비즈니스의 성장을 경험하세요. 리뷰 체험단 마케팅부터 최신 웹/앱 개발까지, 검증된 기술력으로 고객 맞춤형 솔루션을 제공합니다.',
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
                      text: 'SERVICES',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'RT Company가 제공하는 전문 서비스로 비즈니스의 성장을 경험하세요.\n리뷰 체험단 마케팅부터 최신 웹/앱 개발까지, 검증된 기술력과 풍부한 경험을 바탕으로\n고객 맞춤형 솔루션을 제공합니다.',
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
