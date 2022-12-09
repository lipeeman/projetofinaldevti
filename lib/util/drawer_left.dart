import 'dart:js';

import 'package:flutter/material.dart';
import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/model/pessoa.dart';
import 'package:front_back_api/util/componentes.dart';

class MenuLeft {
  DrawerCreate(context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(4),
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: Column(children: [
                    Expanded(
                      child: Image.asset('/images/teamwork.png'),
                    ),
                  ]),
                ),
                Componentes().criaTexto("Menu Rápido")
              ],
            ),
          ),
          ListTile(
            title: const Text("Cadastrar Pessoa"),
            leading: const Icon(Icons.group_add_outlined),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/cadastro_pessoa',
                  arguments: Pessoa(0, '', 'M', 0, Cidade(0, '', '')));
            },
          ),
          ListTile(
            title: const Text("Consultar Pessoas"),
            leading: const Icon(Icons.find_in_page),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/consulta_pessoa');
            },
          ),
          ListTile(
            title: const Text("Cadastro de Cidades"),
            leading: const Icon(Icons.location_city),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/cadastro_cidade',
                  arguments: Cidade(0, "", ""));
            },
          ),
          ListTile(
            title: const Text("Consulta de Cidades"),
            leading: const Icon(Icons.find_in_page),
            onTap: () {
              Navigator.of(context).pushNamed('/consulta_cidade');
            },
          )
        ],
      ),
    );
  }
}
