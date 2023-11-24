class CreateImageReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :image_reviews do |t|
      t.string :image_url

      t.timestamps
    end
  end
end
