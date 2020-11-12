# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

flutter_application_path = 'flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
#其中flutter_application_path为flutter模块相对于podfile文件的位置。

target 'myAPP' do
  use_frameworks!
  
  install_all_flutter_pods(flutter_application_path)
  pod 'MBProgressHUD'


end


