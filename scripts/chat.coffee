module.exports = (robot) ->
  robot.respond /(.+)/i, (msg) ->
    msg.send msg.match[1]

  robot.hear /おみくじ/i, (msg) ->
    omikuji = ['大吉', '中吉', '小吉', '凶', '大凶']
    msg.send msg.random(omikuji)
