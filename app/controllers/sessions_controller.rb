class SessionsController < Devise::SessionsController
  def create
    super
    set_default_account
  end

  def set_default_account
    current_user.create_account if current_user.account.nil?
  end
end
