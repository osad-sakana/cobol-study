# Chapter 2 データ定義と変数の扱い

前回はCOBOLの基本構造と環境構築について学びました。今回はデータ定義と変数の扱いについて学びます。

## DATA DIVISION

COBOLのプログラムは4つの**DIVISION**(区分)で構成される。そのうちの1つが`DATA DIVISION`です。
COBOLではデータの定義をこの部分で行います。

DATA DIVISIONは以下の3つの部分で構成されます。

| 部分 | 説明 |
| --- | --- |
| FILE SECTION | ファイルの定義 |
| WORKING-STORAGE SECTION | ワーキングストレージの定義 |
| LINKAGE SECTION | 外部から受け取るデータの定義 |

今回は`WORKING-STORAGE SECTION`について学びます。

## 変数の定義

COBOLでは変数のことをデータ項目(Data Item)と呼びます。変数を宣言するときは、ピクチャ記号(PIC)を使ってデータの方を指定します。

### 基本的な変数の書き方

```cobol
       WORKING-STORAGE SECTION.
       01 MY-VARIABLE PIC X(10).
```

`01` …… データ項目のレベル(1~49の数字を使う)
`MY-VARIABLE` …… 変数名。ハイフンで繋ぐ。
`PIC` …… ピクチャ記号。データの型を指定する。`X(10)`は10文字の文字列型。

## 主要なデータ型(PICによる指定)

| PICの指定 | 型 | 説明 |
| --- | --- | --- |
| PIC X(n) | 文字列 | n文字の文字列 |
| PIC 9(n) | 数値 | n桁の数値 |
| PIC 9(n)V9(m) | 少数 | n桁の整数部とm桁の小数部を持つ数値 |
| PIC 9(n) COMP | 数値 | n桁の数値(バイナリ) |

```cobol
         WORKING-STORAGE SECTION.
         01 MY-STRING PIC X(10).
         01 MY-NUMBER PIC 9(5).
         01 MY-DECIMAL PIC 9(3)V9(2).
         01 MY-COMP PIC 9(5) COMP.
```

## 変数の利用(データ入力と表示)

では、COBOLで**変数を使ったプログラム**を作成し、ユーザーから名前を入力し表示する処理を書いてみます。

```cobol
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
```

このプログラムをコンパイルして実行すると、以下のように名前を入力して表示されます。

```bash
あなたの名前を入力してください: 
(入力) Taro
こんにちは Taro さん
```

## 数値計算

算術演算の命令

| 操作 | 命令 |
| --- | --- |
| 加算 | ADD A TO B GIVING C |
| 減算 | SUBTRACT A FROM B GIVING C |
| 乗算 | MULTIPLY A BY B GIVING C |
| 除算 | DIVIDE A BY B GIVING C |

## 演習問題

1. 2つの整数を入力し、足し算をして結果を表示するプログラムを作成
1. 整数と小数の入力を受け取り、合計を計算して表示
1. 名前と年齢を入力し、「○○さんはXX歳です」と表示するプログラムを作成

## まとめ

- DATA DIVISIONの役割の理解
- PICを使ったデータ型の指定
- ACCEPTでユーザー入力を受け取り、DISPLAYで表示する方法
- 算術演算の命令の使い方

(Chapter 3に続く)
