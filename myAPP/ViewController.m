//
//  ViewController.m
//  myAPP
//
//  Created by zcy on 2020/11/10.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, FlutterStreamHandler>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) FlutterViewController *flutterVC;
// 原生发送消息到Flutter - 单项管道，有可能使用多次
@property (nonatomic, copy) FlutterEventSink eventSink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"flutter混编";
    [self.view addSubview:self.myTableView];
    
}

#pragma mark - Method

- (void)showFlutterMethod {
    FlutterEngine *flutterEngine = ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterVC =
            [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    UIView *splashView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    splashView.backgroundColor = [UIColor redColor];
    //flutter渲染是异步的，如果是第一次渲染，并且没有设置splashScreenView，则默认加载启动页图片
    flutterVC.splashScreenView = splashView;
    [self presentViewController:flutterVC animated:YES completion:nil];
    
    // Flutter向原生发送消息
    [self flutterCallbackMethod:flutterVC];
    // 原生向Flutter发送消息
    [self flutterEventStreamHandle:flutterVC];

}

/// 单项通信管道，Flutter向原生发送消息
- (void)flutterCallbackMethod:(FlutterViewController *)flutterVC {
    
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"com.flutterToNative"
                                           binaryMessenger:flutterVC];
    __weak typeof(self) weakSelf = self;
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        //通过call.method来获取方法名称
        if ([@"backToNative" isEqualToString:call.method]) {
            //dismiss掉Flutter控制器，回到原生
            [weakSelf dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

/// 单项通信管道，原生向Flutter发送消息
- (void)flutterEventStreamHandle:(FlutterViewController *)flutterVC {
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"com.nativeToflutter" binaryMessenger:flutterVC];
    [eventChannel setStreamHandler:self];
    
}

#pragma mark - delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row:%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        [self.navigationController pushViewController:self.flutterVC animated:YES];
    }else if(indexPath.row == 1) {
        [self showFlutterMethod];
    }else if(indexPath.row == 2){
        FlutterViewController * flutterViewController =
        [[FlutterViewController alloc] init];
        [flutterViewController setInitialRoute:@"App"];
            
        flutterViewController.view.backgroundColor = [UIColor whiteColor];
        FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"com.nativeToflutter" binaryMessenger:flutterViewController];
        [eventChannel setStreamHandler:self];

    }
    

}

#pragma mark - FlutterStreamHandler代理

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    if (events) {
        self.eventSink = events;
        self.eventSink(@"native12345");
    }
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    return nil;
}

#pragma mark - setter&&getter

- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (FlutterViewController *)flutterVC{
    if (!_flutterVC) {
        _flutterVC = [[FlutterViewController alloc] init];
//        _flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
        UIView *splashView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        splashView.backgroundColor = [UIColor yellowColor];
        //flutter渲染是异步的，如果是第一次渲染，并且没有设置splashScreenView，则默认加载启动页图片
        _flutterVC.splashScreenView = splashView;
    }
    return _flutterVC;
}

@end
