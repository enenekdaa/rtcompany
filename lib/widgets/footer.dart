import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final VoidCallback? onNavigateToAbout;
  final VoidCallback? onNavigateToServices;
  final VoidCallback? onNavigateToConsultation;
  final VoidCallback? onNavigateToContact;

  const AppFooter({
    super.key,
    this.onNavigateToAbout,
    this.onNavigateToServices,
    this.onNavigateToConsultation,
    this.onNavigateToContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1F2937),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section
              Wrap(
                spacing: 80,
                runSpacing: 40,
                children: [
                  // Company Info
                  SizedBox(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/logo.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RT COMPANY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '너구리공작단',
                                  style: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildInfoText('상호', '너구리공작단 (Raccoon Trojanhorse)'),
                        const SizedBox(height: 8),
                        _buildInfoText('대표', '김현'),
                        const SizedBox(height: 8),
                        _buildInfoText('사업자번호', '123-45-67890'),
                        const SizedBox(height: 8),
                        _buildInfoText('주소', '경기도 성남시 수정구 오야로6 2층 38호'),
                        const SizedBox(height: 8),
                        _buildInfoText('이메일', 'help@rtcompany.co.kr'),
                        const SizedBox(height: 8),
                        _buildInfoText('전화', '010-6247-6996'),
                      ],
                    ),
                  ),

                  // Quick Links
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Links',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFooterLink('회사소개', onNavigateToAbout),
                      _buildFooterLink('서비스', onNavigateToServices),
                      _buildFooterLink('무료상담', onNavigateToConsultation),
                      _buildFooterLink('고객센터', onNavigateToContact),
                    ],
                  ),

                  // Legal & SNS
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '약관 및 정책',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFooterLink('개인정보처리방침', null),
                      _buildFooterLink('이용약관', null),
                      const SizedBox(height: 24),
                      const Text(
                        'Follow Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildSocialIcon(Icons.facebook),
                          const SizedBox(width: 12),
                          _buildSocialIcon(Icons.chat),
                          const SizedBox(width: 12),
                          _buildSocialIcon(Icons.mail_outline),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),
              const Divider(color: Color(0xFF374151)),
              const SizedBox(height: 24),

              // Copyright
              const Center(
                child: Text(
                  '© 2024 RT Company. All rights reserved.',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 14,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              color: Color(0xFFD1D5DB),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        color: Colors.white,
        onPressed: () {},
        padding: EdgeInsets.zero,
      ),
    );
  }
}
