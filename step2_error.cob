       IDENTIFICATION DIVISION.
       PROGRAM-ID. STEP2-ERROR.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT JOURNAL-FILE ASSIGN TO "journals.csv"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD JOURNAL-FILE.
       01 JOURNAL-REC          PIC X(100).

       WORKING-STORAGE SECTION.
       01 WS-FS                PIC X(2).
       01 WS-EOF               PIC X VALUE "N".
       01 WS-LINE-NO           PIC 9(5) VALUE 0.

       01 WS-DATE              PIC X(10).
       01 WS-DEBIT             PIC X(20).
       01 WS-CREDIT            PIC X(20).
       01 WS-AMOUNT-STR        PIC X(20).
       01 WS-AMOUNT            PIC 9(9) VALUE 0.

       01 WS-DEBIT-TOTAL       PIC 9(12) VALUE 0.
       01 WS-CREDIT-TOTAL      PIC 9(12) VALUE 0.

       01 WS-FIELD-COUNT       PIC 9 VALUE 0.
       01 WS-NUMVAL-OK         PIC X VALUE "Y".

       PROCEDURE DIVISION.
           OPEN INPUT JOURNAL-FILE
           IF WS-FS NOT = "00"
               DISPLAY "FILE OPEN FAILED"
               STOP RUN
           END-IF

           PERFORM UNTIL WS-EOF = "Y"
               READ JOURNAL-FILE
                   AT END
                       MOVE "Y" TO WS-EOF
                   NOT AT END
                       ADD 1 TO WS-LINE-NO
                       MOVE 0 TO WS-FIELD-COUNT

                       UNSTRING JOURNAL-REC
                           DELIMITED BY ","
                           INTO WS-DATE
                               WS-DEBIT
                               WS-CREDIT
                               WS-AMOUNT-STR
                           COUNT IN WS-FIELD-COUNT
                       END-UNSTRING

                   IF WS-FIELD-COUNT < 4
                       DISPLAY "ERROR: LINE " WS-LINE-NO
                       DISPLAY "CONTENT: " JOURNAL-REC
                       DISPLAY "NOT ENOUGH COLUMNS."
                   ELSE
                       MOVE "Y" TO WS-NUMVAL-OK
                       IF FUNCTION TRIM(WS-AMOUNT-STR) IS NUMERIC
                           MOVE FUNCTION NUMVAL(WS-AMOUNT-STR)
                               TO WS-AMOUNT

                           ADD WS-AMOUNT TO WS-DEBIT-TOTAL
                           ADD WS-AMOUNT TO WS-CREDIT-TOTAL
                       ELSE
                           MOVE "N" TO WS-NUMVAL-OK
                           DISPLAY "ERROR: LINE " WS-LINE-NO
                           DISPLAY "CONTENT: " JOURNAL-REC
                           DISPLAY "THE AMOUNT VALUE IS NOT A NUMBER."
                       END-IF
                   END-IF
               END-READ
           END-PERFORM

           DISPLAY "DEBIT TOTAL = " WS-DEBIT-TOTAL
           DISPLAY "CREDIT TOTAL = " WS-CREDIT-TOTAL

           CLOSE JOURNAL-FILE
           STOP RUN.
