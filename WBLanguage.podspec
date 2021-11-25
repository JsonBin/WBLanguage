
Pod::Spec.new do |s|
  s.name         = 'WBLanguage'
  s.version      = '2.0.0'
  s.license      = 'MIT' 
  s.summary      = 'In your project, you can easy to change the language with swift.'
  s.homepage     = 'https://github.com/JsonBin/WBLanguage'
  s.authors      = { 'JsonBin' => 'enjoy_bin@163.com' }
  s.source = { :git => 'https://github.com/JsonBin/WBLanguage.git', :tag => s.version }

  s.platform = :ios, '9.0'
  s.ios.deployment_target = '9.0'

  s.source_files  =  'Source/*.swift'
  
  s.requires_arc = true
  
  s.swift_version = '5.0'
  
end
