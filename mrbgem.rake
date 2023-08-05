MRuby::Gem::Specification.new('mruby-esp32-ledc') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'

  spec.cc.include_paths << "#{build.root}/src"
  spec.add_dependency('mruby-rational', :core => 'mruby-rational')
end
