# 修正計画(Major Revision)

査読者・指導教員からのフィードバックに基づき、どこをどう直すかを論点単位で記録する。
着手前に優先度とステータスを確認し、対応後は本ファイルのステータスを更新する。
個々の論点への対応は 1コミット = 1論点(`CLAUDE.md` の「査読対応の進め方」参照)。ただし同一文面を触る論点は例外的にまとめる(下記「A作業の着手順」の根拠欄を参照)。

- 優先度: **High**(論文の中心的主張に関わる/複数の査読者が指摘) / **Medium** / **Low**(記述修正・軽微)
- 区分: **A**(書きぶりの修正で対応可能。新しい数値・図・分析を必要としない) / **B**(追加の実験・検証が必要。分析コードの再実行を伴う) / **A+B**(一部は書きぶりで先行対応でき、完全な対応には追加分析が要る)
- ステータス: 未着手 / 検討中 / 対応方針決定 / 対応済み(A+B は「A対応済み・B未着手」のような複合表記を使う)

まずは区分 A(および A+B の A 部分)を、後述の着手順に従って上から順に対応する。

## Major(論文の主張・構成に関わる論点)

| ID | 出典 | 論点 | 優先度 | 区分 | 対応方針(A部分/B部分) | ステータス |
|----|------|------|--------|------|----------------------|-----------|
| R2-1 | Reviewer 2 #1 | 安定性の主張が「企業レベル」と「ノード数(47 vs 1939)」の交絡である可能性 | High | A+B | **A**: Abstract・2.2節・Discussion 第1貢献の「企業レベルが優れる」という因果的表現を「本データでは企業レベルの方が分類粒度変更に対する感度が低かった」という記述的表現に改め、ノード数(47 vs 1,939)の寄与を分離できていないことを限界として明記。**B**: 企業数を揃えたサブサンプル実験(47/100/500/1939)または地域側の細分化(市区町村等)の少なくとも一方を実施し、Fig.2 相当の比較を追加 | **対応済み(順9・順11・順14・順15)**。B の結果(F-0058)は**査読者の指摘を支持した**。N=47 に揃えると gamma +0.057 まで落ち 5-95%区間は負を含む。順4 で置いたプレースホルダを実測記述に差し替える |
| R2-2 | Reviewer 2 #2 | 一貫性(consistency)は妥当性(validity)を保証しない。外部・予測的検証が必要 | High | A+B | **A**: 「more reliable」「significant progress」等の優位性表現を弱め、「一貫性は必要条件であり妥当性の証明ではない」ことを本文で明示。外部検証を将来課題ではなく本研究の明確な限界として位置づけ直す。**B**: R&D集約度・前方引用・技術参入のいずれか1つの外部アウトカムで corporate TCI と regional TCI を直接比較する out-of-sample 検証を追加 | **対応済み(順10・順11・順13・順14・順15)**。GRP 成長では両者 null(F-0044、FC 系の仕様なため著者判断でスコープ外)。**技術参入予測で corporate TCI が優位**(F-0059: ipc3 同時投入 p=0.0064、F-0061: relatedness density 統制後も p=0.0104)。査読者が受理の「条件」とした外部検証は満たされた |
| R1-4 | Reviewer 1 #4 | Section 2.2 の安定性の主張が根拠に対して強すぎる | High | A | 2.2節と Discussion の stability/consistency の主張を「本データセットにおいて、この分類粒度変更に対して企業レベルTCIの感度が低い」という範囲に限定する。R2-1・R2-2 の A 部分と同一文面のため一体で対応 | 対応済み(順4 で主張レベルを限定し、順9・順11 で「優位の大部分はノード数効果」という実測に更新。Abstract は順15 で改稿) |
| R1-1 | Reviewer 1 #1 | 文献の位置づけ・新規性の主張が弱い(Balland & Rigby, ref[18]等との差別化不足) | High | A | Introduction の文献レビューを拡充し、指摘された文献(Straccamore et al. 2023, 2025; Pugliese et al. 2022)を引用・位置づける。「unit of analysis / metric / empirical question / substantive contribution」の4軸で先行研究との差分を示す段落を追加。R2-4と同一コミット | 対応済み |
| R2-4 | Reviewer 2 #4 | 新規性への疑問。実質的な知見が既知の定型的事実の再現に留まる懸念 | High | A | Results の医薬品・愛知の電機等の知見を「手法の妥当性確認(既知の産業地理との整合)」として再位置づけし、Discussion の貢献リストを方法論的側面(企業レベル実装+粒度間比較の枠組み)に絞る。R1-1と同一コミット | 対応済み(優位性表現そのもののトーンダウンは順4に持ち越し) |
| R1-2 | Reviewer 1 #2 | TCIとubiquityの関係の解釈が不明瞭(rarity/diversification/sophisticationの混同) | High | A+B | **A**: 2.1節冒頭に TCI の解釈を1段落で明示する(TCI は rarity そのものではなく、接続する企業の多様性構造から推定される相対指標であること、ubiquity との正相関の意味)。Electrical Engineering vs Chemistry の記述を、low TCI=「低洗練」ではなく「特化型企業への集中」と読める形に統一。**B**: Fitness-Complexity での再計算・比較(任意だが R1 の納得度を上げる) | **A対応済み・B完了**(A対応中に統計量の解釈誤りとPanel参照ミスを発見・修正。下記「発見した既存の誤り」参照)。B の FC 比較(F-0046)は TCI と負相関(−0.643)だが、**FC は本論文のスコープ外という著者判断**のため本文では扱わない |
| R1-9 | Reviewer 1 #9 | 上位3%フィルタリングの正当化が不十分 | Medium | A+B | **A**: Methods に、3%フィルタの目的(ノイズ除去)と RTA ステップとの関係、フィルタ前後のネットワーク規模を説明する文を追加(数値は分析側と要照合)。**B**: RTAのみ / RTA+degree-1除去 / top-3% の3構成での比較。R2-3と同一コミット | **対応済み(順13)**。F-0048: RTA のみでは企業の 57.8% が degree-1 で、RTA 自体はほとんど低活動企業を除去していない。**degree-1 除去(gamma +0.962)は top-3%(+0.585)より強い一貫性**を与える。査読者の提案どおり実施し Table S2 で報告したうえで、top-3% を主仕様に保つ理由を明示した |
| R2-3 | Reviewer 2 #3 | 3%フィルタの感応度分析がなく、安定性の主張と交絡する | Medium | A+B | **A**: regional 分析と corporate 分析が同一のフィルタ条件のデータから計算されているかを事実確認のうえ Methods に明記(不一致なら整合化はB)。**B**: 閾値 1%/5%/10% で TCI ランキングと Fig.2 の一貫性比較を再現。R1-9と同一コミット | **対応済み(順13)**。F-0047 / F-0058: TCI ランキングは閾値に頑健(&#124;rho&#124;≥0.90)だが、**Fig.2 の一貫性優位は非単調で p=1 では符号反転する**(gamma −0.076)。p=5 で跳ねるのは地域側 &#124;ΔTCI&#124; が 19.6→55.7 に悪化するためで、閾値に不安定なのは地域側の指標(企業側は 6.66→6.85 でほぼ不変)。第3点(地域側入力の同一性)は Q-0038 / F-0040 で解決し、like-for-like で再生成しても結論は不変 |
| R1-5 | Reviewer 1 #5 | 地域比較(prefecture間)の議論が定性的すぎる | Medium | A+B | **A**: 2.2節後半と Abstract 最終文の地域比較の主張を弱め、「対角からの乖離は noise や測定感度の可能性を排除できず、外部検証が必要」という限界を明記。**B**: 対角乖離の有意性基準の設定や地域生産構造との外部照合 | **対応済み(順10・順14・順15)**。B の結果(F-0049 / F-0059)により、**対角乖離はプラセボ帰無分布と区別できない**(パーセンタイル 17%/52%/48%)。定性的な限界の明記では足りず、**主張そのものの撤収**が必要 |
| R1-6 | Reviewer 1 #6 | Discussionの3つの主張が結果に対して強すぎる(特に時間的安定性) | Medium | A+B | **A**: Discussion 第2貢献を「示唆」レベルに弱め、2.2節の時間的安定性の記述を Fig.S2 が直接支持できる範囲(例示的観察)に縮小。**B**: Fig.S2 を本文で言及する少数系列のみのハイライト版に再設計(分析側) | **A対応済み・B完了**(F-0050: 強調版バンプチャートを生成済み。原稿側は図の差し替えのみ)。SI の実内容と合わない "firm-level ranking transitions" の文は削除 |
| R1-7 | Reviewer 1 #7 | 予測・政策応用への言及が時期尚早 | Medium | A | Discussion 末尾の予測モデリング・政策応用の記述を「本研究が実証した内容」から切り離し、外部検証を前提とした将来課題として書き直す。Abstract の政策的含意の表現も同様に弱める | 対応済み(Abstract 最終文は地域比較と同一文のため順7で一括対応) |
| R1-3 | Reviewer 1 #3 | Fig.1B の分析が浅い(相関係数のみでquadrant構造に触れていない) | Medium | A+B | **A**: Fig.1B の解釈に「大域相関が低いことは high-high / low-low 象限への集中構造を否定しない」旨を追記し、「negligible correlation」を結論として押し出す書き方を弱める(査読者が明示した最低ライン)。**B**: assortativity や象限集中の統計的検定を追加(追求する場合のみ) | **対応済み**(B の検定結果 F-0045 を順8 で本文に反映済み)。**査読者の観察は部分的に不正確**(下記「発見した既存の誤り」参照)。B の結果が出たら本文の future work 文を定量記述に差し替える |
| R1-8 | Reviewer 1 #8 | 1981-2010の企業同一性(合併・消滅・改称)の扱いが未説明 | Medium | A | Methods の Data 節に、出願人名の同定方法と合併・改称・消滅企業の扱いを1段落で追記し、2.2節の該当記述と整合させる | **対応済み**(新順12)。名寄せ手続き・期間外改称の遡及適用・親子非連結を Methods に明記。フィルタ後の退出企業が 8.0%(全体 84.6%)であることを「ノードは概ね安定した経済主体」の根拠として提示 |

## Minor(記述・体裁の修正)

