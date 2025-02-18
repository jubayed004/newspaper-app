import 'package:flutter/material.dart';
import 'package:newspaper_app/model/news.dart';
import 'package:newspaper_app/services/remote_service.dart';
import 'package:newspaper_app/view/news_details.dart';

class NewsHome extends StatefulWidget {
  const NewsHome({super.key});

  @override
  State<NewsHome> createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  News? news;

  bool _isLoaded = false;

  getData() async {
    news = await RemoteServices().getNews();
    if (news != null) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Paper App"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: _isLoaded,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: news == null ? 0 : news!.articles!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => NewsDetails(news!.articles![index]))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(news!.articles![index].urlToImage ?? '',
                      height: 140,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                      return Container(
                        height: 140,
                        width: double.maxFinite,
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 5,left: 8),
                      child: Text(news!.articles![index].title ?? 'null'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4,bottom: 5,left: 8),
                      child: Text(news!.articles![index].author ?? 'null',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4,bottom: 15,left: 8),
                      child: Text(news!.articles![index].publishedAt ?? 'Nothing',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.redAccent),),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
