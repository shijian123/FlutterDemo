
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/CYTabViewModel.dart';
import 'package:flutter_module/NetworkManager/NetworkManager.dart';

import 'pet_card.dart';
import 'mock_data.dart';

List<CYTabViewModel> modeList = [
  CYTabViewModel(title: "宠物卡片", widget: PetCard(data: petCardData,)),
  CYTabViewModel(title: "宠物卡片", widget: PetCard(data: petCardData,)),
  CYTabViewModel(title: "宠物卡片", widget: PetCard()),
].map((item) => CYTabViewModel(
  title: item.title,
  widget: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[item.widget],
  )
)).toList();

class BasicWidgetsDemo extends StatefulWidget {
  @override
  _BasicWidgetsDemoState createState() => _BasicWidgetsDemoState();
}

// 必需加上 SingleTickerProviderStateMixin
class _BasicWidgetsDemoState extends State<BasicWidgetsDemo> with SingleTickerProviderStateMixin{
  // TabController 就是tabbar的控制器
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tabController = new TabController(length: modeList.length, vsync: this);
    requestServerMovieList(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.tabController.dispose();
  }

  void requestServerMovieList(int start) async {

    final url1 = 'https://douban.uieee.com/v2/movie/top250?start=$start&count=20';
    final result = await CYHttpRequest.request(url1);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CYTabs(
      isShowBack: true,
      title: '基础组件',
      modelList: modeList,
      tabScrollabled: false,
      tabController: this.tabController,
    );
  }
}