import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/config/router/router.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart';
import 'package:maikol_tesis/presentation/providers/auth/auth_provider.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_button.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_text_field.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ciController = TextEditingController();
  final _emailController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _aptoController = TextEditingController();
  final _groupController = TextEditingController();

  String _selectedRole = 'estudiante';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isRegistering = false;

  final List<String> _roles = ['estudiante', 'tecnico', 'profesor', 'admin'];

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _ciController.dispose();
    _emailController.dispose();
    _cardNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _aptoController.dispose();
    _groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primaryBlue, AppTheme.darkBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // Logo y título
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_add,
                            size: 40,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Crear Cuenta',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Únete al Sistema de Guardias UCI',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Formulario de registro
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Información Personal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 24),

                          // Nombre y Apellidos
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _nameController,
                                  label: 'Nombre',
                                  prefixIcon: Icons.person_outlined,
                                  enabled: !_isRegistering,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  controller: _lastNameController,
                                  label: 'Apellidos',
                                  prefixIcon: Icons.person_outline,
                                  enabled: !_isRegistering,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // CI y Número de Carnet
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _ciController,
                                  keyboardType: TextInputType.number,
                                  label: 'Número de Carnet',
                                  prefixIcon: Icons.badge_outlined,
                                  enabled: !_isRegistering,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    if (value.length != 11) {
                                      return 'CI debe tener 11 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  controller: _cardNumberController,
                                  label: 'Solapin',
                                  prefixIcon: Icons.credit_card_outlined,
                                  enabled: !_isRegistering,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Email
                          CustomTextField(
                            controller: _emailController,
                            label: 'Correo Electrónico',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            enabled: !_isRegistering,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su correo';
                              }
                              if (!value.contains('@')) {
                                return 'Ingrese un correo válido';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Rol
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            decoration: InputDecoration(
                              labelText: 'Rol',
                              prefixIcon: const Icon(Icons.work_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabled: !_isRegistering,
                            ),
                            items: _roles.map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(_getRoleText(role)),
                              );
                            }).toList(),
                            onChanged: _isRegistering
                                ? null
                                : (value) {
                                    setState(() {
                                      _selectedRole = value!;
                                    });
                                  },
                          ),

                          const SizedBox(height: 16),

                          // Apto y Grupo
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _aptoController,
                                  label: 'Apartamento',
                                  prefixIcon: Icons.home_repair_service_sharp,
                                  enabled: !_isRegistering,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  keyboardType: TextInputType.number,
                                  controller: _groupController,
                                  label: 'Grupo',
                                  prefixIcon: Icons.group_outlined,
                                  enabled: !_isRegistering,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty &&
                                            _selectedRole == 'estudiante') {
                                      return 'Requerido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Contraseña
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Contraseña',
                            obscureText: _obscurePassword,
                            prefixIcon: Icons.lock_outlined,
                            enabled: !_isRegistering,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: _isRegistering
                                  ? null
                                  : () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese una contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Confirmar contraseña
                          CustomTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirmar Contraseña',
                            obscureText: _obscureConfirmPassword,
                            prefixIcon: Icons.lock_outlined,
                            enabled: !_isRegistering,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: _isRegistering
                                  ? null
                                  : () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor confirme su contraseña';
                              }
                              if (value != _passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: 'Crear Cuenta',
                            onPressed: _isRegistering ? null : _handleRegister,
                            isLoading: _isRegistering,
                          ),

                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿Ya tienes cuenta? '),
                              TextButton(
                                onPressed: _isRegistering
                                    ? null
                                    : () => context.go(AppRouter.login),
                                child: const Text(
                                  'Inicia Sesión',
                                  style: TextStyle(
                                    color: AppTheme.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getRoleText(String role) {
    switch (role) {
      case 'estudiante':
        return 'Estudiante';
      case 'tecnico':
        return 'Tecnico';
      case 'profesor':
        return 'Profesor';
      case 'admin':
        return 'Administrador';
      default:
        return role;
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isRegistering = true;
    });

    try {
      final request = RegisterRequest(
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        ci: _ciController.text.trim(),
        email: _emailController.text.trim(),
        cardNumber: _cardNumberController.text.trim(),
        password: _passwordController.text,
        role: _selectedRole.isEmpty ? ' ' : _selectedRole,
        apto: _aptoController.text.trim(),
        group: _groupController.text.trim(),
      );

      final success = await ref.read(authProvider.notifier).register(request);

      if (mounted) {
        if (success) {
          // Registro exitoso
          context.go(AppRouter.activation, extra: _emailController.text.trim());
        } else {
          // Registro falló
          final authState = ref.read(authProvider);
          if (authState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authState.error!),
                backgroundColor: AppTheme.errorRed,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
              ),
            );
            // Limpiar el error
            ref.read(authProvider.notifier).clearError();
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error inesperado: ${e.toString()}'),
            backgroundColor: AppTheme.errorRed,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRegistering = false;
        });
      }
    }
  }
}
