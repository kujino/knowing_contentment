class BooksController < ApplicationController

  DEFAULT_KEYWORDS = ["藤田一照", "東洋哲学", "仏教　入門"]
  
  def index
    keyword = params[:keyword] || DEFAULT_KEYWORDS.sample
    result = RakutenWebService::Books::Book.search(title: keyword)
    @books = result.take(10)
  end

end
