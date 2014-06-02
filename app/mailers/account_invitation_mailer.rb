class AccountInvitationMailer < ActionMailer::Base
  default from: "donotreply@dollarsapp.io"

  def invite(invitation)
    @presenter = AccountInvitationPresenter.new(invitation)
    subject    = "Invitation to link your Dollars account"

    mail(
      to:      invitation.invitee_email,
      subject: subject)
  end
end


