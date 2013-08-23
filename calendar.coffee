$ ->
  ###
    EventHandler
  ###
  $('#today').on 'click', ->
    displayRange.moveToday()
  $('#before').on 'click', ->
    displayRange.moveRange -1
  $('#next').on 'click', ->
    displayRange.moveRange 1
  $('#monthMode').on 'click', ->
    displayRange.changeMode 'month'
  $('#weekMode').on 'click', ->
    displayRange.changeMode 'week'
  $('#dayMode').on 'click', ->
    displayRange.changeMode 'day'

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

    # todayを含むRangeへの移動
    moveToday: ->
      @today = new ponDate()
      @moveRange 0

    # modeに応じてstartを変更し、calendarを再描画する
    moveRange: (val)->
      @start.copy @today
      switch @mode
        when 'day'
          @today.addDay(val)
          @start.addDay(val)
          $('#calendar').text @start.getDate() + @start.getWeekString()
        when 'week'
          @today.addWeek(val)
          @start.addWeek(val)
          @start.addDay(-@start.getWeekDay())
          @end.copy(@start)
          @end.addDay(6)
          $('#calendar').text @start.getDate() + ' - ' + @end.getDate()
        when 'month'
          @today.addMonth(val)
          @start.addMonth(val)
          @start.setDay(1)
          @start.addDay(if @start.getWeekDay() is 0 then -7 else -@start.getWeekDay())
          @end.copy(@start)
          @end.addDay(41)
        else
      drowCalendar()
    changeMode: (mode)->
      @mode = mode
      @moveRange 0

  ###
    View
  ###
  drowCalendar = ->
    $('#calendar').empty()
    tableTxt = []
    dispDate = new ponDate()
    dispDate.copy(displayRange.start)
    switch displayRange.mode
      when 'month'
        tableTxt.push '<table class="month"><tbody><tr><th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th></tr>'
        for [1..6]
          tableTxt.push '<tr>'
          for [1..7]
            tableTxt.push '<td id="', dispDate.getDate(), '"><p>', dispDate.getDay(), '</p></td>'
            dispDate.addDay(1)
          tableTxt.push '</tr>'
        tableTxt.push '</tbody></table>'
        $('#thisRange').text [displayRange.today.getYear(), displayRange.today.getMonth()].join '/'
      when 'week'
        tableTxt.push '<table class="week"><tbody><tr><th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th></tr>'
        for [1..7]
          tableTxt.push '<td id="', dispDate.getDate(), '"><p>', dispDate.getDay(), '</p></td>'
          dispDate.addDay(1)
        tableTxt.push '</tr>'
        tableTxt.push '</tbody></table>'
        $('#thisRange').text displayRange.today.getDate()
      when 'day'
        tableTxt.push '<table class="day"><tbody><tr><th>', dispDate.getDay(), dispDate.getWeekString(), '</th></tr><tr><td></td></tr></tbody></table>'
        $('#thisRange').text displayRange.today.getDate()
      else
    $('#calendar').append tableTxt.join ''
    $('tr').children('td[id^="' +displayRange.today.getYear() + '/' + displayRange.today.getMonth() + '"]').children('p').css('color','#000')

  displayRange.moveToday()