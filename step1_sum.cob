       IDENTIFICATION DIVISION.
       PROGRAM-ID. STEP1-SUM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT JOURNAL-FILE ASSIGN TO "journals.csv"
                ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD JOURNAL-FILE.
       01 JOURNAL-REC                   PIC X(100).

       WORKING-STORAGE SECTION.
       01 WS-EOF                        PIC X VALUE "N".
       01 WS-LINE-NO                    PIC 9(5) VALUE 0.

       01 WS-DATE                       PIC X(10).
       01 WS-DEBIT                      PIC X(20).
       01 WS-CREDIT                     PIC X(20).
       01 WS-AMOUNT-STR                 PIC X(20).
       01 WS-AMOUNT                     PIC 9(9) VALUE 0.

       01 WS-DEBIT-TOTAL                PIC 9(12) VALUE 0.
       01 WS-CREDIT-TOTAL               PIC 9(12) VALUE 0.

       PROCEDURE DIVISION.
           OPEN INPUT JOURNAL-FILE

           PERFORM UNTIL WS-EOF = "Y"
                   READ JOURNAL-FILE
                           AT END
                                   MOVE "Y" TO WS-EOF
                           NOT AT END
                                   ADD 1 TO WS-LINE-NO
                                   UNSTRING JOURNAL-REC
                                        DELIMITED BY ","
                                        INTO WS-DATE
                                                WS-DEBIT
                                                WS-CREDIT
                                                WS-AMOUNT-STR
                                   END-UNSTRING

                                   MOVE FUNCTION NUMVAL(WS-AMOUNT-STR)
                                   TO WS-AMOUNT
                                   ADD WS-AMOUNT TO WS-DEBIT-TOTAL
                                   ADD WS-AMOUNT TO WS-CREDIT-TOTAL
                   END-READ
           END-PERFORM

           DISPLAY "DEBIT=" WS-DEBIT-TOTAL
           DISPLAY "CREDIT=" WS-CREDIT-TOTAL

           IF WS-DEBIT-TOTAL = WS-CREDIT-TOTAL
                   DISPLAY "DC OK!"
           ELSE
                   DISPLAY "DC MISMATCH!"
           END-IF

           CLOSE JOURNAL-FILE
           STOP RUN.

       *> dylibファイルについて→dylibファイルは動的ライブラリであり、実行時にリンクされるライブラリです。
