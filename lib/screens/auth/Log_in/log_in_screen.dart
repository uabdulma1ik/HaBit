import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/logic/auth/auth_bloc.dart';
import 'package:habit/screens/widgets/customSnackbar.dart/customSnackbar.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomSnackbar(context: context, message: 'Logged In').show();
          context.go('/home');
        } else if (state is AuthFailure) {
          CustomSnackbar(context: context, message: state.message).show();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned(
                left: 36,
                top: 46,
                child: Row(
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(
                          'assets/icons/arrow_back_24px_outlined.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Log In',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back !',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Please login with your credentials',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 285,
                left: 40,
                child: Column(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 52,
                      width: 343,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              'assets/icons/email_24px_outlined.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              cursorColor: const Color(0xFFFFB347),
                              style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email Address',
                                hintStyle: GoogleFonts.roboto(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 52,
                      width: 343,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              'assets/icons/lock_24px_outlined.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final isVisible =
                                    state is PasswordVisibilityState
                                    ? state.isVisible
                                    : false;

                                return TextField(
                                  cursorColor: const Color(0xFFFFB347),
                                  controller: _passwordController,
                                  obscureText: !isVisible,
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: GoogleFonts.roboto(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        context.read<AuthBloc>().add(
                                          const TogglePasswordVisibilityEvent(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 431,
                left: 231,
                child: GestureDetector(
                  onTap: () {
                    context.push('/forgot');
                  },
                  child: Text(
                    'Forgot Password ?',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: const Color.fromARGB(245, 0, 0, 0),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 525,
                left: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Don\'t have an account yet ?',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/createAccount');
                      },
                      child: Text(
                        'Create an account here',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: const Color(0xFFFFB347),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFFFFB347),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 705,
                left: 36,
                child: GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(
                      LoginEvent(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Container(
                        alignment: Alignment.center,
                        width: 343,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(209, 255, 178, 71),
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'LOG IN',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
