platform :ios, '10.0'


use_frameworks!

def main_pods
  pod 'Kingfisher', '~> 5.8.0'
  pod 'lottie-ios'
  pod 'Firebase/Core'
  pod 'Fabric', '~> 1.7.7'
  pod 'Crashlytics', '~> 3.10.2'
end

def test_pods
  pod 'Kingfisher', '~> 5.8.0'
  pod 'lottie-ios'
  pod 'Mockingjay'
  pod 'Firebase/Core'
end

target 'weg-ios' do
  main_pods
end

target 'wegUnitTests' do
  use_frameworks!
  inherit! :search_paths
  test_pods
end