#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2014 
#au titre des revenus perçus en 2013. La présente version a permis la 
#génération du moteur de calcul des chaînes de taxation des rôles d'impôt 
#sur le revenu de ce millésime.
#
#Ce logiciel est régi par la licence CeCILL 2.1 soumise au droit français 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffusée par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez accéder à cet en-tête signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez accepté les termes.
#
#**************************************************************************************************************************
 #
 #                         REVENUS CATEGORIELS NETS
 #
 #
regle 811:
application : iliad , batch  ;
pour i=V,C,1,2,3,4:
TSBNi = TSHALLOi + ALLOi;
TSHALLOP=TSHALLO1+TSHALLO2+TSHALLO3+TSHALLO4;
ALLOP=ALLO1+ALLO2+ALLO3+ALLO4;
TSBNP=TSHALLOP+ALLOP;

pour i=V,C:
2TSNi = CARTSi + REMPLAi;
pour i=1,2,3,4:
2TSNi = CARTSPi + REMPLAPi;
EXTSV = TSBNV + BPCOSAV + GLDGRATV + 2TSNV;
EXTSC = TSBNC + BPCOSAC + GLDGRATC + 2TSNC;
GATASAV = BPCOSAV + GLDGRATV ;
GATASAC = BPCOSAC + GLDGRATC ;

pour i=1..4:
EXTSi = TSBNi + 2TSNi;
TSBV = EXTSV + somme(x=1..3:GLDxV)+CODDAJ+CODEAJ ;
TSBC = EXTSC + somme(x=1..3:GLDxC)+CODDBJ+CODEBJ ;
pour i=1,2,3,4:
TSBi = EXTSi;
TSBP = somme(i=1..4:TSBi);
pour i=V,C,1..4:
PRBi = PRBRi + PALIi;

pour i=V,C:
2PRBi = CARPEi + PENSALi ;
pour i=1..4:
2PRBi = CARPEPi + PENSALPi ;
pour i=V,C:
EXPRi = PRBi + 2PRBi + PEBFi;
pour i=1..4:
EXPRi = PRBi + 2PRBi + PEBFi;
pour i = V,C,1..4:
EXSPBi = EXTSi + EXPRi ;
regle 812:
application : iliad , batch  ;
pour i = V,C,1..4:
TPS10i = arr (TSBi * TX_DEDFORFTS /100);
pour i = V,C,P:
PTPS10i = arr (PERPSALi * TX_DEDFORFTS /100);
pour i = V,C,1..4:
DFNi =  min( PLAF_DEDFORFTS , TPS10i );
pour i = V,C,P:
PDFNi =  min( PLAF_DEDFORFTS , PTPS10i );
regle 813:
application : iliad , batch  ;
pour i = V,C,1..4:
DEDMINi = positif(DETSi)* MIN_DEMEMPLOI + (1- positif(DETSi))* MIN_DEDSFORFTS;
pour i = V,C:
PDEDMINi = DEDMINi;
PDEDMINP = positif(DETS1)* MIN_DEMEMPLOI 
	   + (1- positif(DETS1))* MIN_DEDSFORFTS;

pour i = V,C,1..4:
10MINSi= max( min(TSBi,DEDMINi) , DFNi );
pour i = V,C,P:
P10MINSi= max( min(PERPSALi,PDEDMINi) , PDFNi );
pour i = V,C,1..4:
IND_10MIN_0i = positif(DEDMINi - DFNi ) * positif (TSBi );
pour i = V,C,P:
PIND_10MIN_0i = positif(PDEDMINi - PDFNi ) * positif (PERPSALi );
pour i = V,C,1..4 :
IND_MINi = 1 - positif( IND_10MIN_0i );
pour i = V,C,P :
PIND_MINi = 1 - positif( PIND_10MIN_0i );
regle 814:
application : iliad , batch  ;

pour i = V,C,1..4:
FRDi = (1-positif(ART1731BIS)) * FRNi * positif(FRNi - 10MINSi) + positif(ART1731BIS) * (min(FRDi_A,TSBi+PRNNi)*positif(min(FRDi_A,TSBi+PRNNi) - 10MINSi)*(1-FLAGPREM+0)*(1-positif(CMAJ))
                                                                                       + min(FRNi,TSBi+PRNNi)*positif(min(FRNi,TSBi+PRNNi) - 10MINSi)*(FLAGPREM+0)*(1-positif(CMAJ))
                                                                                       + min(FRNi,TSBi+PRNNi)*positif(min(FRNi,TSBi+PRNNi) - 10MINSi)*positif(CMAJ)) ; 
