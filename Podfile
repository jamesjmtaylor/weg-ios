platform :ios, '9.0'


use_frameworks!

def main_pods
  pod 'Firebase/Core'
  pod 'Kingfisher', '~> 4.7.0'
  pod 'lottie-ios'
  pod 'Fabric', '~> 1.7.7'
  pod 'Crashlytics', '~> 3.10.2'
end

def test_pods
  pod 'Mockingjay'
end

target 'weg-ios' do
  main_pods
end

target 'wegUnitTests' do
  use_frameworks!
  inherit! :search_paths
  main_pods
  test_pods
end