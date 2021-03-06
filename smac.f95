!SIMULATOR FOR SMALL COMPUTER
PROGRAM SMAC
 IMPLICIT NONE
 INTEGER::INST_COUNTER=0,ADDRESS,OP_CODE,INSTRN,ACC=0,INST_REG,LOCATION
 INTEGER,DIMENSION(0:99) :: MEMORY
 LOGICAL :: HALT= .FALSE.
 !THE FOLLOWING LOOP READS SMAC MACHINE LANGUAGE PROGRAM
 !GIVEN AS DATA TO SIMULATOR AND STORES IN SMAC MEMORY
 
 PRINT*,"NOW ENTER YOUR MACHINE CODE FOLLOWING WAY"
 PRINT*,"MEMORY_LOCATION_WITH_THREE_DIGIT,TWO SPACE,OP_CODE_WITH_TWO_DIGIT,TWO_SPACE,MEMORY_ADDRESS_WITH_THREE_DIGIT"
 DO
  READ 10,LOCATION,OP_CODE,ADDRESS
  10 FORMAT(I3,2X,I2,2X,I3)
  IF(LOCATION <0 ) THEN
  EXIT
  ENDIF
  IF(INST_COUNTER>999)THEN
   PRINT*,"PROGRAM OVERFLOWS MEMORY"
   STOP
  ENDIF
  INSTRN = OP_CODE*1000+ADDRESS
  MEMORY(INST_COUNTER)=INSTRN
  INST_COUNTER=INST_COUNTER+1
  
 END DO
 !STORING PROGRAM OVER
 
 !THIS PHASE MACHINE LANGUAGE INSTRUCTIONS ARE RETRIVED ONE 
 !BYE ONE FROM SMAC 'S MEMORY INTERPRETED AND EXECUTED BY THE
 !FOLLOWING PART OF SIMULATOR PROGRAM
 
 INST_COUNTER=0
 DO
 IF(HALT)THEN
 EXIT
 ELSE
 INST_REG=MEMORY(INST_COUNTER)
 OP_CODE=INST_REG/1000
 IF(OP_CODE<0 .OR. OP_CODE>11)THEN
 PRINT*,"ILLEGAL OP CODE ENTRY"
 PRINT*,"INST-COUNTER=",INST_COUNTER,"OP_CODE=",OP_CODE
 STOP
 ENDIF
 ADDRESS=MOD(INST_REG,1000)
 INST_COUNTER=INST_COUNTER+1
 
 SELECT CASE(OP_CODE)
 CASE(1)
 ACC=MEMORY(ADDRESS)  !LOAD UP ACCUMULATOR
 CASE(2)
 ACC=ACC+MEMORY(ADDRESS)  !ADDING CONTENT OF ACCUMULATOR AND THE MEMORY ADDRESS CONTENT
 CASE(3)
 ACC =ACC-MEMORY(ADDRESS)  !SUBTRACT MEMORY CONTENT FROM CONTENT OF ACCUMULATOR
 CASE(4)
 ACC=ACC*MEMORY(ADDRESS)   !PRODUCT OF ACCUMULATOR AND MEMORY CONTENT
 CASE(5)
 IF(MEMORY(ADDRESS)==0)THEN  !DIVISION BY MEMORY CONTENT
 PRINT*,"ATTEMPT TO DIVIDING BY ZERO"
 PRINT*,"INSTRUCTION-COUNTER=",INST_COUNTER-1,OP_CODE,ADDRESS
 ELSE
 ACC=ACC/MEMORY(ADDRESS)
 ENDIF
 CASE(6)
 MEMORY(ADDRESS)=ACC   !LOADING MEMORY WITH ACCUMULATOR CONTENT
 CASE(7)
 INST_COUNTER=ADDRESS  !UNCONDITIONAL JUMP
 CASE(8)
 IF(ACC<0)THEN
 INST_COUNTER=ADDRESS  !IF ACCUMULATOR GET NEGATIVE JUMP INTO THE ADDRESS
 ENDIF
 CASE(9)
 READ*,MEMORY( ADDRESS )  !STORING MEMORY FROM OUTPUT
 CASE(10)
 HALT= .TRUE.           !HALT THE PROGRAM
 CASE(11)
 
 END SELECT
 ENDIF
 END DO
 PRINT*,"PROGRAM TERMINATES NORMALLY"
 PRINT*,"INSTRUCTION COUNTER=",INST_COUNTER-1
 END PROGRAM SMAC
 
  
