$ ->
  ###
    EventHandler
  ###
  $('#today').on 'click', ->
    moveToday()
  $('#before').on 'click', ->
    beforeRange()
  $('#next').on 'click', ->
    nextRange()
  $('#monthMode').on 'click', ->
    changeMonthMode()
  $('#weekMode').on 'click', ->
    changeWeekMode()
  $('#dayMode').on 'click', ->
    changeDayMode()

  $('#calendar').on 'click', 'td', (event) ->
    cellSelect(event)

  ###
    Model
  ###
  schedule =
    day: Date
    subject: String
    detail: String

  displayRange =
    today: new ponDate() # 基準日
    start: new ponDate() # calendarに描画する週・月の開始日(日曜日）
    mode: 'month' # month、week、dayがある 初期値month
    range: 6 # 表示する週の数 月と週の時のみ使用する

    # 引数と月週日モードに応じてtodayを移動し、todayからstart、endを求める
    # 引数(val:-1、null、1 )
    moveRange: (val = null)->
      switch @mode
        when 'day'
          @today.addDay(val) if val
          @start.copy(@today)
        when 'week'
          @today.addWeek(val) if val
          @start.copy(@today)
          @start.addDay(-@start.getWeekDay())
          @range = 1
        when 'month'
          @today.addMonth(val) if val
          @start.copy(@today)
          @start.setDay(1)
          @start.addDay(if @start.getWeekDay() is 0 then -7 else -@start.getWeekDay())
          @range = 6
        else

    # 月週日表示モードの切り替え
    # 引数(mode:'month'、'week'、'day')
    changeMode: (mode)->
      @mode = mode
      @moveRange()

    # todayを現在日に移動
    moveToday: ->
      @today = new ponDate()
      @moveRange()

  ###
    Controller
  ###
  moveToday = ->
    displayRange.moveToday()
    drowCalendar()

  beforeRange = ->
    displayRange.moveRange(-1)
    drowCalendar()

  nextRange = ->
    displayRange.moveRange(1)
    drowCalendar()

  changeMonthMode = ->
    displayRange.changeMode('month')
    displayRange.moveRange()
    drowCalendar()

  changeWeekMode = ->
    displayRange.changeMode('week')
    displayRange.moveRange()
    drowCalendar()

  changeDayMode = ->
    displayRange.changeMode('day')
    drowCalendar()

  cellSelect = (event) ->
    $('.selectday').removeClass('selectday')
    $(event.currentTarget).addClass('selectday')
    tmpArray = $(event.currentTarget).attr('id').split('-')
    tmpArray[0] = Number(tmpArray[0])
    tmpArray[1] = Number(tmpArray[1])
    tmpArray[2] = Number(tmpArray[2])
    displayRange.today.setDate(tmpArray[0], tmpArray[1], tmpArray[2])
    displayRange.moveRange()

  ###
    View
  ###
  # カレンダー描画
  drowCalendar = ->
    $('#calendar').empty()
    tableTxt = []
    dispDate = new ponDate()
    dispDate.copy(displayRange.start)
    if displayRange.mode is 'day'
      tableTxt.push(
        '<table class="day"><tbody><tr><th>'
        dispDate.getWeekString()
        '</th></tr><tr><td id="'
        displayRange.today.getDate().replace(/\//g, '-')
        '"><p>'
        dispDate.getDay()
        '</p></td></tr></tbody></table>'
      )
      $('#thisRange').text displayRange.today.getDate()
    else
      tableTxt.push '<table class="', displayRange.mode, '"><tbody><tr><th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th></tr>'
      weeks = displayRange.range
      for [1..weeks]
        tableTxt.push '<tr>'
        for [1..7]
          tableTxt.push '<td id="', dispDate.getDate().replace(/\//g, '-'), '"><p>', dispDate.getDay(), '</p></td>'
          dispDate.addDay(1)
        tableTxt.push '</tr>'
      tableTxt.push '</tbody></table>'
      $('#thisRange').text displayRange.today.getDate()
    $('#calendar').append tableTxt.join ''
    # todayが含まれる月の日付のみ黒くする
    $('tr').children('td[id^="' +displayRange.today.getYear() + '-' + displayRange.today.getMonth() + '"]').children('p').css('color','#000')
    $('#' + dispDate.getDate().replace(/\//g, '-')).addClass('selectday')

  displayRange.moveToday()
  drowCalendar()