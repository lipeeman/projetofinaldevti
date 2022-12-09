import 'package:flutter/material.dart';
import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/model/pessoa.dart';
import 'package:front_back_api/paginas/cadastro_cidade.dart';
import 'package:front_back_api/paginas/consulta_cidade.dart';
import 'package:front_back_api/paginas/consulta_pessoa.dart';
import 'package:front_back_api/util/componentes.dart';
import 'package:front_back_api/util/drawer_left.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastroPessoa() {
      Navigator.of(context).pushReplacementNamed('/cadastro_pessoa',
          arguments: Pessoa(0, '', 'M', 0, Cidade(0, '', '')));
    }

    consultaPessoa() {
      Navigator.of(context).pushReplacementNamed('/consulta_pessoa');
    }

    cadastroCidade() {
      Navigator.of(context).pushReplacementNamed('/cadastro_cidade',
          arguments: Cidade(0, "", ""));
    }

    consultaCidades() {
      Navigator.of(context).pushReplacementNamed('/consulta_cidade');
    }

    return Scaffold(
      drawer: MenuLeft().DrawerCreate(context),
      appBar: Componentes().criaAppBar("Seja Bem-Vindo", home),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
        child: Form(
            key: formController,
            child: Column(
              children: [
                Componentes().iconHomepage(),
                Componentes().criaBotao(
                    formController, cadastroPessoa, "Cadastro Pessoa"),
                Componentes().criaBotao(
                    formController, consultaPessoa, "Consulta Pessoa"),
                Componentes().criaBotao(
                    formController, cadastroCidade, "Cadastro Cidade"),
                Componentes().criaBotao(
                    formController, consultaCidades, "Consulta Cidade"),
              ],
            )),
      ),
    );
  }
}
