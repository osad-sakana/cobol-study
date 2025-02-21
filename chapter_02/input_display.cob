       IDENTIFICATION DIVISION.
       PROGRAM-ID. INPUT-DISPLAY.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 USER-NAME PIC X(20).  *> 20文字の文字列 ユーザーの名前を入力
       
       PROCEDURE DIVISION.
           DISPLAY "あなたの名前を入力してください: ".
           ACCEPT USER-NAME.
           DISPLAY "こんにちは" USER-NAME "さん".
           STOP RUN.