# https://www.monterail.com/blog/how-to-set-up-user-authentication-and-authorization-in-ruby-on-rails

class ExamplesController < ApplicationController
  def index
    authorize Hash, policy_class: ExamplePolicy
  end

  def show
    example_object = { show: true }

    authorize example_object, policy_class: ExamplePolicy
  end
end
