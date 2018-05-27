import 'package:catbox/models/cat.dart';
import 'package:flutter/material.dart';
import 'package:catbox/ui/cat_details/footer/showcase_catttributes.dart';
import 'package:catbox/ui/cat_details/footer/showcase_details.dart';
import 'package:catbox/ui/cat_details/footer/showcase_pictures.dart';

class CatShowCase extends StatefulWidget {
  final Cat cat;

  CatShowCase(this.cat);

  @override
  State<StatefulWidget> createState() => new _CatShowCaseState();
}

class _CatShowCaseState extends State<CatShowCase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();

    _tabs = [
      new Tab(
        text: 'Fotos',
      ),
      new Tab(
        text: 'Detalhes',
      ),
      new Tab(
        text: 'Atributos',
      ),
    ];

    _pages = [
      new PictureShowCase(widget.cat),
      new DetailsShowCase(widget.cat),
      new CattributesShowCase(widget.cat)
    ];

    _controller = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new TabBar(
            tabs: _tabs,
            controller: _controller,
            indicatorColor: Colors.white,),
          new SizedBox.fromSize(
              size: const Size.fromHeight(300.0),
              child: new TabBarView(
                  controller: _controller,
                  children: _pages
              )
          )
        ],
      ),
    );
  }
}
