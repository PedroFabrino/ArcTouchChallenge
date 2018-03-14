

source 'https://github.com/CocoaPods/Specs.git'
source 'https://bitbucket.org/altran-ais/specs'

def shared_pods
  pod 'SwiftyBeaver'
  pod 'SwiftLint'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Moya-ObjectMapper/RxSwift'
  pod 'SkeletonView'
end


target 'arctouch-challenge-ios' do
  platform :ios, '11.1'
  use_frameworks!
  shared_pods
  pod 'Alamofire'
  pod 'SDWebImage'

  target 'arctouch-challenge-iosTests' do
    inherit! :search_paths
    # Pods for testing
    shared_pods
#    pod 'RxBlocking', '~> 4.0'
#    pod 'RxTest',     '~> 4.0'
  end

  target 'arctouch-challenge-iosUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
