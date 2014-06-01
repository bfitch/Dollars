class AccountInvitationMailer < ActionMailer::Base
  def invite(invitation)
    @presenter = AccountInvitationPresenter.new(invitation)
    subject    = "Invitation to join your account"

    mail(
      to:      invitation.invitee_email,
      from:    invitation.inviter_email,
      subject: subject)
  end
end