| ID | 出典 | 論点 | 優先度 | 区分 | 対応方針 | ステータス |
|----|------|------|--------|------|----------|-----------|
| R1-m1 / R2-m1 | Reviewer 1 #1, Reviewer 2 #1 | TCI定義の重複記載(lines 130-136) | Low | A | 旧版の定義文を削除し、一方に一本化する。Fig.2 キャプションのスケーリング説明の重複も併せて解消 | 対応済み |
| R2-m1 | Reviewer 2 #1 | RTA/Balassaの文が重複記載(lines 484-487) | Low | A | verbatim 重複している後半の文を削除する | 対応済み |
| R1-m2 | Reviewer 1 #2 | Fig.1の軸ラベル表記が不統一 | Low | B | 図の生成コードは別管理。分析側でラベルを $K_{T,0}$/$K_{T,1}$ と同スタイルの TCI 表記に統一した EPS を再生成し、原稿側は差し替えのみ | 対応済み(Q-0032)。dictv2 版の `Figs/Fig1.eps` に差し替え済みで、Panel D の "Diverstity" の綴りミスも解消 |
| R1-m3 / R2-m3 | Reviewer 1 #3, Reviewer 2 #3 | 文法ミス(lines 371-372 "data identify" 等) | Low | A | 指摘箇所("data identify", "consitent", "we follows" 等)を修正したうえで、R2 の要求どおり全文の language pass を1回かける(`doc/style-guide/general.md` のトーン準拠) | 対応済み(明確な文法誤り8件を修正。文体レベルの調整は各論点コミットで実施) |
| R1-m4 | Reviewer 1 #4 | Abstractが長すぎる・結果詳細に寄りすぎ | Low | A | Abstract を約半分に短縮し、結果詳細(具体的分野名の列挙等)を減らして「課題→手法→中核的貢献→含意」の標準構成に書き直す。主張レベルは修正後の本文に一致させるため**最後に実施** | 対応済み(順15。10文→6文・220語) |
| R1-m5 | Reviewer 1 #5 | $K_{T,1}$ が Methods での定式化より前に登場する | Low | A | 2.1節の初出時に「接続企業の多様性の平均(正式な定義は Methods)」という1文の直感的定義を添える | 対応済み |
| R2-m2 | Reviewer 2 #2 | 保持率の数値不整合(91% vs 93%、正しくは90.9%) | Low | A | Fig.S3 キャプションの「93%」を「approximately 91%」に修正し Methods と一致させる。算術的には確定しているが、数値ポリシー上、分析側に一言確認してから反映する | 対応済み(**要事後確認**: `Figs/FigA3.eps` の図中に "93%" が焼き込まれていないか) |
| R2-m4 | Reviewer 2 #4 | 参考文献リストの未完成エントリ("???"等) | Low | A | "???" の正体は BibTeX が必須フィールド欠損時に出力するもの。本文引用のある4件(`jaffe2019patent`, `gault2023handbook`, `Bhatia2018`, `diodato2024handbook`)を書誌確認のうえ補完。併せて重複文献 `Balland2016`(= `balland2017tci`、年が誤り)を削除 | 対応済み(未引用の不備エントリ `mcgowan2015future`, `squicciarini2013measuring`, `oh2023r` は出力されないため未対応) |

## A作業の着手順(コミット計画)

順序の考え方: (a) 機械的修正を先に済ませて以後の diff を汚さない → (b) 論文のフレーミング(新規性・主張レベル)を確定させる → (c) 個別節の修正 → (d) Abstract は全主張が確定してから最後に。

| 順 | コミット | 含む論点 | まとめる根拠 |
|----|---------|----------|-------------|
| 1 ✅ | 校正一括(重複削除・文法・数値不整合・bib補完・$K_{T,1}$ 直感定義) | R1-m1/R2-m1, R2-m1(RTA), R1-m3/R2-m3, R2-m2, R2-m4, R1-m5 | いずれも R2 minor #3 が求める "careful language pass" に属する、論旨に触れない機械的修正。response letter でも一括回答するため分割しない |
| 2 ✅ | 文献位置づけ・新規性の書き直し | R1-1, R2-4 | Introduction / Discussion の同一段落群を書き換えるため分離不能 |
| 3 ✅ | TCI解釈の明確化(A部分) | R1-2 | 単独 |
| 4 ✅ | 安定性・優位性主張のトーンダウン(A部分) | R1-4, R2-1(A), R2-2(A) | 3論点とも Abstract・2.2節・Discussion 第1貢献の**同一文面**を弱める作業で、文単位に切り分けられない |
| 5 ✅ | Discussion 第2貢献(時間的安定性)のトーンダウン(A部分) | R1-6 | 単独(Fig.S2 再設計は B として分析側へ) |
| 6 ✅ | 予測・政策応用のトーンダウン | R1-7 | 単独 |
| 7 ✅ | 地域比較の主張縮小・限界明記(A部分) | R1-5(+ Abstract 最終文の R1-7 部分) | Abstract 最終文は地域比較と政策的含意が同一文のため分離不能 |
| 8 ✅ | Fig.1B 解釈の追記(A部分) | R1-3 | 単独 |
| 12 ✅ | 企業同一性の扱いを Methods に追記 | R1-8 | 単独。事実確認待ちを吸収するため後半に配置(当初の順9) |

補足:
- 順4 は Abstract・2.2節・Discussion の3箇所を同時に触る。

### 順9 以降の再設計(2026-08-12)

B作業(Q-0028〜Q-0043)の結果が出そろい、**A のトーンダウンだけでは足りず、結果の中身と論文の構成そのものを組み替える必要がある**ことが判明したため、当初の順9〜11 を破棄して再設計した。判明した内容は下記2点。

1. **ノード数交絡は査読者の指摘どおりだった**(F-0058)。N=47 に揃えると企業側の一貫性優位は gamma +0.057 まで落ち、5-95%区間は負を含む。順4 で書いた「分離できていない(今後の課題)」というプレースホルダは、「分離を実施した結果、優位の大部分はノード数効果だった」という実測の記述に置き換える必要がある。
2. **旧 Fig.3(府県間比較)の主張は成立しない**(F-0049 / F-0059 / F-0052)。愛知は分類の 95.0% が TCI≥95 に飽和して固有ベクトルが退化しており、対角乖離はプラセボ帰無分布のパーセンタイル 17%/52%/48% で有意でない。一方で **技術参入予測では corporate TCI が regional TCI を明確に上回り、relatedness density を統制しても残る**(F-0061)。地域情報に関する主張は旧 Fig.3 から参入予測(新 Fig.3)へ載せ替える。

| 順 | コミット | 含む論点 | 内容 |
|----|---------|----------|------|
| 9 ✅ | 2.2節の改稿(ノード数分離の実測を本文へ) | R2-1(B反映), R1-4 | 順4 のプレースホルダを F-0058 の実測記述に差し替え済み。**Fig.2 Panel C の作図を Q-0044 で起票済み。図が届くまでコミットしない**(本文が Panel C を参照するため) |
| 10 ✅ | 新2.3節「地域情報」の新設 | R1-5(B反映), R2-2(B反映) | 適用済み。2.2節タイトルを "Consistency across Classification Granularities and over Time" に、導入を地域言及なしに変更。府県間比較14文と旧 Fig.3 を削除し、新 subsection 2.3 "Regional Information and Out-of-Sample Validation"(`subsection:validation`)を挿入。`Figs/Fig3.eps` を `Fig3PredictionAB.eps` に差し替え。`hidalgo2007product` を bib に追加 |
| 11 ✅ | Discussion の全面整合 | R1-4, R1-6, R2-1, R2-2 | 適用済み。第1貢献をノード数効果の**診断**として再定義(「方法論的貢献」の2文は削除)。第3貢献を「府県別推定は退化して失敗 → 参入予測で企業側のみが情報を持つ → 判別性能の改善は限界的で情報テストであり予測ツールではない」に全面書き換え。限界の段落を「分離できていない/未検証」から「分離済み・検証済み、ただしスコープは限定」に改訂。外部検証の段落と結語を「実施済みの第一歩」に書き換え、**"does not demonstrate any predictive advantage" の矛盾文を解消**(grep で不在を確認)。Fitness-Complexity の文と Spearman −0.643 は**意図的に触らない**(どの順序が正しいかという新たな論点を開くため)。第2貢献と他2つの限界段落も変更なし |
| 13 ✅ | Methods のフィルタ正当化 + SI に感応度分析 | R1-9, R2-3 | 適用済み。Data 節に3点の正当化(RTA だけではほぼ除去されない / 閾値は ex ante 定義 / ランキングは閾値に頑健)を追記。Methods 末尾に `\subsection{Robustness Procedures}`(サブサンプル手続き・閾値感応度・pruning 比較)と `\subsection{External Validation Procedures}`(期間分割・参入定義・完全分離の除外・標準化・density の定義 eq9・プラセボとダウンサンプル・成長回帰)を新設。SI に **Table S1(閾値感応度)と Table S2(pruning 比較)** を LaTeX の表として追加(図を作れないため表を選択。分析側への作図依頼が不要になる)。**degree-1 除去が gamma +0.962 で主仕様 +0.585 より強いことを正直に報告**し、top-3% を主仕様に保つ理由を2点(ex ante 定義・報告している差を広げる方向なので保守的)明示。p=1 の符号反転も開示し、順9 のノード数機構と接続。**AUC と成長の adj R² は Methods に書かない**(前者は 2.3節と重複し攻撃面を広げる、後者は同時投入版か未確認)。確認事項は Q-0046 |
| 14 ✅ | Introduction の更新 | R1-1, R2-4 | 適用済み。**4軸の構造は維持**(R1-1 が使った語に一対一で対応させたもので、response letter の整合上変えない)。Third を「差はレベルの効果かノード数か」+「企業側は地域側にない情報を持つか」に、Fourth を「診断 + out-of-sample の情報テスト」に更新。結果予告(148-151行)の「exploratory comparison of prefectures」を「府県別直接推定は縮退 → 全国計算+地域帰属なら参入を予測」に差し替え。**ノード数効果は Introduction で定性的に開示**(数値は Results に譲る)。構成予告に Methods の新 subsection 2本を反映 |
| 15 ✅ | Abstract の全面改稿 | R1-m4 | 適用済み。**10文 → 6文**(220語、EPJ DS 規定の 150-250語内)。課題→手法→中核的貢献3文(診断 / 負の診断 / 情報テスト)→含意の標準構成。pharmaceuticals・food chemistry の分野名列挙を削除(R1-m4 が名指しした箇所)。「less sensitive」は残しつつ同一文内でノード数由来を開示。政策への直接言及を除去し "practical guidance for applying complexity measures to subnational units" に留めた。**成長タスクは入れない**(符号逆転を6文で説明できず、本文でも二次的観察の位置づけ)。キーワードは `bipartite networks` → `out-of-sample validation` に差し替え(6語維持) |

### 残作業(2026-08-14 時点)

**原稿本文の A 作業は順1〜15 すべて完了**し、SI キャプション修正も済んだ。`bash scripts/build.sh` は exit=0、未定義引用・未定義参照なし、**Overfull ゼロ**、不備文献エントリなし。`bash scripts/diff.sh` も通る。

残っているのは次の1つで、このリポジトリ単独では終わらない。

1. **response letter の下書き**(2026-08-14 完了・著者レビュー待ち)。`doc/response-letter/letter.md` に Fable が下書きを作成済み。数値は `sn-article.tex` の実際の記載値と突合済みで一致を確認した(F-0058/F-0059/F-0061 系列の主要な数値はすべて本文と letter で一致)。**著者が内容を承認してから、CLAUDE.md の方針どおり本文変更と同じコミットで確定させる**(順1から1コミット=1論点で分割し、letter の該当箇所を各コミットに含める)

`git push origin submitted` は 2026-08-14 に実施済み。CI の差分 PDF ワークフローが動く状態になった。

