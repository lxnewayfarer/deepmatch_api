# frozen_string_literal: true

ActiveAdmin.register Form do
  Formtastic::FormBuilder.perform_browser_validations = true

  permit_params :title, :description, :private_comment, :tenant_id, :bot_id, form_questions_attributes: %i[id question kind slug _destroy]

  show do |form|
    attributes_table do
      row :id
      row :title
      row :button_title
      row :description
      row :private_comment
      row :bot
    end

    render(partial: 'preview', form:)

    panel '' do
      table_for form.form_questions do
        column :question
        column :kind do |form_question|
          form_question.kind&.value
        end
        column :slug, &:slug
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :bot, as: :select, collection: Bot.all

      f.input :title
      f.input :button_title
      f.input :description

      f.has_many :form_questions, allow_destroy: true do |question|
        question.input :question, input_html: { required: true }
        question.input :kind, as: :select, include_blank: false, collection: FormQuestion.kind.values.collect {
          [FormQuestion.kind.find_value(_1).value, _1]
        }
        question.input :slug, as: :select, include_blank: true, collection: FormQuestion.slug.values
      end
      f.input :private_comment
    end

    f.actions
  end
end
