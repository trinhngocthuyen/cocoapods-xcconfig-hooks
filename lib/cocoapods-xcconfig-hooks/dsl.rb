require "cocoapods-xcconfig-hooks/config"

module Pod
  class Podfile
    module DSL
      def config_xcconfig_hooks(options)
        Pod::XCConfig::Config.instance.dsl_config = options
      end
    end
  end
end