**2026-08-14〜16 に分析側待ち3件がすべて解決した**(詳細は「B作業」節の表を参照)。
- **Q-0044 完了**。`Fig2.eps` を4パネル版(A=企業散布図・B=地域散布図・C=|ΔTCI|バイオリン図・D=新しい N vs gamma プロット)に差し替え済み。当初 Q-0044 は「既存 Fig2 は A/B の2パネル」を前提にしていたが、実際は A/B/C の3パネルだったため、著者確認の上でレイアウトを A/B/C(既存)+ D(新規)に確定した。この過程で判明した**査読者指摘外の誤り**として、原稿のキャプション(234-247行)と本文2箇所(旧253行「Panel B」・旧256行「Panel C」)が実際の画像と食い違っていたため、キャプションを A/B/C/D 定義に全面改稿し、本文の参照を Panel C(|ΔTCI|分布)・Panel D(新プロット)に修正した。**この修正と Q-0044 の図差し替えにより、順9(2.2節改稿)のコミット前提条件が満たされた**
- **Q-0045 完了**。分析側の `results.md` に不足していた行(ipc3「統制なし・同時投入」・schmoch35 の4行)が追加された(F-0065)。本文が引用している定性的記述(「density を統制しないと同時投入ではどちらも有意にならない」)と数値は一致することを確認済み。本文に数値を追加するかは著者判断で、**現状は定性的記述のままで成立している**(未反映のままでよい)
- **Q-0046 完了**。Table S2 の次数統計は**ipc3(124分類)のRTAネットワーク**の値であることが確定し(F-0064)、原稿の Table S2 キャプションに「at the three-digit IPC level」を追記した。地域側の入力特許集合は「企業側のフィルタ後の特許集合をそのまま再利用する(like-for-like)」ことが確定したため、キャプションに「computed from the same patent set that the corporate-side filter retains at each threshold」を追記した

`bash scripts/build.sh` は exit=0、Overfull ゼロ、不備文献エントリなしを維持したまま反映済み。

**次にやること**は response letter 下書きの著者レビュー(DRAFT NOTE の Q-0044・Q-0046 待ち事項は解消したため、レビュー後に DRAFT NOTE を除去できる)。そのうえで 順9 以降を含めた全コミットの分割・確定に進める。

