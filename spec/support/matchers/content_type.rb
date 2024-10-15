# frozen_string_literal: true

RSpec::Matchers.define :have_content_type do |expected|
  match do |actual|
    content_types = {
      html: 'text/html'
    }
    actual.content_type.include?(content_types[expected.to_sym])
  end
end
