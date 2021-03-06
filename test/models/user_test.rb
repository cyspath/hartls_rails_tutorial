require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=User.new(name:"Example User", email:"user@example.com",
                  password: "foobar", password_confirmation:"foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name=" "
    assert_not @user.valid?
  end
  
  test "name should not be longer than 50 characters" do
    @user.name="watermelon"
    assert @user.valid? #short enough, valid!
    @user.name="w"*51
    assert_not @user.valid? #now too long, not valid!
  end
  
  
  test "email should be present" do
    @user.email="  "
    assert_not @user.valid?
  end
  
  test "email should not be longer than 255 characters" do
    @user.email="a"*256
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses=%w[darkterr@dota.com tide_hunter@dota.com SVEN-ROGUEKNIGHT@wc3.org lycan+wolf@roshan.io]
    valid_addresses.each do |address|
      @user.email=address
      assert @user.valid?, "#{address.inspect} should be valid but it is not!"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses=%w[user@example,com user_at_foo.bar user.name@foo. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email=address
      assert_not @user.valid?, "#{address.inspect} should be invalid but it appears valid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user=@user.dup
    duplicate_user.email=@user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password=@user.password_confirmation="a"*5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    michael  = users(:michael)
    archer   = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end