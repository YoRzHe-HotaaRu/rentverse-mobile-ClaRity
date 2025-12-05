// lib/features/auth/presentation/cubit/register/register_state.dart
import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final RegisterStatus status;
  final String? errorMessage;
  final String role; // <--- Properti Baru untuk Role
  // Inline field errors
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;

  const RegisterState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.role = "TENANT", // Default Value
    this.nameError,
    this.emailError,
    this.phoneError,
    this.passwordError,
    this.confirmPasswordError,
  });

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    RegisterStatus? status,
    String? errorMessage,
    String? role, // <--- Add CopyWith
    String? nameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      role: role ?? this.role,
      nameError: nameError,
      emailError: emailError,
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }

  @override
  List<Object?> get props => [
    isPasswordVisible,
    isConfirmPasswordVisible,
    status,
    errorMessage,
    role,
    nameError,
    emailError,
    phoneError,
    passwordError,
    confirmPasswordError,
  ];
}
