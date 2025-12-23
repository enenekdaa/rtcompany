import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/footer.dart';

class ContactPage extends StatefulWidget {
  final VoidCallback onNavigateToAbout;
  final VoidCallback onNavigateToServices;
  final VoidCallback onNavigateToConsultation;
  final VoidCallback onNavigateToContact;

  const ContactPage({
    super.key,
    required this.onNavigateToAbout,
    required this.onNavigateToServices,
    required this.onNavigateToConsultation,
    required this.onNavigateToContact,
  });

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      const botToken = '8468965673:AAFdpadWx3LOB45NWNKywhq1VbuWHlskzcY';
      const chatId = '2027724910';

      // Format message with form data
      final message = '''
📝 새로운 문의가 접수되었습니다

👤 이름: ${_nameController.text}
📧 이메일: ${_emailController.text}
📱 연락처: ${_phoneController.text}

💬 문의 내용:
${_messageController.text}
''';

      try {
        // Send message to Telegram using POST method
        final response = await http.post(
          Uri.parse('https://api.telegram.org/bot$botToken/sendMessage'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'chat_id': chatId,
            'text': message,
          }),
        );

        if (!mounted) return;

        if (response.statusCode == 200) {
          // Success
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('문의 감사합니다'),
              content: const Text('빠른 시일 내에 연락드리겠습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _formKey.currentState!.reset();
                    _nameController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _messageController.clear();
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          );
        } else {
          // Error
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('오류'),
              content: const Text('문의 전송에 실패했습니다. 다시 시도해주세요.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('확인'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;

        // Network error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('네트워크 오류'),
            content: const Text('네트워크 연결을 확인하고 다시 시도해주세요.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          _buildHeroSection(context, isMobile),

          // Contact Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    const Text(
                      '문의하기',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 60),
                    _buildContactContent(isMobile),
                  ],
                ),
              ),
            ),
          ),

          // Footer
          AppFooter(
            onNavigateToAbout: widget.onNavigateToAbout,
            onNavigateToServices: widget.onNavigateToServices,
            onNavigateToConsultation: widget.onNavigateToConsultation,
            onNavigateToContact: widget.onNavigateToContact,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      height: isMobile ? 600 : 500,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/hero_setting.jpg'),
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
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile ? _buildMobileHero() : _buildDesktopHero(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileHero() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '문의하기',
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
          'RT Company가 도와드리겠습니다. 프로젝트 상담이나 궁금한 점이 있으시면 언제든지 편하게 문의해 주세요.',
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(
                text: '문의하기',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'RT Company가 도와드리겠습니다.\n프로젝트 상담이나 궁금한 점이 있으시면 언제든지 편하게 문의해 주세요.\n빠르고 정확한 답변으로 여러분의 비즈니스 성장을 함께 만들어가겠습니다.',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFFD1D5DB),
            height: 1.8,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildContactContent(bool isMobile) {
    final contactInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '연락처 정보',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 32),
        _buildContactInfoItem(
          icon: Icons.person_outline,
          title: '담당자',
          content: '너구리공작단',
        ),
        const SizedBox(height: 24),
        _buildContactInfoItem(
          icon: Icons.location_on_outlined,
          title: '주소',
          content: '경기도 성남시 수정구 오야로6 2층 38호',
        ),
        const SizedBox(height: 24),
        _buildContactInfoItem(
          icon: Icons.email_outlined,
          title: '이메일',
          content: 'help@rtcompany.co.kr',
        ),
        const SizedBox(height: 24),
        _buildContactInfoItem(
          icon: Icons.language,
          title: '웹사이트',
          content: 'rtcompany.co.kr',
        ),
      ],
    );

    final contactForm = Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '이름을 입력하세요',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: 'example@email.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력해주세요';
                }
                if (!value.contains('@')) {
                  return '올바른 이메일 형식을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: '연락처',
                hintText: '010-1234-5678',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: '문의 내용',
                hintText: '문의하실 내용을 입력하세요',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '문의 내용을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('문의 보내기'),
            ),
          ],
        ),
      ),
    );

    if (isMobile) {
      return Column(
        children: [
          contactInfo,
          const SizedBox(height: 40),
          contactForm,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: contactInfo),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: contactForm),
      ],
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
