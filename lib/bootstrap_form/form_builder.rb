module BootstrapForm
  class FormBuilder < ActionView::Helpers::FormBuilder

    def input(name, options = {})
      klass = map_object_attribute_to_field_class name, options
      klass.new(self, @template, name, options).to_s
    end

    private

    def map_object_attribute_to_field_class(attr, options)
      prefix = field_class_prefix attr, options
      "BootstrapForm::Fields::#{prefix}Field".constantize
    end

    def field_class_prefix(attr, options)
      if options[:as]
        options[:as].to_s.capitalize
      else
        derive_field_class_prefix attr
      end
    end

    def derive_field_class_prefix(attr)
      field_class_prefix_based_on_column_type(attr) ||
      field_class_prefix_based_on_column_name(attr) ||
      'Text'
    end

    def field_class_prefix_based_on_column_type(attr)
      nil
    end

    def field_class_prefix_based_on_column_name(attr)
      case
      when attr.to_sym == :email    ; 'Email'
      when attr.to_s =~ /password/i ; 'Password'
      else nil
      end
    end
  end
end
