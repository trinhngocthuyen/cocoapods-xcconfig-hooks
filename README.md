# cocoapods-xcconfig-hooks

[![Test](https://github.com/trinhngocthuyen/cocoapods-xcconfig-hooks/actions/workflows/test.yml/badge.svg)](https://github.com/trinhngocthuyen/cocoapods-xcconfig-hooks/actions/workflows/test.yml)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat&color=blue)](https://github.com/trinhngocthuyen/cocoapods-xcconfig-hooks/blob/main/LICENSE.txt)
[![Gem](https://img.shields.io/gem/v/cocoapods-xcconfig-hooks.svg?style=flat&color=blue)](https://rubygems.org/gems/cocoapods-xcconfig-hooks)

A CocoaPods plugin to hook xcconfig of CocoaPods targets.

## Installation

    $ gem install cocoapods-xcconfig-hooks

## Usage

### Load the plugin

Load this plugin by adding the following line at the beginning of Podfile (example: [here](/examples/Podfile#L4)).

```rb
plugin "cocoapods-xcconfig-hooks"
```

### Configure the plugin (optional)

In Podfile, call the `config_xcconfig_hooks` method to provide customization for your setup (example: [here](/examples/Podfile#L6)).

```rb
config_xcconfig_hooks(
  hook_dir: "path/to/xcconfig/dir",
  aggregate_targets_only: true
)
```

The following table explains the parameters of the `config_xcconfig_hooks` method.

| Parameter              | Type    | Default    | Description                                                                    |
|------------------------|---------|------------|--------------------------------------------------------------------------------|
| `hook_dir`               | string  | `.xcconfigs` | Path to the directory containing xcconfig files (relative to the project directory)                                |
| `aggregate_targets_only` | boolean | `true`       | Whether to hook aggregate targets only (ex. Pods-App, Pods-AppUITests...) |

After pod installation, the settings defined in those xcconfig files should be hooked to the project.

![](/resources/xcconfig.png)

### Order of xcconfig hooks

xcconfig files (if present in the `hook_dir`) are included in the following order.
- `__base__.xcconfig`
- `<configuration_name>.xcconfig` (ex. `debug.xcconfig`)
- `<TargetName>.__base__.xcconfig` (ex: `Pods-Example.__base__.xcconfig`)
- `<TargetName>.<configuration_name>.xcconfig` (ex: `Pods-Example.debug.xcconfig`)
