# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{report_this}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guoliang Cao"]
  s.autorequire = %q{report_this}
  s.date = %q{2008-12-07}
  s.description = %q{A gem that provides basic report functionality}
  s.email = %q{cao@daoqigame.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README.rdoc", "Rakefile", "TODO", "lib/array_report.rb", "lib/colorful_console_output.rb", "lib/report_this", "lib/report_this/base.rb", "lib/report_this/config.rb", "lib/report_this/pageable.rb", "lib/report_this.rb", "spec/report_this", "spec/report_this/array_report_spec.rb", "spec/report_this/base_spec.rb", "spec/report_this/config_spec.rb", "spec/report_this/pageable_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://www.daoqigame.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A gem that provides basic report functionality}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
