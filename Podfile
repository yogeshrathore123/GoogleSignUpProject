# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GoogleSignUpProject' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GoogleSignUpProject

  target 'GoogleSignUpProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GoogleSignUpProjectUITests' do
    inherit! :search_paths
    # Pods for testing
  end

pod 'Google/SignIn'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
