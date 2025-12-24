       IDENTIFICATION DIVISION.
       PROGRAM-ID. STEP3-ACCOUNTS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNT-FILE ASSIGN TO "accounts.csv"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-AFS.

       DATA DIVISION.
       FILE SECTION.
       FD ACCOUNT-FILE.
       01 ACCOUNT-REC          PIC X(50).

       WORKING-STORAGE SECTION.
       01 WS-AFS               PIC X(2).
       01 WS-EOF               PIC X VALUE "N".
       01 WS-ACC-COUNT         PIC 9(4) VALUE 0.

       01 WS-ACC-NAME          PIC X(20).
       01 WS-ACC-TYPE          PIC X(10).

       01 ACCOUNTS.
           05 ACC-ENTRY OCCURS 100 TIMES.
               10 ACC-NAME     PIC X(20).
               10 ACC-TYPE     PIC X(10).

       01 IDX                  PIC 9(4) VALUE 0.
       01 FOUND                PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN INPUT ACCOUNT-FILE
           IF WS-AFS NOT = "00"
               DISPLAY "FILE OPEN FAILED"
               STOP RUN
           END-IF

           PERFORM UNTIL WS-EOF = "Y"
               READ ACCOUNT-FILE
                   AT END
                       MOVE "Y" TO WS-EOF
                   NOT AT END
                       ADD 1 TO WS-ACC-COUNT
                       UNSTRING ACCOUNT-REC
                           DELIMITED BY ","
                           INTO WS-ACC-NAME
                               WS-ACC-TYPE
                       END-UNSTRING

                       MOVE WS-ACC-NAME TO ACC-NAME(WS-ACC-COUNT)
                       MOVE WS-ACC-TYPE TO ACC-TYPE(WS-ACC-COUNT)
               END-READ
           END-PERFORM

           DISPLAY "NUMBER OF ACCOUNTS: " WS-ACC-COUNT
           DISPLAY "NAME OF TOP: " ACC-NAME(1) " " ACC-TYPE(1)

           CLOSE ACCOUNT-FILE
           STOP RUN.
