import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

class PetCardViewModel {
  // 封面地址
  final String coverUrl;
  // 用户头像地址
  final String userImgUrl;
  /// 用户名
  final String userName;
  /// 用户描述
  final String description;
  /// 话题
  final String topic;
  /// 发布时间
  final String publishTime;
  /// 发布内容
  final String publishContent;
  /// 回复数量
  final int replies;
  /// 喜欢数量
  final int likes;
  /// 分享数量
  final int shares;
  const PetCardViewModel({
    this.coverUrl,
    this.userImgUrl,
    this.userName,
    this.description,
    this.topic,
    this.publishTime,
    this.publishContent,
    this.replies,
    this.likes,
    this.shares,
  });
}

class PetCard extends StatelessWidget {
  final PetCardViewModel data;
  static BuildContext APPContext;

  const PetCard({
    Key key,
    this.data,

  }) : super(key: key);

  Widget renderCover() {
    return Stack( //Stack/Positoned(绝对定位布局组件)
      fit: StackFit.passthrough,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only( // 修剪边角
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Image.network(
            data.coverUrl,
            height: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient( // 渐变色
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(80, 0, 0, 0),
                      ]
                  )
              ),
            ))
      ],
    );
  }

  Widget renderUserInfo() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFCCCCCC),
                backgroundImage: NetworkImage(data.userImgUrl),
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.userName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      decoration: TextDecoration.none,

                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF999999),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.blueGrey,
                      decorationStyle: TextDecorationStyle.solid,

                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            data.publishTime,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
              // decoration: TextDecoration.none,

            ),
          ),
        ],
      ),
    );
  }

  Widget renderPublishConent() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 14),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFFFC600),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                  '#${data.topic}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )
              )
          ),
          Text(
            data.publishContent,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color(0xFF333333),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget renderInteractionArea() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: _messageMethod,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.message,
                  size: 16,
                  color: Color(0xFF999999),
                ),
                Padding(padding: EdgeInsets.only(left: 6)),
                Text(
                  data.replies.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF999999),
                    decoration: TextDecoration.none,

                  ),
                )
              ],
            ),
          ),

          GestureDetector(
            onTap: _favoriteMethod,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  size: 16,
                  color: Color(0xFFFFC600),
                ),
                Padding(padding: EdgeInsets.only(left: 6)),
                Text(
                  data.likes.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF999999),
                    decoration: TextDecoration.none,

                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: _shareMethod,
            child:
            Row(
              children: <Widget>[
                Icon(
                  Icons.share,
                  size: 16,
                  color: Color(0xFF999999),
                ),
                Text(
                  data.shares.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF999999),
                    decoration: TextDecoration.none,

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void showToast(String text, {
  //   gravity: ToastGravity.CENTER,
  //   toastLength: Toast.LENGTH_SHORT,
  // }) {
  //   Fluttertoast.showToast(
  //     msg: text,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIos: 1,
  //     backgroundColor: Colors.grey[600],
  //     fontSize: 16.0,
  //   );
  // }

  void showLoading(BuildContext context, [String text]) {
    text = text ?? "Loading...";
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _messageMethod() {
    Toast.show(
        "查看评论",
        APPContext,
        gravity: Toast.CENTER,
    );


  }

  void _favoriteMethod() {
    Toast.show("喜欢", APPContext, gravity:Toast.CENTER);

  }

  void _shareMethod() {
    Toast.show("开始分享", APPContext, gravity:Toast.CENTER);
  }

  @override
  Widget build(BuildContext context) {
    APPContext = context;
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: Color.fromARGB(20, 0, 0, 0),

          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          this.renderCover(),
          this.renderUserInfo(),
          this.renderPublishConent(),
          this.renderInteractionArea(),
        ],
      ),
    );
  }
}