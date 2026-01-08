import 'package:flutter/material.dart';
import 'package:news/core/environment/environment.dart';
import 'package:news/core/model/news.dart';
import 'package:news/core/model/user.dart';
import 'package:news/core/services/auth/auth_service.dart';
import 'package:news/core/services/http/http_service.dart';
import 'package:news/core/widgets/card/card_widget.dart';
import 'package:news/core/widgets/menu/menu_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;
  String selectedCategory = 'general';
  final http = HttpService();

  void _loadData() async {
    final result = await AuthService.getUser();
    setState(() {
      user = result;
    });
  }

  void changeCategory(String category) {
    if (category == selectedCategory) {
      return;
    }
    setState(() {
      selectedCategory = category;
    });
  }

  void goToProfile() {}

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: goToProfile,
            icon: Icon(Icons.account_circle_rounded, size: 40),
          ),
        ],
      ),
      drawer: MenuWidget(
        name: user.name,
        onSelectCategory: (category) => changeCategory(category),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'News about $selectedCategory',
              style: TextStyle(fontSize: 26, fontFamily: 'serif'),
            ),
          ),
          FutureBuilder(
            future: http.get<News>(
              '${Environment.newsUrl.value}&category=$selectedCategory',
              (json) => News.fromJson(json),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error al consumir la api');
              }

              final data = snapshot.data;

              return Expanded(
                child: ListView.builder(
                  itemCount: data!.articles.length,
                  itemBuilder: (context, index) {
                    var news = data.articles[index];
                    return CardWidget(
                      author: news.author,
                      description: news.description,
                      publishedAt: news.publishedAt,
                      title: news.title,
                      urlToImage: news.urlToImage,
                      url: news.url,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
