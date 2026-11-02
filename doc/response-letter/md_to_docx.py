# -*- coding: utf-8 -*-
# letter.md(point-by-point response。2026-09-17 に添え状を doc/cover-letter/ へ分離)から docx を生成する。
# 前回版 response-letter.docx をベースラインとし、そこに(正規化後の文単位で)
# 存在しない文を赤字にする。md と docx の本文は 1:1 で一致する。
#
# 使い方(WSL):
#   python3 md_to_docx.py letter.md response-letter.docx <出力.docx> [--no-red]
#   --no-red: 赤字を付けないクリーン版(ジャーナルへの提出用)。parity 検証は同じ
#
# letter.md の書式: 段落は空行区切り。段落全体が **...** のものは太字段落
# (見出し・査読コメント引用)。それ以外は平文段落。
import sys, re, zipfile

MD, BASE_DOCX, OUT_DOCX = sys.argv[1], sys.argv[2], sys.argv[3]
NO_RED = '--no-red' in sys.argv[4:]

# ---------- ベースライン(前回版 docx)の全文 ----------
with zipfile.ZipFile(BASE_DOCX) as z:
    xml = z.read('word/document.xml').decode('utf-8')
old_texts = []
for p in re.split(r'</w:p>', xml):
    t = ''.join(re.findall(r'<w:t[^>]*>([^<]*)</w:t>', p)).strip()
    if t:
        old_texts.append(t)

def norm(s):
    s = s.replace('“', '"').replace('”', '"')
    s = s.replace('‘', "'").replace('’', "'")
    s = s.replace('–', '-').replace('—', '-')
    return re.sub(r'\s+', ' ', s).strip()

OLD_ALL = norm(' '.join(old_texts))

ABBR = ['Fig.', 'Figs.', 'Eq.', 'Eqs.', 'No.', 'vs.', 'et al.', 'e.g.', 'i.e.',
        'cf.', 'Prof.', 'Dr.', 'Mr.', 'Ms.', 'St.', 'Sec.']

def split_sentences(text):
    prot = text
    for i, a in enumerate(ABBR):
        prot = prot.replace(a, a.replace('.', '\x00%d\x00' % i))
    parts = re.split(r'(?<=[.!?:])\s+(?=[A-Z0-9"(“])', prot)
    out = []
    for p in parts:
        for i, a in enumerate(ABBR):
            p = p.replace(a.replace('.', '\x00%d\x00' % i), a)
        out.append(p)
    return out

def is_old(sentence):
    n = norm(sentence)
    return len(n) < 2 or n in OLD_ALL

# ---------- letter.md の読み込み ----------
with open(MD, encoding='utf-8') as f:
    md = f.read()

paragraphs = []
for block in md.split('\n\n'):
    text = re.sub(r'\s+', ' ', block.replace('\n', ' ')).strip()
    if not text:
        continue
    bold = text.startswith('**') and text.endswith('**')
    if bold:
        text = text[2:-2].strip()
    runs = []
    for s in split_sentences(text):
        r = (not NO_RED) and (not is_old(s))
        if runs and runs[-1]['red'] == r:
            runs[-1]['text'] += ' ' + s
        else:
            runs.append(dict(text=s, bold=bold, red=r))
    is_label = len(text.split()) <= 4
    paragraphs.append(dict(runs=runs, label=is_label))

# ---------- WordprocessingML 出力 ----------
def esc(s):
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')

