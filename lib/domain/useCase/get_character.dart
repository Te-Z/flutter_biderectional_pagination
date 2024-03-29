import 'package:flutter_biderectional_pagination/data/entities/character_entity.dart';
import 'package:flutter_biderectional_pagination/data/network/character.api.dart';
import 'package:flutter_biderectional_pagination/di/di_initializer.dart';

class GetCharater {
  final _api = getIt.get<CharacterApi>();

  Future<List<Character>> call(int page) async {
    final characterPagination = await _api.getCharacters(page: page);
    return characterPagination.results;
  }
}
