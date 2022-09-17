#管理者ログイン用ユーザー作成
Admin.create!(
  email: "admin@admin",
  password: "testtest"
  )


#レビュー投稿タグ作成
Tag.create([
  { name: "エアロパーツ" },
  { name: "ホイール" },
  { name: "タイヤ" },
  { name: "エクステリアパーツ" },
  { name: "エンジン周りパーツ" },
  { name: "ステアリング" },
  { name: "シフトノブ" },
  { name: "インテリア用品" },
  { name: "その他カー用品" }
  ])
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
