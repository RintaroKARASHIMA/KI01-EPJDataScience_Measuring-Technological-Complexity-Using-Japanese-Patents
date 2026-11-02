#!/bin/bash
# Windows 側(Git Bash)から WSL の texlive を呼ぶためのラッパ。
#
# 背景: Git Bash には latexmk が無く、build.sh / diff.sh は WSL 内で実行する必要がある。
# リポジトリのディレクトリ名に丸括弧が含まれるため、`wsl.exe bash -lc 'cd ...'` のように
# インナーシェルへパスを渡すと `syntax error near unexpected token '('` で落ちる。
# そのため cd 先をこのファイル内にハードコードしている。
#
# 使い方(Git Bash から):
#   powershell.exe -NoProfile -Command "wsl.exe bash '/mnt/c/Users/rintaro.karashima_hu/Desktop/Pandora/Publishments/(KI01 EPJDataScience) Measuring Technological Complexity Using Japanese Patents/scripts/wsl-run.sh' build"
#   powershell.exe -NoProfile -Command "wsl.exe bash '.../scripts/wsl-run.sh' diff"
#   powershell.exe -NoProfile -Command "wsl.exe bash '.../scripts/wsl-run.sh' overfull"
set -u

REPO="/mnt/c/Users/rintaro.karashima_hu/Desktop/Pandora/Publishments/(KI01 EPJDataScience) Measuring Technological Complexity Using Japanese Patents"
cd "$REPO" || exit 1

case "${1:-build}" in
  build)
    bash scripts/build.sh 2>&1 | tail -30
    ;;
  diff)
    shift
    bash scripts/diff.sh "$@" 2>&1 | tail -30
    ;;
  overfull)
    # build.sh の後に実行する。Overfull が 0 件であることを確認する用。
    grep -n "Overfull" /tmp/tcibuild/sn-article.log || echo "OK: Overfull なし"
    ;;
  *)
    echo "usage: wsl-run.sh {build|diff [ref]|overfull}" >&2
    exit 2
    ;;
esac
