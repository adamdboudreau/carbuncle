module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == @sort) ? "current &crarr; #{(@asc == 1) ? 'asc' : 'desc'}" : nil
    direction = (column == @sort && @asc == 1) ? 0 : 1
    #link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    link_to title, params.merge(sort: column, asc: direction, page: nil), {:class => css_class}
  end
end
