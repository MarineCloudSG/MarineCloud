module Support
  module YamlHelpers
    def yaml
      path = RSpec.
             current_example.
             metadata.
             dig(:example_group, :description)

      YAML.load_file(Rails.root.join(path))
    end
  end
end

RSpec.configure do |config|
  config.include Support::YamlHelpers, type: :yaml
end
