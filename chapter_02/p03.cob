       IDENTIFICATION DIVISION.
       PROGRAM-ID. INPUT-DISPLAY.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 USER-NAME PIC X(20).
       01 USER-AGE PIC 9(3).

       PROCEDURE DIVISION.
           DISPLAY "あなたの名前を入力してください".
           ACCEPT USER-NAME.
           DISPLAY "あなたの年齢を入力してください".
           ACCEPT USER-AGE.
           DISPLAY USER-NAME "さんは" USER-AGE "歳です".

           STOP RUN.