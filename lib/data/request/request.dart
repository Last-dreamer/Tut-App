class LoginRequest {
  final String email;
  final String password;
  final String imei;
  final String deviceType;
  LoginRequest({
    required this.email,
    required this.password,
    required this.imei,
    required this.deviceType,
  });
}

class RegisterRequest {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String picture;
  final String imei;
  final String deviceType;
  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.picture,
    required this.imei,
    required this.deviceType,
  });
}
