* Encoding: UTF-8.


DATASET ACTIVATE DataSet1.


DESCRIPTIVES VARIABLES=pain1 pain2 pain3 pain4 age STAI_trait pain_cat cortisol_serum mindfulness
  /STATISTICS=MEAN STDDEV MIN MAX SEMEAN SKEWNESS.

RECODE sex ('male'='1') ('female'='0').
EXECUTE.

FREQUENCIES VARIABLES=pain1 pain2 pain3 pain4 sex age STAI_trait pain_cat cortisol_serum 
    cortisol_saliva mindfulness
  /STATISTICS=STDDEV MINIMUM MAXIMUM SKEWNESS SESKEW
  /HISTOGRAM
  /ORDER=ANALYSIS.



EXAMINE VARIABLES=pain1 pain2 pain3 pain4 BY sex age STAI_trait pain_cat cortisol_serum mindfulness
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS NONE
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

CORRELATIONS
  /VARIABLES=pain1 pain2 pain3 pain4
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.



DESCRIPTIVES VARIABLES=PostOp_Pain age STAI_trait pain_cat cortisol_serum mindfulness sex
  /STATISTICS=MEAN STDDEV MIN MAX SEMEAN SKEWNESS.

*random intercept mixed model (SLOPE IS INCORRECT)

MIXED PostOp_Pain WITH age sex STAI_trait pain_cat cortisol_serum mindfulness Day
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0, ABSOLUTE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0.000001, ABSOLUTE)    
  /FIXED=age sex STAI_trait pain_cat cortisol_serum mindfulness | SSTYPE(3)
  /METHOD=REML
  /PRINT=CORB  SOLUTION
  /RANDOM=INTERCEPT | SUBJECT(ID) COVTYPE(VC)
  /SAVE=PRED.

*random intercept, random slope (day) mixed model

