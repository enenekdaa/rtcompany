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
  final _regularPriceController = TextEditingController();
  final _customerPriceController = TextEditingController();
  final _shippingFeeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _durationDaysController = TextEditingController();
  final _keywordsController = TextEditingController();
  final _missionContentController = TextEditingController();
  final _remarksController = TextEditingController();

  String? _selectedSalesChannel;
  DateTime? _selectedStartDate;
  String? _selectedPhotoReview;

  final List<String> _salesChannels = [
    '네이버 스마트스토어',
    '쿠팡',
    '11번가',
    '지마켓',
    '옥션',
    'G마켓',
    '자사몰',
    '기타',
  ];

  final List<String> _photoReviewOptions = [
    '필수',
    '선택',
  ];

  @override
  void dispose() {
    _companyNameController.dispose();
    _managerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _productNameController.dispose();
    _productUrlController.dispose();
    _regularPriceController.dispose();
    _customerPriceController.dispose();
    _shippingFeeController.dispose();
    _startDateController.dispose();
    _durationDaysController.dispose();
    _keywordsController.dispose();
    _missionContentController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      const botToken = '8468965673:AAFdpadWx3LOB45NWNKywhq1VbuWHlskzcY';
      const chatId = '2027724910';

      // Format message with all form data in Korean
      final message = '''
📝 새로운 리뷰 체험단 상담 신청

👤 기본 정보
━━━━━━━━━━━━━━━━━━━━
회사명: ${_companyNameController.text}
담당자명: ${_managerNameController.text}
연락처: ${_phoneController.text}
이메일: ${_emailController.text}

📦 상품 정보
━━━━━━━━━━━━━━━━━━━━
판매처: ${_selectedSalesChannel ?? '미선택'}
상품명: ${_productNameController.text}
상품URL: ${_productUrlController.text}

💰 금액 정보
━━━━━━━━━━━━━━━━━━━━
정상가: ${_regularPriceController.text}원
고객 실구매가: ${_customerPriceController.text}원
배송비: ${_shippingFeeController.text}원

📅 진행 일정
━━━━━━━━━━━━━━━━━━━━
상품 구매 시작 일자: ${_selectedStartDate != null ? '${_selectedStartDate!.year}-${_selectedStartDate!.month.toString().padLeft(2, '0')}-${_selectedStartDate!.day.toString().padLeft(2, '0')}' : '미선택'}
진행일 수: ${_durationDaysController.text}일

⭐ 리뷰 미션 가이드
━━━━━━━━━━━━━━━━━━━━
키워드: ${_keywordsController.text}
내용: ${_missionContentController.text}
포토리뷰: ${_selectedPhotoReview ?? '미선택'}

📝 비고
━━━━━━━━━━━━━━━━━━━━
${_remarksController.text.isEmpty ? '없음' : _remarksController.text}
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
                    _regularPriceController.clear();
                    _customerPriceController.clear();
                    _shippingFeeController.clear();
                    _startDateController.clear();
                    _durationDaysController.clear();
                    _keywordsController.clear();
                    _missionContentController.clear();
                    _remarksController.clear();
                    setState(() {
                      _selectedSalesChannel = null;
                      _selectedStartDate = null;
                      _selectedPhotoReview = null;
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
            DropdownButtonFormField<String>(
              value: _selectedSalesChannel,
              decoration: const InputDecoration(
                labelText: '판매처 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
              hint: const Text('판매처를 선택해주세요'),
              items: _salesChannels.map((channel) {
                return DropdownMenuItem(
                  value: channel,
                  child: Text(channel),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return '판매처를 선택해주세요';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedSalesChannel = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: '상품명 *',
                hintText: '리뷰를 받을 상품명을 입력해주세요',
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
                labelText: '상품URL *',
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

            // 금액 정보
            const Text(
              '금액 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _regularPriceController,
              decoration: const InputDecoration(
                labelText: '정상가 *',
                hintText: '예: 30000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments_outlined),
                suffixText: '원',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '정상가를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _customerPriceController,
              decoration: const InputDecoration(
                labelText: '고객 실구매가 *',
                hintText: '예: 20000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.price_check_outlined),
                suffixText: '원',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '고객 실구매가를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _shippingFeeController,
              decoration: const InputDecoration(
                labelText: '배송비 *',
                hintText: '예: 3000 (무료 배송인 경우 0 입력)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_shipping_outlined),
                suffixText: '원',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '배송비를 입력해주세요';
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            // 진행 일정
            const Text(
              '진행 일정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _startDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: '상품 구매 시작 일자 *',
                hintText: '날짜를 선택해주세요',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedStartDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                    _selectedStartDate = picked;
                    _startDateController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '상품 구매 시작 일자를 선택해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _durationDaysController,
              decoration: const InputDecoration(
                labelText: '진행일 수 *',
                hintText: '예: 7',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.event_note),
                suffixText: '일',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '진행일 수를 입력해주세요';
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            // 리뷰 미션 가이드
            const Text(
              '리뷰 미션 가이드',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _keywordsController,
              decoration: const InputDecoration(
                labelText: '키워드 *',
                hintText: '예: 편안함, 가성비, 디자인',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tag),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '키워드를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _missionContentController,
              decoration: const InputDecoration(
                labelText: '내용 *',
                hintText: '리뷰에 포함되어야 할 내용을 자세히 작성해주세요',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '리뷰 내용 가이드를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedPhotoReview,
              decoration: const InputDecoration(
                labelText: '포토리뷰 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.photo_camera),
              ),
              hint: const Text('포토리뷰 필수 여부를 선택해주세요'),
              items: _photoReviewOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return '포토리뷰 필수 여부를 선택해주세요';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedPhotoReview = value;
                });
              },
            ),

            const SizedBox(height: 40),

            // 비고
            const Text(
              '비고',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _remarksController,
              decoration: const InputDecoration(
                labelText: '비고 (선택)',
                hintText: '예: 랭킹 진입 희망',
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
