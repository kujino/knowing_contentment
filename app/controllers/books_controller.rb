class BooksController < ApplicationController

  TITLE_KEYWORDS = ["東洋哲学", "仏教"]

  AUTHOR_KEYWORDS = ["藤田一照", "魚川祐司"]
  
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