- 論点ごとの回答内容 → Major / Minor の各表の「ステータス」欄(何を、どの順で本文に反映したかを記載済み)
- 査読者に不利な結果の開示方針 → 「順9 以降の再設計」節。ノード数交絡は**査読者の指摘が正しかった**、旧 Fig.3 の主張は**撤収**、degree-1 除去は主仕様より**強い**結果を出す、の3点は letter でも隠さない
- 査読コメント自体が不正確な2件(Reviewer 1 #3 の Fig.1B の象限記述、Reviewer 1 #1 の参考文献[3]の書誌)の扱い → 「査読コメント自体の誤り」節に方針を記載済み
- letter 限定の図として旧 Fig.3 とプラセボ比較を添付する案は「旧 Fig.3 を SI に残さない」根拠(3)に記載
- letter ができたら **1コミット = 1論点** で順1 から分割してコミットし、本文と letter の記述を同じコミットに入れる

旧 Fig.3(府県間比較)は **SI に残さず削除**した。根拠は3点。(1) 撤収の根拠となる情報(median |ΔTCI|・プラセボのパーセンタイル・愛知の飽和率)はすべて新2.3節の本文に数値で記載しているため、図が担う情報が残らない。(2) 旧 Fig.3 は唯一 dictv2 での再生成が済んでいない図で、SI に残すなら再生成の工数が必要になる。解釈を撤回した図のためにそれを使うのは不合理。(3) 透明性は response letter で担保できる(letter に旧図とプラセボ比較を letter 限定の図として添付するのが自然)。git 履歴には残るので復元は可能。

新2.3節で使った数値の出所(すべて dictv2):
- 府県別ネットワークの退化・プラセボ: F-0049 / F-0059 / F-0052
- 参入ロジット(ipc3 同時投入 +density): F-0061、標準化係数は F-0062
- 技術シェア成長: F-0061 の「density_c 平均・同時投入」行(corporate p=0.0177 / regional p=0.684)
- **注意**: 成長タスクの「density なし・同時投入」の値は `experiments/12_validation_long/docs/results.md` の表に無く、Fig.3 Panel B の図中注記(corporate p=0.111 / regional p=0.744)にしか出ていない。本文では数値を引かず「density を統制しないと同時投入ではどちらも有意にならない」と定性的に書いた。results.md 側に行を足してもらうのが望ましい(Q-0045 で依頼)

Fig.3 の扱い(2026-08-12 決定):
- 新 Fig.3 は **2パネル版 `Fig3PredictionAB.eps`** を使う。Panel A = 参入ロジットの TCI 係数比較、Panel B = 技術シェア対数成長率での同型比較
- Panel C(ROC)は落とす。in-sample AUC の増分が +0.0015(0.7974 → 0.7989)で3本の曲線が視覚的に重なり、Panel A/B の主張を打ち消すため。判別性能ではなく「情報テスト」として書く
- 参入(係数 +0.2166)とシェア成長(係数 −0.0157)で符号が逆転する。extensive margin / intensive margin の違いという読み方を採るが、成長側は抑えめに書く

## B作業(要・分析リポジトリ)

このリポジトリ単独では数値を書き換えないため(`CLAUDE.md` 参照)、分析側への依頼をここで追跡する。

**2026-08-13 時点で Q-0028〜Q-0043 はすべて完了した。** 原稿の正本データ版は **dictv2**(著者決定)。以降の作業は分析結果を本文に反映する A 作業(順9 以降)であり、新たな B 作業は Fig.2 Panel C の作図のみ。

追跡は分析リポジトリ `KCIinJapaneseFirms` の `knowledge/open_questions.csv`(Q-NNNN)で行う。本表はその索引。

| ID | 必要な追加分析 | 分析側 Q | 状況 |
|----|---------------|---------|------|
| R2-1 | 企業数を揃えたサブサンプル比較(47/100/500/1939)、または地域側を市区町村等に細分化した比較 | Q-0028 | **完了**(F-0042 → dictv2 で F-0058)。**査読者の指摘は支持された**。N=47 で gamma +0.057、5-95%区間は負を含む。順9 で本文に反映 |
| R2-2 | 外部アウトカム(R&D集約度・生産性・前方引用・将来の技術参入のいずれか)による corporate vs regional TCI の head-to-head な out-of-sample 比較。査読者は「望ましい拡張ではなく主張成立の条件」と明言 | Q-0029 | **完了**(F-0051 → dictv2 で F-0059)。GRP 成長では両者 null(F-0044、著者判断でスコープ外)。**技術参入予測で corporate が優位**(ipc3 同時投入 p=0.0064)。順10 で本文に反映 |
| R2-3 / R1-9 | 閾値 1%/5%/10% での TCI ランキングと Fig.2 の一貫性比較、RTAのみ / RTA+degree-1除去 / top-3% の3構成の比較、および地域側 TCI が同一のフィルタ済みデータから計算されているかの事実確認 | Q-0030 | **完了**(F-0047 / F-0048 → dictv2 で F-0058)。ランキングは頑健(&#124;rho&#124;≥0.90)だが gamma は非単調で p=1 では符号反転。degree-1 除去の方が top-3% より強い一貫性。順13 で反映 |
| R1-6 | Fig.S2 の再設計。主案は全124系列をグレー低不透明度に落とし、本文で解釈する4クラス(C13, A21, A23, A01)のみ彩色・太線・端点ラベル | Q-0031 | **完了**(F-0050)。強調版バンプチャートを生成済み。原稿側は図の差し替えのみ |
| R1-m2 | Fig.1 の軸ラベル表記を統一した EPS の再生成。併せて Panel D の "The Average **Diverstity**" の綴りミスを修正 | Q-0032 | **完了**。dictv2 版の Fig1.eps に差し替え済み(綴りミスも解消) |
| R1-2 | Fitness-Complexity アルゴリズムでの再計算と TCI との比較(任意) | Q-0033 | **完了**(F-0046)。TCI と FC complexity は負相関(schmoch35 企業側 Spearman −0.638、dictv2 で −0.643)。**FC は本論文のスコープ外という著者判断**のため本文では扱わず、Discussion の「順序が一致する保証はない」という記述で足りる |
| R1-3 | Fig.1B の assortativity / 象限集中の統計的検定(任意) | Q-0034 | **完了**(F-0045)。66%集中・phi=0.30・$\chi^2$=3.150・p=0.076。順8 で本文に反映済み |
| R1-5 | 対角乖離の有意性基準の設定、地域生産構造との外部照合 | Q-0035 | **完了**(F-0049 → dictv2 で F-0059)。プラセボ帰無分布が定量的基準に相当し、**どのペアも有意でない**。順10 で主張を撤収 |
| (自主) | 府県別 TCI 比較(Fig.3)の企業数交絡。東京/大阪を愛知水準にサブサンプルして乖離パターンが再現するか、および乖離の帰無分布の構成 | Q-0036 | **完了**(F-0049 / F-0059)。東京-大阪の高い類似性は企業数を揃えると再現しない(大標本の産物)。愛知は固有ベクトルが退化(F-0052、飽和 95.0%) |
| R1-8 | 名寄せ・統廃合の実処理の確認、書き換え件数、退出企業の扱い | Q-0037 | **完了**(F-0043 / F-0054)。順12 で Methods に反映済み |
| **R2-3(第3点)** | **Fig.2 の地域側入力 `ipc3_schmoch_addr.csv` の生成コードが不在で、ディスク上のどのデータとも一致しない** | Q-0038 | **完了**(F-0040)。like-for-like で再生成しても結論は不変(gamma 0.592 vs 原稿 0.60) |
| (再現性) | 原稿の図6点・本文数値を現行パイプラインから再生成する経路が無い問題。図・数値ごとの生成スクリプト対応表と再生成スクリプトの整備 | Q-0039 | **完了**(F-0041 / F-0053)。`src/paper/ki01.py` に一元化。原稿記載値の不一致は F-0018 が母数ファイルを取り違えていたためで、**原稿の値が正しかった** |
| (データ版統一) | 社名辞書とデータの非同期(F-0055)。現行辞書で 01-03 を再構築した dictv2 版の整備と全結果の再計算 | Q-0040 / Q-0041 | **完了**(F-0056 / F-0057 / F-0058 / F-0059 / F-0060)。**dictv2 を原稿の正本データ版として採用**(著者決定)。図6点は差し替え済み |
| (数値確定) | 原稿引用の相関2件の dictv2 値 | Q-0042 | **完了**(F-0063)。ubiquity×average diversity **0.069**、Electrical の ubiquity×TCI **0.644**。原稿に反映済み |
| R2-2(前提) | 技術参入ロジットに relatedness density を統制として追加し、corporate TCI が残るかの確認(新 Fig.3 の前提) | Q-0043 | **完了**(F-0061 / F-0062)。density を統制しても ipc3 同時投入で corporate p=0.0104 が残り、**判断基準を満たした**。新 Fig.3 は2パネル版を採用(Panel C は AUC 増分 +0.0015 のため落とす) |
| (順9 の前提) | **Fig.2 に Panel C(gamma vs アクターノード数 N)を追加**。順9 で本文が参照する図。F-0058 のサブサンプル結果を図示する | Q-0044 | **起票済み・待ち**。本文が Panel C を参照しているため、3パネル版 `Fig2.eps` が届くまで順9 をコミットできない |
| (数値の突合) | 成長タスクの「density なし・同時投入」行と Panel B の schmoch35 4行を `results.md` の表に追加してほしい(現在は Fig.3 の図中注記にしか無い) | Q-0045 | **起票済み・待ち**。届いたら本文に数値を入れるかを判断する |
| (順13 の確認) | Table S2 の presence 次数統計が ipc3 / schmoch35 のどちらか、および3構成それぞれで地域側 TCI の入力特許集合がフィルタ前後どちらかの明示 | Q-0046 | **起票済み・待ち**。キャプションを分類非特定の書き方にしてあるので、回答後に限定する |

## 対応中に発見した既存の誤り(査読者の指摘外)

査読対応の作業中に見つかった、投稿版に元から存在する誤り。査読者は指摘していないが、修正しないと本文が成立しないもの。**著者確認が必要**。

| 発見箇所 | 内容 | 対応 |
|---------|------|------|
| Results 2.1節(旧189行) | ubiquity と TCI の正の相関($r=0.594$)に対し、本文が「より少数の企業に関連する技術が複雑な能力を要する」= 負の相関の解釈を書いていた。R1-2 が指摘した読者の混乱の直接の発生源 | 順3 で修正。正相関の解釈に書き換え(数値は変更なし) |
| Results 2.1節(旧184行) | Electrical Engineering の $r=0.738$(ubiquity–TCI 正相関)から「広く適用可能な技術に特化する企業とニッチに集中する企業の共存」という結論を導いていたが、この統計量からは導けない | 順3 で全体傾向との整合を述べる中立的記述に置換 |
| Results 2.1節(旧186行) | Panel 参照ミス。「low TCI and low average diversity (Panel B)」だが、TCI × average diversity の平面は Panel **D**(Panel B は ubiquity × average diversity)。`Figs/Fig1.eps` を目視確認して確定 | 順3 で Panel D に修正 |
| `Figs/Fig1.eps`(Panel D の y軸ラベル) | "The Average **Diverstity**" と綴りミス。図の再生成が必要なため原稿側では対応不可 | R1-m2(区分B)の図修正時に併せて修正するよう分析側へ依頼(Q-0032)。dictv2 版への差し替えで解消済み |
| SI 図3点のキャプション(464-486行) | dictv2 版の図に差し替えた結果、**キャプションが図の内容と一致しなくなった**。(a) Fig.S1: 実際は12パネルで Schmoch 5セクター+全体に層別され、各パネルに Pearson $r$ と $n$ が注記されているが、キャプションは "In both figures" と2枚構成を前提に書かれている。(b) Fig.S2: 実際は強調版(4クラスのみ彩色・他120系列はグレー)だが、キャプションは "color-coded according to the one-digit IPC classes" と旧版の意匠を説明している。(c) Fig.S3: 実際は Panel A = 企業の多様性 $K_{C,0}$ の CCDF、Panel B = 保持企業内の累積特許シェア(全期間+3期間)だが、キャプションは "black dashed lines ... indicate the excluded region" という**存在しない要素**を説明している | **対応済み**(順9〜15 とは独立の1コミット)。3点すべて実物の図を目視して書き直し、`\bmhead{Supplementary information}` の3行要約も整合させた。図中に "93%" は焼き込まれていないことを確認済み(R2-m2 の要事後確認は解消)。**派生して判明した問題**: 新 Fig.S3 はフィルタ**後**の集合の記述しか含まず、旧版が担っていた「上位3%が全特許の91%」を示す分布と除外領域の図示が失われている。Methods 389行の `(Fig.~\ref{fig:patentdistribution})` という参照はもはや図に裏づけられていない。R1-9(3%が恣意的)の回答に直接関わるので順13 で扱う |

## 査読コメント自体の誤り(response letter で扱いを要検討)

| 出典 | 内容 | 対応方針 |
|------|------|---------|
| Reviewer 1 #3 | Fig.1B に「high-high と low-low の象限への集中、mixed cases が少ない」と述べているが、Fig1.eps を目視確認すると4象限すべてに点があり、off-diagonal(高ubiquity・低diversity の Semiconductors / Handling、低ubiquity・高diversity の Micro-structural and nano-technology)にも明確に点がある。実在するのは**セクター別のクラスタリング**であって対角集中ではない | 順8 で対応。査読者の核心(大域相関だけでは構造を捉えられない)は受け入れて明記し、パターンの記述は図に即した内容にした。**letter では査読者の見立てを否定せず、「非ランダム構造というご指摘の趣旨には同意し、実際に見えるパターンを記述した」と回答する**。査読者の解釈(non-random assortative structure)とは両立する |
| Reviewer 1 #1(参考文献[3]) | 書誌情報が誤り。arXiv:2210.01001 は実際には [1] の Straccamore 論文であり、著者リストにも実在しない共著者(Cimini, Patelli, Gabbi)が含まれる。実物は Pugliese, Napolitano, Zaccaria, Pietronero, PLoS One 14(10):e0223403 (2019) | 順2 で正しい書誌の出版版を引用。letter では触れない(指摘の趣旨には対応済み) |

## 指導教員フィードバック

`doc/Feedbacks/professor.md` を受領(2026-09-08)。response letter 自体の書き方の問題(自己評価的表現・修正箇所の不明示)と、個別の内容不整合5件からなる。区分はいずれも letter.md および必要に応じて本文の書きぶり修正で対応可能(A)。

| ID | 出典 | 論点 | 優先度 | 区分 | 対応方針 | ステータス |
|----|------|------|--------|------|----------|-----------|
| P-1 | 指導教員 #1 | letter の自己評価的表現(「we report this honestly」等)が押しつけがましい | High | A(letterのみ) | letter.md の該当箇所から自己評価的な言い回しを削除し、不利な結果を淡々と記述する文に置き換える。第2ラウンドの監査(2026-09-10、Fable)で「We report this plainly...」(R2M1)と「We disclose this non-monotonicity...」(R2M3)の2件が適用漏れで残存していたのを発見し、設計済みの置換文を適用して完了 | 対応済み(第2ラウンドで漏れ2件を解消) |
| P-2 | 指導教員 #1 | letter の多くの回答に、原稿のどこを直したかの明示がない | High | A(letterのみ) | letter.md の Major/Minor 各回答に、改訂稿の該当セクション名・ラベルを明示する一文を追加する | 対応済み |
| P-3 | 指導教員 #2(R1 Major 2) | Fitness–Complexity比較(相関−0.64)がletterにしかなく、SIに掲載されていない | High | A | SIに Table S3(FC比較、Schmochレベル、Spearman −0.643)を追加し、Discussion末尾を「本論文の目的は企業/地域という分析単位の比較であり、指標間の優劣評価はスコープ外」と明記する形に改稿。letter も対応させた | 対応済み |
| P-4 | 指導教員 #2(R2 Major 1) | 地域を細分化しなかった理由と、複数県住所企業6.46%がletterにしかない | High | A | Methods 4.1(Data)に prefecture属性が登記住所に基づくこと・6.46%が複数県に登記される事情を追記。Discussion の限界段落に、細分化しなかった理由(ノイズの増幅)を追記。letter も対応させた | 対応済み |
| P-5 | 指導教員 #3(R2 Major 3) | 条件を揃えた再計算のγ=0.592が本文・表になく、0.585との違いが不明 | High | A | **誤りを発見・修正した上で最終確定**: 0.592(Q-0038/F-0040)は dictv2 移行**前**のデータ版での like-for-like 検証値で、比較対象も当時の主仕様 0.60(現行の 0.585 ではない)。分析リポジトリに Q-0048 として再検証を依頼した結果、**F-0068 でより強い結論が判明**: dictv2 版では main仕様の Fig.2 計算(`ki01.class_comparison_table`)と like-for-like 検証が同一コードパス・同一入力ファイルに統合されており、**現行の 0.585 自体がすでに like-for-like な値**(別途の確認用数値は不要)。本文 Section 2.2 に「regional TCI は corporate 側と同一のフィルタ済み特許集合から計算されており、構造的に like-for-like である」旨を追記し、letter もこの結論に更新した。0.592 という数値そのものは旧データ版の superseded な値として言及しない | 対応済み(Q-0048/F-0068で確定) |
| P-6 | 指導教員 #4 | 本文のp=0.223(Schmoch35, density統制なしの同時投入)とFig.3のp=0.266(Schmoch35, density統制ありの同時投入)の対応関係が本文から読み取れない。AUCもMethods 4.4で「Section 2.3に報告する」としながら本文に数値がない | High | A | Section 2.3(line 294付近)に、Fig.3のdensity統制ありのSchmoch35 p値(0.266)とbaseline(0.223)の違いを1文で追記。AUCは第2ラウンド(2026-09-10)で**教授の第1選択肢(数値を示す)を採用**(著者承認済み。順13の「AUCは書かない」判断を一部変更): Section 2.3 に in-sample AUC 0.7974(統制のみ)→0.7975(+regional)→0.7989(+corporate)を掲載(正本は `experiments/12_validation_long/docs/results.md` 229-240行)。Methods 4.4 は元の簡潔な文(summarized by the AUC and reported in Section 2.3)に戻し、記述と実体が一致。letter も対応させた | 対応済み |
| P-m1 | 指導教員 #5(Minor系) | letterの場所明示の誤り・不足。「firm-level ranking transitions」の文をDiscussionから削除したという記載が、実際はDiscussion(line 330付近)に類似文言が残存し矛盾。文献番号[4][5][14][31]が確定していない | Low | A | letter.md の該当箇所(R1 Minor 1, R1 Minor 3/R2 Minor 3, R2 Minor 1, R2 Minor 4, R1 Major 6, R1 Major 8, R1 Major 9, R2 Major 4)に正確な節・行を明記した。文献番号は build 後の `.bbl` で確定(`gault2023handbook`=[4], `jaffe2019patent`=[5], `diodato2024handbook`=[14], `Bhatia2018`=[31]。`Bhatia2018`は事前推定の[32]ではなく[31]だった)。letter.md を確定番号に修正済み | 対応済み |

対応順は上表の優先度に従い、P-1〜P-2(letter全体の書き方)→P-3〜P-6(個別内容)→P-m1(場所明示の訂正)の順で進めた。`bash scripts/build.sh` は exit=0、LaTeXエラーなし、未定義引用・未定義参照なし、不備文献エントリなし、Overfull 0件(`overfull`チェックOK)を確認済み(2026-09-09)。文献番号は `.bbl` 生成後に実測して確定済み。第2ラウンドの監査(2026-09-10、Fable)で全5項目の反映状況を professor.md と突き合わせて確認し、残っていたギャップ(P-1 の適用漏れ2件、AUC数値の掲載、letter R2M3 の査読者に文脈のない1文)をすべて解消した。

**第3ラウンドの実物検証(2026-09-10、Fable)**: ビルド済みPDF(lineno行番号つき)を取得し、letter.md の全22回答(R1 Major 1-9 / Minor 1-5、R2 Major 1-4 / Minor 1-4)の場所指示を、PDFの該当箇所の実文と1件ずつ突き合わせた。結果、場所指示・引用数値(係数・p値・γ・AUC・文献番号[4][5][14][31]・図キャプション)はすべてPDFの実物と一致。ただし R1 Major 2 の回答に不正確な記述を2件発見し修正した: (1)「Section 2.1 now opens with an explicit interpretation paragraph」→ 実際は第2段落のため「The second paragraph of the revised Section 2.1」に訂正、(2) FC比較の −0.643 に「computed at the Schmoch level of 35 classes」を追記(Table S3 の記載と精度を揃えた)。

**第4ラウンドの過大表現パス(2026-09-10、Fable)**: professor.md の全項目反映を最終確認したうえで、言いすぎ・過大表現を6件修正した。最重要は**「chiefly reflecting formal headquarters relocations at multi-site firms」(letter R2M1 と本文4.1の両方)**で、分析側 F-0067 は「本社移転か記載揺れかは判別不能」と明言しており、「主に本社移転を反映」はデータが支持しない断定だったため、「chiefly at multi-site firms, and the records do not distinguish formal headquarters relocations from variation in the recorded address」に修正。他は (a) letter冒頭「this revision goes beyond rewording」削除(対応姿勢の自己評価)、(b) R1M1末尾「We believe this framing is both more accurate and more modest」削除、(c) R2M4「and, we believe, better supported」削除(結びの1回のみ残す)、(d) R2M2「as promised in」→「consistent with」、(e) 本文2.2「rather than by a separate post hoc check」削除(letter文脈の本文への漏出)、(f) 本文Discussion「addresses that change for 6.46%」→「addresses that are recorded under more than one prefecture for 6.46%」(4.1の記述と精度を統一)。build は exit=0・Overfull 0件を維持。

**第5ラウンドの style-guide 準拠パス(2026-09-11、Fable)**: `doc/style-guide/general.md` の規則(短縮形・ダッシュ・コロン・セミコロン禁止、過剰な分詞構文回避、"Overall"系回避、TOEIC 700-800語彙、既存トーン一致)に照らして本文と letter を機械的に精査した。短縮形・ダッシュ・"Overall" は0件。修正した違反: 本文の**セミコロン2件**(2.1節の括弧内「Fig.~1; Pearson...」→カンマ、Declarations「downloadable; data older...」→2文に分割)と**コロン1件**(SI要約「Appendix A: Table S1...」→ピリオド)。今回追加文の語彙・整合も調整: 「gives a corporate p=0.266」→「yields p=0.266 for the corporate measure」(既存の yields に統一)、AUC文の「in-sample」重複を解消、「not free of noise」→「subject to noise」、「chiefly」→「mainly」(既存本文の語彙に統一、letter も同様)、Table S3 キャプションの「corporate--technology」→「corporation--technology」(既存表記に統一)とカンマ羅列の同格構文を関係節に書き換え、表中「TCI vs.」→「TCI versus」(Fig.1キャプションの表記に統一)。letter のセミコロン3件(R2 Minor 3 の2件・R2 Minor 4 の1件)も文分割で解消。build は exit=0・Overfull 0件を維持。

**教授レポート成果物(2026-09-14、`doc/advisor-report/`)**: (1) `diff.pdf` = v20260823(前回教授レビュー版)→現在の latexdiff。ベースラインは今回の全tex編集10箇所を逆適用して復元し、単体コンパイルが27ページで v20260823 と一致することを検証済み。差分マークアップ60箇所はすべて意図した変更のみ。旧 diff.pdf は `diff_v20260823.pdf` に退避。(2) `(KI01...)_v20260914.pdf` = 現行本文(28ページ、build合格)。(3) `response_letter_v20260914.docx` = 旧 `doc/response-letter/response-letter.docx` の正式レター形式(日付・宛先・カバーレター・全文引用・Before/After抜粋)を踏襲し、回答本文を現行 letter.md に差し替えたもの。**旧docxに存在しない文をセンテンス単位で赤字**にしてある(生成スクリプトは scratchpad の make_letter_docx.py)。旧docxのカバーレターにあった「this revision goes well beyond rewording」(自己評価)と R2 General 回答の「including the ones that are unfavorable...」(透明性の自賛)も本体と同基準で削除した。冒頭の内部ノートは著者指示で削除済み(2026-09-14)。

**企業数 1,939→1,936 の開示を追加(2026-09-14)**: 著者から「1,936社は記憶より少ない」との確認があり、分析側の正本(F-0056)と突合した。投稿版=旧辞書で 1,939社/2,900,359件、改訂版=dictv2(現行NISTEP辞書で01-03を再構築、著者決定の正本)で **1,936社/2,904,188件** であり、1,936 が正しい。査読者自身がコメントで 1,939 を引用しているため、**letter に辞書更新の開示を追加**した(R1 Major 8 に詳細、R2 Major 1 に短い参照)。著者の意向(2026-09-14)により、表現は「非同期の解消(過失の訂正)」ではなく**「より新しい辞書リリースへのアップデート」という前向きな書き方**に確定: 「we updated the name harmonization to the current release of the dictionary, which maps some assignees further along their succession chains, for example corporations renamed in holding-company transitions」。1,939→1,936・γ 0.60→0.585 の由来と結論不変の検証も明記。なお実態は**グループ会社の親子連結ではなく**、持株会社化・合併に伴う同一法人格チェーン(前身→後継)の追跡の最新化であり、「parent and subsidiary corporations are not consolidated」の設計は不変(F-0055/F-0056)。letter.md と docx の両方に反映済み。

**トーンの前向き化パス(2026-09-14、著者指示)**: 実質的な不利益開示(ノード数効果の確認・旧Fig.3の撤収・解釈誤りの訂正・γや企業数の変化)は正直なまま維持しつつ、不必要に過失調・自己卑下調の言い回し4件を前向きな事実記述に変更した。(1) md冒頭「identified genuine weaknesses in the submitted manuscript」→「Our own follow-up analyses confirmed several of the reviewers' central points」、(2) R1M9「the submitted caption described graphical elements that the figure did not contain」→「so that it accurately describes the regenerated figure」、(3) R2M1「Because this finding removes the original basis for the paper's central claim」→「In view of this finding」(「rests its case on that test alone」の実質は維持)、(4) docxのR2 General「central weakness of the submitted manuscript」→「central issue」。辞書更新の開示(前項)と合わせ、letter.md・docx両方に反映し、旧表現はgrepで0件を確認。

**letter.md のフルレター形式への移行(2026-09-14、著者指示「mdとdocxの内容に差異がないように」)**: letter.md を docx と同一内容のフルレター形式(日付・宛先・カバーレター・査読コメント全文引用・point-by-point・Before/After抜粋)に移行した。旧mdの圧縮版Comment要約とDRAFT NOTEは廃止(DRAFT NOTEの2項目=行番号の凍結後付与・letter限定図の要否は本節の残作業として引き続き追跡)。以後の生成経路は `doc/response-letter/md_to_docx.py`(letter.md → docx、前回版docxをベースラインに赤字diff、本文一致をassert検証)。移行時のparity検証OK(171段落・赤字run54、移行前後で内容不変)。CLAUDE.md のファイル役割にも追記済み。

**数値の版混在チェック(2026-09-14、Fable)**: 「letterの0.592と同型の混在が論文本文にもないか」という著者の問いを受け、本文の全数値を分析側の正本(findings.csv / 各results.md)と突合した。結果: 相関4件・象限検定・27/17分類・U/γ・サブサンプル系・参入/成長/AUC系・FC比較・企業数/保持率/退出率/名寄せ件数・府県間乖離統計・Fig.S3(F-0060でdictv2再生成済み)はすべてdictv2と一致。**唯一の疑いは3府県の企業数「東京1,077・大阪367・愛知201」(2.3節とMethods 4.4の2箇所)**で、東京・大阪はpaper版(F-0021: 1,077/367/212)、愛知だけdictv2(F-0057: 1,068/362/201)と一致する混在に見える。**Q-0049は解決(F-0069)**: 分析側が所在ベースの定義でpaper版・dictv2版の両方を再計算し、原稿記載値が「東京・大阪=paper版、愛知=dictv2」の混在であることを確定した(dictv2の正: **東京1,068・大阪362・愛知201**。愛知201とダウンサンプルの201は正しい)。2026-09-15に本文2箇所(2.3節・Methods 4.4)を1,068/362に修正し、build合格(exit=0・Overfull 0件・28ページ維持=letterのページ・行番号は有効)。成果物一式を**v20260915**として再生成(本文PDF・diff.pdf(マークアップ62箇所)・response_letter_v20260915.docx(parity OK))し、旧v20260914版は削除。メール下書きも email-2026-09-15.md に更新。

### 追加フィードバック第2弾(professor_2.md、2026-09-16受領)

前回指摘は「おおむね反映されている」との評価。修正指示は3点。

| ID | 論点 | 区分 | 対応方針 | ステータス |
|----|------|------|----------|-----------|
| P2-1 | R1 Minor 1回答の誤記: Before/Afterで残っているのは「二つ目の定義」なのに「The second version has been removed」と書いていた | A(letterのみ) | 教授指定の表現「The duplicated definition of TCI has been removed」に修正 | **対応済み**(2026-09-16。letter.md+docx再生成、parity OK) |
| P2-2 | Table S3が相関係数のみで、35分類のTCI順位とFC順位の併記がない | **B** | 分析側に **Q-0050** を起票(dictv2・企業側・schmoch35の35分類についてTCI rank/FC rankの対応表をresults.mdに正本として追記依頼)。届いたらTable S3を35行表に拡張する。**本文の修正は不要**(教授明言)。表が長くなるためSI以降のページがずれる見込みで、letterのSI系ページ参照(Table S1/S2/S3・references・Fig.S2/S3)と全ページ・行番号の再検証が必要 | **対応済み**(2026-09-16。Q-0050解決=F-0070、`experiments/12_validation_long/docs/results.md` の35行対応表を正本としてTable S3を35行表(Schmoch class / TCI rank / FC rank / TCI / FC、rank 1=最複雑)に拡張。SI導入文も「compares the TCI and Fitness Complexity rankings of the 35 Schmoch classes」に更新。build合格・29ページ化) |
| P2-3 | R2 Major 1回答の「as the reviewer's comment allowed for either approach」は査読者の意図の誤読(2つの検証を挙げただけで、どちらか一方でよいとは言っていない) | A(letterのみ) | 当該句を削除。「企業数を揃えた検証を実施+細分化しなかった理由」という既存の構成はそのまま | **対応済み**(2026-09-16。letter.md+docx再生成、parity OK) |

注意: 2026-09-15の成果物フォルダは**送付済み記録として凍結**。P2対応後の成果物は新しい日付フォルダ(2026-09-16以降)に生成する。regen_docx.sh の出力先は一時ファイルに変更済み(旧v20260914パスへの誤出力を1度起こしたため)。

**Table S3拡張後のページ・行番号再検証(2026-09-16、Fable)**: v20260916ビルド(29ページ)を全ページ読み、letterの全所在指示を再照合した。本文(p.1-17)の行番号はすべて不変(Table S3はAppendix内のため本文組版に影響なし)。Table S1/S2(page 19)・Table S3(page 20)・文献[4][5][14][31]の「pages 19-22」も新レイアウトでそのまま有効。ずれたのは図のみで、letterの5箇所を更新した: Fig.2 Panel D「page 24」→**25**(R1M4・R2M1の2箇所)、Fig.S2「page 27」→**28**(R1M6)、Fig.S3「page 28」→**29**(R1M9・R2 Minor 2の2箇所)。あわせてR1M2の回答に「which lists the TCI and Fitness-Complexity ranks of all 35 Schmoch classes side by side」を追記し、拡張後のTable S3の内容と一致させた。

**成果物 2026-09-16(`doc/advisor-report/2026-09-16/`)**: 著者指示により**フォーム提出セット**と**教授確認セット**の2階層で生成。(1) `submission-set/` = ジャーナルのフォーム提出用3点: `point-by-point-response_v20260916.docx`(赤字なしクリーン版。md_to_docx.py に `--no-red` オプションを追加して生成、parity OK)、`revised-manuscript-track-changes_v20260916.pdf`(latexdiff、baseline=`submitted`タグ、マークアップ284箇所、latexmk exit=0)、`(KI01...)_v20260916.pdf`(クリーン最終稿29ページ、build合格・Overfull 0件)。(2) `for-advisor/` = 同じ3点のうちクリーンdocxを**赤字diff版** `response_letter_v20260916_diff-red.docx`(ベースライン=2026-08-22版docx、赤字run 58、parity OK)に替えたもの+track-changes PDF+クリーンPDF。

**P系の残作業**:
1. ~~letter へのページ・行番号の付与~~ **完了(2026-09-14)**。著者指示(「確定版を教授に見てもらう」)により、v20260914 ビルドのPDF(lineno番号)から全28箇所の修正所在にページ・行番号を実測して付与した(例: R1M2 解釈段落 = page 4, lines 158-173、R2M2 AUC = page 10, lines 417-422)。**注意: 行番号は v20260914 の本文に紐づくため、以後本文を変更した場合は最終ビルドで行番号を検証・更新してから提出する**
2. letter限定図(旧Fig.3+プラセボ比較)を添付するかの著者判断(任意)

著者レビュー後、1コミット=1論点の方針で本文・letter・plan.mdの変更をコミットする。

### 投稿ポータル区分への対応と投稿規定チェック(2026-09-17、Opus)

著者から、ジャーナル投稿システムの提出区分(必須: Point-by-point response = PDFのみ / Manuscript file = 編集可能形式(Word or LaTeX zip)、任意推奨: Related files = tracked changes版)を提示され、成果物をこの区分に合わせて出力するよう依頼された。あわせて `doc/style-guide/submission_guidline.md`(EPJ DS投稿規定要約)との整合確認を依頼された。

**投稿規定との突合結果**:
- ダブルスペース・行番号・ページ番号: `submitted` タグの `\documentclass` オプションと現行が同一(`[lineno,pdflatex,sn-mathphys-num]`、`referee`(倍行間)オプションは未使用)。倍行間なしのまま初回査読を通過し major revision まで進んでいる実績があるため、**現状維持で問題なし**と判断(変更しない)
- List of Abbreviations: `submitted` にも現行にも節がない。既存実績どおり**現状維持**(必須項目だが本誌はLaTeXテンプレート運用でこの節を省略しても初回査読を通過している)
- 表(Tables)の数値カンマ区切り禁止: **違反を発見・修正**。Table S1(`tab:threshold`)・Table S2(`tab:pruning`)の本体データと Table S3(`tab:fitness`)のキャプション文中で `1,936` / `3,232` / `6,463` / `64,457` / `27,201` のようにカンマ区切りが使われていた(本文中の同じ数値はカンマ区切りのままでよく、表内のみが対象)。8箇所をカンマなし表記に修正。**査読者対応ではなく投稿規定準拠の機械的修正**のため、A作業の各論点コミットとは別枠として扱う
- 図・表のタイトル15語以内/凡例300語以内、強制改ページ不使用、複合図の単一ファイル化: 目視確認のうえ**すべて準拠**(修正不要)
- Manuscript file の形式: LaTeXソース一式(`sn-article.tex` / `sn-bibliography.bib` / `sn-jnl.cls` / `sn-mathphys-num.bst` / `Figs/*.eps`)をzip化し、隔離した一時ディレクトリに展開して単体で `latexmk` が exit=0・29ページで通ることを確認済み(投稿システム側のコンパイルに耐える編集可能形式)

**Point-by-point response のレイアウト修正**: 教授指摘の「1行だけ次のページに入る」ウィドウ/オーファン症状に対応。`doc/response-letter/md_to_docx.py` の段落生成に `<w:widowControl/>` を全段落へ付与し、見出し相当の太字段落には `<w:keepNext/>` を追加(次段落と分離してページ末に孤立しないように)。**文言は一切変更していない**(parity検証は従来どおり通過、171段落・赤字0)。

**成果物 2026-09-17(`doc/advisor-report/2026-09-17/`)**: 投稿ポータルの区分に合わせて再構成。
- `submission-set/`(必須2点): `point-by-point-response_v20260917.pdf`(レイアウト修正後、Word経由でdocx→PDF変換)+ 参考として同docx、`manuscript-source_v20260917.zip`(編集可能形式としてのManuscript file本体)、`(KI01...)_v20260917.pdf`(クリーン最終稿、参考添付)
- `related-files/`(任意推奨): `revised-manuscript-track-changes_v20260917.pdf`(latexdiff、baseline=`submitted`、マークアップ284箇所、exit=0)。Manuscript fileとは別枠・非公開の位置づけで格納

**Figures and tables / Supplementary material の扱い**: 分けて提出する必要はないと判断。Figures and tablesの個別ファイルは教授指示どおり今回不要(採択後対応)。Supplementary material(公開される付録)については、SI(Table S1-S3・Fig.S1-S3)はすでに `sn-article.tex` 内の Appendix として本文と同一のPDF/LaTeXソースに埋め込まれており、`submitted` 版から一貫してこの構成で初回査読を通過している。追加ファイルとして切り出す(投稿規定 5.6 の「ファイル名/形式/タイトル/説明を本文の専用節に記載し本文中で明示的に参照する」という別建ての運用)に切り替えると構成変更のコストが生じる一方、現状の埋め込み方式でも規定上問題はないため、**現状の埋め込み構成を維持し、別ファイルには分割しない**。

`bash scripts/build.sh` は exit=0・Overfull 0件・29ページを維持。zip内のtexは隔離環境での単体コンパイルで検証済み。すべて作業ツリー上の変更で未コミット(CLAUDE.mdの方針どおり、response letter確定後に1コミット=1論点で分割する対象に含める)。

**Point-by-point response のページ分割の追加修正(2026-09-17)**: 著者から「見出しの書き方が悪くてページが分かれているのでは」と指摘を受け、原因を特定した。`md_to_docx.py` の最初の修正(太字見出し段落への `keepNext`)は "Major comment N." 等の太字ラベルはカバーしていたが、**"Response:" / "Before revision:" / "After revision:" は太字ではないため対象外だった**。これらは1〜2語だけの短い独立段落で、直後の本文と分離してページ末に孤立しやすい。修正: 段落生成時に語数4語以下の段落を「短いラベル」と判定し、太字段落と同様に `keepNext` と前後スペーシングを付与するよう一般化した(`is_label` 判定を追加)。文言・parity検証ロジックは変更なし(171段落・赤字0で再検証済み)。`point-by-point-response_v20260917.docx`/`.pdf` を再生成して差し替え済み。見出しの視覚的な書式自体(太字ラベルと査読者引用文が同じ太字スタイルで並ぶ点)は、査読対応レターとして一般的な慣習であり、内容の伝わりやすさを損なわないため変更していない。

**レイアウトの再設計(2026-09-17、著者指示の見本に合わせる)**: 著者から具体例(「Major comment」見出し+「2. <コメント文>」+「Response: <回答文>」を1段落で)を提示され、`letter.md` の構造をこれに合わせて変更した。`**Major comment N.**` + `**<コメント文>**` の2段落を `**Major comment**` + `**N. <コメント文>**` に、`Response:` 単独段落+回答文段落を `Response: <回答文>` の1段落に、使い捨てスクリプトで機械的に変換した。**文言は一切変更していない**(段落を跨いだテキストの連結結果が変換前後で同一になる設計で、md_to_docx.py の parity 検証(md/docx本文一致)で確認済み。171段落→147段落、赤字0)。あわせて `md_to_docx.py` に「Reviewer N:」見出しの直前にのみ通常見出しの3倍の前スペースを入れる分岐を追加し、査読者が切り替わる箇所を視覚的に区切った。`point-by-point-response_v20260917.docx`/`.pdf` を新レイアウトで再生成し目視確認済み(15ページ)。letter.md のこの構造変更は今後の response letter 生成(docx化)にも恒久的に反映される。

**カバーレターの添付ファイル案内を投稿区分と不一致だった点を修正(2026-09-17)**: letter.md 冒頭のカバーレターが列挙する添付ファイル案内が、投稿ポータルの実際の区分と食い違っていた。旧文言は「2) A Revised Manuscript with track changes / 3) A Clean copy of the revised manuscript」で、track changes 版を2番目、クリーン版を3番目に置いていたが、投稿要件では**必須**が Point-by-point response(PDF)と Manuscript file(編集可能形式)の2点、**任意推奨**が Related files としての track changes 版であり、優先順位が逆だった。加えて Manuscript file を「クリーン版」とだけ書いており、実際に提出する形式(LaTeXソース一式のzip、先方でコンパイル)への言及がなかった。修正後は「2) The Manuscript file, submitted as a LaTeX source archive with all figures included, for compilation by the production system」「3) A Related file: the revised manuscript with tracked changes」に改めた。文言以外(page/line番号等)への影響なし。`point-by-point-response_v20260917.docx`/`.pdf` を再生成して差し替え済み。実際にポータルへアップロードする対応関係は、Point-by-point response → `point-by-point-response_v20260917.pdf`、Manuscript file → `manuscript-source_v20260917.zip`、Related files(任意) → `revised-manuscript-track-changes_v20260917.pdf`。`submission-set/` に同梱しているクリーンな本文PDFは投稿必須区分には対応しない参考用の副産物(zip単体で十分要件を満たす)。

