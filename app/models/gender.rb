class Gender < ActiveHash::Base
  self.data = [
    {id: 1, name: "Women"}, {id: 2, name: "Men"}, {id: 3, name: "Free"}
  ]
end