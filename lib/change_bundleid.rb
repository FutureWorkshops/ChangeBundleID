require "change_bundleid/version"
require 'xcodeproj'
require 'plist'

module ChangeBundleID
  def change_bundle_id(project_filepath, target_name, project_configuration, new_bundle_ID, verbose, skip_plist)

    project_directory=File.dirname project_filepath
    if File.directory?(project_directory)
      puts "ERROR: The project folder '#{project_directory}' doesn't exist."
      exit -12
    end

    if File.exists?(project_filepath)
      puts "ERROR: The project file '#{project_filepath}' doesn't exist."
      exit -12
    end

    puts "*** Parsing project at '#{project_filepath}'"
    project = Xcodeproj::Project.open(project_filepath)
    target = project.targets.find { |t| t.name == target_name }
    if target.nil?
      puts "ERROR: Unable to find target '#{target_name}'!"
      exit -12
    end

    configuration = target.build_configurations.find { |c| c.name == project_configuration }
    if configuration.nil?
      puts "ERROR: Unable to find configuration '#{project_configuration}'!"
      exit -12
    end

    puts "*** Setting Xcode Project's PRODUCT_BUNDLE_IDENTIFIER to '#{new_bundle_ID}'" if verbose == true

    configuration.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = new_bundle_ID
    project.save
    

    if skip_plist == true do
      puts "*** Skipping info_plist" if verbose == true
    end

    puts "*** Looking for Info.plist location" if verbose == true
    relative_plist_path = configuration.build_settings['INFOPLIST_FILE']
    relative_plist_path ||= project.build_settings(project_configuration)['INFOPLIST_FILE']
    if relative_plist_path.nil?
      puts "ERROR: Unable to find info.plist path within the project!"
      exit -13
    end

    info_plist_file = File.join project_directory, relative_plist_path

    # weak attempt to sanitize the file path
    info_plist_file.slice! "$(SRCROOT)"

    unless File.exists? info_plist_file
      puts "ERROR: Unable to find info.plist file at path '#{info_plist_file}'!"
      exit -15
    end

    puts "*** Found Info.plist file at path #{info_plist_file}" if verbose == true
    puts "*** Resetting Info.plist's Bundle Identifier to '$(PRODUCT_BUNDLE_IDENTIFIER)'" if verbose == true
    result = Plist::parse_xml(info_plist_file)
    result['CFBundleIdentifier'] = "$(PRODUCT_BUNDLE_IDENTIFIER)"

    File.open(info_plist_file, 'w') { |file| file.write(result.to_plist) }
  end
end
