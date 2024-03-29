import 'package:dio/dio.dart';
import 'package:flutter_biderectional_pagination/data/entities/character_entity.dart';
import 'package:flutter_biderectional_pagination/di/di_initializer.dart';

class CharacterApi {
  final Dio _client = getIt.get<Dio>();

  CharacterApi();

  Future<CharacterPagination> getCharacters({required int page}) async {
    final response = await _client.get(
      "/character",
      queryParameters: {
        "page": page,
      },
    ).onError((error, stackTrace) => throw Exception(error));

    return CharacterPagination.fromJson(response.data);
  }
}
