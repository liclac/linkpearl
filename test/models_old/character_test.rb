require 'test_helper'

EMI_HTML = File.read(Rails.root.join('test', 'data', 'emi.html'))
YOSHIDA_HTML = File.read(Rails.root.join('test', 'data', 'yoshida.html'))

class CharacterTest < ActiveSupport::TestCase
  test "parsing HTML works" do
    emi = Character.from_html EMI_HTML
    assert_equal 7248246, emi.id
    assert_equal "Emi Katapow", emi.name
    assert_equal 17, emi.class_progresses.length
    
    # Progress hashes include only unlocked jobs
    progress_hash = emi.class_progresses_to_hash
    assert_includes progress_hash, "Arcanist"
    assert_not_includes progress_hash, "Astrologian"
    
    # Classes and exp for level capped classes work
    assert_equal 60, progress_hash["Arcanist"].level
    assert_equal 0, progress_hash["Arcanist"].exp_at
    assert_equal 0, progress_hash["Arcanist"].exp_of
    
    # Classes and exp for uncapped classes work
    assert_equal 59, progress_hash["Gladiator"].level
    assert_equal 2461186, progress_hash["Gladiator"].exp_at
    assert_equal 3888000, progress_hash["Gladiator"].exp_of
  end
  
  test "parsing protected profiles works" do
    yoshi = Character.from_html YOSHIDA_HTML
    assert_equal 7806252, yoshi.id
    assert_equal "Yoshida Eee", yoshi.name
  end
end
