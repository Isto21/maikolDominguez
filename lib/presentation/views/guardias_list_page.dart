import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/config/router/router.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/data/datasources/models/guardia_model.dart';
import 'package:maikol_tesis/presentation/providers/auth/auth_provider.dart';
import 'package:maikol_tesis/presentation/providers/guardias/guardias_provider.dart';

class GuardiasListPage extends ConsumerStatefulWidget {
  const GuardiasListPage({super.key});

  @override
  ConsumerState<GuardiasListPage> createState() => _GuardiasListPageState();
}

class _GuardiasListPageState extends ConsumerState<GuardiasListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(guardiasProvider.notifier).loadGuardias();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guardiasState = ref.watch(guardiasProvider);
    final authState = ref.watch(authProvider);
    final currentUser = authState.user;
    final isAdmin = currentUser?.role == 'admin';

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Guardias'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Todas'),
            Tab(text: 'Planificadas'),
            Tab(text: 'Pendientes'),
            Tab(text: 'Realizadas'),
          ],
        ),
      ),
      body: guardiasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : guardiasState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    guardiasState.error!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(guardiasProvider.notifier).loadGuardias(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildGuardiasList(guardiasState.guardias, isAdmin),
                _buildGuardiasList(
                  guardiasState.guardias
                      .where((g) => g.status == GuardiaStatus.planificada)
                      .toList(),
                  isAdmin,
                ),
                _buildGuardiasList(
                  guardiasState.guardias
                      .where((g) => g.status == GuardiaStatus.pendiente)
                      .toList(),
                  isAdmin,
                ),
                _buildGuardiasList(
                  guardiasState.guardias
                      .where((g) => g.status == GuardiaStatus.realizada)
                      .toList(),
                  isAdmin,
                ),
              ],
            ),
      floatingActionButton: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton(
          onPressed: () => context.go(AppRouter.createGuardia),
          backgroundColor: AppTheme.primaryBlue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildGuardiasList(List<Guardia> guardias, bool isAdmin) {
    if (guardias.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay guardias',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(guardiasProvider.notifier).loadGuardias();
      },
      child: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: guardias.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildGuardiaCard(guardias[index], isAdmin),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGuardiaCard(Guardia guardia, bool isAdmin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        children: [
          // Header con status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor(guardia.status).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getStatusColor(guardia.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getStatusIcon(guardia.status),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guardia #${guardia.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDateRange(guardia.startTime, guardia.endTime),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(guardia.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    guardia.statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => ref
                      .read(guardiasProvider.notifier)
                      .deleteGuardia(guardia.id),
                  icon: const Icon(Icons.delete, color: Colors.red, size: 16),
                ),
              ],
            ),
          ),

          // Contenido
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Información de tiempo
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inicio: ${_formatDateTime(guardia.startTime)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Fin: ${_formatDateTime(guardia.endTime)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Usuarios asignados
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        guardia.usuariosAsignados,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                // Información de confirmaciones para admins
                if (isAdmin && guardia.guardiasUsuarios.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildConfirmacionesInfo(guardia),
                ],

                // Incidencias si las hay
                if (guardia.tieneIncidencias) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        size: 16,
                        color: guardia.incidenciasNoResueltas > 0
                            ? AppTheme.errorRed
                            : AppTheme.successGreen,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${guardia.incidencias.length} incidencia(s)',
                        style: TextStyle(
                          fontSize: 14,
                          color: guardia.incidenciasNoResueltas > 0
                              ? AppTheme.errorRed
                              : AppTheme.successGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (guardia.incidenciasNoResueltas > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.errorRed,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${guardia.incidenciasNoResueltas} sin resolver',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],

                const SizedBox(height: 16),

                // Acciones
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showGuardiaDetails(guardia, isAdmin),
                        icon: const Icon(Icons.visibility, size: 16),
                        label: const Text('Ver Detalles'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryBlue,
                          side: const BorderSide(color: AppTheme.primaryBlue),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showEditGuardiaDialog(guardia),
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Editar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.successGreen,
                          side: const BorderSide(color: AppTheme.successGreen),
                        ),
                      ),
                    ),
                  ],
                ),

                // Botón de confirmar asistencia solo para admins
                if (isAdmin && guardia.tieneUsuariosPendientes) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showConfirmarAsistenciaDialog(guardia),
                      icon: const Icon(Icons.how_to_reg, size: 16),
                      label: const Text('Confirmar Asistencia'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.warningOrange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmacionesInfo(Guardia guardia) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estado de Confirmación:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                size: 14,
                color: AppTheme.successGreen,
              ),
              const SizedBox(width: 4),
              Text(
                'Confirmados: ${guardia.cantidadConfirmados}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.successGreen,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.pending,
                size: 14,
                color: AppTheme.warningOrange,
              ),
              const SizedBox(width: 4),
              Text(
                'Pendientes: ${guardia.cantidadPendientes}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.warningOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(GuardiaStatus status) {
    switch (status) {
      case GuardiaStatus.planificada:
        return AppTheme.primaryBlue;
      case GuardiaStatus.realizada:
        return AppTheme.successGreen;
      case GuardiaStatus.pendiente:
        return AppTheme.warningOrange;
    }
  }

  IconData _getStatusIcon(GuardiaStatus status) {
    switch (status) {
      case GuardiaStatus.planificada:
        return Icons.schedule;
      case GuardiaStatus.realizada:
        return Icons.check_circle;
      case GuardiaStatus.pendiente:
        return Icons.pending;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final startStr = '${start.day}/${start.month}/${start.year}';
    final endStr = '${end.day}/${end.month}/${end.year}';

    if (startStr == endStr) {
      return 'El $startStr';
    } else {
      return 'Del $startStr al $endStr';
    }
  }

  void _showGuardiaDetails(Guardia guardia, bool isAdmin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Guardia #${guardia.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Estado', guardia.statusText),
              _buildDetailRow('Inicio', _formatDateTime(guardia.startTime)),
              _buildDetailRow('Fin', _formatDateTime(guardia.endTime)),
              _buildDetailRow('Usuarios', guardia.usuariosAsignados),
              if (guardia.tieneIncidencias)
                _buildDetailRow(
                  'Incidencias',
                  '${guardia.incidencias.length} reportada(s)',
                ),

              // Detalles de confirmación para admins
              if (isAdmin && guardia.guardiasUsuarios.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Estado de Confirmación:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...guardia.guardiasUsuarios.map((gu) {
                  final user = gu.user;
                  if (user == null) return const SizedBox.shrink();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          gu.isConfirmado ? Icons.check_circle : Icons.pending,
                          size: 16,
                          color: gu.isConfirmado
                              ? AppTheme.successGreen
                              : AppTheme.warningOrange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            user.fullName,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          gu.isConfirmado ? 'Confirmado' : 'Pendiente',
                          style: TextStyle(
                            fontSize: 12,
                            color: gu.isConfirmado
                                ? AppTheme.successGreen
                                : AppTheme.warningOrange,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showEditGuardiaDialog(Guardia guardia) {
    GuardiaStatus selectedStatus = guardia.status;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Editar Guardia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Cambiar estado:'),
              const SizedBox(height: 16),
              ...GuardiaStatus.values.map((status) {
                return RadioListTile<GuardiaStatus>(
                  title: Text(_getStatusText(status)),
                  value: status,
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: selectedStatus != guardia.status
                  ? () async {
                      Navigator.pop(context);

                      final request = UpdateGuardiaRequest(
                        status: selectedStatus,
                      );
                      final success = await ref
                          .read(guardiasProvider.notifier)
                          .updateGuardia(guardia.id, request);

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? 'Estado actualizado a ${_getStatusText(selectedStatus)}'
                                  : 'Error al actualizar el estado',
                            ),
                            backgroundColor: success
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                          ),
                        );
                      }
                    }
                  : null,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmarAsistenciaDialog(Guardia guardia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Asistencia'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selecciona quién asistió a la guardia:'),
            const SizedBox(height: 16),
            ...guardia.usuariosPendientes.map((gu) {
              final user = gu.user;
              if (user == null) return const SizedBox.shrink();

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryBlue,
                  child: Text(
                    user.firstName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(user.fullName),
                subtitle: Text(user.email ?? ''),
                trailing: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    final success = await ref
                        .read(guardiasProvider.notifier)
                        .confirmarAsistencia(guardia.id, user.id);

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'Asistencia confirmada para ${user.fullName}'
                                : 'Error al confirmar asistencia',
                          ),
                          backgroundColor: success
                              ? AppTheme.successGreen
                              : AppTheme.errorRed,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.successGreen,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Confirmar'),
                ),
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  String _getStatusText(GuardiaStatus status) {
    switch (status) {
      case GuardiaStatus.planificada:
        return 'Planificada';
      case GuardiaStatus.realizada:
        return 'Realizada';
      case GuardiaStatus.pendiente:
        return 'Pendiente';
    }
  }
}
