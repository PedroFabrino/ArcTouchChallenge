

source 'https://github.com/CocoaPods/Specs.git'
source 'https://bitbucket.org/altran-ais/specs'

def shared_pods
  pod 'SwiftyBeaver'
  pod 'SwiftLint'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Moya-ObjectMapper/RxSwift'
  pod 'RSLoadingView'
end


target 'arctouch-challenge-ios' do
  platform :ios, '11.1'
  use_frameworks!
  shared_pods
  pod 'Alamofire'
  pod 'SDWebImage'

  target 'arctouch-challenge-iosTests' do
    inherit! :search_paths
    shared_pods
  end

  target 'arctouch-challenge-iosUITests' do
    inherit! :search_paths
  end

end
