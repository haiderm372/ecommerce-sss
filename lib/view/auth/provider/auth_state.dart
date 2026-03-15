class AuthState {
  const AuthState({
    this.obscurePassword = true,
    this.isEmailValid = false,
    this.isUsernameValid = false,
    this.isBirthdayValid = false,
    this.isPasswordValid = false,
    this.isLoading = false,
  });

  final bool obscurePassword;
  final bool isEmailValid;
  final bool isUsernameValid;
  final bool isBirthdayValid;
  final bool isPasswordValid;
  final bool isLoading;

  bool get isFormValid =>
      isEmailValid && isUsernameValid && isBirthdayValid && isPasswordValid;

  AuthState copyWith({
    bool? obscurePassword,
    bool? isEmailValid,
    bool? isUsernameValid,
    bool? isBirthdayValid,
    bool? isPasswordValid,
    bool? isLoading,
  }) {
    return AuthState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isBirthdayValid: isBirthdayValid ?? this.isBirthdayValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
