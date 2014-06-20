ActiveAdmin.register Book do
  permit_params :title, :description, :image_url,
                :author_name, :publisher_name,
                :published_date, :unit_price,
                :total_rating_value, :total_rating_count


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

end
