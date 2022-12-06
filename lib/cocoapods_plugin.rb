require 'cocoapods-xcconfig-hooks/main'

Pod::HooksManager.register("cocoapods-xcconfig-hooks", :post_install) do |context|
  Pod::XCConfig::Hook.new(context).run
end
