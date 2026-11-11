import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  static const Color lime = Color(0xFFB7F34A);
  static const Color background = Color(0xFF101517);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // FUNGSI REGISTER
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    // Simpan ScaffoldMessenger sebelum proses async
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    final email = _emailController.text.trim().toLowerCase();

    final savedEmail = prefs.getString('user_email');

    // Periksa apakah halaman masih aktif
    if (!mounted) return;

    if (savedEmail == email) {
      setState(() {
        _isLoading = false;
      });

      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Email sudah terdaftar. Silakan login.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );

      return;
    }

    // Simpan data akun
    await prefs.setString(
      'user_name',
      _nameController.text.trim(),
    );

    await prefs.setString(
      'user_email',
      email,
    );

    await prefs.setString(
      'user_password',
      _passwordController.text,
    );

    // Periksa kembali setelah seluruh proses async
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // Notifikasi akun berhasil dibuat
    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          'Akun berhasil dibuat! Silakan login.',
        ),
        backgroundColor: Color(0xFF354D25),
      ),
    );

    // Kembali ke halaman Login
    Navigator.pop(context, true);
  }

  // INPUT FIELD
  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool password = false,
    bool confirmPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 9),

        TextFormField(
          controller: controller,
          obscureText: password
              ? _obscurePassword
              : confirmPassword
              ? _obscureConfirm
              : false,
          keyboardType: label == 'Email'
              ? TextInputType.emailAddress
              : TextInputType.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.grey.shade500,
              size: 20,
            ),
            suffixIcon: password || confirmPassword
                ? IconButton(
              onPressed: () {
                setState(() {
                  if (password) {
                    _obscurePassword =
                    !_obscurePassword;
                  } else {
                    _obscureConfirm =
                    !_obscureConfirm;
                  }
                });
              },
              icon: Icon(
                (password
                    ? _obscurePassword
                    : _obscureConfirm)
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade500,
              ),
            )
                : null,
            filled: true,
            fillColor: const Color(0xFF141C1D),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF303B3C),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: lime,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label tidak boleh kosong';
            }

            if (label == 'Email') {
              final regex =
              RegExp(r'^[^@]+@[^@]+\.[^@]+$');

              if (!regex.hasMatch(value.trim())) {
                return 'Masukkan email yang valid';
              }
            }

            if (password && value.length < 6) {
              return 'Password minimal 6 karakter';
            }

            if (confirmPassword &&
                value != _passwordController.text) {
              return 'Konfirmasi password tidak sama';
            }

            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        title: const Text('Daftar Akun'),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    // LOGO
                    const Center(
                      child: Icon(
                        Icons.sports_soccer,
                        color: lime,
                        size: 65,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // JUDUL
                    const Center(
                      child: Text(
                        'Create Your Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Center(
                      child: Text(
                        'Buat akun dan mulai tantangan sepak bolamu!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // FORM REGISTER
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2425),
                        borderRadius:
                        BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF303B3C),
                        ),
                      ),
                      child: Column(
                        children: [

                          _buildField(
                            label: 'Nama Lengkap',
                            hint: 'Masukkan nama kamu',
                            controller: _nameController,
                            icon: Icons.person_outline,
                          ),

                          const SizedBox(height: 19),

                          _buildField(
                            label: 'Email',
                            hint: 'Masukkan email kamu',
                            controller: _emailController,
                            icon: Icons.email_outlined,
                          ),

                          const SizedBox(height: 19),

                          _buildField(
                            label: 'Password',
                            hint: 'Minimal 6 karakter',
                            controller: _passwordController,
                            icon: Icons.lock_outline,
                            password: true,
                          ),

                          const SizedBox(height: 19),

                          _buildField(
                            label: 'Konfirmasi Password',
                            hint: 'Masukkan ulang password',
                            controller: _confirmController,
                            icon: Icons.lock_reset_outlined,
                            confirmPassword: true,
                          ),

                          const SizedBox(height: 27),

                          // TOMBOL BUAT AKUN
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed:
                              _isLoading ? null : _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lime,
                                foregroundColor:
                                const Color(0xFF172014),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                width: 22,
                                height: 22,
                                child:
                                CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                'BUAT AKUN',
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // KEMBALI KE LOGIN
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sudah punya akun? Login',
                          style: TextStyle(
                            color: lime,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
