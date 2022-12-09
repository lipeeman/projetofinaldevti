import 'package:flutter/material.dart';
import 'package:front_back_api/api/acesso_api.dart';
import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/util/componentes.dart';
import 'package:front_back_api/util/drawer_left.dart';

class CadastroCidade extends StatefulWidget {
  const CadastroCidade({super.key});

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf;

    cadastrarcidade() async {
      Cidade c = Cidade(0, txtNome.text, txtUf.text);
      if (args.id == 0) {
        await AcessoApi().insereCidade(c.toJson());
      } else {
        await AcessoApi().alteraCidade(c.toJson(), args.id);
      }
      Navigator.of(context).pushNamed('/consulta_cidade');
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar("Cadastro Cidade", home),
      drawer: MenuLeft().DrawerCreate(context),
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
        child: Form(
          key: formController,
          child: Column(
            children: [
              Componentes().criaInputTexto(TextInputType.text, "Nome", txtNome,
                  "Informe o nome da cidade"),
              Componentes().criaInputTexto(
                  TextInputType.text, "Uf", txtUf, "Informe a uf da cidade"),
              Componentes()
                  .criaBotao(formController, cadastrarcidade, "Cadastrar")
            ],
          ),
        ),
      ),
    );
  }
}
