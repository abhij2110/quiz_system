class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :quiz, foreign_key: true
      t.text :question_text, null: false
      t.string :question_type, null: false         
      t.jsonb :options                              
      t.string :correct_answer                      
      t.integer :position                           

      t.timestamps
    end
  end
end
