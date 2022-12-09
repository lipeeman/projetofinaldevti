import 'dart:convert';

import 'package:front_back_api/model/cidade.dart';
import 'package:front_back_api/model/pessoa.dart';
import 'package:http/http.dart';

class AcessoApi {
  Future<List<Pessoa>> listaPessoas() async {
    String url = "http://localhost:8080/cliente";
    //String url = 'http://54.196.166.129:8080/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = 'http://localhost:8080/cidade';
    //String url = 'http://54.196.166.129:8080/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<void> inserePessoa(Map<String, dynamic> pessoa) async {
    String url = 'http://localhost:8080/cliente';
    //String url = 'http://54.196.166.129:8080/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> alteraPessoa(Map<String, dynamic> pessoa, int id) async {
    String url = 'http://localhost:8080/cliente?id=$id';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade, int id) async {
    String url = 'http://localhost:8080/cidade?id=$id';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> deletaPessoaPorID(int id) async {
    String url = 'http://localhost:8080/cliente/$id';
    Response resposta = await delete(Uri.parse(url));
  }

  Future<void> deletaCidadePorID(int id) async {
    String url = 'http://localhost:8080/cidade/$id';
    await delete(Uri.parse(url));
  }

  Future<List<Cidade>> buscaPorUf(String uf) async {
    String url = 'http://localhost:8080/cidade/buscaruf/$uf';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<List<Pessoa>> filterForCityName(int id) async {
    String url = 'http://localhost:8080/cliente/buscacidade/$id';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((c) => Pessoa.fromJson(c)));
    return pessoas;
  }
}
