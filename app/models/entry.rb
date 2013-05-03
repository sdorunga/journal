class Entry < ActiveRecord::Base
  attr_accessible :title, :content, :time_capsule

  default_scope order('created_at desc')
end
