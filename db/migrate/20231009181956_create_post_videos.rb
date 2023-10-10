class CreatePostVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :post_videos do |t|
      t.string :title, null: false, default: ""
      t.string :video_source, null: false
      t.string :description, null: false, default: ""
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
