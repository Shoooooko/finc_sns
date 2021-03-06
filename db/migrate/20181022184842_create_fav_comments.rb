# frozen_string_literal: true

class CreateFavComments < ActiveRecord::Migration[5.2]
  def change
    create_table :fav_comments do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
