String? emailValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Email is required';
  final email = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\.\-]+$');
  if (!email.hasMatch(v.trim())) return 'Enter a valid email';
  return null;
}
