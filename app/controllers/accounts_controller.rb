class AccountsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:invite, :new]
  
  def invite
    @invitation = AccountInvitation.new(
      inviter_email: current_user.email,
      invitee_email: invitee_email,
      invite_code:   invite_code)

    if @invitation.valid?
      AccountInvitationSender.new(@invitation).call
      @invitation.sent_at = DateTime.current

      if @invitation.save
        flash[:notice] = "Invitation sent"
        render text: "Invitation sent."
      end
    else
      render "new"
    end
  end

  def create
    if invitation.present?
      inviter = User.find_by_email(params['inviter_email'])
      invitee = User.find_by_email(params['invitee_email'])
      invitee.account = inviter.account
      if invitee.save
        redirect_to root_url, notice: "Accounts were successfully joined."
      else
        flash[:alert] = "Error joining accounts." 
      end
    else
      flash[:alert] = "Invitation not found." 
    end
  end

  def new
    @invitation = AccountInvitation.new
  end

  private

  def invitation
    AccountInvitation.where(
      inviter_email: params['inviter_email'],
      invitee_email: params['invitee_email'],
      invite_code:   params['invite_code'])
  end

  def invitee_email
    params['account_invitation']['invitee_email']
  end

  def invite_code
    Digest::MD5.hexdigest(Time.now.to_f.to_s + rand.to_s)
  end
end
