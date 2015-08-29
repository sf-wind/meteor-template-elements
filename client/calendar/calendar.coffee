buildCalendar = (month) ->
  localeFirstDay = 0
  startOfMonth = moment(month).startOf('month')
  lastMonth = moment(startOfMonth).subtract(1, 'month')
  today = moment()

  daysInLastMonth = lastMonth.daysInMonth()
  dayOfWeek = startOfMonth.day()

  #initialize a 6 rows x 7 columns array for the calendar
  calendar = []
  i = 0
  while i < 6
    calendar[i] = []
    i++
  #populate the calendar with date objects
  startDay = daysInLastMonth - dayOfWeek + localeFirstDay + 1
  if startDay > daysInLastMonth
    startDay -= 7
  if dayOfWeek == localeFirstDay
    startDay = daysInLastMonth - 6
  curDate = moment(lastMonth).date(startDay)

  i = 0
  col = 0
  row = 0
  while i < 42
    if i > 0 and col % 7 == 0
      col = 0
      row++
    cls = ""
    if curDate.month() isnt startOfMonth.month()
      cls = 'te-off'
    if today.isSame(curDate, 'day')
      cls += " te-today"
    calendar[row][col] =
      time: curDate.clone()
      date : curDate.date()
      dd : curDate.format("YYYY-MM-DD")
      class : cls

    i++
    col++
    curDate = moment(curDate).add(1, 'day')
  calendar


if Meteor.isClient
  Template.TECalendar.onCreated ->
    instance =this
    data = this.data
    if data?.month?.isValid()
      month = moment(data.month)
    else
      month = moment()
    instance.month = new ReactiveVar(month)

  Template.TECalendar.helpers
    'hasWeekLabels' : ->
      if @noWeekLabels
        return false
      else
        return true
    'weekLabels' : ->
      weekLabels = []
      week = moment().startOf('week')
      i = 0
      while i < 7
        weekLabels.push week.format('dd')
        i++
        week = moment(week).add(1, 'day')
      weekLabels
    'calendar' : ->
      instance = Template.instance()
      month = instance.month.get()
      if not month.isValid()
        return
      calendar = buildCalendar(month)
      if @postProcess
        @postProcess calendar
      calendar
    'cal' : ->
      instance = Template.instance()
      month = instance.month.get()
      if not month.isValid()
        return
      cal =
        month : month.format("MMMM")
        year : month.format("YYYY")
      cal

if Meteor.isClient
  Template.TECalendar.events
    'click .te-prev' : (e, tmpl)->
      if tmpl.month
        month = tmpl.month.get()
        month.subtract(1, 'month')
        tmpl.month.set(month)
    'click .te-next' : (e, tmpl)->
      if tmpl.month
        month = tmpl.month.get()
        month.add(1, 'month')
        tmpl.month.set(month)
