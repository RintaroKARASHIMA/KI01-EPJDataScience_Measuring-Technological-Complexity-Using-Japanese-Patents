# 【非推奨・参考用】2026-09-17 22時以降、この環境の Word COM が SaveAs2 / ExportAsFixedFormat で
# 無応答になった(最小テストでも再現、ダイアログなし)ため、提出版は cover-letter.tex + build_cover_letter.sh で生成した。
# 改訂投稿用カバーレターを、初回投稿時の CoverLetter_RintaroKARASHIMA.pdf と同じ体裁で生成する。
# レターヘッドと手書き署名は初回PDFから抽出した画像(assets/)。本文は Yu Mincho 10.5pt、行送り16pt。
# 使い方(PowerShell): & .\make_cover_letter.ps1   → 同じフォルダに .docx と .pdf を出力する。
# 本文を変えるときはこのファイルの AddPara / TypeText の文字列を編集して再実行する。
$ErrorActionPreference = "Stop"
$Here   = Split-Path -Parent $MyInvocation.MyCommand.Path
$Letterhead = Join-Path $Here "assets\letterhead.png"
$Signature  = Join-Path $Here "assets\signature.png"
$OutDocx = Join-Path $Here "CoverLetter_RintaroKARASHIMA_revision_v20260917.docx"
$OutPdf  = Join-Path $Here "CoverLetter_RintaroKARASHIMA_revision_v20260917.pdf"

Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force -Confirm:$false
Write-Output "step: starting Word"
$word = New-Object -ComObject Word.Application
Write-Output "step: Word started"
$word.Visible = $false
$word.DisplayAlerts = 0                      # wdAlertsNone: 非表示の Word でダイアログが出ると COM が止まるため
try {
  $doc = $word.Documents.Add()
  Write-Output "step: document added"
  $ps = $doc.PageSetup
  $ps.PaperSize = 7          # wdPaperA4
  $ps.TopMargin = 36
  $ps.BottomMargin = 45
  $ps.LeftMargin = 51
  $ps.RightMargin = 51

  $sel = $word.Selection
  $sel.Font.Name = "Yu Mincho"
  $sel.Font.Size = 10.5
  $sel.ParagraphFormat.SpaceBefore = 0
  $sel.ParagraphFormat.SpaceAfter = 0
  $sel.ParagraphFormat.LineSpacingRule = 4   # wdLineSpaceExactly
  $sel.ParagraphFormat.LineSpacing = 16
  $sel.ParagraphFormat.Alignment = 0         # left

  # Letterhead (single line spacing here: "exactly" spacing clips inline pictures)
  $sel.ParagraphFormat.LineSpacingRule = 0
  $sel.ParagraphFormat.Alignment = 1        # centered letterhead
  $shape = $sel.InlineShapes.AddPicture($Letterhead, $false, $true)
  $shape.LockAspectRatio = -1
  $shape.Width = 389
  $sel.TypeParagraph()
  $sel.ParagraphFormat.Alignment = 0
  $sel.ParagraphFormat.LineSpacingRule = 4
  $sel.ParagraphFormat.LineSpacing = 16
  $sel.ParagraphFormat.SpaceBefore = 14

  function AddPara([string]$text, [bool]$justify, [double]$indent, [double]$after) {
    $sel.ParagraphFormat.Alignment = $(if ($justify) { 3 } else { 0 })
    $sel.ParagraphFormat.FirstLineIndent = $indent
    $sel.ParagraphFormat.SpaceAfter = $after
    $sel.TypeText($text)
    $sel.TypeParagraph()
    $sel.ParagraphFormat.FirstLineIndent = 0
    $sel.ParagraphFormat.SpaceAfter = 0
    $sel.ParagraphFormat.Alignment = 0
  }

  AddPara "September 17, 2026" $false 0 14
  $sel.ParagraphFormat.SpaceBefore = 0
  AddPara "Prof. Johannes Wachs" $false 0 0
  AddPara "Editor" $false 0 0
  $sel.Font.Italic = -1; $sel.TypeText("EPJ Data Science"); $sel.Font.Italic = 0; $sel.TypeParagraph()
  $sel.TypeParagraph()
  AddPara "Dear Editor:" $false 0 10

  # 本文は doc/cover-letter/cover-note_former-page1_v20260917.md(point-by-point response の旧1ページ目)と同文。
  # 単独文書になったため "below"(同一文書内の回答を指す語)だけ "in the accompanying point-by-point response" に変更。
  $p1 = 'We are grateful for your constructive comments and the valuable suggestions provided by the reviewers. We appreciate this opportunity to resubmit our manuscript, titled “Measuring Technological Complexity Using Japanese Patents,” for publication in '
  $sel.ParagraphFormat.Alignment = 3; $sel.ParagraphFormat.FirstLineIndent = 14
  $sel.TypeText($p1); $sel.Font.Italic = -1; $sel.TypeText("EPJ Data Science"); $sel.Font.Italic = 0
  $sel.TypeText(" as an original research article. The manuscript ID is c2970727-07a5-4193-93d3-809ed46060d2.")
  $sel.TypeParagraph()

  AddPara "In response to the feedback, we have thoroughly revised our paper, incorporating all comments and suggestions from the reviewers. Both reviewers raised serious concerns about whether our analysis supported the paper’s primary claims. We carried out the additional analyses the reviewers requested, and in two respects the results confirmed the reviewers’ concerns rather than merely qualifying them. A subsampling test shows that most of the apparent advantage of the corporate-level measure over the regional-level measure reflects the number of actor nodes rather than the corporate level itself, and the original prefecture-to-prefecture comparison could not be defended against a placebo null distribution, so we have withdrawn that analysis and its figure. In their place, we added a new out-of-sample validation in which corporate-level TCI predicts subsequent regional technological entry while regional TCI does not. During the revision we also found and corrected several errors in the submitted manuscript that the reviewers had not flagged but that affected passages they commented on, and these are disclosed in the individual responses. We report all of this directly in the accompanying point-by-point response, together with the corresponding revisions to the Abstract, Introduction, Results, Discussion, and Methods. Manuscript locations cited in the responses refer to the revised manuscript, and page and line numbers refer to its line-numbered PDF." $true 14 0

  Write-Output "step: body paragraphs typed"
  AddPara "In accordance with the submission requirements, we have prepared the following files:" $true 14 0
  # 曲がった二重引用符 “ ” は PowerShell では " と同じ区切り文字になるため、単一引用符で囲む(' は '' で表す)
  AddPara '1) A “Point-by-point response” to the reviewers'' comments' $false 0 0
  AddPara '2) The “Manuscript file”, submitted as a LaTeX source archive with all figures included, for compilation by the production system' $false 0 0
  AddPara '3) A “Related file”: the revised manuscript with tracked changes relative to the submitted version, for the reviewers'' reference' $false 0 0

  Write-Output "step: file list typed"
  AddPara "We believe we have addressed all concerns raised and hope that our paper is now suitable for publication. We look forward to your feedback." $true 14 10

  AddPara "Kind regards," $false 0 4
  Write-Output "step: closing typed"
  $sel.ParagraphFormat.LineSpacingRule = 0
  $sig = $sel.InlineShapes.AddPicture($Signature, $false, $true)
  $sig.LockAspectRatio = -1
  $sig.Width = 150
  $sel.TypeParagraph()
  $sel.ParagraphFormat.LineSpacingRule = 4
  $sel.ParagraphFormat.LineSpacing = 16
  AddPara "Rintaro Karashima" $false 0 0
  AddPara "Graduate School of Information Science, University of Hyogo" $false 0 0
  AddPara "7-1-28 Minatojima-minamimachi, Chuo-ku, Kobe, 650-0047, Hyogo, Japan" $false 0 0
  AddPara "+81 80-4647-8803" $false 0 0
  $sel.TypeText("rintaro.karashima@gmail.com")
  Write-Output "step: signature block typed"

  $doc.SaveAs2($OutDocx, 16)          # wdFormatXMLDocument
  Write-Output "step: docx saved"
  $doc.ExportAsFixedFormat($OutPdf, 17)
  Write-Output "step: pdf exported"
  $doc.Close([ref]0)
  Write-Output "saved: $OutDocx"
  Write-Output "saved: $OutPdf"
} finally {
  $word.Quit()
}
