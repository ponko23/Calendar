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
    today: new Date() # 基準日
    start: {} # calendarに描画する週・月の開始日(日曜日）
    end: {} # calendarに描画する週・月の最終日(土曜日)
    days: Number
    mode: 'month'
    # weekだと7日 monthだと6行42日

    copyDate: (day)->
      return new Date(day.getFullYear(), day.getMonth(), day.getDate())

    # todayを含むRangeｈへの移動
    moveToday: ->
      @today = new Date()
      @moveRange 0

    # modeに応じてfirstdayとstartdayを変更し、calendarを再描画する
    moveRange: (vol)->
      @start = @copyDate @today
      switch @mode
        when 'day'
          @start.setDate(@start.getDate() + vol)
          @today.setDate(@today.getDate() + vol)
          $('#calendar').text @start.toLocaleDateString()
        when 'week'
          @start.setDate(@start.getDate() + vol * 7)
          @start.setDate(@start.getDate() - @start.getDay())
          @end = @copyDate @start
          @end.setDate(@end.getDate() + 6)
          @today.setDate(@today.getDate() + vol * 7)
          $('#calendar').text @start.toLocaleDateString() + ' - ' + @end.toLocaleDateString()
        when 'month'
          @start.setMonth(@start.getMonth() + vol)
          @start.setDate(1)
          @start.setDate(1 - @start.getDay())
          @today.setMonth(@today.getMonth() + vol)
          @end = @copyDate @start
          @end.setDate(@end.getDate() + 41)
          $('#calendar').text @start.toLocaleDateString() + ' - ' + @end.toLocaleDateString()
        else
      $('#thisRange').text @today.toLocaleDateString()

    changeMode: (mode)->
      @mode = mode
      @moveRange 0

  ###
    View
  ###
