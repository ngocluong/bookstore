ActiveAdmin.register Book do

  permit_params :title, :description, :image_url,
                :author_name, :publisher_name,
                :published_date, :unit_price,
                :total_rating_value, :total_rating_count

  form do |f|
    f.inputs "Book Details" do
      f.input :title
      f.input :description
      f.input :image_url, as: :file
      f.input :author_name
      f.input :publisher_name
      f.input :published_date
      f.input :unit_price
    end
    f.actions
  end

  controller do
    before_action :upload_book_image, only: [:update]

    def upload_book_image
      uploaded_file = params[:book][:image_url]
      Cloudinary::Uploader.upload(uploaded_file.path, public_id:  uploaded_file.original_filename.slice(0,uploaded_file.original_filename.index('.')))
      params[:book][:image_url] = uploaded_file.original_filename
    end
  end
end
