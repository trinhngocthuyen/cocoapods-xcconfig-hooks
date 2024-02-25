lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-xcconfig-hooks"
  spec.version       = File.read("VERSION").strip
  spec.authors       = ["Thuyen Trinh"]
  spec.email         = ["trinhngocthuyen@gmail.com"]
  spec.description   = "CocoaPods plugin to hook xcconfig of CocoaPods targets"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/trinhngocthuyen/cocoapods-xcconfig-hooks"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
