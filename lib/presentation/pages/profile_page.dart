import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/config/router/router.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/presentation/providers/auth/auth_provider.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_button.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header del perfil
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
                        user?.firstName?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.fullName ?? 'Usuario',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user?.email ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${user?.group ?? 'N/A'} - Apto ${user?.apto ?? 'N/A'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Información personal
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: _buildInfoSection('Información Personal', [
                _buildInfoItem(
                  'Nombre',
                  user?.firstName ?? 'N/A',
                  Icons.person,
                ),
                _buildInfoItem(
                  'Apellidos',
                  user?.lastName ?? 'N/A',
                  Icons.person_outline,
                ),
                _buildInfoItem(
                  'Cédula de Identidad',
                  user?.ci ?? 'N/A',
                  Icons.badge,
                ),
                _buildInfoItem('Correo', user?.email ?? 'N/A', Icons.email),
                _buildInfoItem(
                  'Número de Carnet',
                  user?.cardNumber ?? 'N/A',
                  Icons.credit_card,
                ),
                _buildInfoItem(
                  'Rol',
                  _getRoleText(user?.role ?? ''),
                  Icons.work,
                ),
              ]),
            ),

            const SizedBox(height: 16),

            // Información académica/residencial
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 400),
              child: _buildInfoSection('Información Académica/Residencial', [
                _buildInfoItem('Grupo', user?.group ?? 'N/A', Icons.group),
                _buildInfoItem('Departamento', user?.apto ?? 'N/A', Icons.home),
              ]),
            ),

            const SizedBox(height: 16),

            // Estado de la cuenta
            // FadeInUp(
            //   duration: const Duration(milliseconds: 800),
            //   delay: const Duration(milliseconds: 600),
            //   child: _buildInfoSection('Estado de la Cuenta', [
            //     _buildInfoItem(
            //       'Estado',
            //       user?.isActive == true ? 'Activa' : 'Inactiva',
            //       user?.isActive == true ? Icons.check_circle : Icons.cancel,
            //       color: user?.isActive == true
            //           ? AppTheme.successGreen
            //           : AppTheme.errorRed,
            //     ),
            //     _buildInfoItem(
            //       'Fecha de Registro',
            //       _formatDate(user?.createdAt),
            //       Icons.calendar_today,
            //     ),
            //   ]),
            // ),
            const SizedBox(height: 32),

            // Acciones
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 800),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Ver Mis Guardias',
                    onPressed: () => context.go(AppRouter.guardias),
                    icon: Icons.security,
                    backgroundColor: AppTheme.successGreen,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Editar Perfil',
                    onPressed: () => context.go(AppRouter.editProfile),
                    icon: Icons.edit,
                    backgroundColor: AppTheme.primaryBlue,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Cerrar Sesión',
                    onPressed: () => _showLogoutDialog(context, ref),
                    icon: Icons.logout,
                    backgroundColor: AppTheme.errorRed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
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
          ...items,
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? AppTheme.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: color ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleText(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return 'Estudiante';
      case 'teacher':
        return 'Profesor';
      case 'admin':
        return 'Administrador';
      default:
        return role;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // Solo limpiar token local y navegar al login
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go(AppRouter.login);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}
