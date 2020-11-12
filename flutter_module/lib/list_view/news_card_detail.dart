
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'news_card.dart';

// class NewsCardDetail extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Scaffold(
//       appBar:AppBar(
//         title: new Text('Detail')
//       ),
//       body: new Center (
//         child:
//         Text(
//         'news Detail',
//         style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Color(0xff333333),
//         ),
//       ),
//       )
//     );
//   }
// }


class NewsCardDetail extends StatefulWidget {
  // 通过构造方法来传值
  NewsViewModel model;
  NewsCardDetail({this.model});

  @override
  _NewsCardDetailState createState() => _NewsCardDetailState(model: model);
}

class _NewsCardDetailState extends State<NewsCardDetail> {
  NewsViewModel model;
  _NewsCardDetailState({this.model});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar:AppBar(
            title: new Text('Detail')
        ),
        body: new Column (
          // crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Image.network(this.model.coverImgUrl),
            Padding(padding: EdgeInsets.only(top: 3)),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'news: ${this.model.title}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff333333),
                ),
              ),
            ),
            Text(
              'this is Test',
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                icon: Icon(Icons.text_fields),
                labelText: "请输入你的昵称",
                helperText: "输入的昵称不支持特殊字符"
              ),
              onChanged: _textFiledChangeMethod,
            ),
          ],
        ),
    );
  }

  void _textFiledChangeMethod(String str) {
    print(str);
  }

}

