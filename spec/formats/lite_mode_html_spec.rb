require File.dirname(__FILE__) + '/../spec_helper'

describe "lite_mode_html" do
  examples_from_yaml do |doc|
    RedClothParslet.new(doc['in'], [:lite_mode]).to_html(:sort_attributes)
  end
end
