* Encoding: UTF-8.
GET DATA
  /TYPE=XLSX
  /FILE='C:\Users\miawe\Documents\Lund University\WPM\SIMM32\Lab 2\lab_2_assignment_dataset.xlsx'
  /SHEET=name 'home_sample_1'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.
DATASET NAME DataSet8 WINDOW=FRONT.
DATASET ACTIVATE DataSet8.
DATASET CLOSE DataSet7.
DATASET ACTIVATE DataSet8.
FREQUENCIES VARIABLES=age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness weight ID
    pain
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=pain age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness
  /STATISTICS=MEAN STDDEV MIN MAX.
EXAMINE VARIABLES=pain BY sex age STAI_trait pain_cat mindfulness cortisol_serum cortisol_saliva
  /PLOT BOXPLOT  HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.
EXAMINE VARIABLES=pain BY sex age STAI_trait pain_cat mindfulness cortisol_serum cortisol_saliva
  /PLOT BOXPLOT  HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.
EXAMINE VARIABLES=pain BY sex age STAI_trait pain_cat mindfulness cortisol_serum cortisol_saliva
  /PLOT BOXPLOT  HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.
DESCRIPTIVES VARIABLES=pain age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness
  /STATISTICS=MEAN STDDEV MIN MAX.
FREQUENCIES VARIABLES=age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness pain sex
  /STATISTICS=STDDEV MINIMUM MAXIMUM SEMEAN SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.
FREQUENCIES VARIABLES=age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness pain sex
  /STATISTICS=STDDEV MINIMUM MAXIMUM SEMEAN SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.
SORT CASES BY sex (A).
SORT CASES BY pain (A).
FREQUENCIES VARIABLES=age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness pain sex
  /STATISTICS=STDDEV MINIMUM MAXIMUM SEMEAN SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.
SORT CASES BY mindfulness (A).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT pain
  /METHOD=ENTER age sex STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness
  /SAVE COOK.


DESCRIPTIVES VARIABLES=pain age sex STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness
  /STATISTICS=MEAN STDDEV MIN MAX.


RECODE sex ('male'='1') ('female'='0').
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT pain
  /METHOD=ENTER sex age STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT pain
  /METHOD=ENTER sex age STAI_trait pain_cat cortisol_serum  mindfulness.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) BCOV R ANOVA SELECTION
  /CRITERIA=PIN(.05) POUT(.10) CIN(95)
  /NOORIGIN 
  /DEPENDENT pain
  /METHOD=ENTER age sex
  /METHOD=ENTER age sex STAI_trait pain_cat cortisol_serum cortisol_saliva mindfulness
  /SAVE SEPRED MCIN ICIN RESID SDBETA COVRATIO.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) BCOV R ANOVA SELECTION
  /CRITERIA=PIN(.05) POUT(.10) CIN(95)
  /NOORIGIN 
  /DEPENDENT pain
  /METHOD=ENTER age sex
  /METHOD=ENTER sex age STAI_trait pain_cat cortisol_serum  mindfulness
  /SAVE SEPRED MCIN ICIN RESID SDBETA COVRATIO.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) BCOV R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10) CIN(95)
  /NOORIGIN 
  /DEPENDENT pain
  /METHOD=ENTER age sex
  /METHOD=ENTER sex age STAI_trait pain_cat cortisol_serum  mindfulness
  /SAVE SEPRED MCIN ICIN RESID DFBETA SDBETA DFFIT SDFIT COVRATIO.

.


