import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_ease_app/config/route_names.dart';
import 'package:read_ease_app/config/theme/theme_data.dart';
import 'package:read_ease_app/pages/auth/signup/provider/signup_provider.dart';
import 'package:read_ease_app/pages/auth/widget/email_field.dart';
import 'package:read_ease_app/pages/auth/widget/name_field.dart';
import 'package:read_ease_app/pages/auth/widget/password_field.dart';

import '../../../models/custom_error.dart';
import '../../../utils/error_dialog.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
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
    ref.read(signupProvider.notifier).signup(
          email: _emailController.text.trim(),
          name: _nameController.text.trim(),
          password: _passwordController.text.trim(),
        );
    /* print(
        'Email: ${_emailController.text}\nName: ${_nameController.text}\nPassword: ${_passwordController.text}'); */
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      signupProvider,
      (prev, next) {
        next.whenOrNull(
          error: (error, stackTrace) => errorDialog(
            context,
            (error as CustomError),
          ),
        );
      },
    );

    final signupState = ref.watch(signupProvider);

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
                    'Create your account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                    ),
                  ),
                  15.verticalSpace,
                  Text(
                    'Create an account and explore a tailored library of captivating stories.',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  40.verticalSpace,
                  //--Name--
                  NameField(
                    nameController: _nameController,
                  ),
                  10.verticalSpace,
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
                    onPressed: signupState.maybeWhen(
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
                      signupState.maybeWhen(
                        orElse: () => 'Create new account',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an acount? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed(RouteNames.signin),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  TextButton(
                    onPressed: () => context.goNamed(RouteNames.main),
                    child: Text(
                      'Skip for now!',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
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
                      'Sign up with Google',
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
