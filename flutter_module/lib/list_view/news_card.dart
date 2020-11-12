
import 'package:flutter/cupertino.dart';

class NewsViewModel{
  final String title;
  final String source;
  final int comments;
  final String coverImgUrl;

  const NewsViewModel({
    this.title,
    this.source,
    this.comments,
    this.coverImgUrl,
  });
}

class NewsCard extends StatelessWidget {
  final NewsViewModel data;

  const NewsCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 3)),
                  Row(
                    children: <Widget>[
                      Text(
                        '${this.data.source} ${this.data.comments} 评论',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF666666),                        ),
                      ),
                    ],
                  ),
                ],
          )),
          Padding(padding: EdgeInsets.only(top: 3)),
          Image.network(
            data.coverImgUrl,
            width: 100,
            height: 60,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}