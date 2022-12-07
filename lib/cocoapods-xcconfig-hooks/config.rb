module Pod
  module XCConfig
    class Config
      attr_accessor :dsl_config

      def initialize
        @dsl_config = {}
      end

      def self.instance
        @instance ||= Config.new
      end

      def hook_dir
        @hook_dir ||= begin
          dir = Pathname(dsl_config[:hook_dir] || ".xcconfigs")
          dir.mkpath
          dir
        end
      end

      def aggregate_targets_only?
        value = dsl_config[:aggregate_targets_only]
        return value unless value.nil?

        true
      end
    end
  end
end