FRDP = FRD1 +FRD2 +FRD3 +FRD4 ;
PFRDV = (FRDV+COD1AE) * positif ((FRDV+COD1AE) - P10MINSV);
PFRDC = (FRDC+COD1BE) * positif ((FRDC+COD1BE) - P10MINSC);
PFRDP = (FRD1+COD1CE) * positif ((FRD1+COD1CE) - P10MINSP);
pour i = V,C,1..4:
IND_10i = positif_ou_nul( 10MINSi - FRDi) ;
PIND_10V = positif_ou_nul( P10MINSV - (FRDV+COD1AE)) ;
PIND_10C = positif_ou_nul( P10MINSC - (FRDC+COD1BE)) ;
PIND_10P = positif_ou_nul( P10MINSP - (FRD1+COD1CE)) ;
pour i = V,C,1..4:
FPTi = max(FRDi, 10MINSi);
pour i = V,C,1..4:
INDEFTSi = positif_ou_nul(TSBi - FRDi);
pour i = V,C,P:
PFPTi = max(PFRDi, P10MINSi);
pour i = V,C,1..4:
D10Mi = IND_MINi *DFNi 
        + (1 - IND_MINi)* 10MINSi ; 
pour i = V,C,P:
PD10Mi = PIND_MINi *PDFNi 
        + (1 - PIND_MINi)* P10MINSi ; 
pour i = V,C,1..4:
REP10i =  IND_10i * D10Mi + (1-IND_10i) * FPTi ;
pour i = V,C,P:
PREP10i =  PIND_10i * PD10Mi + (1-PIND_10i) * PFPTi ;
ABTS1AJ=arr(REP10V*(TSHALLOV)/TSBV);
ABTS1AP=arr(REP10V*(ALLOV)/TSBV);
ABTS3VJ=arr(REP10V*(BPCOSAV)/TSBV);
ABTS1TT=arr(REP10V*(GLDGRATV)/TSBV);
ABTSRAJ=arr(REP10V*(CARTSV)/TSBV);
ABTSRAP=arr(REP10V*(REMPLAV)/TSBV);
ABTSV = ABTS1AJ + ABTS1AP +ABTS3VJ +ABTS1TT +ABTSRAJ+ABTSRAP;
ABDOMDAJ = positif(CODDAJ) * 
	   (positif(CODEAJ+GLD1V+GLD2V+GLD3V) * arr(REP10V*CODDAJ/TSBV)
	   + (1-positif(CODEAJ+GLD1V+GLD2V+GLD3V)) * max(0,REP10V-ABTSV))+0;
ABDOMEAJ = positif(CODEAJ) * 
	   (positif(GLD1V+GLD2V+GLD3V) * arr(REP10V*CODEAJ/TSBV)
	   + (1-positif(GLD1V+GLD2V+GLD3V)) * max(0,REP10V-ABTSV-ABDOMDAJ))+0;
ABGL1V = positif(GLD1V) * 
	   (positif(GLD2V+GLD3V) * arr(REP10V*GLD1V/TSBV)
	   + (1-positif(GLD2V+GLD3V)) * max(0,REP10V-ABTSV-ABDOMDAJ-ABDOMEAJ))+0;
ABGL2V = positif(GLD2V) * 
	   (positif(GLD3V) * arr(REP10V*GLD2V/TSBV)
	   + (1-positif(GLD3V)) * max(0,REP10V-ABTSV-ABDOMDAJ-ABDOMEAJ-ABGL1V))+0;
ABGL3V = max(0,REP10V-ABTSV-ABDOMDAJ-ABDOMEAJ-ABGL1V-ABGL2V)+0;
ABTS1BJ=arr(REP10C*(TSHALLOC)/TSBC);
ABTS1BP=arr(REP10C*(ALLOC)/TSBC);
ABTS3VK=arr(REP10C*(BPCOSAC)/TSBC);
ABTS1UT=arr(REP10C*(GLDGRATC)/TSBC);
ABTSRBJ=arr(REP10C*(CARTSC)/TSBC);
ABTSRBP=arr(REP10C*(REMPLAC)/TSBC);
ABTSC = ABTS1BJ + ABTS1BP +ABTS3VK +ABTS1UT +ABTSRBJ+ABTSRBP;
ABDOMDBJ = positif(CODDBJ) * 
	   (positif(CODEBJ+GLD1C+GLD2C+GLD3C) * arr(REP10C*CODDBJ/TSBC)
	   + (1-positif(CODEBJ+GLD1C+GLD2C+GLD3C)) * max(0,REP10C-ABTSC))+0;
ABDOMEBJ = positif(CODEBJ) * 
	   (positif(GLD1C+GLD2C+GLD3C) * arr(REP10C*CODEBJ/TSBC)
	   + (1-positif(GLD1C+GLD2C+GLD3C)) * max(0,REP10C-ABTSC-ABDOMDBJ))+0;
