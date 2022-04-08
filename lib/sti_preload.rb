# https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#autoloading-and-sti
module StiPreload
  unless Rails.application.config.eager_load
    extend ActiveSupport::Concern

    included do
      cattr_accessor :preloaded, instance_accessor: false
    end

    class_methods do
      def descendants
        preload_sti unless preloaded
        super
      end

      # Constantizes all types present in the correlated directory.
      def preload_sti
        types_in_directory = \
          Dir[Rails.root.join('app', 'models', base_class.name.underscore.pluralize, '**', '*.rb')].map do |path|
            "#{base_class.name.pluralize}::#{File.basename(path, '.rb').camelize}"
          end

        types_in_directory.each do |type|
          logger.debug("Preloading STI type #{type}")
          type.constantize
        end

        self.preloaded = true
      end
    end
  end
end
