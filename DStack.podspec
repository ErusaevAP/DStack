Pod::Spec.new do |s|
    s.version = '0.4.2'
    s.name = 'DStack'

    s.author = { 'Andrey Erusaev' => 'erusaevap@gmail.com' }
    s.default_subspec = 'DSExtensions'
    s.description = 'Helpers for views'
    s.homepage = 'https://github.com/ErusaevAP/DStack'
    s.license = 'MIT'
    s.platform = :ios, '11.0'
    s.source = { :git => 'https://github.com/erusaevap/DStack.git', :tag => "#{s.version}" }
    s.summary = 'Helpers'
    s.swift_versions = '5.0'

    s.subspec 'DSExtensions' do |extensions|
        extensions.source_files  = 'Sources/DSExtensions/*.{swift}'
    end

    s.subspec 'DSViews' do |views|
        views.source_files   = 'Sources/DSViews/*.{swift}'
        views.dependency 'DStack/DSExtensions'
    end

    s.subspec 'DSControllers' do |controllers|
        controllers.source_files   = 'Sources/DSControllers/**/*.{swift}'
        controllers.dependency 'DStack/DSExtensions'
        controllers.dependency 'RxSwift'
        controllers.dependency 'RxCocoa'

    end

end
