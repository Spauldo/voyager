C     VALDIST.F
C
C     THIS IS A SIMPLE TEST PROGRAM THAT CALCULATES THE DISTANCE FROM
C     THE SUN GIVEN THE COORDINATES IN A LINE OF VOYAGER DATA AND THEN
C     COMPARES IT TO THE DISTANCE GIVEN IN THE DATA.
C
C     COPYRIGHT (C) 2018 JEFF SPAULDING <SARNET@GMAIL.COM>
C
C     THIS IS THE ISC LICENSE.
C
C     PERMISSION TO USE, COPY, MODIFY, AND DISTRIBUTE THIS SOFTWARE FOR
C     ANY PURPOSE WITH OR WITHOUT FEE IS HEREBY GRANTED, PROVIDED THAT
C     THE ABOVE COPYRIGHT NOTICE AND THIS PERMISSION NOTICE APPEAR IN
C     ALL COPIES.
C
C     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
C     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
C     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
C     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
C     CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
C     LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
C     NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
C     CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

      PROGRAM VALDIST

      IMPLICIT NONE

      INTEGER DISCREPANCIES

      INTEGER SCID,YEAR,DAY,HOUR
      REAL XCOORD,YCOORD,ZCOORD,DIST,MFSTR,MFMOD,LAMBDA,DELTA

      REAL CALCDIST,ERRMARGIN

      CHARACTER FILENAME*18

      PARAMETER (ERRMARGIN=0.0005)
      PARAMETER(FILENAME='data/VY1MAG_1H.ASC')

      DISCREPANCIES=0

      OPEN(UNIT=10,FILE=FILENAME,STATUS='OLD',ERR=11,
     C     FORM='FORMATTED',ACCESS='SEQUENTIAL')

C     MAIN LOOP BEGIN

 10   CONTINUE

      READ(10,*,END=20,ERR=15)SCID,YEAR,DAY,HOUR,XCOORD,YCOORD,ZCOORD,
     C     DIST,MFSTR,MFMOD,LAMBDA,DELTA

      CALCDIST=SQRT(XCOORD*XCOORD+YCOORD*YCOORD+ZCOORD*ZCOORD)

      IF(ABS(CALCDIST-DIST) > ERRMARGIN)THEN
         WRITE(*,*)'DISCREPANCY ON YEAR ',YEAR,' DAY ',DAY,' HOUR ',
     C        HOUR,':'
         WRITE(*,9000)'  GIVEN: ',DIST,'  DISTANCE: ',CALCDIST

         DISCREPANCIES=DISCREPANCIES+1
      END IF

      GOTO 10

C     MAIN LOOP END

C     ERROR ROUTINES

 11   WRITE(*,*)'ERROR OPENING FILE, EXITING.'
      GOTO 99

 15   WRITE(*,*)'ERROR READING FILE, EXITING.'
      GOTO 98

C     MAIN LOOP EXIT POINT

 20   CONTINUE

      WRITE(*,*)'TOTAL DISCREPANCIES FOUND: ',DISCREPANCIES

 98   CONTINUE

      CLOSE(UNIT=10)

 99   CONTINUE

      STOP

 9000 FORMAT(' ',A,F9.5,A,F9.5)

      END