**Corresponding author の不一致を発見・修正(2026-09-17)**: 著者から「corresponding authorは私ではないのか」との指摘を受けて `sn-article.tex` を確認したところ、titlepage 上は `\author*[1,2]{Hiroyasu Inoue}` + `\email{inoue@gsis.u-hyogo.ac.jp}` で**井上先生が corresponding author** として記載されており、一方カバーレターは Rintaro Karashima の署名・個人連絡先で結ばれていて矛盾していた。著者に確認したところ「あなたが正、原稿側を修正」との回答だったため、`sn-article.tex` の著者ブロックを修正: `\author*[1]{Rintaro Karashima}` + `\email{rintaro.karashima@gmail.com}`(letter.md の署名と同じアドレス)、`\author[1,2]{Hiroyasu Inoue}`(emailなし)に変更。affiliation index([1]=University of Hyogo)は両著者に共通のため `\affil*[1]` 側の変更は不要。build は exit=0・Overfull 0件・29ページを維持し、titlepage を目視確認して "*Corresponding author(s). E-mail(s): rintaro.karashima@gmail.com" の表示を確認済み。Authors' contributions の記述(H.I.が研究設計・資金確保、R.K.が分析・執筆)は役割分担の実態であり corresponding author の指定とは独立のため変更していない。本文修正に伴い `manuscript-source_v20260917.zip`・クリーンPDF・`revised-manuscript-track-changes_v20260917.pdf`(マークアップ292箇所、exit=0)を再生成済み。

