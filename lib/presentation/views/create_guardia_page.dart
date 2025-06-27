import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/config/router/router.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/data/datasources/models/guardia_model.dart';
import 'package:maikol_tesis/presentation/providers/guardias/guardias_provider.dart';
import 'package:maikol_tesis/presentation/providers/users/users_provider.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_button.dart';

class CreateGuardiaPage extends ConsumerStatefulWidget {
  const CreateGuardiaPage({super.key});

  @override
  ConsumerState<CreateGuardiaPage> createState() => _CreateGuardiaPageState();
}

class _CreateGuardiaPageState extends ConsumerState<CreateGuardiaPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now();

  final List<int> _selectedUserIds = [];

  @override
  void initState() {
    super.initState();
    // Cargar usuarios al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final guardiasState = ref.watch(guardiasProvider);
    final usersState = ref.watch(usersProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Crear Guardia'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.go(AppRouter.guardias),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryBlue, AppTheme.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.security, size: 48, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        'Nueva Guardia',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Asignar guardia a usuarios',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: Container(
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
                      const Text(
                        'Información de la Guardia',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Fecha y hora de inicio
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fecha de Inicio *',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () => _selectStartDate(),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hora de Inicio *',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () => _selectStartTime(),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 20),
                                        const SizedBox(width: 8),
                                        Text(_startTime.format(context)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Fecha y hora de fin
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fecha de Fin *',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () => _selectEndDate(),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hora de Fin *',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () => _selectEndTime(),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 20),
                                        const SizedBox(width: 8),
                                        Text(_endTime.format(context)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Selección de usuarios
                      const Text(
                        'Seleccionar Usuarios *',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 8),

                      if (usersState.isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (usersState.error != null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Error al cargar usuarios',
                                  style: TextStyle(color: Colors.red[700]),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => ref
                                      .read(usersProvider.notifier)
                                      .loadUsers(),
                                  child: const Text('Reintentar'),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (usersState.users.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('No hay usuarios disponibles'),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: usersState.users.length,
                            itemBuilder: (context, index) {
                              final user = usersState.users[index];
                              final isSelected = _selectedUserIds.contains(
                                user.id,
                              );

                              return CheckboxListTile(
                                title: Text(user.fullName),
                                subtitle: Text(user.email ?? ''),
                                value: isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedUserIds.add(user.id);
                                    } else {
                                      _selectedUserIds.remove(user.id);
                                    }
                                  });
                                },
                                secondary: CircleAvatar(
                                  backgroundColor: AppTheme.primaryBlue,
                                  child: Text(
                                    user.firstName
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                        '',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                child: CustomButton(
                  text: 'Crear Guardia',
                  onPressed: guardiasState.isLoading
                      ? null
                      : _handleCreateGuardia,
                  isLoading: guardiasState.isLoading,
                  icon: Icons.security,
                ),
              ),

              const SizedBox(height: 16),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 500),
                child: OutlinedButton(
                  onPressed: () => context.go(AppRouter.guardias),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryBlue,
                    side: const BorderSide(color: AppTheme.primaryBlue),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _startDate = date;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (time != null) {
      setState(() {
        _startTime = time;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _endDate = date;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final time = await showTimePicker(context: context, initialTime: _endTime);
    if (time != null) {
      setState(() {
        _endTime = time;
      });
    }
  }

  Future<void> _handleCreateGuardia() async {
    if (_selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe seleccionar al menos un usuario'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    final startDateTime = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute,
    );

    final endDateTime = DateTime(
      _endDate.year,
      _endDate.month,
      _endDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    if (endDateTime.isBefore(startDateTime) ||
        endDateTime.isAtSameMomentAs(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'La fecha de fin debe ser posterior a la fecha de inicio',
          ),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    final request = CreateGuardiaRequest(
      startTime: startDateTime,
      endTime: endDateTime,
      usersId: _selectedUserIds,
    );

    final success = await ref
        .read(guardiasProvider.notifier)
        .createGuardia(request);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Guardia creada exitosamente'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
      context.go(AppRouter.guardias);
    } else if (mounted) {
      final error = ref.read(guardiasProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al crear la guardia'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
    }
  }
}
