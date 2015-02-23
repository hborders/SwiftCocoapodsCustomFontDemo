Pod::Spec.new do |s|
    s.name = 'SwiftCocoapodsCustomFont'
    s.version = '0.0.1'
    s.license = { :type => "Apache License, Version 2.0", :file => "README.md" }
    s.summary = 'View Library'
    s.homepage = 'http://www.jivesoftware.com'
    s.authors = { "Heath Borders" => "heath.borders@jivesoftware.com" }

    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.9'

    s.source_files = 'Source/*.{swift}'
    s.resources = 'Source/*.otf'
    s.framework = 'CoreText'

    s.requires_arc = true
end

