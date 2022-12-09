import 'package:flutter/material.dart';
import 'package:front_back_api/api/acesso_api.dart';
import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/model/pessoa.dart';
import 'package:front_back_api/util/combo_cidade.dart';
import 'package:front_back_api/util/componentes.dart';
import 'package:front_back_api/util/drawer_left.dart';
import 'package:front_back_api/util/radio_sexo.dart';

class CadastroPessoa extends StatefulWidget {
  const CadastroPessoa({Key? key}) : super(key: key);

  @override
  State<CadastroPessoa> createState() => _CadastroPessoaState();
}

class _CadastroPessoaState extends State<CadastroPessoa> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: 'M');
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Pessoa;
    txtNome.text = args.nome;
    txtSexo.text = args.sexo;
    txtIdade.text = args.idade == 0 ? '' : args.idade.toString();
    txtCidade.text = args.cidade.id.toString();

    salvar() {
      Pessoa p = Pessoa(0, txtNome.text, txtSexo.text, int.parse(txtIdade.text),
          Cidade(int.parse(txtCidade.text), "", ""));
      AcessoApi().inserePessoa(p.toJson());
      Navigator.of(context).pushReplacementNamed('/home',
          arguments: Pessoa(0, '', 'M', 0, Cidade(0, '', '')));
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      drawer: MenuLeft().DrawerCreate(context),
      appBar: Componentes().criaAppBar("Formulário Pessoa", home),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
        child: Form(
          key: formController,
          child: Column(
            children: [
              Componentes().iconCadPessoa(),
              Componentes().criaInputTexto(
                  TextInputType.text, "Nome", txtNome, "Informe o nome"),
              Componentes().criaInputTexto(
                  TextInputType.number, "Idade", txtIdade, "Informe a idade"),
              Center(child: RadioSexo(controller: txtSexo)),
              Center(child: ComboCidade(controller: txtCidade)),
              Componentes().criaBotao(formController, salvar, "Salvar"),
            ],
          ),
        ),
      ),
    );
  }
}
