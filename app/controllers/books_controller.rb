class BooksController < ApplicationController

  TITLE_KEYWORDS = ["東洋哲学", "仏教 入門", "仏教 悟り"]

  AUTHOR_KEYWORDS = ["藤田 一照", "魚川 祐司"]
  
  def index
    search_type = [:title, :author].sample

    if search_type == :title
      keyword = TITLE_KEYWORDS.sample
      result = RakutenWebService::Books::Book.search(title: keyword)
    else
      keyword = AUTHOR_KEYWORDS.sample
      result = RakutenWebService::Books::Book.search(author: keyword)
    end
    
    @books = result.first(10)
  
  end

end
