module ApplicationHelper

  def default_meta_tags
    {
      site: "BuddhaLog",
      title: "仏教みつけ",
      reverse: true,
      charset: "utf-8",
      description: "日常の中の出来事を「仏教の視点」で見つめ直せる投稿サービスです。",
      keywords: "仏教,禅,初期仏教,上座部仏教,大乗仏教",
      canonical: "https://buddhalog.com/",
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: "https://buddhalog.com/",
        image: image_url("ogp.png"),
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@obvyamdrss",
        image: image_url("ogp.png")
      }
    }
  end
end
