class AccountInvitation < ActiveRecord::Base
  #TODO: add completed column, set to true when link is clicked
  #lookup invitation where `completed` is false to prevent 
  #reusing link and
  #
  #check for invite_code at beginning of action. If doesn't match
  #return unauthorized
end
