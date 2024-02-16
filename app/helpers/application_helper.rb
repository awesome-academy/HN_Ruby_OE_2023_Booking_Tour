module ApplicationHelper
  include Pagy::Frontend
  def set_title title
    base_title = t("base_title")
    title.empty? ? base_title : " #{base_title} | #{title}"
  end
end
