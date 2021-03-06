module JSONAPI
  module ResourceFor
    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      # :nocov:
      if RUBY_VERSION >= '2.0'
        def resource_for(type)
          resource_name = JSONAPI::Resource._resource_name_from_type(type)
          Object.const_get resource_name if resource_name
        rescue NameError
          nil
        end
      else
        def resource_for(type)
          resource_name = JSONAPI::Resource._resource_name_from_type(type)
          resource_name.safe_constantize if resource_name
        end
      end
      # :nocov:
    end
  end
end