# CLAUDE.md

EPJ Data Science 投稿論文「Measuring Technological Complexity Using Japanese Patents」の原稿リポジトリ。
現在 **major revision 対応中(締切 2026年9月)**。

## ファイルの役割

- `sn-article.tex` — 本文(唯一の編集対象。1行1文)
- `sn-bibliography.bib` — 文献。`.cls` / `.bst` はテンプレートなので触らない
- `Figs/*.eps` — 図。原稿リポジトリでは差し替えのみ(生成コードは別管理)
- `doc/Feedbacks/reviewer1.md`, `reviewer2.md` — 査読コメント原文。**原稿に触る前に必ず読む**
- `doc/revision-plan/plan.md` — 査読者・指導教員のフィードバックに基づく論点ごとの優先度・対応方針・ステータス。着手前に確認し、対応後に更新する
- `doc/style-guide/general.md` — 本文修正・翻訳時の全体方針(英語のトーン等)。個別論点の方針も同フォルダに追加していく
- `doc/response-letter/letter.md` — point-by-point response の正本(見出し・原稿ID行・査読コメント全文引用・point-by-point回答・Before/After抜粋・署名)。**docx と内容を1:1で一致させる**運用で、編集は必ず letter.md に対して行う。カバーレター(添え状)は 2026-09-17 に分離し、投稿フォームの Cover letter 欄へ別ファイルで提出する
- `doc/cover-letter/` — カバーレター。`CoverLetter_RintaroKARASHIMA.pdf` は初回投稿時のもの(上書きしない)。改訂用は `cover-letter.tex` を `build_cover_letter.sh`(WSL の pdflatex。レターヘッド・署名画像は `assets/`)でビルドする。本文を変えるときは tex を編集して再ビルドし、1ページに収まることを `pdfinfo` で確認する。`make_cover_letter.ps1`(Word COM 版)は 2026-09-17 に Word の保存が停止するようになったため使わない
- `doc/response-letter/md_to_docx.py` — letter.md から docx を生成する(WSL: `python3 md_to_docx.py letter.md response-letter.docx <出力.docx>`)。前回版 `response-letter.docx` をベースラインに、そこに無い文を**センテンス単位で赤字**にし、md と docx の本文一致を assert で検証する
- `doc/response-letter/response-letter.docx` — 前回教授に見せた版(2026-08-22)。赤字diffのベースラインなので**上書きしない**
- `doc/advisor-report/` — 教授向け成果物一式。**日付フォルダ(YYYY-MM-DD)で送付回ごとに分ける**(例: `2026-09-15/` = 本文PDF・diff.pdf・response letter docx・メール下書き)。教授に送るのは最新日付フォルダの中身
- `guidelines.md` — EPJ DS の投稿規定まとめ。フォーマット・構成の疑問はまずここを参照
- CLAUDE.md(本ファイル)は「このリポジトリでの作業の仕方」、guidelines.md は「投稿先の規定」

## 査読対応の進め方

- 対応順は `doc/revision-plan/plan.md` の優先度に従う。着手時・完了時にステータスを更新する
- 1コミット = 1論点。コミットメッセージに対応する論点ID(例: `R1-3`)を明記する
- 本文の変更と response letter の変更は同じコミットで行い、両者の記述を一致させる
- 査読者が求めていない論旨変更・主張の強化・スコープ拡大をしない。必要と思ったら提案に留め、著者の判断を仰ぐ
- 数値・図の変更は分析コード側の再実行が必要なため、このリポジトリ単独で数値を書き換えない
- 分析リポジトリは `C:\Users\rintaro.karashima_hu\Desktop\Pandora\KCIinJapaneseFirms`。数値の正本は `knowledge/findings.csv`(F-NNNN)と各 `experiments/*/docs/results.md`。**要検証事項は同リポジトリの `knowledge/open_questions.csv` に Q-NNNN として起票する**(10列・CRLF・UTF-8 BOM なし)
- **役割分担**: 文面の設計・判断は Fable、実装(tex の編集・build・plan.md の更新)は Opus。セッションをまたぐ場合は Fable に対象箇所の現行テキストと使える実測値を渡し直す

## セッション再開時の手順

1. `doc/revision-plan/plan.md` の「残作業」節を読む。論点ごとの完了状況・判断根拠・分析側待ちはすべてここにある
2. `git status` で作業ツリーを確認する。**response letter ができるまでコミットしない方針のため、順1〜15 の変更はすべて未コミットで作業ツリー上にある**
3. 上記の `wsl-run.sh build` を通して現状が壊れていないことを確認する

## Git / Overleaf 同期

- GitHub が唯一の正。Overleaf はミラーで、`main` への push 時に CI が自動 force push する
- `git push overleaf ...` を手動実行しない。Overleaf 側での取り込みは Pull CI の手動実行のみ
- ブランチは `main`

## コンパイル検証(ローカル)

- ローカルの TeX 環境は WSL(Ubuntu)上の texlive。Windows 側には無い
- `bash scripts/build.sh` — 本文をコンパイルし、LaTeX エラー・未定義引用・不完全な参考文献エントリを一括チェックする
- `bash scripts/diff.sh [ref]` — 差分 PDF を生成(baseline 既定値は `submitted` タグ)。未コミットの変更も比較対象になるので、コミット前に確認できる
- **Windows 側の Git Bash からは上記を直接実行できない**(latexmk が無い)。`scripts/wsl-run.sh` 経由で WSL に渡す。ディレクトリ名の丸括弧が `wsl.exe bash -lc 'cd ...'` を壊すため、cd 先はこのスクリプト内にハードコードしてある

```bash
powershell.exe -NoProfile -Command "wsl.exe bash '/mnt/c/Users/rintaro.karashima_hu/Desktop/Pandora/Publishments/(KI01 EPJDataScience) Measuring Technological Complexity Using Japanese Patents/scripts/wsl-run.sh' build"     # コンパイル + 一括チェック
powershell.exe -NoProfile -Command "wsl.exe bash '.../scripts/wsl-run.sh' overfull"   # build 後。Overfull が 0 件かを確認
powershell.exe -NoProfile -Command "wsl.exe bash '.../scripts/wsl-run.sh' diff"       # 差分 PDF
```

- **コミット前の合格基準**: `build` が exit=0、LaTeX エラーなし、未定義引用・未定義参照なし、不備文献エントリなし、`overfull` が 0 件
- どちらも `/tmp` にコピーしてから実行するため、リポジトリに成果物が残らない
- 論点対応のコミット前には必ず `scripts/build.sh` を通す

## 修正差分の可視化(指導教員・共著者向け)

- 投稿時の原稿には `submitted` タグを付けてある。これが差分の baseline
- ローカルでは `scripts/diff.sh`。CI 経由でも生成できる(下記)
- `.github/workflows/build-diff.yaml` が latexdiff で `submitted` → 現在 の差分 PDF を生成し、artifact `revision-diff` として出力する。`main` への push で自動実行、`workflow_dispatch` で baseline を指定して手動実行も可能
- コンパイルに失敗しても `diff.tex` は artifact に残る。Overleaf に貼れば手元でコンパイルできる
- 差分 PDF はコミットしない(コンパイル成果物を置かない方針のまま)

## LaTeX の書き方

- 1行1文で改行(セマンティック改行)。段落区切りは空行、`\\` は使わない
- コンパイル成果物(`.aux`, `.log`, `.out`, `.pdf` など)は生成・コミットしない

## 修正・翻訳の方針

本文の修正・翻訳時の全体方針(英語のトーン等)は `doc/style-guide/general.md` を参照。個別論点の方針を追加する場合も同フォルダに置く。
