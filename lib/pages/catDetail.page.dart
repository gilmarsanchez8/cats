import 'package:demo_cats/model/cat.model.dart';
import 'package:flutter/material.dart';

class CatDetailPage extends StatefulWidget {
  @override
  State<CatDetailPage> createState() => _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage> {
  late Size _size;
  late Cat _catItem;
  final ScrollController _controllerServices = ScrollController();
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    final params =
        ModalRoute.of(context)?.settings.arguments as Map<String, Cat>;
    _catItem = params["informationCat"]!;
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: <Widget>[
          _content(),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      title: const Text(
        "Details",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      elevation: 2,
    );
  }

  Widget _content() {
    return Column(
      children: [
        _image(),
        const SizedBox(height: 10),
        _information(),
      ],
    );
  }

  Widget _image() {
    return _catItem.referenceImageId != ""
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _catItem.urlImage != "" ? Image(
              image: NetworkImage(
                _catItem.urlImage.toString(),
              ),
            ) : Container(),
            ),
          )
        : Container();
  }

  Widget _information() {
    return Scrollbar(
      thickness: 6,
      radius: const Radius.circular(10),
      controller: _controllerServices,
      thumbVisibility: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        alignment: AlignmentDirectional.topStart,
        padding: const EdgeInsets.all(20),
        height: _size.height * 0.15,
        width: _size.width * 0.7,
        child: SingleChildScrollView(
          controller: _controllerServices,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Description: ${_catItem.description}"),
              Text("Origin: ${_catItem.origin}"),
              Text("Intelligence: ${_catItem.intelligence.toString()}"),
              Text("Adaptability: ${_catItem.adaptability.toString()}"),
              Text("Life span: ${_catItem.lifeSpan}")
            ],
          ),
        ),
      ),
    );
  }
}
