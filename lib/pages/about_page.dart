import 'package:flutter/material.dart';
import '../widgets/footer.dart';

class AboutPage extends StatelessWidget {
  final VoidCallback onNavigateToAbout;
  final VoidCallback onNavigateToServices;
  final VoidCallback onNavigateToConsultation;
  final VoidCallback onNavigateToContact;

  const AboutPage({
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
                image: AssetImage('assets/hero_company.jpg'),
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

          // STRENGTH Section
      Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                const Text(
                  'STRENGTH',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '너구리공작단만의 경쟁력',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 900;
                    if (isMobile) {
                      return Column(
                        children: [
                          _buildStrengthCard(
                            number: '01',
                            title: '전문적인 기술력',
                            description: '최신 기술 스택과 풍부한 개발 경험을 바탕으로\n고품질의 서비스를 제공합니다.',
                            icon: Icons.psychology_outlined,
                          ),
                          const SizedBox(height: 40),
                          _buildStrengthCard(
                            number: '02',
                            title: '빠른 대응과 소통',
                            description: '고객과의 긴밀한 소통을 통해 요구사항을\n신속하게 파악하고 대응합니다.',
                            icon: Icons.speed,
                          ),
                          const SizedBox(height: 40),
                          _buildStrengthCard(
                            number: '03',
                            title: '맞춤형 솔루션',
                            description: '고객의 비즈니스 특성을 이해하고\n최적화된 솔루션을 제공합니다.',
                            icon: Icons.tune,
                          ),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildStrengthCard(
                            number: '01',
                            title: '전문적인 기술력',
                            description: '최신 기술 스택과 풍부한 개발 경험을 바탕으로\n고품질의 서비스를 제공합니다.',
                            icon: Icons.psychology_outlined,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: _buildStrengthCard(
                            number: '02',
                            title: '빠른 대응과 소통',
                            description: '고객과의 긴밀한 소통을 통해 요구사항을\n신속하게 파악하고 대응합니다.',
                            icon: Icons.speed,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: _buildStrengthCard(
                            number: '03',
                            title: '맞춤형 솔루션',
                            description: '고객의 비즈니스 특성을 이해하고\n최적화된 솔루션을 제공합니다.',
                            icon: Icons.tune,
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

      // Work Process Section
      Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        color: const Color(0xFFF9FAFB),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                const Text(
                  'WORK PROCESS',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '체계적인 프로젝트 진행 과정',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 900;
                    if (isMobile) {
                      return Column(
                        children: [
                          _buildProcessSteps(),
                          const SizedBox(height: 40),
                          _buildProcessIllustration(),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildProcessSteps()),
                        const SizedBox(width: 60),
                        Expanded(child: _buildProcessIllustration()),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

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

  Widget _buildStrengthCard({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 320,
      ),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
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
          Row(
            children: [
              Text(
                'STRENGTH $number',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 32, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
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

  Widget _buildProcessSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProcessStep(
          number: '01',
          title: '상담 및 요구사항 분석',
          description: '고객의 니즈를 파악하고 프로젝트 목표를 설정합니다.',
        ),
        const SizedBox(height: 32),
        _buildProcessStep(
          number: '02',
          title: '기획 및 설계',
          description: '최적의 솔루션을 설계하고 상세한 프로젝트 계획을 수립합니다.',
        ),
        const SizedBox(height: 32),
        _buildProcessStep(
          number: '03',
          title: '개발 및 구현',
          description: '최신 기술을 활용하여 안정적이고 효율적인 시스템을 개발합니다.',
        ),
        const SizedBox(height: 32),
        _buildProcessStep(
          number: '04',
          title: '테스트 및 배포',
          description: '철저한 품질 검증 후 안전하게 서비스를 런칭합니다.',
        ),
      ],
    );
  }

  Widget _buildProcessStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProcessIllustration() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: CustomPaint(
        painter: ProcessIllustrationPainter(),
      ),
    );
  }

  Widget _buildMobileHero() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'About RT COMPANY',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.2,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          '너구리공작단을 소개합니다',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9CA3AF),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFD1D5DB),
              height: 1.8,
            ),
            children: [
              TextSpan(
                text: '너구리공작단 (Raccoon Trojanhorse)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(text: ', 약칭 '),
              TextSpan(
                text: 'RT COMPANY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: '는 혁신적인 기술과 창의적인 아이디어로 고객에게 최상의 가치를 제공하는 기업입니다. 끊임없는 도전과 변화를 통해 업계를 선도합니다.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Text Content (60%)
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
                    TextSpan(text: 'About RT '),
                    TextSpan(
                      text: 'COMPANY',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '너구리공작단을 소개합니다',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9CA3AF),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFD1D5DB),
                    height: 1.8,
                  ),
                  children: [
                    TextSpan(
                      text: '너구리공작단 (Raccoon Trojanhorse)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(text: ', 약칭 '),
                    TextSpan(
                      text: 'RT COMPANY',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '는 혁신적인 기술과 창의적인 아이디어로 고객에게 최상의 가치를 제공하는 기업입니다.\n끊임없는 도전과 변화를 통해 업계를 선도하며, 고객의 성공을 위한 최적의 솔루션을 제공합니다.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TeamworkIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Background
    paint.color = const Color(0xFFF0F4F8);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Desk
    paint.color = const Color(0xFF8B7355);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.125, size.height * 0.67, size.width * 0.75, size.height * 0.27),
        const Radius.circular(5),
      ),
      paint,
    );

    // Desk top
    paint.color = const Color(0xFFA0826D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.125, size.height * 0.65, size.width * 0.75, size.height * 0.033),
        const Radius.circular(5),
      ),
      paint,
    );

    // Laptop
    paint.color = const Color(0xFF374151);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.325, size.height * 0.53, size.width * 0.35, size.height * 0.3),
        const Radius.circular(3),
      ),
      paint,
    );

    // Laptop screen
    paint.color = const Color(0xFF60A5FA);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.3375, size.height * 0.55, size.width * 0.325, size.height * 0.25),
        const Radius.circular(2),
      ),
      paint,
    );

    // People silhouettes
    final people = [
      {'x': 0.3, 'color': const Color(0xFF2563EB)},
      {'x': 0.5, 'color': const Color(0xFF7C3AED)},
      {'x': 0.7, 'color': const Color(0xFF059669)},
    ];

    for (var person in people) {
      final x = size.width * (person['x'] as double);
      final color = person['color'] as Color;

      // Head
      paint.color = color;
      canvas.drawCircle(Offset(x, size.height * 0.3), size.width * 0.04, paint);

      // Body
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - size.width * 0.033, size.height * 0.33, size.width * 0.067, size.height * 0.1),
          const Radius.circular(3),
        ),
        paint,
      );
    }

    // Lightbulb (ideas)
    paint.color = const Color(0xFFFCD34D).withOpacity(0.8);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.27), size.width * 0.0375, paint);

    // Light rays
    final rayPaint = Paint()
      ..color = const Color(0xFFFCD34D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rays = [
      [Offset(size.width * 0.7625, size.height * 0.233), Offset(size.width * 0.7375, size.height * 0.2)],
      [Offset(size.width * 0.8375, size.height * 0.233), Offset(size.width * 0.8625, size.height * 0.2)],
      [Offset(size.width * 0.7625, size.height * 0.3), Offset(size.width * 0.7375, size.height * 0.333)],
      [Offset(size.width * 0.8375, size.height * 0.3), Offset(size.width * 0.8625, size.height * 0.333)],
    ];

    for (var ray in rays) {
      canvas.drawLine(ray[0], ray[1], rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProcessIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Background
    paint.color = const Color(0xFFF0F4F8);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Process flow circles
    final steps = [
      {'x': 0.25, 'y': 0.25, 'color': const Color(0xFF1F2937)},
      {'x': 0.75, 'y': 0.25, 'color': const Color(0xFF374151)},
      {'x': 0.25, 'y': 0.65, 'color': const Color(0xFF4B5563)},
      {'x': 0.75, 'y': 0.65, 'color': const Color(0xFF6B7280)},
    ];

    // Draw connecting lines
    final linePaint = Paint()
      ..color = const Color(0xFFD1D5DB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Horizontal line top
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.25),
      linePaint,
    );

    // Vertical line right
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.65),
      linePaint,
    );

    // Horizontal line bottom
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.65),
      Offset(size.width * 0.25, size.height * 0.65),
      linePaint,
    );

    // Draw step circles
    for (var i = 0; i < steps.length; i++) {
      final step = steps[i];
      final x = size.width * (step['x'] as double);
      final y = size.height * (step['y'] as double);
      final color = step['color'] as Color;

      // Outer circle
      paint.color = color;
      canvas.drawCircle(Offset(x, y), size.width * 0.08, paint);

      // Inner circle (white)
      paint.color = Colors.white;
      canvas.drawCircle(Offset(x, y), size.width * 0.055, paint);

      // Number
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: color,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          y - textPainter.height / 2,
        ),
      );
    }

    // Decorative elements
    // Document icon
    paint.color = const Color(0xFF60A5FA).withOpacity(0.3);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.1, size.width * 0.08, size.height * 0.12),
        const Radius.circular(4),
      ),
      paint,
    );

    // Gear icon representation
    paint.color = const Color(0xFFFCD34D).withOpacity(0.3);
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.5),
      size.width * 0.05,
      paint,
    );

    // Checkmark area
    paint.color = const Color(0xFF10B981).withOpacity(0.3);
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.85),
      size.width * 0.045,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
