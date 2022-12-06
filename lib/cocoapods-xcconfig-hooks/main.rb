require "cocoapods-xcconfig-hooks/config"
require "cocoapods-xcconfig-hooks/dsl"

module Pod
  module XCConfig
    class Hook
      def initialize(context)
        @context = context
      end

      def sandbox
        @context.sandbox
      end

      def config
        Config.instance
      end

      def run
        sandbox.target_support_files_root.glob("*/*.xcconfig") do |path|
          prepend_includes(path)
        end
      end

      private

      def prepend_includes(path)
        target, config_name, = path.basename.to_s.split(".")
        is_agg_target = target.start_with?("Pods-")
        return if !is_agg_target && config.aggregate_targets_only?

        includes = [
          "__base__.xcconfig",
          "#{target}.__base__.xcconfig",
          "#{target}.#{config_name}.xcconfig",
        ].map { |p| "#include? \"#{config.hook_dir}/#{p}\"" }

        to_prepend = <<~HEADER
          #{includes.join("\n")}
          // ------------------------------------------------------------
          // The above includes were injected by cocoapods-xcconfig-hooks
          // ------------------------------------------------------------

        HEADER
        path.write(to_prepend + path.read)
      end
    end
  end
end
