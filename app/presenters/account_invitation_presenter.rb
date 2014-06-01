class AccountInvitationPresenter < Struct.new(:invitation)
  def invitation_link
    "#{base_uri}?#{query_params}"
  end

  private

  def base_uri
    "http://localhost:3001/"
  end

  def query_params
    { invite_code:   invitation.invite_code,
      inviter_email: invitation.inviter_email
      invitee_email: invitation.invitee_email }.to_query
  end
end
