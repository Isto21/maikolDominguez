import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/config/router/router.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/presentation/providers/auth/auth_provider.dart';
import 'package:maikol_tesis/presentation/widgets/shared/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ActivationPage extends ConsumerStatefulWidget {
  final String email;

  const ActivationPage({super.key, required this.email});

  @override
  ConsumerState<ActivationPage> createState() => _ActivationPageState();
}

class _ActivationPageState extends ConsumerState<ActivationPage> {
  final _formKey = GlobalKey<FormState>();
  final _activationCodeController = TextEditingController();
  bool _isActivating = false;
  String _currentText = "";

  @override
  void dispose() {
    _activationCodeController.dispose();
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
                  const SizedBox(height: 60),

                  // Logo y título
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.verified_user,
                            size: 50,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Activar Cuenta',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ingresa el código de verificación',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Formulario de activación
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
                          Text(
                            'Hemos enviado un código de verificación a:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 8),

                          Text(
                            widget.email,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 32),

                          // Campo de código de verificación
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(12),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              activeColor: AppTheme.primaryBlue,
                              inactiveColor: Colors.grey[300],
                              selectedColor: AppTheme.primaryBlue,
                            ),
                            animationDuration: const Duration(
                              milliseconds: 300,
                            ),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            controller: _activationCodeController,
                            onCompleted: (v) {
                              // Auto-submit cuando se completa
                              if (!_isActivating) {
                                _handleActivation();
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              // Validar que solo sean números
                              if (text != null) {
                                return text.length == 6 &&
                                    RegExp(r'^[0-9]+$').hasMatch(text);
                              }
                              return false;
                            },
                            keyboardType: TextInputType.number,
                            enabled: !_isActivating,
                          ),

                          const SizedBox(height: 32),

                          CustomButton(
                            text: 'Verificar Código',
                            onPressed: _isActivating || _currentText.length < 6
                                ? null
                                : _handleActivation,
                            isLoading: _isActivating,
                          ),

                          const SizedBox(height: 16),

                          TextButton(
                            onPressed: _isActivating
                                ? null
                                : () {
                                    // Aquí iría la lógica para reenviar el código
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Código reenviado. Revisa tu correo.',
                                        ),
                                        backgroundColor: AppTheme.successGreen,
                                      ),
                                    );
                                  },
                            child: const Text(
                              '¿No recibiste el código? Reenviar',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextButton(
                            onPressed: _isActivating
                                ? null
                                : () => context.go(AppRouter.login),
                            child: const Text(
                              'Volver al inicio de sesión',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
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

  Future<void> _handleActivation() async {
    if (_activationCodeController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa el código de 6 dígitos'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _isActivating = true;
    });

    try {
      final success = await ref
          .read(authProvider.notifier)
          .activateAccount(widget.email, _activationCodeController.text);

      if (mounted) {
        if (success) {
          // Activación exitosa - navegar al home
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Cuenta activada exitosamente!'),
              backgroundColor: AppTheme.successGreen,
            ),
          );
          context.go(AppRouter.login);
        } else {
          // Activación falló
          final authState = ref.read(authProvider);
          if (authState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authState.error!),
                backgroundColor: AppTheme.errorRed,
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
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isActivating = false;
        });
      }
    }
  }
}
