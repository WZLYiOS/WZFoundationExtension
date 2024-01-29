Pod::Spec.new do |s|
  s.name             = 'WZFoundationExtension'
  s.version          = '3.2.3'
  s.summary          = 'FoundationExtension.'
  s.description      = <<-DESC
TODO: Add long descr asaa 
                       DESC
  s.homepage         = 'https://github.com/WZLYiOS/WZFoundationExtension.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZFoundationExtension.git', :tag => s.version.to_s }

  s.static_framework = true
  s.swift_versions   = '5.0'
  s.requires_arc = true
  s.ios.deployment_target = '13.0'

  s.dependency 'WZNamespaceWrappable', '>= 2.1.3'

  s.subspec 'Foundation' do |ss|
       ss.source_files = 'WZFoundationExtension/Classes/Foundation/*'
   end
     
   s.subspec 'UI' do |ss|
       ss.source_files = 'WZFoundationExtension/Classes/UI/*'
   end
  
end
