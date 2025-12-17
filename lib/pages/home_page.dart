import 'package:flutter/material.dart';
import '../widgets/footer.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onNavigateToAbout;
  final VoidCallback onNavigateToServices;
  final VoidCallback onNavigateToConsultation;
  final VoidCallback onNavigateToContact;

  const HomePage({
    super.key,
    required this.onNavigateToAbout,
    required this.onNavigateToServices,
    required this.onNavigateToConsultation,
    required this.onNavigateToContact,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          _buildHeroSection(context),

          // Service Highlight
          _buildServiceHighlight(context),

          // Trust Section (Numbers)
          _buildTrustSection(context),

          // Consultation CTA
          _buildConsultationCTA(context),

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

  // Hero Section
  Widget _buildHeroSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      height: isMobile ? 600 : 500,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/hero_home.jpg'),
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
            child: isMobile ? _buildMobileHeroContent() : _buildDesktopHeroContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileHeroContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'RT Company 너구리공작단',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9CA3AF),
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Innovation is our PASSION',
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
          '혁신적인 기술과 창의적인 솔루션으로 고객의 성공을 함께 만들어갑니다. 웹, 앱, 리뷰 마케팅까지 - RT Company는 디지털 시대의 완벽한 파트너입니다.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFD1D5DB),
            height: 1.8,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: onNavigateToConsultation,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF111111),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
          ),
          child: const Text('무료상담 바로가기'),
        ),
      ],
    );
  }

  Widget _buildDesktopHeroContent() {
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
              const Text(
                'RT Company 너구리공작단',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9CA3AF),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
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
                    TextSpan(text: 'Innovation is our '),
                    TextSpan(
                      text: 'PASSION',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                '혁신적인 기술과 창의적인 솔루션으로 고객의 성공을 함께 만들어갑니다.\n웹, 앱, 리뷰 마케팅까지 - RT Company는 디지털 시대의 완벽한 파트너입니다.\n여러분의 아이디어를 현실로 만들어드립니다.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFD1D5DB),
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: onNavigateToConsultation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF111111),
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                child: const Text('무료상담 바로가기'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeywordChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Service Highlight
  Widget _buildServiceHighlight(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '서비스',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'RT Company가 제공하는 전문 서비스',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 60),
              Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  _buildServiceCard(
                    context,
                    icon: Icons.rate_review,
                    title: '리뷰 체험단',
                    description: '네이버, 구글, SNS 리뷰 마케팅',
                    color: const Color(0xFF1F2937),
                    onTap: onNavigateToServices,
                  ),
                  _buildServiceCard(
                    context,
                    icon: Icons.web,
                    title: '홈페이지 제작',
                    description: '반응형 웹사이트 개발',
                    color: const Color(0xFF374151),
                    onTap: onNavigateToServices,
                  ),
                  _buildServiceCard(
                    context,
                    icon: Icons.phone_android,
                    title: '앱 개발',
                    description: 'iOS/Android 앱 개발',
                    color: const Color(0xFF4B5563),
                    onTap: onNavigateToServices,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 320,
          height: 280,
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
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 32, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Trust Section
  Widget _buildTrustSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFF9FAFB),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Wrap(
            spacing: 60,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _buildStatItem(
                context,
                '2025',
                '설립 연도',
                Icons.calendar_today,
              ),
              _buildStatItem(
                context,
                '100+',
                '프로젝트 문의',
                Icons.contact_mail,
              ),
              _buildStatItem(
                context,
                '100%',
                '고객만족도',
                Icons.sentiment_satisfied_alt,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String number,
    String label,
    IconData icon,
  ) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            number,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Consultation CTA
  Widget _buildConsultationCTA(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1F2937),
            const Color(0xFF374151),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Icon(
                Icons.contact_support,
                size: isMobile ? 64 : 80,
                color: Colors.white.withOpacity(0.9),
              ),
              SizedBox(height: isMobile ? 24 : 32),
              Text(
                '무료 상담 신청',
                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Text(
                '리뷰 체험단 마케팅 전문가가 여러분의 비즈니스 성장을 위한\n맞춤형 솔루션을 제공합니다.',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: const Color(0xFFD1D5DB),
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 32 : 48),
              ElevatedButton(
                onPressed: onNavigateToConsultation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1F2937),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 40 : 64,
                    vertical: isMobile ? 18 : 24,
                  ),
                  textStyle: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('지금 바로 무료 상담 받기'),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 20 : 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

// Communication Illustration Painter
class CommunicationIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Central envelope
    final envelopeRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.45),
      width: size.width * 0.35,
      height: size.height * 0.3,
    );

    paint.color = Colors.white;
    canvas.drawRect(envelopeRect, paint);

    paint.color = const Color(0xFF1F2937);
    strokePaint.color = const Color(0xFF1F2937);
    canvas.drawRect(envelopeRect, strokePaint);

    // Envelope flap lines
    final path = Path();
    path.moveTo(envelopeRect.left, envelopeRect.top);
    path.lineTo(envelopeRect.center.dx, envelopeRect.top + envelopeRect.height * 0.35);
    path.lineTo(envelopeRect.right, envelopeRect.top);
    canvas.drawPath(path, strokePaint);

    // Content lines inside envelope
    for (int i = 0; i < 3; i++) {
      final y = envelopeRect.top + envelopeRect.height * 0.5 + i * 15;
      canvas.drawLine(
        Offset(envelopeRect.left + 20, y),
        Offset(envelopeRect.right - 20, y),
        strokePaint,
      );
    }

    // Surrounding icons in circles
    final icons = [
      {'x': 0.18, 'y': 0.2, 'icon': Icons.description, 'color': const Color(0xFF2563EB)},
      {'x': 0.5, 'y': 0.15, 'icon': Icons.language, 'color': const Color(0xFF7C3AED)},
      {'x': 0.82, 'y': 0.2, 'icon': Icons.settings, 'color': const Color(0xFF059669)},
      {'x': 0.18, 'y': 0.7, 'icon': Icons.lightbulb_outline, 'color': const Color(0xFFFBBF24)},
      {'x': 0.82, 'y': 0.7, 'icon': Icons.notifications_outlined, 'color': const Color(0xFFDC2626)},
    ];

    for (var iconData in icons) {
      final x = size.width * (iconData['x'] as double);
      final y = size.height * (iconData['y'] as double);
      final color = iconData['color'] as Color;

      // Circle background
      paint.color = color.withOpacity(0.1);
      canvas.drawCircle(Offset(x, y), 30, paint);

      // Circle border
      strokePaint.color = color;
      canvas.drawCircle(Offset(x, y), 30, strokePaint);
    }

    // Connecting lines (subtle network effect)
    strokePaint.color = const Color(0xFF9CA3AF);
    strokePaint.strokeWidth = 1;
    for (var i = 0; i < icons.length; i++) {
      final x1 = size.width * (icons[i]['x'] as double);
      final y1 = size.height * (icons[i]['y'] as double);

      if (i < icons.length - 1) {
        final x2 = size.width * (icons[i + 1]['x'] as double);
        final y2 = size.height * (icons[i + 1]['y'] as double);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), strokePaint);
      }
    }

    // SEND button (bottom right)
    final sendButton = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.7,
        size.height * 0.82,
        size.width * 0.2,
        size.height * 0.1,
      ),
      const Radius.circular(8),
    );

    paint.color = const Color(0xFFDC2626);
    canvas.drawRRect(sendButton, paint);

    // TALK button (bottom right - yellow circle)
    paint.color = const Color(0xFFFBBF24);
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.92),
      size.width * 0.06,
      paint,
    );

    // Decorative elements (@ symbol, asterisks)
    strokePaint.color = const Color(0xFF6B7280);
    strokePaint.strokeWidth = 2;

    // @ symbol area (left side)
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.5),
      12,
      strokePaint,
    );

    // Asterisk decorations
    final asteriskPaint = Paint()
      ..color = const Color(0xFF9CA3AF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    void drawAsterisk(double x, double y, double size) {
      canvas.drawLine(
        Offset(x - size, y),
        Offset(x + size, y),
        asteriskPaint,
      );
      canvas.drawLine(
        Offset(x, y - size),
        Offset(x, y + size),
        asteriskPaint,
      );
    }

    drawAsterisk(size.width * 0.4, size.height * 0.28, 6);
    drawAsterisk(size.width * 0.65, size.height * 0.35, 5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
