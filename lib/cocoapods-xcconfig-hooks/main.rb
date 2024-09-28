require "fileutils"
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
        create_symlink_to_hook_dir
      end

      private

      def prepend_includes(path)
        target, config_name, = path.basename.to_s.split(".")
        is_agg_target = target.start_with?("Pods-")
        return if !is_agg_target && config.aggregate_targets_only?

        includes = [
          "__base__.xcconfig",
          "#{config_name}.xcconfig",
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

      def create_symlink_to_hook_dir
        # Create symlink to hook dir (under Pods) so that xcconfigs can be included
        # in a pod target's xcconfig without caring about absolute/relative paths
        path = Pod::Config.instance.sandbox.root / config.hook_dir
        FileUtils.rm_rf(path) if path.exist?
        File.symlink(File.absolute_path(config.hook_dir), path)
      end
    end
  end
end
