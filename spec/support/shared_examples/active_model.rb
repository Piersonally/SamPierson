shared_examples_for "ActiveModel" do
  include ActiveModel::Lint::Tests

  ActiveModel::Lint::Tests.public_instance_methods
                          .map { |method| method.to_s }
                          .grep(/^test/).each do |method|

    example method.gsub('_', ' ') do
      send method
    end
  end

  def model
    subject
  end
end
