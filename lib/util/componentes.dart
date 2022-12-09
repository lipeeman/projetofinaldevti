import 'package:flutter/material.dart';
import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/model/pessoa.dart';

class Componentes {
  criaAppBar(texto, acao) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: criaTexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: acao,
        )
      ],
    );
  }

  criaTexto(texto, [cor]) {
    if (cor != null) {
      return Text(
        texto,
        style: TextStyle(color: cor),
      );
    }
    return Text(texto);
  }

  iconeGrande() {
    return const Icon(
      Icons.maps_home_work_outlined,
      size: 180.0,
    );
  }

  iconHomepage() {
    return Container(
      height: 160,
      width: 160,
      child: Column(children: [
        Expanded(
          child: Image.asset('/images/homepage.png'),
        ),
      ]),
    );
  }

  criaInputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: textoEtiqueta,
          labelStyle: const TextStyle(fontSize: 20),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controlador,
        validator: (value) {
          if (value!.isEmpty) {
            return msgValidacao;
          }
        },
      ),
    );
  }

  criaBotao(controladorFormulario, funcao, titulo) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                if (controladorFormulario.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  criaContainerDados(rua, complemento, bairro, cidade, estado) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: criaTexto(rua, Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  criaItemPessoa(Pessoa p) {
    String sexo = p.sexo == 'M' ? "Masculino" : "Feminino";
    return ListTile(
        title: criaTexto("${p.id} - ${p.nome}"),
        subtitle: criaTexto("${p.idade} anos - $sexo"),
        trailing: criaTexto("${p.cidade.nome} / ${p.cidade.uf}"));
  }

  criaItemCidade(Cidade c) {
    return ListTile(
      title: criaTexto("${c.id} - ${c.nome} - ${c.uf}"),
    );
  }

  iconCadPessoa() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 130,
        width: 130,
        child: Column(children: [
          Expanded(
            child: Image.asset('/images/add-user.png'),
          ),
        ]),
      ),
    );
  }

  buttonDelete(funcao) {
    return Container(
      width: 30,
      child: Row(
        children: [
          IconButton(onPressed: funcao, icon: const Icon(Icons.delete))
        ],
      ),
    );
  }

  buttonRefresh(controladorFormulario, funcao) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            height: 70,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  if (controladorFormulario.currentState!.validate()) {
                    funcao();
                  }
                },
                child: const Icon(Icons.search)),
          ),
        ),
      ],
    );
  }

  DecorPage() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
    );
  }
}
