require 'test_helper'

EMI_HTML = File.read(Rails.root.join('test', 'data', 'emi.html'))

class CharacterTest < ActiveSupport::TestCase
  test "parsing HTML works" do
    emi = Character.from_html EMI_HTML
    assert_equal 7248246, emi.id
    assert_equal "Emi Katapow", emi.name
  end
end
