require 'test_helper'

class ZestimateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "new Zestimate" do
  zestimate = Zestimate.new
  assert_not zestimate.save
  end

end
