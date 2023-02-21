# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Admin.create(
   email: 'test@test.com',
   password: 'testtarou'
)

  Tag.create(
  [{ name: 'HG' },
  { name: 'MG' },
  { name: 'RG' },
  { name: 'EG' },
  { name: '素組' },
  { name: 'スミ入れ' },
  { name: '部分塗装' },
  { name: '艶消し' },
  { name: 'ミリタリー' },
  { name: '車' },
  { name: 'ロボット' },
  { name: '飛行機' },
  { name: 'アニメ' },
  { name: '城' },
])