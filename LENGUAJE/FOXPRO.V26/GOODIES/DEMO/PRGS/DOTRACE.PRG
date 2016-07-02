procedure temptrac
parameter dodebug
push key clear
wait window "Las teclas ESCAPE y de funci¢n est n desactivadas durante el Seguimiento" timeout 2
_throttle = .10
if dodebug = 1
	activate window DEBUG
	activate window TRACE
	play macro debugit
	suspend
else
	activate window TRACE
endif

for contador = 1 to 10
	testnum1 = contador * 3
	looptalk = "Esto es un ejemplo"
	looptalk = "de Seguimiento y"
	looptalk = "de Depuraci¢n"
	testnum2 = contador/2
endfor

release window TRACE
if dodebug = 1
	release window DEBUG
endif
pop key