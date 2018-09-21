#
# Be sure to run `pod lib lint ScrollViewPagingAndReload.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScrollViewPagingAndReload'
  s.version          = '0.1.2'
  s.summary          = 'Helper implementation for paging and reloading scroll views (UITableView, UIScrollView)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Helper implementation for paging and reloading scroll views (UITableView, UIScrollView). You can easily trigger reloading or next page loading of a scroll view. Set the offset when the actions should be triggered.
                       DESC

  s.homepage         = 'https://github.com/angelantonov213/ScrollViewPagingAndReload'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Angel' => 'angel.antonov213@gmail.com' }
  s.source           = { :git => 'https://github.com/angelantonov213/ScrollViewPagingAndReload.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'ScrollViewPagingAndReload/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ScrollViewPagingAndReload' => ['ScrollViewPagingAndReload/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
