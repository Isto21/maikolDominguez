import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maikol_tesis/config/constants/consts.dart';
import 'package:maikol_tesis/config/router/router.dart';
import 'package:maikol_tesis/config/theme/app_theme.dart';
import 'package:maikol_tesis/generated/l10n.dart';
import 'package:maikol_tesis/l10n/l10n.dart';
import 'package:maikol_tesis/presentation/providers/providers.dart';

//* cambio de idioma
//? Nota: este archivo se genera luego de compilar
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
Instalar en dependencias
animate_do, dio, flutter_riverpod, go_router, intl, cached_network_image

Para cambiar de lenguaje: /////////////////////////////
+En el archivo: pubspec.yaml
-Poner en dependencias
flutter_localizations:
    sdk: flutter

-Poner en flutter
  generate: true

+Crear archivo: l10n.yaml
-Copiar dentro:
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart

//////////////////////////////////////////////////

En caso de pedir permisos: permission_handler

En caso de usar map: flutter_osm_plugin

Variables de entorno: flutter_dotenv

Para isar db:
  dependencias: isar, isar_flutter_libs, path_provider
  dev dependencias: build_runner, isar_generator

Para paginar listas: fl_paging (probar)

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Prefs.instance.initPrefs();
  //para poner la apk potrait
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  //para saltarse protocolos de red
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final router = ref.read(routerProvider);
        // final locale = ref.watch(localeProvider);
        print("");
        print("");
        final brightness = ref.watch(isDarkThemeProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: ApkConsts.apkName,
          theme: AppTheme().themeLight(),
          darkTheme: AppTheme().themeDark(),
          themeMode: (brightness)
              ? ThemeMode.dark
              : (!brightness)
              ? ThemeMode.light
              : ThemeMode.system,
          routerConfig: router,

          //para el idioma
          // locale: locale.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
