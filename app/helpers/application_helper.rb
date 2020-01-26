module ApplicationHelper

  def length_select(gender)
    if gender == 1
      Length.all.first(7)
    elsif gender == 2
      Length.all.last(6)
    else
      Length.all
    end
  end

end
