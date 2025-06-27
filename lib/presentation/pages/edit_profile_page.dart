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

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _aptoController = TextEditingController();
  final _groupController = TextEditingController();
  final _ciController = TextEditingController();
  final _cardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = ref.read(authProvider).user;
    if (user != null) {
      _nameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _emailController.text = user.email ?? '';
      _aptoController.text = user.apto ?? '';
      _groupController.text = user.group ?? '';
      _ciController.text = user.ci ?? '';
      _cardNumberController.text = user.cardNumber ?? '';
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(authProvider).user;
    final request = UpdateUserRequest(
      name: _nameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      role: user?.role,
      apto: _aptoController.text.trim(),
      group: _groupController.text.trim(),
      ci: _ciController.text.trim(),
      cardNumber: _cardNumberController.text.trim(),
    );

    final success = await ref
        .read(authProvider.notifier)
        .updateProfile(request);

    ref.invalidate(authProvider);
    await ref.read(authProvider.notifier).validateToken();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Perfil actualizado correctamente'
                : 'Error al actualizar el perfil',
          ),
          backgroundColor: success ? AppTheme.successGreen : AppTheme.errorRed,
        ),
      );
      // if (success) {
      //   context.pop(context);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryBlue, AppTheme.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Text(
                          ref
                                  .watch(authProvider)
                                  .user
                                  ?.firstName
                                  ?.substring(0, 1)
                                  .toUpperCase() ??
                              'U',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ref.watch(authProvider).user?.fullName ?? 'Usuario',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: _buildInfoSection('Información Personal', [
                  CustomTextField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,

                    label: 'Nombre',
                    validator: _validateNameField,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Por favor ingrese su nombre';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _lastNameController,
                    label: 'Apellido',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su apellido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Correo Electrónico',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su correo electrónico';
                      }
                      if (!value.contains('@')) {
                        return 'Por favor ingrese un correo electrónico válido';
                      }
                      return null;
                    },
                  ),
                ]),
              ),

              const SizedBox(height: 16),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                child: _buildInfoSection('Información Académica/Residencial', [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _aptoController,
                          label: 'Departamento',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su Departamento';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          controller: _groupController,
                          label: 'Grupo',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su grupo';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),

              const SizedBox(height: 16),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 600),
                child: _buildInfoSection('Información Adicional', [
                  CustomTextField(
                    controller: _ciController,
                    label: 'Número de Carné',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su número de carné';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _cardNumberController,
                    label: 'Solapín',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su solapín';
                      }
                      return null;
                    },
                  ),
                ]),
              ),

              const SizedBox(height: 32),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 800),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Guardar Cambios',
                      onPressed: _updateProfile,
                      icon: Icons.save,
                      backgroundColor: AppTheme.primaryBlue,
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'Eliminar Cuenta',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Eliminar Cuenta'),
                            content: const Text(
                              '¿Está seguro que desea eliminar su cuenta? Esta acción no se puede deshacer.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => const Center(
                                      child: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                  final success = await ref
                                      .read(authProvider.notifier)
                                      .deleteAccount();
                                  ref.invalidate(authProvider);
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          success
                                              ? 'Cuenta eliminada correctamente'
                                              : 'Error al eliminar la cuenta',
                                        ),
                                        backgroundColor: success
                                            ? AppTheme.successGreen
                                            : AppTheme.errorRed,
                                      ),
                                    );
                                    if (success) {
                                      context.pop();
                                      context.go(AppRouter.login);
                                    } else {
                                      context.pop();
                                    }
                                  }
                                },
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  static final RegExp _nameRegExp = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

  String? _validateNameField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre es requerido';
    }
    if (value.trim().length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }
    if (!_nameRegExp.hasMatch(value.trim())) {
      return 'El nombre solo puede contener letras';
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _aptoController.dispose();
    _groupController.dispose();
    _ciController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }
}
