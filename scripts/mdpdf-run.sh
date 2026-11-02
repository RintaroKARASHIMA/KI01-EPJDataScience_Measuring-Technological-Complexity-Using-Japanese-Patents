#!/bin/bash
# doc/Feedbacks/*.md を PDF に変換するための WSL ラッパ (wsl-run.sh と同じ理由でパスをハードコード)。
#
# 使い方(Git Bash から):
#   powershell.exe -NoProfile -Command "wsl.exe bash '.../scripts/mdpdf-run.sh' doc/Feedbacks/reviewer1.md reviewer1"
set -eu

REPO="/mnt/c/Users/rintaro.karashima_hu/Desktop/Pandora/Publishments/(KI01 EPJDataScience) Measuring Technological Complexity Using Japanese Patents"
cd "$REPO"

python3 scripts/md_to_pdf.py "$1" "$2"
