// Generated by CoffeeScript 1.6.3
/*
  カスタムDateオブジェクト
*/

var ponDate;

ponDate = function() {
  return {
    ponDate: new Date(),
    getYear: function() {
      return this.ponDate.getFullYear();
    },
    setYear: function(val) {
      this.ponDate.setFullYear(val);
    },
    addYear: function(val) {
      this.ponDate.setFullYear(this.ponDate.getFullYear() + val);
    },
    getMonth: function() {
      return this.ponDate.getMonth() + 1;
    },
    setMonth: function(val) {
      this.ponDate.setMonth(val - 1);
    },
    addMonth: function(val) {
      this.ponDate.setMonth(this.ponDate.getMonth() + val);
    },
    getDay: function() {
      return this.ponDate.getDate();
    },
    setDay: function(val) {
      this.ponDate.setDate(val);
    },
    addDay: function(val) {
      this.ponDate.setDate(this.ponDate.getDate() + val);
    },
    getWeekDay: function() {
      return this.ponDate.getDay();
    },
    getWeekString: function() {
      return "日月火水木金土"[this.ponDate.getDay()];
    },
    addWeek: function(val) {
      this.ponDate.setDate(this.ponDate.getDate() + val * 7);
    },
    getLastDay: function() {
      return new Date(this.ponDate.getFullYear(), this.ponDate.getMonth() + 1, 0).getDate();
    },
    getHours: function() {
      return this.ponDate.getHours();
    },
    setHours: function(val) {
      this.ponDate.setHours(val);
    },
    getMinutes: function() {
      return this.ponDate.getMinutes();
    },
    setMinutes: function(val) {
      this.ponDate.setMinutes(val);
    },
    getSeconds: function() {
      return this.ponDate.getSeconds();
    },
    setSeconds: function(val) {
      this.ponDate.setSeconds(val);
    },
    getMilliseconds: function() {
      return this.ponDate.getMilliseconds();
    },
    setMilliseconds: function(val) {
      this.ponDate.setMilliseconds(val);
    },
    getDate: function(double) {
      var day, month;
      if (double) {
        month = "00" + (this.ponDate.getMonth() + 1);
        day = "00" + this.ponDate.getDate();
        return [this.ponDate.getFullYear(), month.substr(month.length - 2), day.substr(day.length - 2)].join('/');
      } else {
        return [this.ponDate.getFullYear(), this.ponDate.getMonth() + 1, this.ponDate.getDate()].join('/');
      }
    },
    setDate: function(val1, val2, val3) {
      var separator;
      if (typeof val1 === 'string') {
        if (val1.indexOf('-') > -1) {
          separator = '-';
        } else if (val1.indexOf('/') > -1) {
          separator = '/';
        } else {
          return;
        }
        val1 = val1.split(separator);
      }
      if (val1 instanceof Array) {
        val1 = val1.map(function(a) {
          return Number(a);
        });
        val3 = val1[2];
        val2 = val1[1];
        val1 = val1[0];
      }
      this.ponDate.setFullYear(val1);
      this.ponDate.setMonth(val2 - 1);
      this.ponDate.setDate(val3);
    },
    getTime: function() {
      return [this.ponDate.getHours(), this.ponDate.getMinutes(), this.ponDate.getSeconds()].join(':');
    },
    setTime: function(val1, val2, val3, val4) {
      if (val4 == null) {
        val4 = 0;
      }
      this.ponDate.setHours(val1);
      this.ponDate.setMinutes(val2);
      this.ponDate.setSeconds(val3);
      this.ponDate.setMilliseconds(val4);
    },
    copy: function(source) {
      this.ponDate = new Date(source.ponDate);
    }
  };
};
