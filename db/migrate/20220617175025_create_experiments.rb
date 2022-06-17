class CreateExperiments < ActiveRecord::Migration[7.0]
  def change
    create_table :experiments do |t|
      t.string :title, null: false
      t.text :description
      t.string :key, null: false, index: true
      t.text :javascript
      t.text :stylesheet
      t.boolean :approved, default: false, null: false
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }, index: true
      t.references :updated_by_user, null: false, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
  end
end
