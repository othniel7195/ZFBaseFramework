#
# Be sure to run `pod lib lint ZFBaseFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZFBaseFramework'
  s.version          = '0.1.3'
  s.summary          = '个人BaseFramework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
个人基础库，个人常用的类，有一些Category，UI，Foundation等
                       DESC

  s.homepage         = 'https://github.com/othniel7195/ZFBaseFramework'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaofeng' => 'zhaofeng7195@yeah.net' }
  s.source           = { :git => 'https://github.com/othniel7195/ZFBaseFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #s.source_files = 'ZFBaseFramework/Classes/**/*'

  s.subspec 'ZFCategoryFramework' do |cf|
    cf.source_files = 'ZFBaseFramework/Classes/ZFCategoryFramework/**/*'
  end

  s.subspec 'ZFFoundationFramework' do |ff|
    ff.source_files = 'ZFBaseFramework/Classes/ZFFoundationFramework/**/*'
    ff.frameworks = 'CoreServices'
    ff.libraries = 'sqlite3'
  end

  s.subspec 'ZFUISegmentBar' do |uisb|
    uisb.source_files = 'ZFBaseFramework/Classes/ZFUISegmentBar/**/*'
    uisb.dependency 'ZFBaseFramework/ZFCategoryFramework'
  end

  s.subspec 'ZFDownLoaderFramework' do |dl|
    dl.source_files = 'ZFBaseFramework/Classes/ZFDownLoaderFramework/**/*'
    dl.dependency 'ZFBaseFramework/ZFCategoryFramework'
    dl.dependency 'ZFBaseFramework/ZFFoundationFramework'
  end
  
  s.subspec 'ZFAudioPlayerFramework' do |ap|
      ap.source_files = 'ZFBaseFramework/Classes/ZFAudioPlayerFramework/**/*'
      ap.frameworks = 'AVFoundation'
  end
  
  # s.resource_bundles = {
  #   'ZFBaseFramework' => ['ZFBaseFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
