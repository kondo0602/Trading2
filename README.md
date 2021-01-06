# TRADING

このアプリケーションはユーザ同士のスニーカーのトレードをサポートします！

http://ec2-18-182-80-77.ap-northeast-1.compute.amazonaws.com/

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/874156/40bf5f2f-f141-886c-f1c5-30bcc14ec2cc.png)


# 開発環境
- 言語：Ruby 2.6.6
- フレームワーク：Rails 6.0.3
- DB：MySQL 8.0.22
- インフラ：AWS(VPC/EC2)
- コードエディタ：atom
- コード整形：atom-beautify

# 実装機能(使用ライブラリ)
- ユーザログイン機能
- ユーザ編集・削除機能
- 管理ユーザログイン機能
- 商品一覧表示機能
- 商品詳細表示機能
- 商品投稿機能
- 画像アップロード機能（active_storage）
- 商品の下書き機能
- 商品編集・削除機能
- 商品に対するお気に入り・コメント機能
- ユーザ間でのメッセージのやり取り
- 商品検索機能：AND検索/OR検索/商品の条件による検索
- ページネーション機能（will_paginate）
- 自動テスト（rspec-rails/factory_bot_rails/webdrivers/capybara)


# DB構造図
![E-R](https://user-images.githubusercontent.com/73473550/102683720-653ad400-4216-11eb-9fcc-d30b13072d8f.png)

# 作者
- Qiita：https://qiita.com/kondo0602
- Twitter：https://twitter.com/kondo0602_t
