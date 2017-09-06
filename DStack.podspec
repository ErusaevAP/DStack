Pod::Spec.new do |s|
    s.name          = "DStack"
    s.version       = "0.0.19"
    s.summary       = "Helpers"
    s.description   = "Helpers for views"
    s.homepage      = "https://github.com/ErusaevAP/DStack"

    # s.screenshots = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

    s.license       = "MIT"
    s.author        = { "Andrey Erusaev" => "erusaevap@gmail.com" }

    s.platform      = :ios, "10.0"
    s.source        = { :git => "https://github.com/erusaevap/DStack.git", :tag => "#{s.version}" }
    s.source_files  = 'Sources/*.{swift}'

    # s.resource    = "icon.png"
    # s.resources   = "Resources/*.png"

    s.dependency "RxSwift"
    s.dependency "RxCocoa"

    s.subspec 'Controllers' do |core|
        core.source_files   = 'Sources/Controllers/**/*.{swift}'
    end

end
