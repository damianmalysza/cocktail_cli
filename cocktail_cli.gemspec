require_relative 'lib/cocktail_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "cocktail_cli"
  spec.version       = CocktailCli::VERSION
  spec.authors       = ["Damian Malysza"]
  spec.email         = ["damian.malysza@gmail.com"]

  spec.summary       = %q{CLI Application that allows users to look up cocktail information.}
  spec.description   = %q{CLI Application will allows users to search for cocktails by name or ingredient and find information on them or search for a random cocktail.}
  spec.homepage      = "https://github.com/damianmalysza/cocktail_cli"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/damianmalysza/cocktail_cli"
  spec.metadata["changelog_uri"] = "https://github.com/damianmalysza/cocktail_cli"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
