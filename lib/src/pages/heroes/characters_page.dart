import 'package:dio_app_flutter/src/model/marvel/characters_model.dart';
import 'package:dio_app_flutter/src/repositories/marvel/marvel_repository.dart';
import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ScrollController _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();
  int offset = 0;
  var carregando = false;
  var carregamentoInicial = false;

  carregarDados() async {
    if (carregando) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        carregando = true;
      });
      offset = offset + characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }
    setState(() {});
  }

  int retornaQuantidadeTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (posicaoParaPaginar > _scrollController.position.pixels) {
        carregarDados();
      }
      debugPrint(_scrollController.position.pixels.toString());
    });
    super.initState();
    marvelRepository = MarvelRepository();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Herois: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}'),
        ),
        body: (characters.data == null || characters.data!.results == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: (characters.data == null ||
                              characters.data!.results == null)
                          ? 0
                          : characters.data!.results!.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        var character = characters.data!.results![index];
                        return Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                                width: 150,
                                height: 150,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        character.name!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(character.description!),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  !carregando
                      ? TextButton(
                          onPressed: () {
                            carregarDados();
                          },
                          child: const Text('Carregar mais itens'),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
      ),
    );
  }
}
