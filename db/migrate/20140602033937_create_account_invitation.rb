class CreateAccountInvitation < ActiveRecord::Migration
  def change
    create_table :account_invitations do |t|
      t.string :inviter_email
      t.string :invitee_email
      t.string :invite_code
      t.datetime :sent_at, default: :null
      t.timestamps
    end
  end
end
