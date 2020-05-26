import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_mode.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL = 'https://newsapi.org/v2';
final _APIKey = 'cb444c5acde6443898599ec4e7ca05cb';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  String _selectedCategory = 'busness';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainments'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sport'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

//
  get selectedCategory => this._selectedCategory;
//establecer
  set selectedCategory(String valor) {
//valor que estoy reciviendo

    this._selectedCategory = valor;

    this.getArticlesByCategory(valor);

    //a todos los que les interes saber cuando cambio
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = '$_URL/top-headlines?apiKey=$_APIKey&country=mx';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    //agregar al suscriptor
    this.headlines.addAll(newsResponse.articles);
    //
    notifyListeners();
  }

  //method
  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }

    final url =
        '$_URL/top-headlines?apiKey=$_APIKey&country=mx&categry=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    //
    notifyListeners();
  }
}
