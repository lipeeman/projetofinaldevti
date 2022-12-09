import 'package:flutter/material.dart';
import 'package:front_back_api/api/acesso_api.dart';
import 'package:front_back_api/model/cidade.dart';

class ComboCidadeBusca extends StatefulWidget {
  TextEditingController? controller;
  ComboCidadeBusca({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboCidadeBusca> createState() => _ComboCidadeBuscaState();
}

class _ComboCidadeBuscaState extends State<ComboCidadeBusca> {
  int? cidadesel;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 500))
          .then((value) => AcessoApi().listaCidades()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Cidade> cidades = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton(
              isExpanded: true,
              value: cidadesel,
              icon: const Icon(Icons.arrow_downward),
              hint: const Text('Selecione uma cidade....'),
              elevation: 16,
              onChanged: (int? value) {
                setState(() {
                  cidadesel = value;
                  widget.controller?.text = "$value";
                });
              },
              items: cidades.map<DropdownMenuItem<int>>((Cidade cid) {
                return DropdownMenuItem<int>(
                    value: cid.id, child: Text("${cid.nome}/${cid.uf}"));
              }).toList(),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Carregando Cidades'),
            ],
          );
        }
      },
    );
  }
}
