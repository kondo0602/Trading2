# テストログインユーザの生成
name = 'テスト太郎'
email = 'a@sample.com'
address = '宮城'
password = 'password'
User.create!(name: name,
             email: email,
             address: address,
             password: password,
             password_confirmation: password)

# サイトの見栄え用サンプルデータの生成
20.times do |n|
  name  = "テストユーザ#{n + 1}"
  email = "foobar#{n + 1}@sample.com"
  address = %w[北海道 宮城 東京 神奈川 京都 福岡 沖縄].sample
  password = 'password'
  User.create!(name: name,
               email: email,
               address: address,
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(20)
3.times do
  name = ['Nike AirForce1', 'NewBalance m1700', 'Reebok Pump'].sample
  content = '仙台の古着屋で購入しました。あまり履かなくなったので出品します。'
  brand = %w[Nike adidas NewBalance Reebok converse BALENCIAGA].sample
  size = %w[24cm以下 24.5cm 25cm 25.5cm 26cm 26.5cm 27cm 27.5cm 28cm 28.5cm 29cm 29cm以上].sample
  status = %w[未使用新品 ほとんど使用していない やや使用感あり 使用感あり ジャンク品].sample
  users.each do |user|
    user.items.create!(name: name,
                       content: content,
                       brand: brand,
                       size: size,
                       status: status)
    # 最新のitem（上のcreateで作成したitemを取得する）
    item = Item.find_by(name: name)
    image_path = 'app/assets/images/'
    image_name = %w[item1.jpg item2.jpg item3.jpg item4.jpg item5.jpg item6.jpg item7.jpg item8.jpg item9.jpg
                    item10.jpg item11.jpg item12.jpg].sample
    item.image.attach(io: File.open(File.join(image_path, image_name)), filename: 'image_name')
    item.save!
  end
end
