# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://gstonehill.xyz"

SitemapGenerator::Sitemap.create do
  # ルートページ
  add root_path, priority: 1.0, changefreq: 'daily'

  # 静的ページ
  add home_path, priority: 0.8, changefreq: 'daily'
  add about_path, priority: 0.2, changefreq: 'yearly'  # 優先度低
  add help_path, priority: 0.2, changefreq: 'yearly'   # 優先度低
  add contact_path, priority: 0.5, changefreq: 'yearly'
  add signup_path, priority: 0.7, changefreq: 'yearly'
  add login_path, priority: 0.7, changefreq: 'yearly'

  # Tierlistの新規作成ページを優先的に表示
  add new_tierlist_path, priority: 1.0, changefreq: 'daily'

  # 既存のTierlistページ
  Tierlist.find_each do |tierlist|
    add tierlist_path(tierlist), lastmod: tierlist.updated_at, priority: 0.8, changefreq: 'weekly'
  end
end