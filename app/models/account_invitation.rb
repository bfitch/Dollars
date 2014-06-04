class AccountInvitation < ActiveRecord::Base
  validates :invitee_email, uniqueness: { message: "User has already been invited" }
end
