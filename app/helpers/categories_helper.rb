module CategoriesHelper
  def display_period_dates(range)
    "#{format_date(range.first)} - #{format_date(range.last)}"
  end
end
