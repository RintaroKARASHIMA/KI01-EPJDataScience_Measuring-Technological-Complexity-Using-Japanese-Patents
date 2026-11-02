#!/usr/bin/env python3
"""Minimal Markdown -> standalone PDF converter for reviewer feedback files.

No external dependencies (pandoc/python-markdown not available in this
environment). Handles just what doc/Feedbacks/*.md actually use: ATX headers
(#, ##, ###), blank-line-separated paragraphs, and top-level numbered lists
(lines starting with "N. "). Compiles with xelatex via latexmk.
"""
import re
import subprocess
import sys
from pathlib import Path

SPECIAL = {
    "&": r"\&",
    "%": r"\%",
    "$": r"\$",
    "#": r"\#",
    "_": r"\_",
    "{": r"\{",
    "}": r"\}",
    "~": r"\textasciitilde{}",
    "^": r"\textasciicircum{}",
}


def escape(text):
    # Protect backslash first, then the rest.
    text = text.replace("\\", r"\textbackslash{}")
    for ch, repl in SPECIAL.items():
        text = text.replace(ch, repl)
    return text


def render_inline(text):
    # Bold **text** -> \textbf{text}. Runs after escape(), so raw "**"
    # markers (not in SPECIAL) survive escaping untouched.
    return re.sub(r"\*\*(.+?)\*\*", r"\\textbf{\1}", text)


def convert_body(md_text, page_break_level=2, skip_first_h1=True):
    lines = md_text.splitlines()
    blocks = []
    buf = []

    def flush():
        if buf:
            blocks.append(" ".join(buf).strip())
            buf.clear()

    for line in lines:
        if line.strip() == "":
            flush()
        else:
            buf.append(line.strip())
    flush()

    out = []
    in_enum = False
    first_h1_seen = False
    first_break_section_seen = False
    for block in blocks:
        if block == "---":
            continue  # horizontal-rule separators are redundant with \clearpage
        m = re.match(r"^(#{1,3})\s+(.*)$", block)
        num_m = re.match(r"^(\d+)\.\s+(.*)$", block)
        if m:
            level = len(m.group(1))
            if level == 1 and skip_first_h1 and not first_h1_seen:
                first_h1_seen = True
                continue  # already used as \title
            if in_enum:
                out.append(r"\end{enumerate}")
                in_enum = False
            if level <= page_break_level:
                if first_break_section_seen:
                    out.append(r"\clearpage")
                else:
                    first_break_section_seen = True  # first section stays on the title page
            title = render_inline(escape(m.group(2)))
            cmd = {1: r"\section*", 2: r"\section*", 3: r"\subsection*"}[level]
            out.append(f"{cmd}{{{title}}}")
        elif num_m:
            if not in_enum:
                out.append(r"\begin{enumerate}")
                in_enum = True
            out.append(rf"\item {render_inline(escape(num_m.group(2)))}")
        else:
            if in_enum:
                out.append(r"\end{enumerate}")
                in_enum = False
            out.append(render_inline(escape(block)))
            out.append("")
    if in_enum:
        out.append(r"\end{enumerate}")
    return "\n\n".join(out)


TEMPLATE = r"""\documentclass[10pt]{article}
\usepackage[margin=0.85in]{geometry}
\usepackage{fontspec}
\usepackage{parskip}
\usepackage{hyperref}
\usepackage{titlesec}
\titlespacing*{\section}{0pt}{1.2ex}{0.6ex}
\titlespacing*{\subsection}{0pt}{1ex}{0.4ex}
\setlength{\emergencystretch}{3em}
\begin{document}
\thispagestyle{empty}
\begin{center}
\Large\bfseries %s
\end{center}
\vspace{0.5em}
%s
\end{document}
"""


def main():
    if len(sys.argv) != 3:
        print("usage: md_to_pdf.py <input.md> <output_basename>", file=sys.stderr)
        sys.exit(2)
    src = Path(sys.argv[1])
    outbase = sys.argv[2]
    md_text = src.read_text(encoding="utf-8")
    first_line = md_text.splitlines()[0].lstrip("# ").strip()
    body = convert_body(md_text)
    tex = TEMPLATE % (escape(first_line), body)
    workdir = Path("/tmp/mdpdf")
    workdir.mkdir(parents=True, exist_ok=True)
    texfile = workdir / f"{outbase}.tex"
    texfile.write_text(tex, encoding="utf-8")
    subprocess.run(
        ["latexmk", "-xelatex", "-interaction=nonstopmode", "-halt-on-error", f"{outbase}.tex"],
        cwd=workdir,
        check=True,
    )
    print(workdir / f"{outbase}.pdf")


if __name__ == "__main__":
    main()
