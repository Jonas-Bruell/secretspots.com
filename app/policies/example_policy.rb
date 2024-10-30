# https://www.monterail.com/blog/how-to-set-up-user-authentication-and-authorization-in-ruby-on-rails

class ExamplePolicy
  attr_reader :user, :example_object

  def initialize(user, example_object)
    @user = user
    @example_object = example_object
  end

  def index?
    true
  end

  def show?
    user&.created_at&.today? && example_object[:show] == true
  end
end
