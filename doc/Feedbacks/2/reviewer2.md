Reviewer 2

Thanks to the authors for their substantial revisions and clarifications. I appreciate the efforts!
In my opinion, I still do not see the novelty claim supported by the analysis, unfortunately.
First, the regional TCI appears to be wrongly estimated, which undermines the whole comparison and analysis. Fig. 2B shows that the vast majority of complexities pile up between 75 and 100, while they should be distributed more evenly across the spectrum (as for the corporate case). Now, this is a common problem in ECI computation, if one is not careful in removing the appropriate number of rows or columns in the matrix (see Hidalgo 2021 for a thorough discussion). This is also why ranks jump as erratically in Fig. 2SB. I buy the argument that ECI values based on firm-level data should be more stable, but Fig. 2SB is not paying justice to the regional ECI version. The negative correlation between Fitness and TCI supports the fact that something must be wrong.
Second, the gain in explanatory power of using any complexity index on predicting entries is negligible (AUC moves from 0.7974 to 0.7989). The authors acknowledge this, but then describe the result as showing that the corporate level “carries information”.
Third, the out-of-sample test does not compare indices with equal node counts. The authors establish that node counts matters in computing complexity, but then compare a 1,936-node corporate TCI to a 47-node regional TCI. Hence, it is unclear whether the results is again driven by node count (or the issues raised in my first comment).
A couple of other points:

- The authors mention attribution issues on the address of corporations, with 6,46% having multiple addresses. It would be interesting to see whether invention-based computations might resolve this.
- Standard errors in the logit regression should be clustered, and ubiquity should be controlled for in the regressions.

Hidalgo, C. A. (2021). Economic complexity theory and applications. Nature Reviews Physics, 3(2), 92-113.
