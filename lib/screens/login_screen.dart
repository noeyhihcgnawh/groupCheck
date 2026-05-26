import 'package:flutter/material.dart';

import 'app_shell.dart';

// 로그인 화면: 아이디와 비밀번호 입력 후 앱 홈 영역으로 이동합니다.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 입력 상태: 사용자가 입력한 아이디와 비밀번호를 보관합니다.
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 로그인 처리: 입력값 검증 후 하단 탭이 있는 AppShell로 전환합니다.
  void _login() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => AppShell(userId: _idController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 로그인 레이아웃: 작은 화면에서도 버튼까지 스크롤 가능하게 구성합니다.
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 44),
                        const _BrandMark(),
                        const SizedBox(height: 42),
                        const Text(
                          '간편하게 로그인하고\n동아리 활동을 확인하세요',
                          style: TextStyle(
                            fontSize: 28,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF191F28),
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '아이디와 비밀번호를 입력하면 홈 피드로 이동합니다.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.45,
                            color: Color(0xFF6B7684),
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(height: 36),
                        // 아이디 입력 영역
                        _LoginTextField(
                          key: const Key('idField'),
                          controller: _idController,
                          hintText: '아이디',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '아이디를 입력해주세요';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        // 비밀번호 입력 영역
                        _LoginTextField(
                          key: const Key('passwordField'),
                          controller: _passwordController,
                          hintText: '비밀번호',
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _login(),
                          suffixIcon: IconButton(
                            tooltip: _obscurePassword ? '비밀번호 보기' : '비밀번호 숨기기',
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '비밀번호를 입력해주세요';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        // 보조 액션 영역
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('아이디 찾기'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('비밀번호 재설정'),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // 로그인 실행 버튼
                        FilledButton(
                          key: const Key('loginButton'),
                          onPressed: _login,
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF3182F6),
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0,
                            ),
                          ),
                          child: const Text('로그인'),
                        ),
                        const SizedBox(height: 14),
                        TextButton(
                          onPressed: () {},
                          child: const Text('처음이신가요? 회원가입'),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 브랜드 표시 영역: 앱 로고와 이름을 함께 보여줍니다.
class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF3182F6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 12),
        const Text(
          'groupCheck',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF191F28),
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

// 로그인 입력 필드 공통 위젯: 아이디/비밀번호 입력 UI를 같은 스타일로 재사용합니다.
class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF191F28),
        letterSpacing: 0,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF8B95A1)),
        filled: true,
        fillColor: const Color(0xFFF2F4F6),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF3182F6), width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF5C5C), width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF5C5C), width: 1.4),
        ),
      ),
    );
  }
}
