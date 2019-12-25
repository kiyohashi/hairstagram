class Genre < ActiveHash::Base
  self.data = [
    {id: 1, name: "ヘアワックス・クリーム"}, {id: 2, name: "ヘアジェル"}, {id: 3, name: "ヘアムース"},
    {id: 4, name: "ヘアスプレー・ミスト"}, {id: 5, name: "プレスタイリング・寝ぐせ直し"}, {id: 6, name: "その他ヘアスタイリング"},
    {id: 7, name: "ヘアケア美容家電"}
  ]
end