# Ensure that ENABLE_BITCODE is set to NO, add a #include to Generated.xcconfig, and
# add a run script to the Build Phases.
# TODO(dnfield): Figure out a way to deliver the Build Phase scripts without manual user intervention.
post_install do |installer|
    framework_dir = File.join(flutter_application_path, '.ios', 'Flutter')
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            xcconfig_path = config.base_configuration_reference.real_path
            File.open(xcconfig_path, 'a+') do |file|
                file.puts "#include \"#{File.realpath(File.join(framework_dir, 'Generated.xcconfig'))}\""
            end
        end
    end
end
