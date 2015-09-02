require 'test_helper'

EMI_HTML = File.read(Rails.root.join('test', 'data', 'emi.html'))
YOSHIDA_HTML = File.read(Rails.root.join('test', 'data', 'yoshida.html'))

class CharacterTest < ActiveSupport::TestCase
  test "parsing HTML works" do
    emi = Character.from_html EMI_HTML
    assert_equal 7248246, emi.id
    assert_equal "Emi Katapow", emi.name
  end
  
  test "parsing protected profiles works" do
    yoshi = Character.from_html YOSHIDA_HTML
    assert_equal 7806252, yoshi.id
    assert_equal "Yoshida Eee", yoshi.name
  end
end
