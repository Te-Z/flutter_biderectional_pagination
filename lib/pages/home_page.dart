import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_biderectional_pagination/data/entities/character_entity.dart';
import 'package:flutter_biderectional_pagination/domain/useCase/get_character.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum Direction {
  backward,
  forward,
}

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Key downListKey = UniqueKey();
  static const _pageSize = 20;
  static const firstPageKey = 20;

  final PagingController<int, Character> _pagingReplyUpController =
      PagingController(
    firstPageKey: firstPageKey,
  );
  final PagingController<int, Character> _pagingReplyDownController =
      PagingController(
    firstPageKey: firstPageKey,
  );

  Future<void> _fetchUpPage(int pageKey) async => _fetchPage(
        controller: _pagingReplyUpController,
        pageKey: pageKey,
        direction: Direction.backward,
      );

  Future<void> _fetchDownPage(int pageKey) async => _fetchPage(
        controller: _pagingReplyDownController,
        pageKey: pageKey,
        direction: Direction.forward,
      );

  Future<void> _fetchPage({
    required int pageKey,
    required PagingController<int, Character> controller,
    required Direction direction,
  }) async {
    try {
      final newItems = await GetCharater()(pageKey);

      final isLastPage = pageKey == 0 || newItems.length < _pageSize;
      if (isLastPage) {
        controller.appendLastPage(newItems);
      } else {
        final nextPageKey =
            direction == Direction.forward ? pageKey + 1 : pageKey - 1;
        controller.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      controller.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingReplyUpController.addPageRequestListener((pageKey) {
      _fetchUpPage(pageKey);
    });

    _pagingReplyDownController.addPageRequestListener((pageKey) {
      _fetchDownPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollable(
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            offset: position,
            center: downListKey,
            axisDirection: AxisDirection.up,
            slivers: [
              PagedSliverList(
                pagingController: _pagingReplyUpController,
                builderDelegate: PagedChildBuilderDelegate<Character>(
                  itemBuilder: (context, characterUp, index) => SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Text(characterUp.name),
                  ),
                ),
              ),
              PagedSliverList(
                key: downListKey,
                pagingController: _pagingReplyDownController,
                builderDelegate: PagedChildBuilderDelegate<Character>(
                  itemBuilder: (context, characterDown, index) => SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Text(characterDown.name),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}
