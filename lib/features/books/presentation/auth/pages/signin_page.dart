import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/presentation/auth/widgets/email_field.dart';
import 'package:read_ease_app/features/books/presentation/auth/widgets/password_field.dart';

import '../../../../../config/router/route.dart';
import '../../../../../core/utils/error_dialog.dart';
import '../../../data/models/custom_error/custom_error.dart';
import '../providers/signin/signin_provider.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void submit() {
    FocusManager.instance.primaryFocus!.unfocus();
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;
    ref.read(signinProvider.notifier).signin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
    /* print(
        'Email: ${_emailController.text}\nName: ${_nameController.text}\nPassword: ${_passwordController.text}'); */
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      signinProvider,
      (prev, next) {
        next.whenOrNull(
          error: (error, stackTrace) => errorDialog(
            context,
            (error as CustomError),
          ),
        );
      },
    );

    final signinState = ref.watch(signinProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                reverse: false,
                shrinkWrap: true,
                children: [
                  76.verticalSpace,
                  Text(
                    'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                    ),
                  ),
                  15.verticalSpace,
                  Text(
                    'Welcome back! Log in to resume your reading journey.',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  40.verticalSpace,
                  //--Email--
                  EmailField(
                    emailController: _emailController,
                  ),
                  10.verticalSpace,
                  //--Password--
                  PasswordField(
                    passwordController: _passwordController,
                    isVisible: _isVisible,
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                  ),
                  15.verticalSpace,
                  ElevatedButton(
                    onPressed: signinState.maybeWhen(
                      loading: () => null,
                      orElse: () => submit,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      signinState.maybeWhen(
                        orElse: () => 'Log in',
                        loading: () => 'Submitting...',
                      ),
                      style: TextStyle(
                        color: AppColors.textOtherColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  15.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Don\'t have an acount? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.goNamed(RouteNames.signup),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed(RouteNames.resetPassword),
                        child: Text(
                          'Forgot password',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColors.secondaryColor1,
                        ),
                      ),
                      7.horizontalSpace,
                      Text(
                        'or',
                        style: TextStyle(
                          color: AppColors.secondaryColor2,
                          fontSize: 14.sp,
                        ),
                      ),
                      7.horizontalSpace,
                      const Expanded(
                        child: Divider(color: AppColors.secondaryColor1),
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  ElevatedButton.icon(
                    onPressed: () {
                      //todo: coming soon...
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    label: Text(
                      'Login with Google',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/google.svg',
                    ),
                  ),
                  15.verticalSpace,
                ],
              )..reverse,
            ),
          ),
        ),
      ),
    );
  }
}
