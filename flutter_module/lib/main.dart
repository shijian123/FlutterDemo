import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/basic_widgets/mock_data.dart';

import 'basic_widgets/pet_card.dart';
import 'basic_widgets/mock_data.dart';
import 'list_view/pull_down_refreshList.dart';
import 'basic_widgets/index.dart';

/*
* BasicMessageChannel：用于传递字符串和半结构化的信息。
* MethodChannel：用于传递方法调用（method invocation）
* EventChannel: 用于数据流（event streams）的通信
* */
//com.flutterToNative 需与native的保持一致
const methodChannel = MethodChannel('com.flutterToNative');
const eventChannel = EventChannel('com.nativeToflutter');

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // home: SampleApp(),
      // data 赋值
      // home: PetCard(data: petCardData),
      home:CYHomePage(),
      // routes: {
      //   'basic_widgets': (context) => BasicWidgetsDemo()
      // },
    );
  }
}


class CYHomePage extends StatefulWidget {
  @override
  _CYHomePageState createState()=> new _CYHomePageState();
}

class _CYHomePageState extends State<CYHomePage> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      // appBar: AppBar(
      //   title: Text('Sample APP'),
      //   leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>methodChannel.invokeMethod('backToNative')),
      // ),
      body: new TabBarView(
        controller: tabController,
        // 禁止左右滑动
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[
          new BasicWidgetsDemo(),
          new PullDownRefreshList(),
          new PetCard(data: petCardData,),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.orangeAccent,
        child: new TabBar(
            controller: tabController,
            tabs:<Tab>[
              new Tab(text: "tab1", icon: Icon(Icons.home)),
              new Tab(text: "tab2", icon: Icon(Icons.message)),
              new Tab(text: "Tab3", icon: Icon(Icons.cloud)),
            ]
        ),
      ),
    );
  }
}
















/*
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

class PetCard extends StatelessWidget{
  final PetCardViewModel data;

  const PetCard({
    Key key,
    this.data,
}): super(key: key);

  Widget renderCover(){
    return Stack(//Stack/Positoned(绝对定位布局组件)
      fit: StackFit.passthrough,
      children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(// 修剪边角
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
                  gradient: LinearGradient(// 渐变色
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
  Widget renderUserInfo(){
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
  Widget renderPublishConent(){
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
  Widget renderInteractionArea(){
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector (
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

  void showToast (
      String text,{
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
  }){
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey[600],
      fontSize: 16.0,
    );
  }

  void showLoading (BuildContext context, [String text]){
    text = text ?? "Loading...";
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
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
    showToast('查看评论');
  }

  void _favoriteMethod() {
    showToast('喜欢');
  }

  void _shareMethod(){
    showToast('开始分享');
  }

  @override
  Widget build(BuildContext context) {
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

*/




class SampleApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
       primarySwatch: Colors.red,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}): super(key: key);
  @override
  _SampleAppPageState createState() => _SampleAppPageState();

}

class _SampleAppPageState extends State<SampleAppPage> {
  String textToShow = 'I like Flutter';
  void _updateText(){
    setState(() {
      textToShow = 'YES, Flutter';
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
        appBar: AppBar(
          title: Text('Sample APP'),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>methodChannel.invokeMethod('backToNative')),

        ),
        body: Center(child:
          Text(
            textToShow,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red

            )
        )
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: _updateText,
          tooltip: "Update Text",
          child: Icon(Icons.update),
        )
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>methodChannel.invokeMethod('backToNative')),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_getData, onError: _getError);
  }
  // 获取消息
  void _getData(dynamic data) {
    var str = data.toString();
    print("-----flutter----:"+ str);
    print(str);
    // setState(() {
    //
    // });
  }
  // 获取错误
  void _getError(Object err) {

  }
}



