return {
  s({trig="ddmmyy", dscr = "Date"},
  { extras.partial(os.date, "%x") }),


  s({trig="time", dscr = "time"},
  { extras.partial(os.date, "%X") }),
}
