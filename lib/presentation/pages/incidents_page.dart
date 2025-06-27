import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/data/datasources/models/incident_model.dart';
import 'package:maikol_tesis/presentation/providers/auth/auth_provider.dart';
import 'package:maikol_tesis/presentation/providers/guardias/guardias_provider.dart';
import 'package:maikol_tesis/presentation/providers/incidents/incidents_provider.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_text_field.dart';

class IncidentsPage extends ConsumerStatefulWidget {
  const IncidentsPage({super.key});

  @override
  ConsumerState<IncidentsPage> createState() => _IncidentsPageState();
}

class _IncidentsPageState extends ConsumerState<IncidentsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(incidentsProvider.notifier).loadIncidents();
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
    final incidentsState = ref.watch(incidentsProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Incidencias'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Todas'),
            Tab(text: 'Pendientes'),
            Tab(text: 'Resueltas'),
          ],
        ),
      ),
      body: incidentsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : incidentsState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    incidentsState.error!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(incidentsProvider.notifier).loadIncidents(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildIncidentsList(incidentsState.incidents),
                _buildIncidentsList(
                  incidentsState.incidents
                      .where((i) => !(i.resolved ?? false))
                      .toList(),
                ),
                _buildIncidentsList(
                  incidentsState.incidents
                      .where((i) => (i.resolved) ?? false)
                      .toList(),
                ),
              ],
            ),
      floatingActionButton: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton(
          onPressed: () => _showCreateIncidentDialog(),
          backgroundColor: AppTheme.primaryBlue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildIncidentsList(List<Incident> incidents) {
    if (incidents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.report_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay incidencias',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(incidentsProvider.notifier).loadIncidents();
      },
      child: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: incidents.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildIncidentCard(incidents[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIncidentCard(Incident incident) {
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getSeverityColor(
                incident.severity ?? 'baja',
              ).withOpacity(0.1),
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
                    color: _getSeverityColor(incident.severity ?? 'baja'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getSeverityIcon(incident.severity ?? 'baja'),
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
                        incident.title ?? 'Sin título',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDateTime(incident.reportedAt ?? DateTime.now()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getSeverityColor(incident.severity ?? 'baja'),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getSeverityText(incident.severity ?? 'baja'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (incident.resolved ?? false)
                            ? AppTheme.successGreen
                            : AppTheme.warningOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        (incident.resolved ?? false) ? 'Resuelta' : 'Pendiente',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  incident.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showEditIncidentDialog(incident),
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Editar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryBlue,
                          side: const BorderSide(color: AppTheme.primaryBlue),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showDeleteIncidentDialog(incident),
                        icon: const Icon(Icons.delete, size: 16),
                        label: const Text('Eliminar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.errorRed,
                          side: const BorderSide(color: AppTheme.errorRed),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateIncidentDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedSeverity = 'baja';
    int? selectedGuardiaId;

    final guardiasState = ref.read(guardiasProvider);
    final availableGuardias = guardiasState.guardias;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Reportar Incidencia'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: titleController,
                  label: 'Título',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: descriptionController,
                  label: 'Descripción',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedSeverity,
                  decoration: const InputDecoration(
                    labelText: 'Severidad',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'baja', child: Text('Baja')),
                    DropdownMenuItem(value: 'media', child: Text('Media')),
                    DropdownMenuItem(value: 'alta', child: Text('Alta')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedSeverity = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: selectedGuardiaId,
                  decoration: const InputDecoration(
                    labelText: 'Guardia relacionada',
                    border: OutlineInputBorder(),
                  ),
                  items: availableGuardias.map((guardia) {
                    return DropdownMenuItem(
                      value: guardia.id,
                      child: Text(
                        '${guardia.statusText} - ${_formatDateTime(guardia.startTime)}',
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGuardiaId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione una guardia';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    selectedGuardiaId != null) {
                  final request = CreateIncidentRequest(
                    guardiaId: selectedGuardiaId!,
                    userId: ref.read(authProvider).user!.id,
                    // title: titleController.text,
                    description: descriptionController.text,
                    // severity: selectedSeverity,
                  );

                  final success = await ref
                      .read(incidentsProvider.notifier)
                      .createIncident(request);

                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? 'Incidencia reportada exitosamente'
                              : 'Usted no puede reportar en esta guardia',
                        ),
                        backgroundColor: success
                            ? AppTheme.successGreen
                            : AppTheme.errorRed,
                      ),
                    );
                  }
                }
              },
              child: const Text('Reportar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditIncidentDialog(Incident incident) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final descriptionController = TextEditingController(
      text: incident.description,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Incidencia'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: descriptionController,
              label: 'Descripción',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (descriptionController.text.isNotEmpty) {
                Navigator.pop(context);
                final request = UpdateIncidentRequest(
                  description: descriptionController.text,
                );
                final success = await ref
                    .read(incidentsProvider.notifier)
                    .updateIncident(incident.id, request);

                if (mounted) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Incidencia actualizada correctamente'
                            : 'Error al actualizar la incidencia',
                      ),
                      backgroundColor: success
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                    ),
                  );
                }
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteIncidentDialog(Incident incident) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Incidencia'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar esta incidencia?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              String? errorMsg;
              try {
                final success = await ref
                    .read(incidentsProvider.notifier)
                    .deleteIncident(incident.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Incidencia eliminada correctamente'
                            : (ref.read(incidentsProvider).error ??
                                  'Error al eliminar incidencia'),
                      ),
                      backgroundColor: success
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                    ),
                  );
                }
              } catch (e) {
                errorMsg = e.toString();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMsg),
                      backgroundColor: AppTheme.errorRed,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'alta':
        return AppTheme.errorRed;
      case 'media':
        return AppTheme.warningOrange;
      case 'baja':
        return AppTheme.successGreen;
      default:
        return Colors.grey;
    }
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity) {
      case 'alta':
        return Icons.error;
      case 'media':
        return Icons.warning;
      case 'baja':
        return Icons.info;
      default:
        return Icons.help;
    }
  }

  String _getSeverityText(String severity) {
    switch (severity) {
      case 'alta':
        return 'ALTA';
      case 'media':
        return 'MEDIA';
      case 'baja':
        return 'BAJA';
      default:
        return 'N/A';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
