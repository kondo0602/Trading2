module ApplicationHelper
  # 表示するページに応じてタイトルを返すカスタムヘルパー
  def full_title(page_title = '')
    base_title = 'Trading'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
