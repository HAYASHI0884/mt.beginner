# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Area.create(name:'北海道')
Area.create(name:'青森県')
Area.create(name:'岩手県')
Area.create(name:'宮城県')
Area.create(name:'秋田県')
Area.create(name:'山形県')
Area.create(name:'福島県')
Area.create(name:'茨城県')
Area.create(name:'栃木県')
Area.create(name:'群馬県')
Area.create(name:'埼玉県')
Area.create(name:'千葉県')
Area.create(name:'東京都')
Area.create(name:'神奈川県')
Area.create(name:'新潟県')
Area.create(name:'富山県')
Area.create(name:'石川県')
Area.create(name:'福井県')
Area.create(name:'山梨県')
Area.create(name:'長野県')
Area.create(name:'岐阜県')
Area.create(name:'静岡県')
Area.create(name:'愛知県')
Area.create(name:'三重県')
Area.create(name:'滋賀県')
Area.create(name:'京都府')
Area.create(name:'大阪府')
Area.create(name:'兵庫県')
Area.create(name:'奈良県')
Area.create(name:'和歌山県')
Area.create(name:'鳥取県')
Area.create(name:'島根県')
Area.create(name:'岡山県')
Area.create(name:'広島県')
Area.create(name:'山口県')
Area.create(name:'徳島県')
Area.create(name:'香川県')
Area.create(name:'愛媛県')
Area.create(name:'高知県')
Area.create(name:'福岡県')
Area.create(name:'佐賀県')
Area.create(name:'長崎県')
Area.create(name:'熊本県')
Area.create(name:'大分県')
Area.create(name:'宮崎県')
Area.create(name:'鹿児島県')
Area.create(name:'沖縄県')

Elevation.create(name:'1000m未満')
Elevation.create(name:'1000m以上、2000m未満')
Elevation.create(name:'2000m以上、3000m未満')
Elevation.create(name:'3000m以上')

ClimbTime.create(name:'2時間未満')
ClimbTime.create(name:'2時間以上、4時間未満')
ClimbTime.create(name:'4時間以上、6時間未満')
ClimbTime.create(name:'6時間以上、8時間未満')
ClimbTime.create(name:'8時間以上')

Mountain.create(name:'にゅう', area_id:'20', elevation_id:'3', climb_time_id:'2')
Mountain.create(name:'愛鷹山(あしたかやま)', area_id:'22', elevation_id:'2', climb_time_id:'3')
Mountain.create(name:'茶臼山(ちゃうすやま)', area_id:'20', elevation_id:'2', climb_time_id:'2')
Mountain.create(name:'至仏山(しぶつさん)', area_id:'10', elevation_id:'3', climb_time_id:'3')
Mountain.create(name:'鳳来寺山(ほうらいじさん)', area_id:'23', elevation_id:'1', climb_time_id:'3')
Mountain.create(name:'蓼科山(たてしなやま)', area_id:'20', elevation_id:'3', climb_time_id:'4')
Mountain.create(name:'縞枯山(しまがれやま)', area_id:'20', elevation_id:'3', climb_time_id:'5')
Mountain.create(name:'赤城山(あかぎさん)', area_id:'10', elevation_id:'2', climb_time_id:'2')
Mountain.create(name:'榛名山(はるなさん)', area_id:'10', elevation_id:'2', climb_time_id:'3')
Mountain.create(name:'妙義山(みょうぎさん)', area_id:'10', elevation_id:'2', climb_time_id:'3')
Mountain.create(name:'男体山(なんたいさん)', area_id:'9', elevation_id:'3', climb_time_id:'4')
Mountain.create(name:'富士山(ふじさん)吉田コース', area_id:'19', elevation_id:'4', climb_time_id:'5')
Mountain.create(name:'大小山(だいしょうやま)',area_id:'9', elevation_id:'1', climb_time_id:'2')