**Keywords の "out-of-sample validation" を "bipartite networks" に戻す(2026-09-17)**: 順15(Abstract改稿)で `bipartite networks` → `out-of-sample validation` に差し替えていたが、著者からこの選択の適否を問われ、他5語(Technological Complexity Index / Japanese patents / corporate level analysis / method of reflections / economic complexity)が概念・トピック語であるのに対し、"out-of-sample validation" は分野を問わず使われる手続き記述語であり検索での特異性が低いと指摘した。著者は `bipartite networks` への復帰を選択。`sn-article.tex` の `\keywords{}` を修正し、6語構成は維持。build は exit=0・Overfull 0件・29ページを維持。`manuscript-source_v20260917.zip`・クリーンPDF・`revised-manuscript-track-changes_v20260917.pdf`(マークアップ292箇所)を再生成済み。

**Point-by-point response の1ページ目の改ページ位置を調整(2026-09-17)**: 著者から「1ページ目が rintaro.karashima@gmail.com で終わるようにしたい」との指示。

最初の対応(見出しの前スペース削除+ページ余白1440→1080twips)は、社内ツールの Read によるPDF目視確認では「1ページ目がemailで終わる」ように見えたが、著者が実際のPDFで確認したところ終わっていないとの指摘があった。WSLの`pdftotext`(poppler、実ビューアと同じレンダリング系列)で再検証したところ、目視確認は誤りで、実際は1ページ目が "POINT-BY-POINT RESPONSE..." 見出し・"Reviewer 1:"・"General comment:"・引用文の冒頭数行まで含んでいた(ページ数は15→14に減少)。**以後、この文書のページ境界確認は Read ツールではなく `pdftotext` で行う**方針に変更した。

