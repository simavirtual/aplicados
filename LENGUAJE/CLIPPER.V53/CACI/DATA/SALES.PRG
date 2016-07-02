
LOCAL cOldSalesRep, nTotal

USE Sales
SET INDEX TO Sales

DO WHILE ! EF()
  cOldSalesRep = Sales->Sales
	DO WHILE cOldSalesRep = Sales->SalesRep
    ? Sales->SalesRep Sales->Amount
		nTotal += Sales->Amount
		SKIP
	ENDDO
	? "Total: ", nTotal, "for", cOldSalesRep
ENDDO

CLOSE
?
?
WAIT
