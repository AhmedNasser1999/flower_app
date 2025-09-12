class AuthResponse<T> {
  final T? data;
  final String? error;

  AuthResponse.success(this.data) : error = null;
  AuthResponse.error(this.error) : data = null;

  bool get isSuccess => data != null;
}
