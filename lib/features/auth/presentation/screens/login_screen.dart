import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../providers/auth_provider.dart';
import '../state/auth_state.dart';

/// Login screen for authentication
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authNotifierProvider.notifier).signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final brightness = Theme.of(context).brightness;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(authNotifierProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLogo(brightness),
                  const SizedBox(height: 48),
                  _buildTitle(context),
                  const SizedBox(height: 8),
                  _buildSubtitle(context),
                  const SizedBox(height: 40),
                  _buildEmailField(context),
                  const SizedBox(height: 16),
                  _buildPasswordField(context),
                  const SizedBox(height: 32),
                  _buildLoginButton(authState),
                  const SizedBox(height: 24),
                  _buildDemoCredentials(context, brightness),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Brightness brightness) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.primary(brightness).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.restaurant_menu,
        size: 50,
        color: AppColors.primary(brightness),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Welcome Back',
      style: AppTextStyles.headlineLarge(context),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Sign in to continue',
      style: AppTextStyles.bodyLarge(context),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton(AuthState authState) {
    return AppButton.primary(
      text: 'Sign In',
      icon: Icons.login,
      onPressed: authState.isLoading ? null : _handleLogin,
      isLoading: authState.isLoading,
    );
  }

  Widget _buildDemoCredentials(BuildContext context, Brightness brightness) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: brightness == Brightness.light
            ? AppColors.lightSurfaceVariant
            : AppColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demo Accounts',
            style: AppTextStyles.titleSmall(context),
          ),
          const SizedBox(height: 12),
          _buildCredentialRow(context, 'Student', 'student@university.edu', 'student123'),
          const SizedBox(height: 8),
          _buildCredentialRow(context, 'Cook', 'cook@canteen.edu', 'cook123'),
        ],
      ),
    );
  }

  Widget _buildCredentialRow(BuildContext context, String role, String email, String password) {
    return GestureDetector(
      onTap: () {
        _emailController.text = email;
        _passwordController.text = password;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              role == 'Student' ? Icons.school : Icons.restaurant,
              size: 20,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: AppTextStyles.labelMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$email / $password',
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.touch_app,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
