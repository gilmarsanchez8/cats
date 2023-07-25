import 'package:demo_cats/model/cat.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/catProvider.provider.dart';

class CatsWidget extends StatefulWidget {
  @override
  State<CatsWidget> createState() => _CatsWidgetState();
}

class _CatsWidgetState extends State<CatsWidget> {
  final textController = TextEditingController();
  late BuildContext _context;
  late CatProvider _catProvider;
  late Size _size;
  final _controller = ScrollController();
  List<Cat>? informationCats = [];
  String dataFilter = '';
  @override
  Widget build(BuildContext context) {
    _catProvider = Provider.of<CatProvider>(context);
    informationCats = _catProvider.cats;
    _size = MediaQuery.of(context).size;
    _context = context;
    if (informationCats == null) {
      return _getInformationCats();
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _search(),
              _showCards(informationCats!),
            ],
          )
        ],
      );
    }
  }

  Widget _showCards(List<Cat> informationCats) {
    if (dataFilter.isNotEmpty) {
      final textFilter = dataFilter.toLowerCase();

      informationCats = informationCats.where(
        (cat) {
          return cat.name.toLowerCase().contains(textFilter);
        },
      ).toList();
    }

    return Column(
      children: [
        SizedBox(
          height: _size.height * 1,
          child: ListView.builder(
            controller: _controller,
            itemCount: informationCats.length,
            itemBuilder: (_, index) {
              return _createCard(informationCats[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _createCard(Cat informationCat) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Breed: ${informationCat.name}"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        _context,
                        "/catDetails",
                        arguments: {'informationCat': informationCat},
                      );
                    },
                    child: const Text('Más...')),
              ],
            ),
            informationCat.urlImage != "" ? Image(
              image: NetworkImage(
                informationCat.urlImage.toString(),
              ),
              width: 300,
              height: 300,
            ) : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Origin: ${informationCat.origin}"),
                Text("Intelligence: ${informationCat.intelligence.toString()}"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: _size.width * 0.8,
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Search by breed',
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey[300] as Color, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey[200] as Color, width: 2),
          ),
        ),
        onChanged: (value) => setState(() => dataFilter = value),
      ),
    );
  }

  Widget _getInformationCats() {
    _catProvider.getCats();
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: _size.height * 0.2,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
