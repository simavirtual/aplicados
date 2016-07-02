CC
CC  SWAPDEMO.FOR - BLINKER SWAP FUNCTION DEMO 94.11.17
CC
CC  FL -AL -c SWAPDEMO.FOR
CC

      INCLUDE  'BLINKER.FI'
      INCLUDE  'BLX286.FI'

      LOGICAL Success, OldSetting
      INTEGER*2 Count
      INTEGER*2 Mode
      INTEGER*2 DOSFNRETURN
      INTEGER*2 KeyStatus
C
C     CLS...
C
      DO Count = 1,25
        write(*,*)
      END DO
C
C     Enable use of EMS / XMS and UMBs
C
      OldSetting = SWPUSEEMS(.TRUE.)
      OldSetting = SWPUSEXMS(.TRUE.)
      OldSetting = SWPUSEUMB(.TRUE.)
      OldSetting = SWPVIDMDE(.TRUE.)
      OldSetting = SWPCURDIR(.TRUE.)
      OldSetting = SWPDISMSG(.FALSE.)
      OldSetting = SWPGETKEY(.FALSE.)
      OldSetting = SWPNOBOOT(.FALSE.)

C
C     Set the system prompt
C     (note the C following the string constant - required for
C     passing strings to 'C' functions
C

      Success = SWPSETENV("PROMPT=[Fortran Swapdemo!] $p$g"C)

C
C     Determine if this is the first invocation of SWAPDEMO
C

      if (.NOT. SWPGETPID("SWAPDEMO.FOR"C)) THEN
C
C     If the ID is not set, this is the first time the
C     program has been executed
C
        DOSFNRETURN = DOSGETMACHINEMODE(Mode)

        write(*,*) "Fortran Swap function Example"
        write(*,*) "============================="
        write(*,*)
        IF (Mode .EQ. 1) THEN
           write(*,*) "Running in protected mode"
        ELSE
           write(*,*) "Running in real mode"
        ENDIF
        write(*,*)
        write(*,*) "Settings"
        write(*,*) "--------"
        write(*,*) "Use EMS                    ",SWPUSEEMS(.TRUE.)
        write(*,*) "Use XMS                    ",SWPUSEXMS(.TRUE.)
        write(*,*) "Use UMB's                  ",SWPUSEUMB(.TRUE.)
        write(*,*) "Save/restore video mode    ",SWPVIDMDE(.TRUE.)
        write(*,*) "Save/restore directory     ",SWPCURDIR(.TRUE.)
        write(*,*) "Display message            ",SWPDISMSG(.FALSE.)
        write(*,*) "Wait for keypress          ",SWPGETKEY(.FALSE.)
        write(*,*) "Suppress <Ctrl><Alt><Del>  ",SWPNOBOOT(.FALSE.)
        write(*,*)
        write(*,*) "This is the first invocation of SWAPDEMO.FOR"
        write(*,*)
        write(*,*) "Press enter to swap to DOS"
        write(*,*) "(Run Swapdemo again once swapped out)"
        read(*,*)

C
C     Set the program ID to 'SWAPDEMO.FOR'
C
        Success = SWPSETPID("SWAPDEMO.FOR"C)
C
C     Stuff the string 'SWAPDEMO' into the keyboard buffer
C
        KeyStatus = SWPKEYBRD("'SWAPDEMO'"C)
C
C     Swap to DOS, freeing as much memory as possible
C
        Success = SWPRUNCMD(""C, 0, ""C, ""C)
        if(.NOT. Success) THEN
          write(*,*) "Swap to DOS failed."
          write(*,*) "Major error code: ",SWPERRMAJ()
          write(*,*) "Minor error code: ",SWPERRMIN()
         else
          DO Count = 1,25
            write(*,*)
          END DO
          write(*,*) "Swap was successful"
          write(*,*) "String returned from child program = ",SWPGETSTR()
         endif
      else
        write(*,*) "SWAPDEMO.FOR is already running"
        write(*,*) "Type EXIT to return to the parent program"
        Success = SWPSETSTR("SWAPDEMO.FOR"C,"Hello from the child!"C)
      endif

      END
