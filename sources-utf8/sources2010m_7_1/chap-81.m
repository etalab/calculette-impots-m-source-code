#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2011 
#au titre des revenus perçus en 2010. La présente version a permis la 
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
application : pro , oceans , iliad , batch  ;
pour i=V,C,1,2,3,4:
TSBNi = TSHALLOi + ALLOi;
TSHALLOP=TSHALLO1+TSHALLO2+TSHALLO3+TSHALLO4;
ALLOP=ALLO1+ALLO2+ALLO3+ALLO4;
TSBNP=TSHALLOP+ALLOP;

pour i=V,C:
2TSNi = CARTSi + REMPLAi;
pour i=1,2,3,4:
2TSNi = CARTSPi + REMPLAPi;
pour i=V,C:
EXTSi = TSBNi + BPCOSAi + 2TSNi;
pour i=1..4:
EXTSi = TSBNi + 2TSNi;
pour i=V,C:
TSBi = EXTSi + somme(x=1..3:GLDxi);
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
application : pro , oceans , iliad , batch  ;
pour i = V,C,1..4:
TPS10i = arr (TSBi * TX_DEDFORFTS /100);
pour i = V,C,P:
PTPS10i = arr (PERPSALi * TX_DEDFORFTS /100);
pour i = V,C,1..4:
DFNi =  min( PLAF_DEDFORFTS , TPS10i );
pour i = V,C,P:
PDFNi =  min( PLAF_DEDFORFTS , PTPS10i );
regle 813:
application : pro , oceans , iliad , batch  ;
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
application : pro , oceans , iliad , batch  ;
pour i = V,C,1..4:
FRDi = FRNi * positif (FRNi - 10MINSi); 
pour i = V,C:
PFRDi = FRNi * positif (FRNi - P10MINSi); 
PFRDP = FRN1 * positif (FRN1 - P10MINSP); 
pour i = V,C,1..4:
IND_10i = positif_ou_nul( 10MINSi - FRNi ) ;
pour i = V,C:
PIND_10i = positif_ou_nul( P10MINSi - FRNi) ;
PIND_10P = positif_ou_nul( P10MINSP - FRN1) ;
pour i = V,C,1..4:
FPTi = max(FRDi, 10MINSi);
pour i = V,C,P:
PFPTi = max(PFRDi, P10MINSi);
pour i = V,C:
D10Mi = IND_MINi *DFNi 
        + (1 - IND_MINi)* 10MINSi ; 
pour i = V,C,P:
PD10Mi = PIND_MINi *PDFNi 
        + (1 - PIND_MINi)* P10MINSi ; 
pour i = V,C:
REP10i =  IND_10i * D10Mi + (1-IND_10i) * FPTi ;
pour i = V,C,P:
PREP10i =  PIND_10i * PD10Mi + (1-PIND_10i) * PFPTi ;
pour i = V,C:
ABTSi=arr(REP10i*(EXTSi)/TSBi);
regle 816:
application : pro , oceans , iliad , batch  ;
pour i = V,C:
ABGL1i = positif(GLD1i) * 
	   (positif(GLD2i+GLD3i) * arr(REP10i*GLD1i/TSBi)
	   + (1-positif(GLD2i+GLD3i)) * (REP10i-ABTSi));
pour i = V,C:
ABGL2i = positif(GLD2i) * 
	   (positif(GLD3i) * arr(REP10i*GLD2i/TSBi)
	   + (1-positif(GLD3i)) * (REP10i-ABTSi-ABGL1i));
pour i = V,C:
ABGL3i = positif(GLD3i) * (REP10i-ABTSi-ABGL1i-ABGL2i);
regle 817:
application : pro , oceans , iliad , batch  ;
pour i = V,C:
ABGLTi = somme (x=1..3: ABGLxi);
regle 818:
application : pro , oceans , iliad , batch  ;
pour i = V,C,1,2,3,4:
PLRi = min ( MIN_DEDPR , EXPRi );
pour i = V,C,1,2,3,4:
APBi = max( PLRi , (EXPRi*TX_DEDPER/100));
pour i = V,C,1,2,3,4:
IND_APBi = positif_ou_nul(PLRi- (EXPRi * TX_DEDPER/100));
PL_PB = arr(PLAF_DEDPRFOYER -somme (i=V,C,1..4: APBi * IND_APBi));
regle 819:
application : pro , oceans , iliad , batch  ;
pour i = V,C,1,2,3,4:
ABPRi = arr ( (1 - IND_APBi) * 
 min(APBi,(PL_PB * APBi / somme(x=V,C,1..4:APBx * (1 - IND_APBx))))
 + IND_APBi * APBi );
regle 8110:
application : pro , oceans , iliad , batch  ;
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
application : pro , oceans , iliad , batch  ;
pour i = V,C,1,2,3,4:
PRNNi = EXPRi - APRi;
regle 8112:
application : pro , oceans , iliad , batch  ;
pour i = V,C,1..4:
TSNTi =  TSBi - FPTi;
regle 8113:
application : pro , oceans , iliad , batch  ;
pour i =V,C,1,2,3,4:
TSNi = positif (-TSNTi) * min (0 , TSNTi + PRNNi)
     + positif_ou_nul (TSNTi) * TSNTi;
pour i =V,C,1,2,3,4:
PRNi = positif (-TSNTi) * positif (TSNTi + PRNNi) * (TSNTi + PRNNi)
       + positif_ou_nul (TSNTi) * PRNNi;

