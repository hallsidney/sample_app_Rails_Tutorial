require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: 'Example User', email: 'exuser@something.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid ' do
    assert @user.valid?
  end

  test 'name should be present' do
    assert_not @user.name.empty?
  end

  test 'email should be present' do
    assert_not @user.email.empty?
  end

  test "name shouldn't be too long" do
    @user.name = 'a' * 52
    assert_not @user.valid?
  end

  test "email shouldn't be too long" do
    @user.email = 'a' * 352
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example USERfoo.COM bar_bar@bar_gar,com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email.upcase!
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'passowrd should have minimum length' do
    @user.password = @user.password_confirmation = 'a' * 3
    assert_not @user.valid?
  end
end
