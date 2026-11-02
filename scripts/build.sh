#!/bin/bash
# 原稿のコンパイル検証。
#
# 使い方(WSL 側で実行):
#   bash scripts/build.sh
#
# リポジトリを汚さないよう /tmp にコピーしてからコンパイルする
# (CLAUDE.md: コンパイル成果物は生成・コミットしない)。
# 生成物は /tmp/tcibuild/ に残るので、必要なら各自コピーして参照する。

set -u

REPO="$(cd "$(dirname "$0")/.." && pwd)"
B=/tmp/tcibuild

rm -rf "$B"
mkdir -p "$B"
cp "$REPO/sn-article.tex" "$REPO/sn-bibliography.bib" "$REPO/sn-jnl.cls" "$REPO/sn-mathphys-num.bst" "$B/"
cp -r "$REPO/Figs" "$B/"

cd "$B" || exit 1
latexmk -pdf -interaction=nonstopmode -shell-escape sn-article.tex > compile.out 2>&1
STATUS=$?
echo "latexmk exit=$STATUS"

echo "=== PDF ==="
ls -la sn-article.pdf 2>/dev/null || echo "NO PDF PRODUCED"

echo "=== LaTeX errors ==="
grep -nE '^!' compile.out | head -40

echo "=== undefined citations / references ==="
grep -nE 'Warning: (Citation|Reference)|There were undefined' sn-article.log | head -40

echo "=== 参考文献の総数 ==="
grep -c '^\\bibitem' sn-article.bbl

echo "=== 不完全な参考文献エントリ('???')が残っていないか ==="
grep -n '???' sn-article.bbl && echo "^^^ 残っている" || echo "OK: なし"

echo "=== Overfull/Underfull 件数 ==="
grep -cE 'Overfull|Underfull' sn-article.log

echo
echo "出力: $B/sn-article.pdf"
exit $STATUS