ページ余白の変更を1440(元の値)に戻し、真因を特定した。`is_label`(4語以下)判定による `keepNext` が、"Kind regards," → "Rintaro Karashima" → (長い所属・住所行はlabel対象外のため鎖が切れる) → "+81 80-4647-8803" → "rintaro.karashima@gmail.com" → **"POINT-BY-POINT RESPONSE..."見出し(太字)** → "Reviewer 1:" → "General comment:" → 引用文全体(太字)という**段落間で連鎖**しており、email 段落の keepNext が次の見出しに、その見出しの keepNext がさらに次に…と連鎖して、email から引用文末尾までが1つの分割不可能な塊になっていた。そのため、間隔をわずかに詰めるだけでは「emailの手前で全塊が次ページに落ちる」か「塊がまるごと1ページ目に収まる」の二択にしかならず、ちょうどemailで切ることができなかった。

修正: カバーレター部分(日付〜署名、`in_letterhead` フラグで判定、"POINT-BY-POINT RESPONSE" 見出しの直前まで)は `is_heading`/`keepNext` の対象から除外した。カバーレターの各行(日付・宛先・本文・署名)は通常の手紙として、どこで改ページされても不自然ではないため、孤立防止の `keepNext` はそもそも不要だった。ページ余白・段落間隔は元の値(1440twips・after=160)のまま。`pdftotext` で再検証し、1ページ目が "rintaro.karashima@gmail.com" で終わり2ページ目が "POINT-BY-POINT RESPONSE..." から始まることを確認し、さらに全15ページの各ページ最終行を点検して見出し・ラベルが孤立していないこと(既存の孤立防止効果に regression がないこと)も確認済み。文言・parity検証は変更なし(147段落・赤字0)。`point-by-point-response_v20260917.docx`/`.pdf` を再生成して差し替え済み。

**Reviewer 1 General comment 直後の不要な改ページを修正(2026-09-17)**: 上記の1ページ目修正の直後、著者から「PDFが更新されていない」との指摘。ファイルの更新時刻・PDF内部メタデータ・`pdftotext`による内容再確認のいずれも更新済みであることを示したが、それとは別に、著者が実際に見ていたのは別の問題だった: Reviewer 1 の General comment(引用文+Response)の直後、"Major comments:" 見出し以降が丸ごと次のページに送られ、前のページの残り数行が空白のまま残っていた。

原因は上記と同じ `keepNext` 連鎖の別の発生箇所だった。太字段落(査読者引用文そのもの)まで `is_heading` 判定に含めていたため、"Major comments:" → "Major comment" → "1. <引用文全体>" → "Response: <回答文>" の直前まで(引用文は太字なので次段落=ResponseにもkeepNextを持つ)が連鎖し、引用文が長い場合はこの塊全体がページに収まらず、そのままページ全体が次ページに送られていた。

修正: `is_heading` の判定を、太字であることではなく「短いラベル段落であること」(`para['label']`、4語以下)に一本化した。これにより「Major comment」「General comment:」「Reviewer N:」等の短い見出しラベルは引き続き次段落(引用文の先頭)と分離されないが、**引用文自体は太字であっても見出し扱いされず、次のResponseへの `keepNext` を持たない**。引用文は通常の段落として、ページ境界で自然に分割されることを許容する(長い引用の途中でページが切り替わるのは自然で、孤立行の問題は生じない)。あわせて "POINT-BY-POINT RESPONSE TO REVIEWERS' COMMENTS:" の大見出し(5語超のため`para['label']`では捕捉されない)を `is_section_title` として明示的に見出し扱いに戻した。これが無いと同見出しだけがページ1の末尾に孤立するため(この副作用は一度発生し、即座に検出・修正した)。

`pdftotext` で最終確認: 1ページ目は "rintaro.karashima@gmail.com" で終わり、2ページ目は "POINT-BY-POINT RESPONSE..." から始まり、Reviewer 1 の Major comment 1 の引用文はページ2の末尾で自然に終わり(「...national setting.」)、Response はページ3の先頭から自然に続く(空白の無駄なし)。全15ページの最終行を再点検し、見出し・ラベルの孤立が新たに発生していないことも確認済み(ページ当たり行数も45〜53行で均一、空白による無駄なし)。文言・parity検証は変更なし(147段落・赤字0)。`point-by-point-response_v20260917.docx`/`.pdf` を再生成して差し替え済み。**以後、この文書のページ内容の検証は必ず `pdftotext` の実出力で行う**(Read ツールのPDF目視結果は本セッションで一度不一致が確認されたため信用しない)。

**letter.md 末尾の署名を「The Authors」から corresponding author 名義に修正(2026-09-17)**: 著者が汎用テンプレート("Sincerely, [Corresponding Author, on behalf of all co-authors]")と見比べて、point-by-point response パート末尾の署名が「The Authors」という匿名的な表記になっている点を指摘。カバーレター側は既に「Kind regards, Rintaro Karashima」と個人名で署名しており、同一文書内で回答書パートだけ名無しなのは一貫性がなかった。`letter.md` 末尾を「Sincerely, / Rintaro Karashima, on behalf of all co-authors」に変更(corresponding author が Rintaro Karashima であることは既に確定済み)。`pdftotext` で再検証し、1ページ目が "rintaro.karashima@gmail.com" で終わる状態を維持していること、最終ページ(15ページ目)の署名が正しく反映されていることを確認済み。parity検証は変更なし(148段落、文言追加のため147→148)。`point-by-point-response_v20260917.docx`/`.pdf` を再生成して差し替え済み。

**提出直前の最終検証(2026-09-17、著者の提出判断前)**: 著者から「本当に問題ないか再確認」の依頼を受け、`doc/advisor-report/2026-09-17/` の成果物を独立に再検証した。(1) `manuscript-source_v20260917.zip` の全10ファイル(tex/bib/cls/bst/eps×6)が作業ツリーとmd5で一致、余計なファイルなし。zipを隔離ディレクトリに展開して `latexmk` 単体コンパイル: exit=0・29ページ・LaTeXエラー0・Overfull 0・未定義参照なし。(2) クリーンPDF(29ページ)を `pdftotext` で確認: titlepage は Karashima が corresponding author(email 表示あり)、keywords は `bipartite networks`、`???` なし、Table S1/S2 の数値にカンマなし。(3) letter が引く所在をクリーンPDFの lineno と照合: 行番号アンカー(100/113/120→p3、151〜181→p4、226→p5、234〜267→p6、327〜362→p8、383〜413→p9、417〜454→p10、461〜484→p11、518〜546→p12、561〜575→p13、603〜633→p14、702〜733→p16、773→p17)と、Table S1/S2=p19・Table S3=p20・Fig.2=p25・Fig.S2=p28・Fig.S3=p29・文献[4][5][14][31]=pp.19-22 がすべて letter の記載と一致。行158/420/442/702 の本文も letter の説明どおり。(4) point-by-point PDF(15ページ): 日付 September 17・添付ファイル説明(Manuscript file / Related file)・P2-1 の「duplicated definition of TCI」・P2-3 の句削除・末尾「Sincerely, Rintaro Karashima, on behalf of all co-authors」を確認。1ページ目は email で終わり2ページ目は "POINT-BY-POINT RESPONSE..." から始まる。全15ページの末尾行に見出し・ラベルの孤立なし。「The Authors」「allowed for either approach」「second version」は不在。(5) track-changes PDF(32ページ、baseline=`submitted`)は現行 tex から生成されている(著者入替・email・`bipartite networks` の差分を含む)。**提出可の判断**: 区分対応は Point-by-point response → `point-by-point-response_v20260917.pdf`、Manuscript file → `manuscript-source_v20260917.zip`、Related files(任意) → `revised-manuscript-track-changes_v20260917.pdf`。同梱の docx とクリーンPDFはアップロード必須ではない。注意点として、letter のページ・行番号は当方ビルド(WSL texlive)のPDFに基づくため、ジャーナル側が TeX Live 2021 で再コンパイルした場合に微小なずれが生じる可能性はゼロではない。クリーンPDFをあわせてアップロードしておけば(Related files 等)、査読者が参照先を確実に辿れる。

**Abstract の複合修飾語ハイフン修正(2026-09-17、提出フォーム入力時)**: 投稿フォームの Abstract 欄に貼り付けた際、フォーム側のチェックで "head-to-head" と "network-based" のハイフン欠落が指摘された。本文の他箇所は "patent-based"(Introduction 3箇所)・"citation-based"・"head-to-head"(Methods 4.4)とハイフン付きで統一されており、Abstract の "Patent based" / "network based" / "head to head" だけが不統一だった(`doc/style-guide/general.md` が禁じているのはダッシュであってハイフンではない)。フォームと原稿の Abstract は同一であるべきなので、`sn-article.tex` の Abstract を3箇所とも修正(`Patent-based measures` / `network-based measure` / `head-to-head with`)。ハイフン化により単語数が 220→217 になるため、letter.md の R1 Minor 4 回答の "(220 words, within the journal limit)" を "(217 words, ...)" に修正。Discussion の "Citation based"(354行)・"citation based"(362行)・"graph based"(363行)も同種の不統一だが、査読者指摘外かつ行番号アンカーへの影響を避けるため今回は触っていない(次回改訂時の候補)。build は exit=0・Overfull 0・29ページを維持。`pdftotext` で再検証: 3箇所のハイフンが反映され、letter が引く行番号アンカー(100→p3、158→p4、334→p8、420/442→p10、603→p14、702→p16、773→p17 ほか)と Table S1/S2=p19・S3=p20・Fig.2=p25・Fig.S2=p28・Fig.S3=p29 はすべて変化なし(文字数が同じ置換のため改行位置も不変)。`manuscript-source_v20260917.zip`(md5一致)・クリーンPDF・`revised-manuscript-track-changes_v20260917.pdf`(マークアップ292)・`point-by-point-response_v20260917.docx/.pdf`(parity OK・148段落・15ページ・1ページ目は email で終了)をすべて再生成済み。**フォームの Abstract 欄には、原稿の Abstract(ハイフン修正後)と同一の文をそのまま貼り付ける。**

**Discussion の残り3箇所もハイフン統一(2026-09-17、著者承認)**: 上記の「次回候補」としていた `Citation based measures`(354行)・`citation based indicators`(362行)・`graph based models`(363行)を著者の指示で修正し、`Citation-based` / `citation-based` / `graph-based` に統一した。tex 全体を `[a-z]+ based [a-z]+` で走査し、残る "based" は全て "based on" の動詞句(109・159・228・265・394・404・524・561行)であることを確認。letter.md 側に未ハイフンの同種表現はなく変更不要。build は exit=0・Overfull 0・29ページ。`pdftotext` で再検証: 3箇所の反映を確認、Discussion の該当段落の行範囲(518-526・527-546)は不変で、letter が引く全アンカー(100→p3 … 773→p17)・Table S1/S2=p19・S3=p20・Fig.2=p25・Fig.S2=p28・Fig.S3=p29 も不変。`manuscript-source_v20260917.zip`(tex md5一致)・クリーンPDF・`revised-manuscript-track-changes_v20260917.pdf`(マークアップ293)を再生成済み。response letter は変更なし(19:50 版が最新)。

