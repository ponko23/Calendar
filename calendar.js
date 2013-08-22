// Generated by CoffeeScript 1.6.3
$(function() {
  /*
    EventHandler
  */

  var displayRange, drowCalendar, schedule;
  $('#today').on('click', function() {
    return displayRange.moveToday();
  });
  $('#before').on('click', function() {
    return displayRange.moveRange(-1);
  });
  $('#next').on('click', function() {
    return displayRange.moveRange(1);
  });
  $('#monthMode').on('click', function() {
    return displayRange.changeMode('month');
  });
  $('#weekMode').on('click', function() {
    return displayRange.changeMode('week');
  });
  $('#dayMode').on('click', function() {
    return displayRange.changeMode('day');
  });
  /*
    Model
  */

  schedule = {
    day: Date,
    subject: String,
    detail: String
  };
  displayRange = {
    today: new ponDate(),
    start: new ponDate(),
    end: new ponDate(),
    days: Number,
    mode: 'month',
    moveToday: function() {
      this.today = new ponDate();
      return this.moveRange(0);
    },
    moveRange: function(val) {
      this.start.copy(this.today);
      switch (this.mode) {
        case 'day':
          this.today.addDay(val);
          this.start.addDay(val);
          $('#calendar').text(this.start.getDate() + this.start.getWeekString());
          break;
        case 'week':
          this.today.addWeek(val);
          this.start.addWeek(val);
          this.start.addDay(-this.start.getWeekDay());
          this.end.copy(this.start);
          this.end.addDay(6);
          $('#calendar').text(this.start.getDate() + ' - ' + this.end.getDate());
          break;
        case 'month':
          this.today.addMonth(val);
          this.start.addMonth(val);
          this.start.setDay(1);
          this.start.addDay(this.start.getWeekDay() === 0 ? -7 : -this.start.getWeekDay());
          this.end.copy(this.start);
          this.end.addDay(41);
          break;
      }
      return drowCalendar();
    },
    changeMode: function(mode) {
      this.mode = mode;
      return this.moveRange(0);
    }
  };
  /*
    View
  */

  drowCalendar = function() {
    var dispDate, tableTxt, _i, _j, _k;
    $('#calendar').empty();
    tableTxt = [];
    dispDate = new ponDate();
    dispDate.copy(displayRange.start);
    switch (displayRange.mode) {
      case 'month':
        tableTxt.push('<table class="month"><tbody><tr><th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th></tr>');
        for (_i = 1; _i <= 6; _i++) {
          tableTxt.push('<tr>');
          for (_j = 1; _j <= 7; _j++) {
            tableTxt.push('<td>', dispDate.getDay(), '</td>');
            dispDate.addDay(1);
          }
          tableTxt.push('</tr>');
        }
        tableTxt.push('</tbody></table>');
        $('#thisRange').text([displayRange.today.getYear(), displayRange.today.getMonth()].join('/'));
        break;
      case 'week':
        tableTxt.push('<table class="week"><tbody><tr><th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th></tr>');
        for (_k = 1; _k <= 7; _k++) {
          tableTxt.push('<td>', dispDate.getDay(), '</td>');
          dispDate.addDay(1);
        }
        tableTxt.push('</tr>');
        tableTxt.push('</tbody></table>');
        $('#thisRange').text(displayRange.today.getDate());
        break;
      case 'day':
        tableTxt.push('<table class="day"><tbody><tr><th>', dispDate.getDay(), dispDate.getWeekString(), '</th></tr><tr><td></td></tr></tbody></table>');
        $('#thisRange').text(displayRange.today.getDate());
        break;
    }
    return $('#calendar').append(tableTxt.join(''));
  };
  return displayRange.moveToday();
});
