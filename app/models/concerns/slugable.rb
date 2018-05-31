module Slugable

  private

  def set_prefixed_slug
    slug = self.name.downcase.split(" ").join("-")

    unless self.is_root? || self.parent.is_root?
      slug = parent.slug + '-' + slug
    end

    write_attribute(:slug, slug)
  end  
end