**track-changes PDF の先頭空白ページを修正(2026-09-17)**: 著者から「track-changes PDF の最初に空白ページが入っている」との指摘。原因は当日の corresponding author 入替。`scripts/diff.sh` の `--append-safecmd` に `email` が含まれていたため、latexdiff が削除された `\email{inoue@...}` を `\DIFdel{\email{...}}` として出力し、これが `\maketitle` の**前**に取り消し線テキストとして組版されて1ページ目を占有(行番号 001〜046 と ":" の残骸だけの白紙)、タイトルページが2ページ目に押し出されていた。同じ理由で E-mail(s) 行に取り消し線付きの旧アドレス(指導教員)が並んで表示されていた。09-16 までは著者ブロックに差分がなかったため発生していなかった。修正: `diff.sh` の safecmd から `email` を除外(理由をコメントで明記)。これにより旧 `\email` は `%DIFDELCMD` コメントとして記録され本文には何も出力されない(新アドレスのみ表示、旧アドレスは非表示)。再生成後(exit=0・マークアップ291・31ページ)を `pdftotext` で精査: 1ページ目にタイトル・著者(Inoue に波線マーク)・所属・新 email・Abstract、2ページ目が Introduction(047行)から開始、旧 email は本文に不在、Abstract/Keywords/Discussion のハイフン変更・Table S1/S2 の数値変更が新旧対で表示されていることを確認。`related-files/revised-manuscript-track-changes_v20260917.pdf` を差し替え済み。

**改訂投稿用カバーレターの作成(2026-09-17)**: 投稿フォームの Cover letter 欄(任意)に初回投稿時の `doc/cover-letter/CoverLetter_RintaroKARASHIMA.pdf`(2026-06-04)が既定で残っていた。初回レターには今回撤回・後退させた主張(「revealing distinct regional specialization patterns across Japanese prefectures」=旧Fig.3の府県間比較、「methodological advantages of a corporate-level approach」、「how they evolve over time」)と原稿と一致しない数値(「approximately 3.9 million patent records」、原稿は 3,189,536件)が含まれるため、そのまま残さず改訂用に差し替えることを推奨し、著者の依頼で同じ体裁の改訂版を作成した。初回PDFから `pdfimages` でレターヘッド(ロゴ+大学名・住所)を抽出し、手書き署名は `pdftoppm` で2ページ目の該当領域を300dpiでラスタライズ(pdfimages のRGB層は黒地になるため)。Word COM(PowerShell)で A4・Yu Mincho 10.5pt・行送り16pt・左右余白51ptの1ページに組み、`doc/cover-letter/CoverLetter_RintaroKARASHIMA_revision_v20260917.{docx,pdf}` として保存、`doc/advisor-report/2026-09-17/submission-set/cover-letter_v20260917.pdf` にも複製。生成スクリプト `doc/cover-letter/make_cover_letter.ps1` と画像 `doc/cover-letter/assets/{letterhead,signature}.png` をリポジトリに置き再生成可能にした。本文は point-by-point response 1ページ目の添え状と整合(宛先 Prof. Johannes Wachs、添付3点の区分、査読者指摘の要旨、指摘外修正と辞書更新 1,939→1,936 の開示、二重投稿なし・利益相反なし・全著者承認)。署名ブロックは初回レターと同一(University of Hyogo / gmail / Tel +81-78-308-1997)。**注意**: レターヘッド画像は初回どおり「Graduate School of Simulation Studies」だが、原稿の所属は「Graduate School of Information Science」。改組・改称なら原稿側が正しく、次回以降は現行の公式レターヘッドを使うこと(著者に伝達済み)。初回PDFは上書きしていない。**著者判断(同日)**: フォームの Cover letter 欄は任意のため**空欄で提出**する(初回レターは残さない)。添え状の役割は point-by-point response の1ページ目が担う。作成した改訂版カバーレターは `doc/cover-letter/` に保管し、`submission-set/` からは複製を削除した(提出物と混同しないため)。旧ファイルをフォームから削除できない場合の代替は、この改訂版 PDF への差し替え。point-by-point response の分割(添え状を切り離す案)は不採用。

**decision letter との照合(2026-09-17)**: 著者が編集者の決定通知(Submission ID c2970727-…、Decision: major revision、**Deadline: 18 Sep 2026**、署名 "Johannes Wachs, Editor, EPJ Data Science")を共有。通知は「the updated manuscript and a point-by-point response」の提出を求めており、cover letter は要求されていない → Cover letter 欄を空欄にする判断を裏づける。通知の署名が "Editor" であるため、letter.md 冒頭の宛先肩書 "Editor-in-Chief" を **"Editor"** に修正(推測で役職を上げない)。docx/PDF を再生成(parity OK・148段落・15ページ、1ページ目は email で終了、2ページ目は POINT-BY-POINT 見出しから)。通知が強調する3点(結果を正確に報告する・過大な結論を書き直す・限界を十分に説明する)は、添え状1ページ目の「両査読者の懸念を追加分析で確認し、主張を縮小・撤回・差し替えた」旨の記述と、R1 Major 4/6/7・R2 Major 1/2/4 への回答および Discussion の限界段落で対応済み。**提出期限は翌日 2026-09-18**。

**Cover letter 欄が必須と判明(同日)**: 空欄提出の方針を撤回し、作成済みの改訂版カバーレターを提出する。宛先肩書を response letter と同じく "Editor" に修正して `doc/cover-letter/make_cover_letter.ps1` で再生成し、`doc/advisor-report/2026-09-17/submission-set/cover-letter_v20260917.pdf` として提出セットに復帰させた。レターヘッドは初回と同じ画像(Graduate School of Simulation Studies)を使用(著者に所属表記の差異は伝達済み)。

**添え状と point-by-point response を分離(2026-09-17、著者判断)**: 著者から「point-by-point response の1ページ目をカバーレターにする話ではなかったか。フォームの項目は別」との指摘。Cover letter 欄と Point-by-point response 欄が別項目である以上、両方に添え状が入るのは重複になるため、letter.md の冒頭35行(日付・宛先・添え状本文・"Kind regards" 署名)を切り離して `doc/cover-letter/cover-note_former-page1_v20260917.md` に保管し、letter.md は `**POINT-BY-POINT RESPONSE TO REVIEWERS' COMMENTS:**` 見出しから始める形にした。見出し直後に原稿の識別行(タイトル・Submission ID・「ページ/行番号は行番号付き改訂原稿PDFを参照」)を1段落追加(単独文書として成立させるため)。末尾の "Sincerely, / Rintaro Karashima, on behalf of all co-authors" は維持。`md_to_docx.py` は変更なし(`in_letterhead` は見出しで即 False になるだけで無害)。再生成: parity OK・131段落(148→131)、`point-by-point-response_v20260917.{docx,pdf}` を `submission-set/` に差し替え(22:01)。`pdftotext` で検証: **14ページ**(15→14)、1ページ目は見出し→識別行→"Reviewer 1:"→"General comment:" で開始、"Kind regards"・"Dear"・日付・添え状定型文は不在、各ページ末尾に孤立した見出し・ラベルなし、最終ページ末尾が署名行。添え状の役割は `submission-set/cover-letter_v20260917.pdf`(レターヘッド版、21:55)が担う。CLAUDE.md の letter.md の説明も「point-by-point response の正本」に更新。

**最終アップロード対応表(2026-09-17 22:01 時点、締切 2026-09-18)**: Cover letter 欄 ← `submission-set/cover-letter_v20260917.pdf`(1ページ)/ Point-by-point response 欄 ← `submission-set/point-by-point-response_v20260917.pdf`(14ページ)/ Manuscript file 欄 ← `submission-set/manuscript-source_v20260917.zip`(tex・bib・cls・bst・Figs、単独コンパイル exit=0・29ページ)/ Related files 欄 ← `related-files/revised-manuscript-track-changes_v20260917.pdf`(31ページ、マークアップ291)。フォームの Abstract 欄は原稿 Abstract(217語、ハイフン修正後)と同一文、Keywords は原稿と同じ6語。クリーンPDF `(KI01…)_v20260917.pdf` は照合用で、フォームには zip を出す(PDF は編集可能ファイルではないため)。

**カバーレター本文を旧1ページ目の文面に差し替え、生成を LaTeX に切替(2026-09-17、著者指摘)**: 著者から「cover letter の文面が違う。"We are grateful for your constructive comments…" で始まる文面(point-by-point response の旧1ページ目)にすべき」との指摘。21:55 版のレターヘッド PDF は本文を別に書き起こしていたため、`doc/cover-letter/cover-note_former-page1_v20260917.md` の文面に一字も変えず差し替えた(著者が貼り付けた全文と同一。"disclosed in the individual responses below" / "point-by-point response below" の "below" も著者指定どおり残した。宛名 "Dear Editor:"、結び "Kind regards,"、署名ブロックは Graduate School of Information Science / 住所 / +81 80-4647-8803 / gmail も同文面に合わせた)。作業中、Word COM が `SaveAs2` と `ExportAsFixedFormat` で無応答になる事象が発生(1行だけの最小テストでも再現、可視化して画面キャプチャしてもダイアログなし、ファイルロックなし、Resiliency キーを消しても再現)。締切前のため Word に依存しない方法に切替: `doc/cover-letter/cover-letter.tex`(article/A4/geometry 余白 top36・bottom45・左右51pt/Times(ptm) 10.5pt・行送り15pt/ハイフネーション禁止/`assets/letterhead.png` 幅389pt中央・`assets/signature.png` 幅130pt)を `build_cover_letter.sh`(WSL pdflatex、/tmp でビルド)で生成。16pt 行送りでは2ページに溢れたため 15pt と余白調整で**1ページ**に収めた。`pdftotext` で本文全文が指定文面と一致することを確認し、`pdftoppm` で描画してレターヘッド中央・署名・段組を目視確認。`submission-set/cover-letter_v20260917.pdf` を差し替え(md5 一致)。`make_cover_letter.ps1` は非推奨の注記を付けて残置。CLAUDE.md の `doc/cover-letter/` の説明を更新。**追記(同日、著者指示)**: 宛名の肩書を "Editor" から **"Editor-in-Chief"** に戻した(著者の指定。decision letter の署名は "Editor" だが、カバーレターの宛名は著者判断で Editor-in-Chief)。添付ファイルの番号付きリストは `list` 環境で吊り下げインデント(番号を段落インデントと同じ 14pt 位置、本文と折返し行を 28pt)にした。再ビルド後も1ページ、`submission-set/cover-letter_v20260917.pdf` を差し替え(md5 一致)。**追記2(同日、著者指示)**: 署名画像を幅 175pt に拡大。さらに著者の希望でフルブロック形式に変更(段落の先頭字下げなし・段落間 5pt・リストは番号を左端、本文と折返し行を 14pt に揃える吊り下げ)。段落間の空きが増えた分、ヘッダ周りの `\vspace` を縮めて1ページを維持(`pdfinfo` で確認、`pdftoppm` で目視確認)。`submission-set/cover-letter_v20260917.pdf` を差し替え(md5 一致)。
