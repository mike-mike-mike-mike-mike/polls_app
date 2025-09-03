class CreatePollResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :poll_responses do |t|
      t.references :poll, null: false, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
