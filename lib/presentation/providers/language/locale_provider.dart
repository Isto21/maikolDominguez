// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:ui';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:maikol_tesis/domain/repositories/local/local_repository.dart';
// import 'package:maikol_tesis/l10n/l10n.dart';
// import 'package:maikol_tesis/presentation/providers/data/local_data_provider.riverpod.dart';

// final localeProvider = StateNotifierProvider<LocaleNotifier, LocaleState>((
//   ref,
// ) {
//   return LocaleNotifier(ref.watch(localDataProvider));
// });

// class LocaleNotifier extends StateNotifier<LocaleState> {
//   LocalRepository localRepository;

//   LocaleNotifier(this.localRepository) : super(LocaleState());

//   void setLocale(String locale) {
//     if (!L10n.all.contains(Locale(locale))) return;
//     state = state.copyWith(locale: Locale(locale));
//     localRepository.saveLanguage(locale);
//   }
// }

// class LocaleState {
//   /*
//   Si se deja null la aplicación toma el idioma por defecto del sistema
//   */

//   final Locale locale;
//   LocaleState({this.locale = const Locale("es")});

//   LocaleState copyWith({Locale? locale}) {
//     return LocaleState(locale: locale ?? this.locale);
//   }
// }