ABGL1C = positif(GLD1C) * 
	   (positif(GLD2C+GLD3C) * arr(REP10C*GLD1C/TSBC)
	   + (1-positif(GLD2C+GLD3C)) * max(0,REP10C-ABTSC-ABDOMDBJ-ABDOMEBJ))+0;
ABGL2C = positif(GLD2C) * 
	   (positif(GLD3C) * arr(REP10C*GLD2C/TSBC)
	   + (1-positif(GLD3C)) * max(0,REP10C-ABTSC-ABDOMDBJ-ABDOMEBJ-ABGL1C))+0;
ABGL3C = max(0,REP10C-ABTSC-ABDOMDBJ-ABDOMEBJ-ABGL1C-ABGL2C)+0;
ABTS1CJ=arr(REP101*(TSHALLO1)/TSB1);
ABTS1CP=arr(REP101*(ALLO1)/TSB1);
ABTSRCJ=arr(REP101*(CARTSP1)/TSB1);
ABTSRCP=max(0,REP101 - (ABTS1CJ  +ABTS1CP +ABTSRCJ))+0;
ABTS1DJ=arr(REP102*(TSHALLO2)/TSB2);
ABTS1DP=arr(REP102*(ALLO2)/TSB2);
ABTSRDJ=arr(REP102*(CARTSP2)/TSB2);
ABTSRDP=max(0,REP102 - (ABTS1DJ  +ABTS1DP +ABTSRDJ))+0;
ABTS1EJ=arr(REP103*(TSHALLO3)/TSB3);
ABTS1EP=arr(REP103*(ALLO3)/TSB3);
ABTSREJ=arr(REP103*(CARTSP3)/TSB3);
ABTSREP=max(0,REP103 - (ABTS1EJ  +ABTS1EP +ABTSREJ)) +0;
ABTS1FJ=arr(REP104*(TSHALLO4)/TSB4);
ABTS1FP=arr(REP104*(ALLO4)/TSB4);
ABTSRFJ=arr(REP104*(CARTSP4)/TSB4);
ABTSRFP=max(0,REP104 - (ABTS1FJ  +ABTS1FP +ABTSRFJ))+0;
regle 817:
application : iliad , batch  ;
ABGLTV = somme (x=1..3: ABGLxV)+ABDOMDAJ + ABDOMEAJ;
ABGLTC = somme (x=1..3: ABGLxC)+ABDOMDBJ + ABDOMEBJ;
regle 8178888:
application : iliad , batch  ;
TSN1AJ = TSHALLOV - ABTS1AJ;
TSN1AP = ALLOV - ABTS1AP;
TSN3VJ = BPCOSAV - ABTS3VJ;
TSN1TT = GLDGRATV - ABTS1TT;
TSNRAJ = (CARTSV - ABTSRAJ) ;
TSNRAP = (REMPLAV - ABTSRAP);
TSNDAJ = (CODDAJ - ABDOMDAJ);
TSNEAJ = (CODEAJ - ABDOMEAJ);
TSNGL1V = (GLD1V - ABGL1V);
TSNGL2V = (GLD2V - ABGL2V);
TSNGL3V = (GLD3V - ABGL3V);
TSN1BJ = TSHALLOC - ABTS1BJ;
TSN1BP = ALLOC - ABTS1BP;
TSN3VK = BPCOSAC - ABTS3VK;
TSN1UT = GLDGRATC - ABTS1UT;
TSNRBJ = (CARTSC - ABTSRBJ);
TSNRBP = (REMPLAC - ABTSRBP);
TSNDBJ = (CODDBJ - ABDOMDBJ);
TSNEBJ = (CODEBJ - ABDOMEBJ);
TSNGL1C = (GLD1C - ABGL1C);
TSNGL2C = (GLD2C - ABGL2C);
TSNGL3C = (GLD3C - ABGL3C);
TSN1CJ = TSHALLO1 - ABTS1CJ;
TSN1CP = ALLO1 - ABTS1CP;
TSNRCJ = (CARTSP1 - ABTSRCJ);
TSNRCP = (REMPLAP1 - ABTSRCP);
TSN1DJ = TSHALLO2 - ABTS1DJ;
TSN1DP = ALLO2 - ABTS1DP;
TSNRDJ = (CARTSP2 - ABTSRDJ);
TSNRDP = (REMPLAP2 - ABTSRDP);
TSN1EJ = TSHALLO3 - ABTS1EJ;
TSN1EP = ALLO3 - ABTS1EP;
TSNREJ = (CARTSP3 - ABTSREJ);
TSNREP = (REMPLAP3 - ABTSREP);
TSN1FJ = TSHALLO4 - ABTS1FJ;
TSN1FP = ALLO4 - ABTS1FP;
TSNRFJ = (CARTSP4 - ABTSRFJ);
TSNRFP = (REMPLAP4 - ABTSRFP);
regle 818:
application : iliad , batch  ;
pour i = V,C,1,2,3,4:
PLRi = min ( MIN_DEDPR , EXPRi );
pour i = V,C,1,2,3,4:
APBi = max( PLRi , (EXPRi*TX_DEDPER/100));
pour i = V,C,1,2,3,4:
IND_APBi = positif_ou_nul(PLRi- (EXPRi * TX_DEDPER/100));
PL_PB = arr(PLAF_DEDPRFOYER -somme (i=V,C,1..4: APBi * IND_APBi));
regle 819:
application : iliad , batch  ;
pour i = V,C,1,2,3,4:
ABPRi = arr ( (1 - IND_APBi) * 
 min(APBi,(PL_PB * APBi / somme(x=V,C,1..4:APBx * (1 - IND_APBx))))
 + IND_APBi * APBi );
