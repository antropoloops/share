# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params %i(email name locale password password_confirmation)

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :locale
    column :created_at
    column :updated_at
    column :confirmed_at
    actions
  end

  filter :email
  filter :locale
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :locale
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def update_resource(object, attributes)
      attributes.each do |attr|
        # Allows updating the user without changing the password
        if attr[:password].blank? && attr[:password_confirmation].blank?
          attr.delete :password
          attr.delete :password_confirmation
        end
      end

      object.public_send :update_attributes, *attributes
    end
  end
end
