module PostsHelper
  def salon_name(salon)
    salon.name.split(/\【.*?\】/).join
  end
end