body = []
in_letterhead = True  # cover letter, before the "POINT-BY-POINT RESPONSE" heading
for para in paragraphs:
    runs = para['runs']
    rxml = []
    for r in runs:
        props = []
        if r['bold']:
            props.append('<w:b/>')
        if r['red']:
            props.append('<w:color w:val="FF0000"/>')
        rpr = '<w:rPr>%s</w:rPr>' % ''.join(props) if props else ''
        rxml.append('<w:r>%s<w:t xml:space="preserve">%s</w:t></w:r>' % (rpr, esc(r['text'])))
        rxml.append('<w:r>%s<w:t xml:space="preserve"> </w:t></w:r>' % rpr)
    if rxml:
        rxml.pop()
    full_text = ' '.join(r['text'] for r in runs)
    is_section_title = full_text.strip().startswith('POINT-BY-POINT RESPONSE')
    if is_section_title:
        in_letterhead = False
    # Short bare/bold labels (e.g. "Major comment", "General comment:", "Before
    # revision:") are kept attached to the paragraph that follows them, so a
    # label never gets stranded alone at the bottom of a page. Long paragraphs
    # (the quoted reviewer comments, which happen to be set in bold) are
    # deliberately NOT treated as headings: giving them keepNext too would bind
    # them to whatever comes next (e.g. the following Response paragraph), so
    # the whole heading+quote+response chain has to fit together on one page or
    # jump as a block, leaving a large blank gap at the bottom of the previous
    # page. Only the short label needs to stay with the quote's first line; the
    # quote itself is free to split normally across the page boundary.
    # The cover letter (date/address/signature block) is excluded entirely: its
    # lines are a plain sequence where a break between any two of them is normal.
    is_heading = (not in_letterhead) and (para['label'] or is_section_title)
    is_reviewer_switch = bool(re.match(r'^Reviewer \d+:$', full_text.strip()))
    # Only the reviewer-switch heading gets extra space before it (a deliberate
    # visual break). Other headings/labels keep the ordinary spacing so they
    # don't consume extra vertical space and shift pagination.
    if is_reviewer_switch:
        spacing = '<w:spacing w:before="480" w:after="160"/>'
    else:
        spacing = '<w:spacing w:after="160"/>'
    ppr = [spacing, '<w:widowControl/>']
    if is_heading:
        ppr.append('<w:keepNext/>')
    body.append('<w:p><w:pPr>%s</w:pPr>%s</w:p>' % (''.join(ppr), ''.join(rxml)))

document = ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
            '<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">'
            '<w:body>%s'
            '<w:sectPr><w:pgSz w:w="11906" w:h="16838"/>'
            '<w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440"/></w:sectPr>'
            '</w:body></w:document>' % ''.join(body))

content_types = ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                 '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
                 '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
                 '<Default Extension="xml" ContentType="application/xml"/>'
                 '<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>'
                 '<Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>'
                 '</Types>')

rels = ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
        '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>'
        '</Relationships>')

doc_rels = ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
            '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
            '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>'
            '</Relationships>')

styles = ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
          '<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">'
          '<w:docDefaults><w:rPrDefault><w:rPr>'
          '<w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>'
          '<w:sz w:val="22"/></w:rPr></w:rPrDefault></w:docDefaults>'
          '</w:styles>')

with zipfile.ZipFile(OUT_DOCX, 'w', zipfile.ZIP_DEFLATED) as z:
    z.writestr('[Content_Types].xml', content_types)
    z.writestr('_rels/.rels', rels)
    z.writestr('word/document.xml', document)
    z.writestr('word/_rels/document.xml.rels', doc_rels)
    z.writestr('word/styles.xml', styles)

# ---------- md と docx の本文一致検証 ----------
md_full = norm(' '.join(' '.join(r['text'] for r in para['runs']) for para in paragraphs))
with zipfile.ZipFile(OUT_DOCX) as z:
    xml2 = z.read('word/document.xml').decode('utf-8')
docx_texts = []
for p in re.split(r'</w:p>', xml2):
    t = ''.join(re.findall(r'<w:t[^>]*>([^<]*)</w:t>', p)).strip()
    if t:
        docx_texts.append(t)
docx_full = norm(' '.join(docx_texts))
assert md_full == docx_full, 'md と docx の本文が一致しません'

n_red = sum(1 for para in paragraphs for r in para['runs'] if r['red'])
print('paragraphs:', len(paragraphs), ' red runs:', n_red, ' parity: OK')
