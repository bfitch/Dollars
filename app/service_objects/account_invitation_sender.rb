class AccountInvitationSender
  attr_reader :invitation

  def initialize(invitation)
    @invitation = invitation
  end

  def call
    AccountInvitationMailer.invite(invitation).deliver
  end
end
