# EPJ Data Science — Regular Article テンプレート

> **ジャーナル概要**  
> *EPJ Data Science* (Springer Nature) は、テクノ・社会・経済システムに関するデータ駆動型研究を対象とするオープンアクセスジャーナル。  
> 投稿規定原文: https://link.springer.com/journal/13688/submission-guidelines

---

## 投稿前チェックリスト

- [ ] 研究内容がジャーナルのスコープ（テクノ・社会・経済システムのデータ分析）に合致している
- [ ] 未発表・未投稿の独自研究である
- [ ] 単なる記述統計や既存手法の適用にとどまらず、新たな知見・洞察を提供している
- [ ] 英語で執筆されている（文法・表現の品質確保）
- [ ] 全著者が投稿を承認している
- [ ] APC (£1,340 / $1,990 / €1,690) の支払い手段または免除申請を確認した

---

## ファイル形式

| 種別 | 対応形式 |
|------|----------|
| 本文 | .doc / .docx / .rtf / .tex (LaTeX) |
| 図 | EPS, PDF, TIFF, JPEG, PNG, BMP, PowerPoint, Word |
| 追加ファイル | 各 20 MB 以内 |

> LaTeX 利用時は [Springer Nature LaTeX テンプレート](https://www.springernature.com/gp/authors/campaigns/latex-author-support) の使用を推奨。

---

## 本文フォーマット（基本ルール）

- 行間: **ダブルスペース**
- 行番号・ページ番号を入れる
- 単位: SI 単位系を使用
- ページブレーク不使用
- 略語: 本文初出時に定義し、末尾に略語一覧を記載

---

## 論文構成（Regular Article）

### 1. タイトルページ

```
タイトル          : 研究デザインや報告内容を含む明確なタイトル
著者（全員）      : 氏名・所属機関・メールアドレス
責任著者          : 明示する
LLM使用の場合     : Methods セクションに使用内容を記載（LLMは著者にはなれない）
```

---

### 2. Abstract（150〜250語）

未定義の略語・未指定の参考文献を含めないこと。

```
[ここにアブストラクトを記載 — 150〜250語]
```

---

### 3. Keywords（3〜10個）

```
keyword1, keyword2, keyword3, ...
```

---

### 4. Main Text

セクション構成は自由だが、以下が一般的：

```
1. Introduction
2. Related Work
3. Data / Dataset
4. Methods
5. Results
6. Discussion
7. Conclusion
```

> 各セクションは短く明確な見出しをつける。

---

### 5. List of Abbreviations（略語一覧）

本文中で使用した略語をアルファベット順に記載。

```
APC : Article Processing Charge
LLM : Large Language Model
...
```

---

### 6. Declarations

以下の項目をすべて記載すること（該当なしの場合は "Not applicable" と書く）。

#### 6.1 Availability of data and materials

```
The dataset(s) supporting the conclusions of this article is(are) available
in the [リポジトリ名] repository, [DOI or persistent URL].
```

（ソフトウェアの場合は以下も追記）

```
Project name      : 
Project home page : 
Archived version  : DOI or identifier (e.g. Zenodo)
Operating system  : 
Programming lang  : 
License           : 
```

#### 6.2 Competing interests

```
The authors declare that they have no competing interests.
（または具体的な利益相反を記載）
```

#### 6.3 Funding

```
[資金源と、それぞれの研究への関与を記載]
```

#### 6.4 Authors' contributions

イニシャルで各著者の貢献を記載。

```
例) XX designed the study and analyzed the data. YY collected the dataset
and drafted the manuscript. All authors read and approved the final manuscript.
```

#### 6.5 Acknowledgements

著者基準を満たさない貢献者への謝辞。

```
[謝辞 or "Not applicable"]
```

#### 6.6 Authors' information（任意）

著者の経歴・所属などの補足情報。

---

### 7. References

**基本スタイル（Basic Springer style）**

| 種別 | 形式例 |
|------|--------|
| 学術論文 | Smith J, Jones M (1999) Title of article. J Name 10:100–110 |
| DOI付き論文 | ... doi:10.1007/xxxxx |
| 書籍章 | Brown B (2001) Chapter title. In: Smith J (ed) Book Title. Wiley, New York |
| Webサイト | Site Name. https://example.com. Accessed 20 May 2024 |

- Web リンクは本文中に置かず、参考文献リストに番号付きで掲載
- 未発表データ・個人的通信は参考文献リストに入れず、本文中で "(unpublished observations)" と記す
- 公開データセットには DOI を含む完全な引用を付与する

---

## 図（Figures）の規則

| 項目 | ルール |
|------|--------|
| 番号付け | 本文での初出順に Figure 1, 2, … |
| タイトル | 最大15語、図ファイル内ではなく本文に記載 |
| 凡例 | 最大300語、本文に記載 |
| ファイルサイズ | 各10 MB 以内 |
| 解像度（PDF最終版） | 約300 dpi、横幅85 mm（半ページ）または170 mm（全ページ） |
| 複合図 | a, b, c … は1ファイルにまとめて投稿 |
| 既存図の転載 | 著作権者から許可を取得し、図の凡例に明記 |

---

## 表（Tables）の規則

| 項目 | ルール |
|------|--------|
| 番号付け | Table 1, 2, …（アラビア数字） |
| タイトル | 表の上に、最大15語 |
| 凡例 | 表の下に、最大300語 |
| 色・シェーディング | 使用不可（上付き文字・太字等で強調） |
| 大型データ | 追加ファイル（.xls / .csv）として提出可 |

---

## 追加ファイル（Additional Files）

- "Additional file 1", "Additional file 2", … と命名
- 本文中で明示的に引用する（例: `[see Additional file 1]`）
- 各ファイルに以下を本文の別セクションで説明:
  - ファイル名
  - ファイル形式と拡張子
  - データのタイトル
  - データの説明

---

## カバーレター（Cover Letter）に含める内容

- [ ] *EPJ Data Science* に投稿する理由
- [ ] ジャーナルポリシーに関する事項（該当する場合）
- [ ] 利益相反の宣言
- [ ] 全著者が投稿を承認した旨
- [ ] 他誌への未投稿・未掲載の確認
- [ ] 特集号投稿の場合はその名称
- [ ] （任意）推薦査読者の氏名・所属・連絡先（ORCID/Scopus ID推奨）
- [ ] （任意）査読を避けてほしい人物

---

## 参考リンク

| リンク | URL |
|--------|-----|
| 投稿規定（メイン） | https://link.springer.com/journal/13688/submission-guidelines |
| Regular Article詳細 | https://link.springer.com/journal/13688/submission-guidelines/regular-article |
| 投稿システム | https://submission.springernature.com/new-submission/13688/3 |
| 推奨データリポジトリ | https://www.springernature.com/gp/authors/research-data-policy/recommended-repositories |
| LaTeX テンプレート | https://www.springernature.com/gp/authors/campaigns/latex-author-support |