import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const methodChannel = MethodChannel('com.flutterToNative');

class CYTabViewModel{
  final String title;
  final Widget widget;

  const CYTabViewModel ({
   this.title,
   this.widget,
  });
}

class CYTabs extends StatelessWidget {
  final String title;
  final List<CYTabViewModel> modelList;
  final bool tabScrollabled;
  final TabController tabController;

  final bool isShowBack;
  
  CYTabs({
    this.title,
    this.isShowBack,
    this.modelList,
    this.tabScrollabled,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: this.isShowBack ? IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>methodChannel.invokeMethod('backToNative')) : Text(''),
        bottom: TabBar(
          controller: this.tabController,
          isScrollable: tabScrollabled,
          tabs: this.modelList.map((item) => Tab(text: item.title)).toList(),
        ),
      ),
      body: TabBarView(
        controller: this.tabController,
        children: this.modelList.map((item) => item.widget).toList(),
      ),
    );
  }
}