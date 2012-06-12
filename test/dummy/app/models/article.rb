class Article < ActiveRecord::Base
  attr_accessible :author_id, :content, :published, :title
end
