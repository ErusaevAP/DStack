Pod::Spec.new do |s|
    s.name          = "DStack"
    s.version       = "0.4.1"
    s.summary       = "Helpers"
    s.description   = "Helpers for views"
    s.homepage      = "https://github.com/ErusaevAP/DStack"

    s.license       = "MIT"
    s.author        = { "Andrey Erusaev" => "erusaevap@gmail.com" }

    s.platform      = :ios, "10.0"
    s.source        = { :git => "https://github.com/erusaevap/DStack.git", :tag => "#{s.version}" }

    s.default_subspec = 'DSExtensions'

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
        controllers.dependency "RxSwift"
        controllers.dependency "RxCocoa"

    end

end
