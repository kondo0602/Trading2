class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 表示用のリサイズ済み画像を返す
  def display_image(_size)
    image.variant(gravity: :center, resize: 'sizex300^', crop: '300x300+0+0').processed
  end
end
