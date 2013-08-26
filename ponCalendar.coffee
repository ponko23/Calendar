$ ->
  ###
    EventHandler
  ###
  $('#goToday').on 'click', ->
    calendar.goToday()
    drowCalendar()
  $('#goBack').on 'click', ->
    calendar.moveDay(-1)
    drowCalendar()
  $('#goNext').on 'click', ->
    calendar.moveDay(1)
    drowCalendar()
  $('#changeModeMonth').on 'click', ->
    calendar.changeMode('month')
    drowCalendar()
  $('#changeModeWeek').on 'click', ->
    calendar.changeMode('week')
    drowCalendar()
  $('#changeModeDay').on 'click', ->
    calendar.changeMode('day')
    drowCalendar()
  $('#changeStartDay').on 'click', ->
    calendar.changeStartDay()
    drowCalendar()
  $('#calendar').on 'click', 'td', (event)->
    $('.selectedDay').removeClass('selectedDay')
    currentDay = $(event.currentTarget)
    currentDay.addClass('selectedDay')
    a = currentDay.attr('id').split('-')
    calendar.day.setDate(Number(a[0]), Number(a[1]), Number(a[2]))


  ###
    Model
  ###
  calendar = ->
    day: new ponDate()
    range:
      month: [6, 7]
      week: [1, 7]
      day: [1, 1]
    mode: 'month'
    start: 0

    goToday: ->
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

    changeStartDay: ->
      if @start is 6
        @start = 0
      else
        @start++


  ###
    Controller
  ###



  ###
    View
  ###
  drowCalendar = ->
    $('#calendar').empty()
    tableTxt =[]
    drowDate = new ponDate()
    drowDate.copy(calendar.day)
    tableTxt.push '<table ="', calendar.mode, '"><tr>'

    for d in [1..calendar.range]
