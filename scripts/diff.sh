#!/bin/bash
# 投稿時の原稿と現在の原稿の差分 PDF を latexdiff で生成する(指導教員・共著者向け)。
#
# 使い方(WSL 側で実行):
#   bash scripts/diff.sh            # baseline = submitted タグ
#   bash scripts/diff.sh <ref>      # baseline を任意の ref に変更
#
# baseline は投稿時のコミットに付けた `submitted` タグ。
# 作業ツリーの未コミットの変更もそのまま比較対象になる(コミット前に確認できる)。
# 生成物は /tmp/tcidiff/ に残る。リポジトリには置かない。

set -u

REPO="$(cd "$(dirname "$0")/.." && pwd)"
BASELINE="${1:-submitted}"
D=/tmp/tcidiff

# Windows 側のリポジトリを WSL の git で扱うため所有者チェックを回避する。
# safe.directory=* はクォートしないとグロブ展開されるので関数で包む。
GIT() { git -C "$REPO" -c 'safe.directory=*' "$@"; }

cd "$REPO" || exit 1
if ! GIT rev-parse --verify "${BASELINE}^{commit}" >/dev/null 2>&1; then
  echo "baseline ref '${BASELINE}' が見つかりません。" >&2
  echo "投稿時のコミットに 'submitted' タグを付けてください。" >&2
  exit 1
fi

rm -rf "$D"
mkdir -p "$D"
GIT show "${BASELINE}:sn-article.tex" > "$D/old.tex" || exit 1
cp "$REPO/sn-article.tex" "$D/new.tex"
cp "$REPO/sn-bibliography.bib" "$REPO/sn-jnl.cls" "$REPO/sn-mathphys-num.bst" "$D/"
cp -r "$REPO/Figs" "$D/"

cd "$D" || exit 1

# --append-safecmd は sn-jnl.cls 固有のコマンドを差分マークアップから保護するため。
# \email は含めない: safecmd にすると \DIFdel{\email{...}} が \maketitle の前に
# 取り消し線テキストとして組版され、先頭に空白ページが挿入される(2026-09-17 に発生)。
# 除外すると変更は %DIFDELCMD コメントとして記録され、本文には何も出力されない。
# "Wide character in print" の警告は baseline 側の非ASCII文字由来で無害。
latexdiff \
  --encoding=utf8 \
  --append-safecmd="cite,ref,eqref,label,url,fnm,sur,orgdiv,orgname,orgaddress,street,city,postcode,state,country,affil,equalcont" \
  old.tex new.tex > diff.tex 2> latexdiff.err
echo "latexdiff exit=$?"
head -5 latexdiff.err

latexmk -pdf -interaction=nonstopmode -shell-escape diff.tex > compile.out 2>&1
STATUS=$?
echo "latexmk exit=$STATUS"

echo "=== PDF ==="
ls -la diff.pdf 2>/dev/null || echo "NO PDF PRODUCED"

echo "=== errors ==="
grep -nE '^!' compile.out | head -20

echo "=== 差分マークアップ数(DIFadd/DIFdel) ==="
grep -cE 'DIFadd|DIFdel' diff.tex

echo
echo "baseline: ${BASELINE} ($(GIT rev-parse --short "${BASELINE}^{commit}" 2>/dev/null))"
echo "出力: $D/diff.pdf"
exit $STATUS
