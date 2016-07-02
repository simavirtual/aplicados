
// this demostration program provides a list of drives from A to Z
// and their current status.


LOCAL n, nStat

for n = 65 to 90
  nStat := DRVFLGGET( chr( n ) )
  ? "Drive "+chr( n )+" is "
  do case
    case nStat <= 0
      ?? "unused"
    case nStat < 4
      ?? "a permanently mapped network drive"
    case nStat = 128
      ?? "local drive"
    case nStat > 128
      ?? "a local drive re-assigned to a network drive"
  endcase
next



