json.array! @items do |item|
  json.id      item.id
  json.image   item.image_url
  json.brand   item.brand.name
  json.name    item.name
end