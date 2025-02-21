# Chapter 1 基本構造と環境構築

## COBOLとは

COBOL(COmmon Business-Oriented Language)は1959年に開発されたビジネス向けのプログラミング言語。
金融、保険、政府機関などの業務システムで使用されていて、今でも多くのレガシーシステムで使用されている。

### 特徴

- 自然言語に似た読みやすい構文
- 膨大なデータ処理が得意
- レガシーシステムが多いため、既存システムの維持、改修に需要がある

## COBOLのプログラム構造

COBOLのプログラムは4つの**DIVISION**(区分)で構成される。

1. IDENTIFICATION DIVISION. * プログラムの識別情報
2. ENVIRONMENT DIVISION. * 環境設定
3. DATA DIVISION. * 変数やデータ構造の定義
4. PROCEDURE DIVISION. * 実際の処理を記述

他の言語とは異なり、明示的にこの部分が何のためのコードなのかを示す構成になっている。

## 環境構築

コンパイラを入手する必要がある。**GnuCOBOL**は無料で使えるオープンソースのCOBOLコンパイラ。Windows, Mac, Linuxに対応している。
Macでのインストール手順を解説する。

```bash
brew install gnucobol
```

## 最初のCOBOLプログラム

環境が整ったら最初のプログラムを書いてみる。
`hello.cob`というファイルを作成して以下の内容を記述する。

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       
       PROCEDURE DIVISION.
           DISPLAY "Hello, World!".
           STOP RUN.
```

ポイントとしては、7スペースのインデントが必要であることと、行末にピリオドを忘れないこと。

コンパイルして実行する。

```bash
cobc -x hello.cob
./hello
```

```bash
(実行結果)
Hello, World!
```

これで最初のCOBOLプログラムが実行できました。
(Chapter 2に続く)
