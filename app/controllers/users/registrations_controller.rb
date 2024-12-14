class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @show_header = true
    super
  end
  def view
    puts current_user.secrets.count
  end
  def update
    puts account_update_params
    @account_params = account_update_params
    super
  end
end
