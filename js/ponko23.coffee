###
  カスタムDateオブジェクト

###
ponDate = ->
  ponDate: new Date()

  # 西暦表記の年数を返す
  getYear: ->
    @ponDate.getFullYear()

  # 西暦表記の年数を設定する
  # 引数(val:年)
  setYear: (val)->
    @ponDate.setFullYear(val)
    return

  # 年を加算する(マイナス値指定で減算)
  # 引数(val:年)
  addYear: (val)->
    @ponDate.setFullYear(@ponDate.getFullYear() + val)
    return

  # 月を返す(1~12)
  getMonth: ->
    @ponDate.getMonth() + 1

  # 月を設定する(1~12)
  # 引数(val:月)
  setMonth: (val)->
    @ponDate.setMonth(val - 1)
    return

  # 月を加算する(マイナス値指定で減算)
  # 引数(val:月)
  addMonth: (val)->
    @ponDate.setMonth(@ponDate.getMonth() + val)
    return

  # 日を返す(1~31)
  getDay: ->
    @ponDate.getDate()

  # 日を設定する(1~31)
  # 引数(val:日)
  setDay: (val)->
    @ponDate.setDate(val)
    return

  # 日を加算する(マイナス値指定で減算)
  # 引数(val:日)
  addDay: (val)->
    @ponDate.setDate(@ponDate.getDate() + val)
    return

  # 曜日を数値で返す(日:0、月:1、火:2、水:3、木:4、金:5、土:6)
  getWeekDay: ->
    @ponDate.getDay()

  # 曜日を漢字で返す(日、月、火、水、木、金、土)
  getWeekString: ->
    "日月火水木金土"[@ponDate.getDay()]

  # 週を加算する(マイナス値指定で減算)
  # 引数(val:週)
  addWeek: (val)->
    @ponDate.setDate(@ponDate.getDate() + val * 7)
    return

  # 月末日を返す(28~31)
  getLastDay: ->
    new Date(
      @ponDate.getFullYear()
      @ponDate.getMonth() + 1
      0
    ).getDate()

  # 時を返す(0~23)
  getHours: ->
    @ponDate.getHours()

  # 時を設定する(0~23)
  setHours: (val)->
    @ponDate.setHours(val)
    return

  # 分を返す(0~59)
  getMinutes: ->
    @ponDate.getMinutes()

  # 分を設定する(0~59)
  setMinutes: (val)->
    @ponDate.setMinutes(val)
    return

  # 秒を返す(0~59)
  getSeconds: ->
    @ponDate.getSeconds()

  # 秒を設定する(0~59)
  setSeconds: (val)->
    @ponDate.setSeconds(val)
    return

  # ミリ秒を返す(0~999)
  getMilliseconds: ->
    @ponDate.getMilliseconds()

  # ミリ秒を設定する(0~999)
  setMilliseconds: (val)->
    @ponDate.setMilliseconds(val)
    return

  # 日付を文字列で返す("年/月/日")
  # 引数(double:null以外なら月日を2桁表示に固定する)
  getDate: (double)->
    if double
      month = ("00" + (@ponDate.getMonth() + 1))
      day = ("00" + @ponDate.getDate())
      [
        @ponDate.getFullYear()
        month.substr(month.length-2)
        day.substr(day.length-2)
      ].join '/'
    else
      [
        @ponDate.getFullYear()
        @ponDate.getMonth() + 1
        @ponDate.getDate()
      ].join '/'


  # 日付を設定する
  # 引数(val1:年or配列or文字列, val2:月,val3:日)
  # 文字列の場合、'yyyy-MM-dd'でも'yyyy/M/d'でも可、'yyyy-MM/dd'は不可
  # 配列の場合、文字列配列でも数値配列でも可
  setDate: (val1, val2, val3)->
    if typeof val1 is 'string'
      if val1.indexOf('-') > -1
        separator = '-'
      else if val1.indexOf('/') > -1
        separator = '/'
      else
        return
      val1 = val1.split(separator)

    if val1 instanceof Array
      val1 = val1.map((a)->Number(a))
      val3 = val1[2]
      val2 = val1[1]
      val1 = val1[0]
    @ponDate.setFullYear(val1)
    @ponDate.setMonth(val2 - 1)
    @ponDate.setDate(val3)
    return

  # 時間を文字列で返す("時:分:秒:ミリ秒")
  getTime: ->
    [
      @ponDate.getHours()
      @ponDate.getMinutes()
      @ponDate.getSeconds()
    ].join ':'

  # 時間を設定する
  # 引数(val1:時, val2:分, val3:秒, val4:ミリ秒)
  setTime: (val1, val2, val3, val4 = 0)->
    @ponDate.setHours(val1)
    @ponDate.setMinutes(val2)
    @ponDate.setSeconds(val3)
    @ponDate.setMilliseconds(val4)
    return

  # ponDateオブジェクトをコピーする
  # 引数(source:コピー元ponDateオブジェクト
  copy: (source)->
    @ponDate = new Date(source.ponDate)
    return
