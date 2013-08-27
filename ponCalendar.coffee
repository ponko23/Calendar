$ ->
  ###
    EventHandler
  ###
  $('#goToday').on 'click', ->
    goToday()
  $('#goBack').on 'click', ->
    goBack()
  $('#goNext').on 'click', ->
    goNext()
  $('#changeModeMonth').on 'click', ->
    changeMode('month')
  $('#changeModeWeek').on 'click', ->
    changeMode('week')
  $('#changeModeDay').on 'click', ->
    changeMode('day')
  $('#changeStartDay').on 'change', ->
    changeStartDay()
  $('#calendar').on 'click', 'td', (event)->
    selectDate(event)


  ###
    Model
  ###
  calendar =
    day: new ponDate()
    range:
      month: [6, 7]
      week: [1, 7]
      day: [1, 1]
    mode: 'month'
    start: 0 #0:日曜始まり 1:月曜始まり…

    today: () ->
      @day = new ponDate()

    moveDay: (width = null) ->
      return if !width
      switch @mode
        when 'month'
          @day.addMonth(width)
        when 'week'
          @day.addWeek(width)
        when 'day'
          @day.addDay(width)
        else

    changeMode: (mode) ->
      @mode = mode if @mode isnt mode

    changeStartDay: (day) ->
      @start = day


  ###
    Controller
  ###
  goToday = ->
    calendar.today()
    drowCalendar()

  goBack = ->
    calendar.moveDay(-1)
    drowCalendar()

  goNext = ->
    calendar.moveDay(1)
    drowCalendar()

  changeMode = (mode) ->
    calendar.changeMode(mode)
    drowCalendar()
    if mode is 'day'
      $('#changeStartDay').attr('disabled','disabled')
    else
      $('#changeStartDay').removeAttr('disabled','disabled')
  changeStartDay = ->
    calendar.changeStartDay(Number($('#changeStartDay').children('option:selected').val()))
    drowCalendar()

  selectDate = (event) ->
    $('.selectDay').removeClass('selectDay')
    currentDay = $(event.currentTarget)
    currentDay.addClass('selectDay')
    calendar.day.setDate(currentDay.attr('id'))
    $('#thisRange').text calendar.day.getDate()


  ###
    View
  ###
  drowCalendar = ->
    $('#calendar').empty()
    tableTxt =[]
    drowDate = new ponDate()
    drowDate.copy(calendar.day)
    if calendar.mode is 'month'
      drowDate.setDay(1)
      addDay = ((7-calendar.start)%7+drowDate.getWeekDay())%7
      addDay = 7 if addDay is 0
      drowDate.addDay(-addDay)
    else if calendar.mode is 'week'
      addDay = ((7-calendar.start)%7+drowDate.getWeekDay())%7
      drowDate.addDay(-addDay)
    tableTxt.push '<table id="', calendar.mode, '"><tbody><tr>'
    if calendar.mode is 'day'
      tableTxt.push '<th>',drowDate.getWeekString(), '</th></tr>'
    else
      weekArray = '日月火水木金土日月火水木金'
      for h in [0...calendar.range[calendar.mode][1]]
        tableTxt.push '<th>',weekArray[h + calendar.start],'</th>'
      tableTxt.push '</tr>'

    for [1..calendar.range[calendar.mode][0]]
      tableTxt.push '<tr>'
      for [1..calendar.range[calendar.mode][1]]
        tableTxt.push(
          '<td id="'
          drowDate.getDate().replace(/\//g, '-')
          '" class="sunday' if drowDate.getWeekDay() is 0
          '" class="saturday' if drowDate.getWeekDay() is 6
          '">'
          drowDate.getDay()
          '</td>'
        )
        drowDate.addDay(1)
      tableTxt.push '</tr>'
    tableTxt.push '</tbody></table>'
    $('#calendar').append(tableTxt.join '')
    $('tr').children('td[id^="' + calendar.day.getYear() + '-' + calendar.day.getMonth() + '"]').css('color','#000')
    $('#thisRange').text calendar.day.getDate()
    $('td[id^="' + calendar.day.getDate().replace(/\//g, '-') + '"]').addClass('selectDay')

  drowCalendar()