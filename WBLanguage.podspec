
Pod::Spec.new do |s|
  s.name         = 'WBLanguage'
  s.version      = '1.0.1'
  s.license      = 'MIT' 
  s.summary      = 'In your project, you can easy to change the language with swift.'
  s.homepage     = 'https://github.com/JsonBin/WBLanguage'
  s.authors      = { 'JsonBin' => '1120508748@qq.com' }
  s.source = { :git => 'https://github.com/JsonBin/WBLanguage.git', :tag => s.version }

  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source_files  =  'Source/*.swift'
  
  s.requires_arc = true
  
end
