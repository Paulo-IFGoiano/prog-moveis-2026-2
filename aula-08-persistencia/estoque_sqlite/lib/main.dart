// ============================================================
// Estoque de Insumos — CRUD com SQLite (arquitetura em camadas)
// Programação para Dispositivos Móveis · IF Goiano — Campus Ceres
//
//   telas  ->  repository  ->  data (DAO -> AppDatabase)  ->  model
//
// O main() liga o SQLite no desktop (Linux/Windows/macOS) via FFI.
// No Android/iOS o sqflite nativo é usado automaticamente.
// ============================================================

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'telas/tela_produtos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const EstoqueApp());
}

class EstoqueApp extends StatelessWidget {
  const EstoqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estoque de Insumos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5631)),
        useMaterial3: true,
      ),
      home: const TelaProdutos(),
    );
  }
}
