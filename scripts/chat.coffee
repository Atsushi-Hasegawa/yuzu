module.exports = (robot) ->
  robot.respond /(.+)/i, (msg) ->
    msg.send msg.match[1]

  robot.hear /おみくじ/i, (msg) ->
    omikuji = ['大吉', '中吉', '小吉', '凶', '大凶']
    msg.send msg.random(omikuji)

  robot.respond /hatena (.*)/i, (msg) ->
   category = msg.match[1]
   request = require('request')
   parser  = require 'xml2json'
   uri = "http://b.hatena.ne.jp/entrylist/#{category}?mode=rss"
   #httpリクエストで要素を取得する
   request.get(uri, (error, response, body) ->
    if error or response.statusCode != 200
      return msg.send('fail to article')

    #xmlをjsonに変換
    json = parser.toJson(body, { object : true })
    
    counter = 0
    #要素に分けて表示
    for result in json['rdf:RDF']['item']
      text = text + "#{result.title}\n\n"
      text = text + "#{result.link}\n\n"
      text = text + "#{result.description}\n\n"
      
      counter += 1
      msg.send text if counter == json["rdf:RDF"]["item"].length
   )
