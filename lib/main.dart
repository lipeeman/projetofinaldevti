import 'package:flutter/material.dart';
import 'package:front_back_api/paginas/cadastro_cidade.dart';
import 'package:front_back_api/paginas/cadastro_pessoa.dart';
import 'package:front_back_api/paginas/consulta_pessoa.dart';
import 'package:front_back_api/paginas/consulta_cidade.dart';
import 'package:front_back_api/paginas/home.dart';
import 'package:front_back_api/util/tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema().criaTema(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/consulta_pessoa': (context) => const ConsultaPessoa(),
        '/cadastro_pessoa': (context) => const CadastroPessoa(),
        '/cadastro_cidade': (context) => const CadastroCidade(),
        '/consulta_cidade': (context) => const ConsultaCidades(),
      },
    );
  }
}
