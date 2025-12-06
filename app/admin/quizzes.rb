ActiveAdmin.register Quiz do
  permit_params :title,
    questions_attributes: [
      :id, :question_text, :question_type,
      :options, :correct_answer, :position,
      :_destroy
    ]

  index do
    selectable_column
    id_column
    column :title
    column :created_at
    actions
  end

  filter :title
  filter :created_at


  form do |f|
    f.semantic_errors

    f.inputs "Quiz Details" do
      f.input :title
    end

    f.inputs "Questions" do
      f.has_many :questions, allow_destroy: true, sortable: :position, new_record: "Add Question" do |q|
        q.input :question_text
        q.input :question_type, as: :select, collection: Question::QUESTION_TYPES

        q.input :options, as: :text,
          hint: "For MCQ only. Enter JSON array like: [\"Option 1\", \"Option 2\"]"

        q.input :correct_answer,
          hint: "For MCQ → must match one option; For boolean → true/false; For text → exact answer"

        q.input :position
      end
    end

    f.actions
  end
end
