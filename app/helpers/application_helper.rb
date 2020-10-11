module ApplicationHelper
  def title(page_title = '')
    base_title = 'Stelle'
    page_title.empty? ? base_title : (page_title + ' | ' + base_title)
  end
end
