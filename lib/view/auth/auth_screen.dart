import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './widgets/auth_button.dart';
import './widgets/auth_text_tab.dart';
import './provider/auth_provider.dart';
import './widgets/auth_text_field.dart';
import '../../configs/themes/colors.dart';
import './widgets/auth_date_formatter.dart';
import '../../configs/assets/icons/icons.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const routePath = '/auth';
  static const routeName = 'auth';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _birthdayController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _birthdayController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final authState = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              child: Column(
                spacing: 24,
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Text(
                    'Welcome!',
                    textAlign: .center,
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  RichText(
                    textAlign: .center,
                    text: TextSpan(
                      style: textTheme.headlineSmall?.copyWith(
                        height: 2.0,
                        fontSize: 14,
                        letterSpacing: 0.9,
                        color: AppColors.grey,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'Please complete the required information, and then press the',
                        ),
                        TextSpan(
                          text: ' Next ',
                          style: textTheme.headlineLarge?.copyWith(
                            height: 2.0,
                            fontSize: 14,
                            letterSpacing: 0.9,
                            color: AppColors.grey,
                          ),
                        ),
                        TextSpan(text: 'button'),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: AuthTextTab(
                          title: "Email Address",
                          isEnable: true,
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: AuthTextTab(
                          title: "Phone Number",
                          isEnable: false,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  AuthTextField(
                    title: 'E-mail',
                    hint: 'email@example.com',
                    icon: AppIcons.mail,
                    textInputAction: .next,
                    textCapitalization: .none,
                    textInputType: .emailAddress,
                    textController: _emailController,
                    onChanged: notifier.validateEmail,
                    textInputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),

                  AuthTextField(
                    title: 'Username',
                    hint: 'JohnApple',
                    icon: AppIcons.person,
                    textInputType: .name,
                    textInputAction: .next,
                    textCapitalization: .none,
                    textController: _usernameController,
                    onChanged: notifier.validateUsername,
                    textInputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),

                  AuthTextField(
                    title: 'Birthday',
                    hint: '14/08/2020',
                    textInputType: .number,
                    icon: AppIcons.calendar,
                    textController: _birthdayController,
                    onChanged: notifier.validateBirthday,
                    textInputFormatters: [AuthDateFormatter()],
                  ),

                  AuthTextField(
                    title: 'Password',
                    hint: '\u2022 \u2022 \u2022 \u2022 \u2022 \u2022',
                    icon: AppIcons.lock,
                    obscureText: authState.obscurePassword,
                    textInputAction: .done,
                    textCapitalization: .none,
                    textInputType: .visiblePassword,
                    textController: _passwordController,
                    onChanged: notifier.validatePassword,
                    textInputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    suffix: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: notifier.togglePasswordVisibility,
                        borderRadius: BorderRadius.circular(60),
                        overlayColor: WidgetStatePropertyAll(
                          AppColors.main.withValues(alpha: 0.1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            authState.obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Text(
                    'Password must include a number, a letter, and a special character.',
                    textAlign: .center,
                    style: textTheme.headlineSmall?.copyWith(
                      height: 2.0,
                      fontSize: 11,
                      letterSpacing: 0.8,
                      color: AppColors.grey,
                    ),
                  ),

                  AuthButton(
                    label: 'Next',
                    isEnabled: authState.isFormValid && !authState.isLoading,
                    onTap: (authState.isFormValid && !authState.isLoading)
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            notifier.authenticate(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                              username: _usernameController.text.trim(),
                              birthday: _birthdayController.text,
                            );
                          }
                        : null,
                  ),

                  RichText(
                    textAlign: .center,
                    text: TextSpan(
                      style: textTheme.headlineSmall?.copyWith(
                        height: 2.0,
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Signin',
                          style: textTheme.headlineMedium?.copyWith(
                            height: 2.0,
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
