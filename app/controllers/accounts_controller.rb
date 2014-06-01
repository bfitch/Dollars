class AccountsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:invite]
  
  def invite
    @invitation = AccountInvitation.new(
      inviter_email: current_user.email,
      invitee_email: invitee_email,
      invite_code:   invite_code)

    if @invitation.save
      AccountInvitationSender.new(current_user, @invitation).call
    else
      render "new"
    end
  end

  def create
  end

  def new
  end

  private
  
  def invite_code
    Digest::MD5.hexdigest(Time.now.to_f.to_s + rand.to_s)
  end

  def invitee_email
    params['invitee_email']
  end
end
