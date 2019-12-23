module PostsHelper
  def salon_name(salon)
    salonName = salon.name.split(/\【.*?\】/).join
    salonName.gsub("　", "")
  end
end
