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
      case attr_column_type(attr)
      when :boolean; 'Boolean'
      when :datetime; 'Datetime'
      when :string; string_field_class_prefix_based_on_column_name(attr)
      when :text  ; 'Textarea'
      else 'Text'
      end
    end

    def attr_column_type(attr)
      attr_column_info(attr).try(:type) || :string
    end

    def attr_column_info(attr)
      return nil unless object.class.respond_to? :columns
      object.class.columns.detect { |c| c.name == attr.to_s }
    end

    def string_field_class_prefix_based_on_column_name(attr)
      x = case
      when attr.to_s =~ /email/i    ; 'Email'
      when attr.to_s =~ /password/i ; 'Password'
      else 'Text'
      end
    end
  end
end
