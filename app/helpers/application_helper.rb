module ApplicationHelper

  # 表示するページに応じてタイトルを返すカスタムヘルパー
  def full_title(page_title = '')
    base_title = "Trading"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
