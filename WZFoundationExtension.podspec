Pod::Spec.new do |s|
  s.name             = 'WZFoundationExtension'
  s.version          = '3.0.7'
  s.summary          = 'FoundationExtension.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/WZLYiOS/WZFoundationExtension.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZFoundationExtension.git', :tag => s.version.to_s }

  s.static_framework = true
  s.swift_versions   = '5.0'
  s.requires_arc = true
  s.ios.deployment_target = '10.0'
  s.source_files = 'WZFoundationExtension/Classes/**/*'
  s.dependency 'WZNamespaceWrappable', '~> 2.1.2'

end
