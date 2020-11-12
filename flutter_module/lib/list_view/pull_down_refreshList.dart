import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'mock_data.dart';
import 'news_card.dart';
import 'news_card_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullDownRefreshList extends StatefulWidget {
  @override
  _PullDownRefreshListState createState() => _PullDownRefreshListState();
}

class _PullDownRefreshListState extends State<PullDownRefreshList> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List list = newsList;
  Future onRefresh(){
    return Future.delayed(Duration(seconds: 1),(){
      List arr = new List();
      arr.addAll(newsList);
      arr.addAll(newsList2);
      setState(() {
        this.list = arr;
      });
      print(this.list);
      Toast.show('已是最新数据', context);
    });
  }


  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      this.list = newsList2;
    });
    _refreshController.refreshCompleted();
    // 重置上拉刷新
    _refreshController.loadComplete();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    List arr = new List();
    arr.addAll(this.list);
    arr.addAll(newsList2);
    if(mounted)
    if (this.list.length <= 50){
      setState(() {
        this.list = arr;
      });
      _refreshController.loadComplete();
    }else{
      _refreshController.loadNoData();
    }
  }

  // 点击跳转
  void _clickItem(int index){
    NewsViewModel model = this.list[index];
    // Toast.show(model.title, context, gravity: Toast.CENTER);
    // sleep(Duration(
    //   seconds: 1,
    // ));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsCardDetail(model: model,)));

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("刷新list"),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus status){
              Widget body;
              if (status == LoadStatus.idle){
                body = Text("上拉刷新");
              }else if(status == LoadStatus.loading){
                body = CupertinoActivityIndicator();
              }else if(status == LoadStatus.failed){
                body = Text("加载失败，点击重试");
              }else if(status == LoadStatus.canLoading){
                body = Text('松手，加载更多');
              }else {
                body = Text('没有更多数据了');
              }
              return Container(
                height: 55.0,
                child: Center(child: body,),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        child: ListView.separated(
            itemBuilder: (context, index){
              return new FlatButton(onPressed: () => _clickItem(index), child: NewsCard(data: this.list[index],));
            },
            separatorBuilder: (context, index){
              return Divider(height: .5, color: Color(0xFFDDDDDD),);
            },
            itemCount: this.list.length,
          ),
      )
      );
    // return RefreshIndicator(
    //     child: ListView.separated(
    //         itemBuilder: (context, index){
    //           return new FlatButton(onPressed: () => _clickItem(index), child: NewsCard(data: this.list[index],));
    //           return NewsCard(data: this.list[index],);
    //         },
    //         separatorBuilder: (context, index){
    //           return Divider(height: .5, color: Color(0xFFDDDDDD),);
    //         },
    //         itemCount: this.list.length,
    //     ),
    //
    //     onRefresh: this.onRefresh);
  }

}