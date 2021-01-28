platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def available_pods
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
end

target 'SkyEngTest' do
    available_pods
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'RxNimble'
    available_pods
end

target 'SkyEngTestTests' do
    testing_pods
end