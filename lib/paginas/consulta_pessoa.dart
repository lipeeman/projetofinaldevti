import 'package:flutter/material.dart';
import 'package:front_back_api/api/acesso_api.dart';
import 'package:front_back_api/model/pessoa.dart';
import 'package:front_back_api/util/combo_cidade_busca.dart';
import 'package:front_back_api/util/componentes.dart';
import 'package:front_back_api/util/drawer_left.dart';

class ConsultaPessoa extends StatefulWidget {
  const ConsultaPessoa({Key? key}) : super(key: key);

  @override
  State<ConsultaPessoa> createState() => _ConsultaPessoaState();
}

class _ConsultaPessoaState extends State<ConsultaPessoa> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtBusca = TextEditingController();
  List<Pessoa> listaPessoas = [];

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listarTodas() async {
      List<Pessoa> pessoas = await AcessoApi().listaPessoas();
      setState(() {
        listaPessoas = pessoas;
      });
    }

    findByCity() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Filtrar por Cidade'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
          ),
          content: ComboCidadeBusca(
            controller: txtBusca,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                List<Pessoa> pessoasPorCidade = await AcessoApi()
                    .filterForCityName(int.parse(txtBusca.text));

                setState(() {
                  listaPessoas = pessoasPorCidade;
                });
                Navigator.pop(context, 'Buscar');
              },
              child: const Text('Buscar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      );
    }

    @override
    void initState() {
      setState(() {
        findByCity();
      });

      super.initState();
    }

    return Scaffold(
      drawer: MenuLeft().DrawerCreate(context),
      appBar: Componentes().criaAppBar("Consulta de Pessoas", home),
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
        child: Form(
          key: formController,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Componentes().criaBotao(formController, listarTodas,
                        'Listar clientes cadastrados'),
                  ),
                  Expanded(
                      flex: 1,
                      child: Componentes()
                          .buttonRefresh(formController, findByCity)),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: listaPessoas.length,
                    itemBuilder: (context, indice) {
                      return Card(
                        elevation: 6,
                        child: ListTile(
                          title: Componentes()
                              .criaItemPessoa(listaPessoas[indice]),
                          trailing: Container(
                            width: 100,
                            child: Row(children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/cadastro_pessoa",
                                    arguments: listaPessoas[indice],
                                  );
                                },
                                color: Colors.green,
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                  color: Colors.red,
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await AcessoApi().deletaPessoaPorID(
                                        listaPessoas[indice].id);
                                    setState(() {
                                      listarTodas();
                                    });
                                  }),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
