import 'package:flutter/material.dart';
import 'package:front_back_api/api/acesso_api.dart';
import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/util/componentes.dart';
import 'package:front_back_api/util/drawer_left.dart';

class ConsultaCidades extends StatefulWidget {
  const ConsultaCidades({Key? key}) : super(key: key);

  @override
  State<ConsultaCidades> createState() => _ConsultaCidadesState();
}

class _ConsultaCidadesState extends State<ConsultaCidades> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtBusca = TextEditingController();

  List<Cidade> listaCidades = [];

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listarTodasCidades() async {
      List<Cidade> cidades = await AcessoApi().listaCidades();
      setState(() {
        listaCidades = cidades;
      });
    }

    Sair() {
      Navigator.of(context).pushReplacementNamed('/consulta_cidade');
    }

    findByUf() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Filtrar por UF'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
          ),
          content: Componentes().criaInputTexto(TextInputType.text,
              'Informe seu filtro', txtBusca, 'Informe seu filtro'),
          contentPadding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                List<Cidade> cidadesuf =
                    await AcessoApi().buscaPorUf(txtBusca.text);

                setState(() {
                  listaCidades = cidadesuf;
                });
                Navigator.pop(context, 'uf');
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
        findByUf();
      });

      super.initState();
    }

    return Scaffold(
      drawer: MenuLeft().DrawerCreate(context),
      appBar: Componentes().criaAppBar("Consulta de Cidades", home),
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
                    child: Componentes().criaBotao(formController,
                        listarTodasCidades, 'Listar cidades cadastrados'),
                  ),
                  Expanded(
                      flex: 1,
                      child: Componentes()
                          .buttonRefresh(formController, findByUf)),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: listaCidades.length,
                    itemBuilder: (context, indice) {
                      return Card(
                        elevation: 9,
                        child: ListTile(
                          title: Componentes()
                              .criaItemCidade(listaCidades[indice]),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/cadastro_cidade",
                                      arguments: listaCidades[indice],
                                    );
                                  },
                                  color: Colors.green,
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Deseja realmente excluir'),
                                              content: const Text(
                                                  'essa ação não pode ser revertida'),
                                              actions: [
                                                TextButton(
                                                    child: const Text('Sim'),
                                                    onPressed: () async {
                                                      await AcessoApi()
                                                          .deletaCidadePorID(
                                                              listaCidades[
                                                                      indice]
                                                                  .id);
                                                      setState(() {
                                                        listarTodasCidades();
                                                      });
                                                    }),
                                                TextButton(
                                                    child: const Text('Não'),
                                                    onPressed: () => {
                                                          Navigator.pop(context)
                                                        })
                                              ],
                                            ));
                                  },
                                ),
                              ],
                            ),
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
