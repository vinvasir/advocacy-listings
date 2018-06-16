class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def post_read_path_for(user)
    raise "Method not implemented: post read path"
  end
end
