# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false, unique: true
      t.datetime :expired_at
      t.references :sender, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