regle 8110:
application : iliad , batch  ;
APRV  =  IND_APBV * ABPRV 
       + (1-IND_APBV)* min ( ABPRV , PL_PB); 
APRC  =  IND_APBC * ABPRC 
       + (1-IND_APBC)* min ( ABPRC , PL_PB - (1-IND_APBV)*APRV ); 
APR1  =  IND_APB1 * ABPR1 
       + (1-IND_APB1)* min ( ABPR1 , PL_PB - (1-IND_APBV)*APRV 
			- (1-IND_APBC)*APRC);
APR2  =  IND_APB2 * ABPR2
       + (1-IND_APB2)* min ( ABPR2 , PL_PB - (1-IND_APBV)*APRV 
                       - (1-IND_APBC)*APRC - (1-IND_APB1)*APR1 ); 
APR3  =  IND_APB3 * ABPR3
       + (1-IND_APB3)* min ( ABPR3 , PL_PB - (1-IND_APBV)*APRV 
                       - (1-IND_APBC)*APRC - (1-IND_APB1)*APR1  
                       - (1-IND_APB2)*APR2 ); 
APR4  =  IND_APB4 * ABPR4 
       + (1-IND_APB4)* min ( ABPR4 , PL_PB - (1-IND_APBV)*APRV 
                       - (1-IND_APBC)*APRC - (1-IND_APB1)*APR1  
                       - (1-IND_APB2)*APR2 - (1-IND_APB3)*APR3 ); 
regle 8111:
application : iliad , batch  ;
pour i = V,C,1,2,3,4:
PRNNi = EXPRi - APRi;
regle 8112:
application : iliad , batch  ;
TSNTV =  TSN1AJ+TSN1AP+TSN3VJ+TSN1TT+TSNRAJ+TSNRAP 
        +TSNDAJ+TSNEAJ+TSNGL1V+TSNGL2V+TSNGL3V ;
TSNTC = TSN1BJ+TSN1BP+TSN3VK+TSN1UT+TSNRBJ+TSNRBP
       +TSNDBJ+TSNEBJ+TSNGL1C+TSNGL2C+TSNGL3C ;
TSNT1 =  TSN1CJ + TSN1CP + TSNRCJ + TSNRCP;
TSNT2 =  TSN1DJ + TSN1DP + TSNRDJ + TSNRDP;
TSNT3 =  TSN1EJ+ TSN1EP+ TSNREJ+ TSNREP ;
TSNT4 =  TSN1FJ+ TSN1FP+ TSNRFJ+ TSNRFP ;
regle 8113:
application : iliad , batch  ;
pour i =V,C,1,2,3,4:
TSNi = positif (-TSNTi) * min (0 , TSNTi + PRNNi)
     + positif_ou_nul (TSNTi) * TSNTi;
pour i =V,C,1,2,3,4:
PRNi = positif (-TSNTi) * positif (TSNTi + PRNNi) * (TSNTi + PRNNi)
       + positif_ou_nul (TSNTi) * PRNNi;

FRDVREP =  positif(ART1731BIS) *  max(0,FRNV - FRDV) * null(IND_10V);
FRDCREP =  positif(ART1731BIS) *  max(0,FRNC - FRDC) * null(IND_10C);
FRD1REP =  positif(ART1731BIS) *  max(0,(max(0,(FRN1-FRD1)) - PRN1 * (1-positif(FRN1-FRD1)))* null(IND_101)
                                       +(max(0,(FRN2-FRD2)) - PRN2 * (1-positif(FRN2-FRD2)) )* null(IND_102)
                                       +(max(0,(FRN3-FRD3)) - PRN3 * (1-positif(FRN3-FRD3)))* null(IND_103)
                                       +(max(0,(FRN4-FRD4)) - PRN4 * (1-positif(FRN4-FRD4)))* null(IND_104) )
                                     ;
FRDREPTOT =   positif(ART1731BIS) *  (FRDVREP + FRDCREP + FRD1REP);
