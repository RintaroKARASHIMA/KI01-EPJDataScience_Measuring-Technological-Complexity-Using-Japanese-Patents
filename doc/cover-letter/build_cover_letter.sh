#!/usr/bin/env bash
# カバーレター(cover-letter.tex)を WSL の pdflatex でビルドし、
# CoverLetter_RintaroKARASHIMA_revision_v20260917.pdf として同じフォルダに出力する。
# /tmp にコピーしてビルドするので、リポジトリに .aux/.log は残らない。
# Windows 側からの実行: powershell.exe -NoProfile -Command "wsl.exe bash '<このファイルの /mnt/c パス>'"
set -euo pipefail
SRC='/mnt/c/Users/rintaro.karashima_hu/Desktop/Pandora/Publishments/(KI01 EPJDataScience) Measuring Technological Complexity Using Japanese Patents/doc/cover-letter'
OUT="$SRC/CoverLetter_RintaroKARASHIMA_revision_v20260917.pdf"
WORK=$(mktemp -d /tmp/coverletter.XXXXXX)
cp "$SRC/cover-letter.tex" "$WORK/"
cp -r "$SRC/assets" "$WORK/"
cd "$WORK"
pdflatex -interaction=nonstopmode -halt-on-error cover-letter.tex > build.log 2>&1 || { tail -n 40 build.log; exit 1; }
grep -E '^(Overfull|Underfull) \\hbox' cover-letter.log || true
cp cover-letter.pdf "$OUT"
echo "saved: $OUT"
pdfinfo "$OUT" | grep Pages
rm -rf "$WORK"