MIXED PostOp_Pain WITH age sex STAI_trait pain_cat cortisol_serum mindfulness Day
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0, ABSOLUTE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0.000001, ABSOLUTE)    
  /FIXED=age sex STAI_trait pain_cat cortisol_serum mindfulness | SSTYPE(3)
  /METHOD=REML
  /PRINT=CORB  SOLUTION
  /RANDOM=INTERCEPT Day | SUBJECT(ID) COVTYPE(UN)
  /SAVE=PRED.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day 
    MEAN(PostOp_pain_pred)[name="MEAN_PostOp_pain_pred"] data_type MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: MEAN_PostOp_pain_pred=col(source(s), name("MEAN_PostOp_pain_pred"))
  DATA: data_type=col(source(s), name("data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("Mean Predicted Values"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("data_type"))
  GUIDE: text.title(label("Multiple Line Mean of Predicted Values by Day by data_type"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(Day*MEAN_PostOp_pain_pred), color.interior(data_type), missing.wings())
END GPL.

SORT CASES  BY ID.
SPLIT FILE SEPARATE BY ID.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day 
    MEAN(PostOp_pain_pred)[name="MEAN_PostOp_pain_pred"] data_type MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: MEAN_PostOp_pain_pred=col(source(s), name("MEAN_PostOp_pain_pred"))
  DATA: data_type=col(source(s), name("data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("Mean Predicted Values"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("data_type"))
  GUIDE: text.title(label("Multiple Line Mean of Predicted Values by Day by data_type"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(Day*MEAN_PostOp_pain_pred), color.interior(data_type), missing.wings())
END GPL.

*random intercept model 2 with slope

DATASET ACTIVATE DataSet2.
MIXED PostOp_Pain WITH age sex STAI_trait pain_cat cortisol_serum mindfulness Day
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0, ABSOLUTE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0.000001, ABSOLUTE)    
  /FIXED=age sex STAI_trait pain_cat cortisol_serum mindfulness Day | SSTYPE(3)
  /METHOD=REML
  /PRINT=CORB  SOLUTION
  /RANDOM=INTERCEPT | SUBJECT(ID) COVTYPE(VC)
  /SAVE=PRED.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day PostOp_Pain data_type MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: PostOp_Pain=col(source(s), name("PostOp_Pain"), unit.category())
  DATA: data_type=col(source(s), name("data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("PostOp_Pain"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("data_type"))
  GUIDE: text.title(label("Multiple Line of PostOp_Pain by Day by data_type"))
  ELEMENT: line(position(Day*PostOp_Pain), color.interior(data_type), missing.wings())
END GPL.

SORT CASES  BY ID.
SPLIT FILE SEPARATE BY ID.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day PostOp_Pain data_type MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: PostOp_Pain=col(source(s), name("PostOp_Pain"), unit.category())
  DATA: data_type=col(source(s), name("data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("PostOp_Pain"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("data_type"))
  GUIDE: text.title(label("Multiple Line of PostOp_Pain by Day by data_type"))
  ELEMENT: line(position(Day*PostOp_Pain), color.interior(data_type), missing.wings())
END GPL.

DESCRIPTIVES VARIABLES=Day
  /STATISTICS=MEAN STDDEV MIN MAX.

DATASET ACTIVATE DataSet3.
COMPUTE center_day=Day-2.5.
EXECUTE.

COMPUTE sq_center_day=center_day * center_day.
EXECUTE.

DATASET ACTIVATE DataSet12.
MIXED PostOp_pain WITH age sex STAI_trait pain_cat cortisol_serum mindfulness center_day 
    sq_center_day
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0, ABSOLUTE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0.000001, ABSOLUTE)    
  /FIXED=age sex STAI_trait pain_cat cortisol_serum mindfulness center_day sq_center_day | SSTYPE(3)    
  /METHOD=REML
  /PRINT=CORB  SOLUTION
  /RANDOM=INTERCEPT | SUBJECT(ID) COVTYPE(VC)
  /SAVE=PRED.

SPLIT FILE OFF.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day PostOp_pain data_type MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: PostOp_pain=col(source(s), name("PostOp_pain"), unit.category())
  DATA: data_type=col(source(s), name("data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("PostOp_pain"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("data_type"))
  GUIDE: text.title(label("Multiple Line of PostOp_pain by Day by data_type"))
  ELEMENT: line(position(Day*PostOp_pain), color.interior(data_type), missing.wings())
END GPL.

DATASET ACTIVATE DataSet17.
* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day Mean_PostOp_pain Data_type MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: Mean_PostOp_pain=col(source(s), name("Mean_PostOp_pain"))
  DATA: Data_type=col(source(s), name("Data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("Mean_PostOp_pain"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Data_type"))
  GUIDE: text.title(label("Multiple Line of Mean_PostOp_pain by Day by Data_type"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(Day*Mean_PostOp_pain), color.interior(Data_type), missing.wings())
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day MEAN(PostOp_pain)[name="MEAN_PostOp_pain"] 
    Data_type MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: MEAN_PostOp_pain=col(source(s), name("MEAN_PostOp_pain"))
  DATA: Data_type=col(source(s), name("Data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("Mean PostOp_pain"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Data_type"))
  GUIDE: text.title(label("Multiple Line Mean of PostOp_pain by Day by Data_type"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(Day*MEAN_PostOp_pain), color.interior(Data_type), missing.wings())
END GPL.

SORT CASES  BY ID.
SPLIT FILE SEPARATE BY ID.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Day MEAN(PostOp_pain)[name="MEAN_PostOp_pain"] 
    Data_type MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Day=col(source(s), name("Day"), unit.category())
  DATA: MEAN_PostOp_pain=col(source(s), name("MEAN_PostOp_pain"))
  DATA: Data_type=col(source(s), name("Data_type"), unit.category())
  GUIDE: axis(dim(1), label("Day"))
  GUIDE: axis(dim(2), label("Mean PostOp_pain"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Data_type"))
  GUIDE: text.title(label("Multiple Line Mean of PostOp_pain by Day by Data_type"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(Day*MEAN_PostOp_pain), color.interior(Data_type), missing.wings())
END GPL.

DATASET ACTIVATE DataSet18.
MIXED PostOp_pain WITH age sex STAI_trait pain_cat cortisol_serum mindfulness center_day 
    sq_center_day
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0, ABSOLUTE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0.000001, ABSOLUTE)    
  /FIXED=age sex STAI_trait pain_cat cortisol_serum mindfulness center_day sq_center_day | SSTYPE(3)    
  /METHOD=REML
  /PRINT=CORB  SOLUTION
  /RANDOM=INTERCEPT | SUBJECT(ID) COVTYPE(VC) SOLUTION
  /SAVE=PRED RESID.

EXAMINE VARIABLES=RESID_1
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=PRED_int_sq_day RESID_1 MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: PRED_int_sq_day=col(source(s), name("PRED_int_sq_day"))
  DATA: RESID_1=col(source(s), name("RESID_1"))
  GUIDE: axis(dim(1), label("Predicted Values"))
  GUIDE: axis(dim(2), label("Residuals"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of Residuals by Predicted Values"))
  ELEMENT: point(position(PRED_int_sq_day*RESID_1))
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=center_day RESID_1 MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: center_day=col(source(s), name("center_day"))
  DATA: RESID_1=col(source(s), name("RESID_1"))
  GUIDE: axis(dim(1), label("center_day"))
  GUIDE: axis(dim(2), label("Residuals"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of Residuals by center_day"))
  ELEMENT: point(position(center_day*RESID_1))
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=sq_center_day RESID_1 MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: sq_center_day=col(source(s), name("sq_center_day"))
  DATA: RESID_1=col(source(s), name("RESID_1"))
  GUIDE: axis(dim(1), label("sq_center_day"))
  GUIDE: axis(dim(2), label("Residuals"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of Residuals by sq_center_day"))
  ELEMENT: point(position(sq_center_day*RESID_1))
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=pain_cat RESID_1 MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: pain_cat=col(source(s), name("pain_cat"))
  DATA: RESID_1=col(source(s), name("RESID_1"))
  GUIDE: axis(dim(1), label("pain_cat"))
  GUIDE: axis(dim(2), label("Residuals"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of Residuals by pain_cat"))
  ELEMENT: point(position(pain_cat*RESID_1))
END GPL.

CORRELATIONS
  /VARIABLES=age sex STAI_trait pain_cat cortisol_serum mindfulness center_day sq_center_day
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

COMPUTE sq_resid=RESID_1 * RESID_1.
EXECUTE.

SPSSINC CREATE DUMMIES VARIABLE=ID 
ROOTNAME1=ID_dummy 
/OPTIONS ORDER=A USEVALUELABELS=YES USEML=YES OMITFIRST=NO.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT sq_resid
  /METHOD=ENTER ID_dummy_2 ID_dummy_3 ID_dummy_4 ID_dummy_5 ID_dummy_6 ID_dummy_7 ID_dummy_8 
    ID_dummy_9 ID_dummy_10 ID_dummy_11 ID_dummy_12 ID_dummy_13 ID_dummy_14 ID_dummy_15 ID_dummy_16 
    ID_dummy_17 ID_dummy_18 ID_dummy_19 ID_dummy_20.

DATASET ACTIVATE DataSet19.
EXAMINE VARIABLES=random_effects
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

DATASET ACTIVATE DataSet18.
MIXED PostOp_pain WITH age sex STAI_trait pain_cat cortisol_serum mindfulness center_day 
    sq_center_day
  /CRITERIA=DFMETHOD(SATTERTHWAITE) CIN(95) MXITER(100) MXSTEP(10) SCORING(1) 
    SINGULAR(0.000000000001) HCONVERGE(0, ABSOLUTE) LCONVERGE(0, ABSOLUTE) PCONVERGE(0.000001, ABSOLUTE)    
  /FIXED=age sex STAI_trait pain_cat cortisol_serum mindfulness center_day sq_center_day | SSTYPE(3)    
  /METHOD=REML
  /PRINT=CORB G  SOLUTION
  /RANDOM=INTERCEPT sq_center_day center_day | SUBJECT(ID) COVTYPE(UN)
  /SAVE=PRED RESID.
