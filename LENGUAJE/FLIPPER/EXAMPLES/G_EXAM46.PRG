* --------------------------------------------------------------------------
*  PROG NAME: ICOMTEST.PRG -- Digitizer tablet input using ICOM_* functions
*  By : John Paul Boedianto, Holland.
*  October 16, 1991.
* --------------------------------------------------------------------------

set talk off
clear

@ 1,1 say 'Digitizer tablet input program using ICOM_* functions of Flipper library.'
@ 3,1 say '        This example is provided by John Paul Boedianto, Holland.'
@ 5,1 say '                          October 16, 1991.'
@ 9,1 say 'This program was tested using Genius Tablet in SummaGraphics ASCII mode.'

public dig_x, dig_y, dig_but, quit

quit = 'N'
dig_menu = 0
do while quit <> 'Y'
   quit = 'N'
   @ 24,0 clear to 24,79
   @ 20,5 say 'Quit :    (Y/N)'
   @ 20,12 get quit pict '@!' valid at(quit,'YyNn') > 0
   read
   quit = upper(quit)
   if quit == 'N'
      @ 20,25 say 'Polling tablet input ...'
      @ 24,5 say 'Press button 4 on the tablet to end digitizer input polling.   '

      do dig_setup                   && initialize com port and tablet
      do while dig_but <> 4          && start polling tablet input
         do dig_read                 &&    until button 4 is pressed
         do dig_disp                 && display coordinates
      enddo
      ICOM_CLOSE()                   && close com port
   endif
enddo


procedure dig_read
   private dig_s1, dig_err

   dig_but  = 0
   dig_err  = .t.
   do while dig_err
      if dig_err         && reset error flag
         dif_err = .f.
      endif

      * read tablet string
      *
      dig_s1  = ICOM_READ("",13,1)

      * extract x,y coordinates and convert them from inches to metric
      *
      dig_x   = 2.54 * val (substr (dig_s1, 1, 4))
      dig_y   = 2.54 * val (substr (dig_s1, 2 + 4, 4))
      *
      * extract button value
      *
      dig_but = val (substr (dig_s1, 3 + 2 * 4, 1))
      *
      * check error situations
      *
      dig_err = (dig_x == 0) .or. (dig_y == 0) .or. (dig_but == 0)
      *

   enddo
return && dig_read


procedure dig_disp
   @ 22,5 say 'x = ' + str (dig_x, 12, 6) +;
              ' mm,   y = ' + str (dig_y, 12, 6) +;
              ' mm,   button = '  + str (dig_but, 1, 0)
return && dig_disp


procedure dig_setup

   * open COM1, 9600 baud, Direct, Odd parity, 1 stop bit, Disable XON/XOFF
   *
   ICOM_OPEN (1, 9600, ASC('D'), asc('O'), 1, asc('D') )
   *

   if ICOM_ERROR(8) > 0     && if number of errors > 0 then quit !
      ? "Comm port initialization failed!"
      quit = 'q'
      return
   endif

   * Initialize digitizer tablet
   *
   ICOM_WRITE ('d')   && Resolution  : d = 100 LPI
   ICOM_WRITE ('B')   && Report mode : B = Location mode
   ICOM_WRITE ('Q')   && Report rate : Q = Maximum rate of baudrate
   *

   * initialize button variable
   dig_but  = 0

return && dig_setup

