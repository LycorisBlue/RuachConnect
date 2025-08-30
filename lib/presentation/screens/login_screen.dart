import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../controllers/login_controller.dart';
import '../../common/constants/app_constants.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _buttonAnimationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final controller = LoginController(ref);

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section - Fixed height
            _buildHeaderSection(),

            // Form Section - Expanded to fill remaining space
            Expanded(child: _buildFormSection(controller)),

            // Footer Section - Fixed height
            _buildFooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo/Icon placeholder
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: Icon(Icons.church, color: Colors.white, size: 35.sp),
          ),

          SizedBox(height: 16.h),

          Text(
            AppConstants.appName,
            style: AppTextStyles.h1.copyWith(fontSize: 26.sp, color: Colors.white, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 6.h),

          Text(
            'Bienvenue dans votre espace',
            style: AppTextStyles.body.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(LoginController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome text
          Text(
            'Connexion',
            style: AppTextStyles.h2.copyWith(fontSize: 22.sp, color: AppColors.primary),
          ),

          SizedBox(height: 6.h),

          Text(
            'Connectez-vous pour accéder à votre compte',
            style: AppTextStyles.caption.copyWith(fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 28.h),

          Form(
            key: _formKey,
            child: Column(
              children: [
                // Email field
                _buildEmailField(controller),

                SizedBox(height: 14.h),

                // Password field
                _buildPasswordField(controller),

                SizedBox(height: 28.h),

                // Login button with animation
                _buildAnimatedLoginButton(controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(LoginController controller) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Adresse email',
        hintText: 'votre@email.com',
        prefixIcon: Container(
          margin: EdgeInsets.all(12.w),
          child: Icon(Icons.email_outlined, color: AppColors.primary, size: 20.sp),
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.divider, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.danger, width: 1),
        ),
      ),
      validator: controller.validateEmail,
    );
  }

  Widget _buildPasswordField(LoginController controller) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        hintText: 'Votre mot de passe',
        prefixIcon: Container(
          margin: EdgeInsets.all(12.w),
          child: Icon(Icons.lock_outline, color: AppColors.primary, size: 20.sp),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.accent,
            size: 20.sp,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.divider, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.danger, width: 1),
        ),
      ),
      validator: controller.validatePassword,
    );
  }

  Widget _buildAnimatedLoginButton(LoginController controller) {
    return AnimatedBuilder(
      animation: _buttonScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonScaleAnimation.value,
          child: Container(
            width: double.infinity,
            height: 54.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: _isLoading ? null : LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
              color: _isLoading ? AppColors.accent : null,
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), offset: Offset(0, 4.h), blurRadius: 12.r)],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: _isLoading ? null : _handleLogin,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isLoading) ...[
                        SizedBox(
                          width: 18.w,
                          height: 18.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Connexion en cours...',
                          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                      ] else ...[
                        Icon(Icons.login, color: Colors.white, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Se connecter',
                          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterSection() {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${AppConstants.appName} v${AppConstants.appVersion}',
            style: AppTextStyles.caption.copyWith(fontSize: 11.sp, color: AppColors.accent),
          ),
          SizedBox(height: 4.h),
          Text(
            'Gestion des nouveaux visiteurs',
            style: AppTextStyles.caption.copyWith(fontSize: 11.sp, color: AppColors.accent),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    // Button press animation
    _buttonAnimationController.forward().then((_) {
      _buttonAnimationController.reverse();
    });

    setState(() => _isLoading = true);

    final controller = LoginController(ref);
    final success = await controller.login(_emailController.text.trim(), _passwordController.text.trim());

    setState(() => _isLoading = false);

    if (success) {
      // Navigation automatique via AuthWrapper dans main.dart
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8.w),
              Text('Identifiants incorrects'),
            ],
          ),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          margin: EdgeInsets.all(16.w),
        ),
      );
    }
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
