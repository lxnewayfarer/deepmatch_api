# frozen_string_literal: true

ActiveAdmin.register MessageTemplate do
  permit_params :slug, :text, :bot_id, :image

  index do
    selectable_column
    id_column
    column :slug
    column :text
    column :bot
    column :image do |message|
      next if message.image_url.blank?

      if message.image(:small).blank?
        message.image_derivatives!
        message.save
      end

      image_tag(message.image(:small).url)
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :slug
      f.input :text, as: :text
      f.input :bot, as: :select, collection: Bot.all
      f.input :image, as: :file,
                      hint: f.object.image(:small).present? ? image_tag(f.object.image(:small).url) : 'Изображение',
                      input_html: { class: 'image_field' }
    end
    f.actions
  end
end
