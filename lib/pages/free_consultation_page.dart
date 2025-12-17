import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/footer.dart';

class FreeConsultationPage extends StatefulWidget {
  final VoidCallback onNavigateToAbout;
  final VoidCallback onNavigateToServices;
  final VoidCallback onNavigateToConsultation;
  final VoidCallback onNavigateToContact;

  const FreeConsultationPage({
    super.key,
    required this.onNavigateToAbout,
    required this.onNavigateToServices,
    required this.onNavigateToConsultation,
    required this.onNavigateToContact,
  });

  @override
  State<FreeConsultationPage> createState() => _FreeConsultationPageState();
}

class _FreeConsultationPageState extends State<FreeConsultationPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _companyNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productUrlController = TextEditingController();
  final _reviewCountController = TextEditingController();
  final _budgetController = TextEditingController();
  final _detailsController = TextEditingController();

  String? _selectedIndustry;
  String? _selectedPlatform;

  final List<String> _industries = [
    '음식점',
    '뷰티/미용',
    '쇼핑몰/리테일',
    '서비스업',
    '숙박/여행',
    '교육',
    '의료/헬스케어',
    '기타',
  ];

  final List<String> _platforms = [
    '네이버',
    '구글',
    '인스타그램',
    '유튜브',
    '블로그',
    '기타',
  ];

  @override
  void dispose() {
    _companyNameController.dispose();
    _managerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _productNameController.dispose();
    _productUrlController.dispose();
    _reviewCountController.dispose();
    _budgetController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      const botToken = '8468965673:AAFdpadWx3LOB45NWNKywhq1VbuWHlskzcY';
      const chatId = '2027724910';

      // Format message with all form data in Korean
      final message = '''
📝 새로운 무료 상담 신청

👤 회사명: ${_companyNameController.text}
👤 담당자명: ${_managerNameController.text}
📱 연락처: ${_phoneController.text}
📧 이메일: ${_emailController.text}
🏢 업종: ${_selectedIndustry ?? '미선택'}

📦 상품명: ${_productNameController.text}
🔗 상품 URL: ${_productUrlController.text}

⭐ 리뷰 플랫폼: ${_selectedPlatform ?? '미선택'}
📊 희망 리뷰 건수: ${_reviewCountController.text}
💰 예산: ${_budgetController.text.isEmpty ? '미입력' : _budgetController.text}

💬 상세 요청사항:
${_detailsController.text.isEmpty ? '미입력' : _detailsController.text}
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
              title: const Text('상담 신청이 접수되었습니다'),
              content: const Text('빠른 시일 내에 담당자가 연락드리겠습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _formKey.currentState!.reset();
                    _companyNameController.clear();
                    _managerNameController.clear();
                    _phoneController.clear();
                    _emailController.clear();
                    _productNameController.clear();
                    _productUrlController.clear();
                    _reviewCountController.clear();
                    _budgetController.clear();
                    _detailsController.clear();
                    setState(() {
                      _selectedIndustry = null;
                      _selectedPlatform = null;
                    });
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
              content: const Text('상담 신청에 실패했습니다. 다시 시도해주세요.'),
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

          // Form Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: _buildConsultationForm(isMobile),
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
          '무료 상담 신청',
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
          '리뷰 체험단 마케팅으로 브랜드 인지도를 높이세요. 네이버, 구글, SNS 리뷰 마케팅 전문가가 맞춤형 상담을 제공합니다.',
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
              TextSpan(text: '무료 '),
              TextSpan(
                text: '상담 신청',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          '리뷰 체험단 마케팅으로 브랜드 인지도를 높이세요.\n네이버, 구글, SNS 리뷰 마케팅 전문가가 맞춤형 상담을 제공합니다.\n지금 바로 무료 상담을 신청하세요!',
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

  Widget _buildConsultationForm(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(40),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '리뷰 체험단 마케팅 상담 신청',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '아래 정보를 입력해주시면 담당자가 빠르게 연락드립니다',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 40),

            // 기본 정보
            const Text(
              '기본 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _companyNameController,
              decoration: const InputDecoration(
                labelText: '회사명 / 업체명 *',
                hintText: '예: RT Company',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '회사명을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _managerNameController,
              decoration: const InputDecoration(
                labelText: '담당자명 *',
                hintText: '홍길동',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '담당자명을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: '연락처 *',
                hintText: '010-1234-5678',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '연락처를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일 *',
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
            DropdownButtonFormField<String>(
              value: _selectedIndustry,
              decoration: const InputDecoration(
                labelText: '업종 / 분야',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              hint: const Text('업종을 선택해주세요'),
              items: _industries.map((industry) {
                return DropdownMenuItem(
                  value: industry,
                  child: Text(industry),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedIndustry = value;
                });
              },
            ),

            const SizedBox(height: 40),

            // 상품 정보
            const Text(
              '상품 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: '상품명 *',
                hintText: '리뷰를 받을 상품 또는 서비스명',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '상품명을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _productUrlController,
              decoration: const InputDecoration(
                labelText: '상품 URL *',
                hintText: 'https://example.com/product',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '상품 URL을 입력해주세요';
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            // 리뷰 상세 정보
            const Text(
              '리뷰 상세 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedPlatform,
              decoration: const InputDecoration(
                labelText: '리뷰 플랫폼 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.star_outline),
              ),
              hint: const Text('플랫폼을 선택해주세요'),
              items: _platforms.map((platform) {
                return DropdownMenuItem(
                  value: platform,
                  child: Text(platform),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return '리뷰 플랫폼을 선택해주세요';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedPlatform = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _reviewCountController,
              decoration: const InputDecoration(
                labelText: '희망 리뷰 건수 *',
                hintText: '예: 10건, 20건',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '희망 리뷰 건수를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _budgetController,
              decoration: const InputDecoration(
                labelText: '예산 (선택)',
                hintText: '예: 100,000원 ~ 500,000원',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _detailsController,
              decoration: const InputDecoration(
                labelText: '상세 요청사항 (선택)',
                hintText: '추가로 전달하실 내용을 자유롭게 작성해주세요',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('무료 상담 신청하기'),
            ),
          ],
        ),
      ),
    );
  }
}
