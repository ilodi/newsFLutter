import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_mode.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/thema.dart';
import 'package:newsapp/src/widgets/list_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //conectar provider
    final newsServices = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          _ListaCategorias(),
          Expanded(
            child:
                ListaNoticias(newsServices.getArticulosCategoriaSeleccionada),
          ),
        ]),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //conectar a provider
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        //que se vea igual en ios y andorid
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final categoryName = categories[index].name;
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButtom(categories[index]),
                SizedBox(height: 5),
                Text(
                    '${categoryName[0].toUpperCase()}${categoryName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButtom extends StatelessWidget {
  final Category categoria;

  const _CategoryButtom(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //para que no se redibuje es mejor usar listen en false
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
