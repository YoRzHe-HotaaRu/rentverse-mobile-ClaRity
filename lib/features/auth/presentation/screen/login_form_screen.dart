// lib/features/auth/presentation/screen/login_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../common/colors/custom_color.dart';
import '../cubit/auth/auth_page_cubit.dart';
import '../../../../common/bloc/auth/auth_cubit.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../widget/custom_button.dart';

class LoginFormScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/metairflow.png',
                height: 80, // Sesuaikan ukuran logo
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Welcome to Rentverse",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // EMAIL INPUT
            Text(
              "Email",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF225555),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter your email address",
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: appPrimaryColor),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // PASSWORD INPUT
            Text(
              "Password",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF225555),
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: !state.isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordVisible
                            ? LucideIcons.eye
                            : LucideIcons.eyeOff,
                        color: const Color(0xFF225555),
                      ),
                      onPressed: () {
                        context.read<LoginCubit>().togglePasswordVisibility();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: appPrimaryColor),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // LOGIN BUTTON
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.success) {
                  // Refresh auth status to navigate to home
                  context.read<AuthCubit>().checkAuthStatus();
                } else if (state.status == LoginStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage ?? "Error")),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: "Sign in", // Sesuai gambar
                  isLoading: state.status == LoginStatus.loading,
                  onTap: () {
                    context.read<LoginCubit>().submitLogin(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            // REGISTER LINK
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have a Rentverse account? ",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    // Pindah ke Register
                    context.read<AuthPageCubit>().showRegister();
                  },
                  child: Text(
                    "Sign up", // Typo di gambar user mungkin 'Sign in' di bawah login, harusnya sign up atau register
                    style: GoogleFonts.poppins(
                      color: appSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
