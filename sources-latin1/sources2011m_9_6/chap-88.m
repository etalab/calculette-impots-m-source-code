#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2012 
#au titre des revenus percus en 2011. La présente version a permis la 
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
regle 881:
application : pro , oceans , iliad , batch  ;
pour i = V,C;x=1..3:
GLNxi = max (GLDxi - ABGLxi,0);
regle 882:
application : pro , oceans , iliad , batch  ;
pour i=V,C:
TSi = TSNi - somme(x=1..3: max(0,GLDxi - ABGLxi));
pour i=1..4:
TSi = TSNi;
pour i=V,C:
TPRi = TSNi + PRNi - somme(x=1..3: GLNxi);
pour i=1..4:
TPRi = TSNi + PRNi;
pour i = V,C :
TSNNi =  positif(TSi) *arr(TSi *(TSBNi + BPCOSAi)/EXTSi )
          + (1 -positif(TSi)) * TSi ;
pour i = 1..4 :
TSNNi = (positif(TSi) * arr(TSi * TSBNi /EXTSi )
            + (1 -positif(TSi)) * TSi)  ;
pour i = V,C :
TSNN2i = ( positif(TSi)
                * ( positif(CARTSi+REMPLAi) 
                          * arr(TSi * 2TSNi / EXTSi )
                    + (1 -positif(CARTSi+REMPLAi)) 
                          * (TSi - TSNNi))) ;
pour i = 1..4 :
TSNN2i = ( positif(TSi)
               * ( positif(CARTSPi+REMPLAPi) 
                          * arr(TSi * 2TSNi /EXTSi )
                    + (1 -positif(CARTSPi+REMPLAPi)) 
                          * (TSi - TSNNi))) ;
pour i = V,C :
TSNN2TSi = ( positif(TSi)
                * ( positif(REMPLAi) 
                          * arr(TSi * CARTSi / EXTSi )
                    + (1 -positif(REMPLAi)) 
                          * (TSi - TSNNi))) ;
pour i = 1..4 :
TSNN2TSi = ( positif(TSi)
               * ( positif(REMPLAPi) 
                          * arr(TSi * CARTSPi /EXTSi )
                    + (1 -positif(REMPLAPi)) 
                          * (TSi - TSNNi))) ;
pour i = V,C :
TSNN2REMPi = (positif(TSi) * (TSi - TSNNi-TSNN2TSi)) ;
pour i = 1..4 :
TSNN2REMPi = (positif(TSi) * (TSi - TSNNi-TSNN2TSi)) ;

regle 883:
application : pro , oceans , iliad , batch  ;
pour i = V,C,1..4:
PRRi = arr(PRNi * PRBi / EXPRi);
pour i = V,C:
PRR2i = positif(PEBFi+PENSALi) * arr(PRNi * CARPEi / EXPRi)
           +  (1 -positif(PEBFi+PENSALi)) * (PRNi -PRRi)   ;
pour i = 1..4:
PRR2i = positif(PEBFi+PENSALPi) * arr(PRNi * CARPEPi / EXPRi )
           +  (1 -positif(PEBFi+PENSALPi)) * (PRNi -PRRi);
pour i = V,C:
PENFi =  positif(PENSALi) * arr(PRNi * PEBFi / EXPRi)
       + (1 - positif(PENSALi)) * max(0,(PRNi -PRRi -PRR2i));
pour i = 1..4:
PENFi =  positif(PENSALPi) * arr(PRNi * PEBFi / EXPRi)
        + (1- positif(PENSALPi)) * (PRNi -PRRi -PRR2i);
pour i = V,C:
PENALIMi = positif(EXPRi) * (PRNi -PRRi -PRR2i - PENFi) ;
pour i = 1..4:
PENALIMi = positif(EXPRi) * (PRNi -PRRi -PRR2i - PENFi) ;
regle 884:
application : pro , oceans , iliad , batch  ;
pour i = 1,2,3,4:
RVi = arr(RVBi * TXRVTi / 100);
RVTOT = RV1 + RV2 + RV3 + RV4;
regle 885:
application : pro , oceans , iliad , batch  ;
2RV1 = arr(RENTAX * TXRVT1 / 100);
2RV2 = arr(RENTAX5 * TXRVT2 / 100);
2RV3 = arr(RENTAX6 * TXRVT3 / 100);
2RV4 = arr(RENTAX7 * TXRVT4 / 100);
T2RV = 2RV1 + 2RV2 + 2RV3 + 2RV4;
regle 886:
application : pro , oceans , iliad , batch  ;
RVBCSG = arr((RVB1 + RENTAX) * TXRVT1 / 100) 
       + arr((RVB2 + RENTAX5) * TXRVT2 / 100) 
       + arr((RVB3 + RENTAX6) * TXRVT3 / 100) 
       + arr((RVB4 + RENTAX7) * TXRVT4 / 100) ;

regle 887:
application : pro , oceans , iliad , batch  ;
TSPR = TSPRT + RVTOT ;
regle 888:
application : pro , oceans , iliad , batch  ;
pour i=V,C,1..4:
TSPRi = TSNNi + PRRi ;
TSPRP = somme(i=1..4:TSPRi) ;
regle 8810:
application : pro , oceans , iliad , batch  ;
TSNN2P = somme(i=1..4: TSNN2i);
PRR2P =somme(i=1..4: PRR2i);
PENFP = PENF1 + PENF2 + PENF3 + PENF4 ;
PENALIMP = PENALIM1 + PENALIM2 + PENALIM3 + PENALIM4;

regle 8811:
application : pro , oceans , iliad , batch ;
TSQVO = 2TSNV;
TSQCJ = 2TSNC;
TSQPC = somme(i=1..4: 2TSNi ) ;
PRQVO =  CARPEV + PEBFV;
PRQCJ =  CARPEC + PEBFC; 
PRQPC = somme(i=1..4:  CARPEPi+PEBFi) ;
PENSALP = PENSALP1 + PENSALP2 + PENSALP3 + PENSALP4;
regle 8812:
application : oceans , iliad , pro , batch ;
PRQNV = 2PRBV;
PRQNC = 2PRBC; 
PRQNP = somme(i=1..4: 2PRBi) ;
PENSTOTV = PRR2V + PENALIMV;
PENSTOTC = PRR2C + PENALIMC;
PENSTOTP = PRR2P + PENALIMP;
regle 8815:
application : oceans , iliad , pro , batch ;
pour i=V,C:
BPCAPTAXi = PCAPTAXi - arr(PCAPTAXi * TX_DEDPER/100);
pour i=V,C:
IPCAPTAXi = arr(BPCAPTAXi * T_PCAPTAX/100);
IPCAPTAXT = somme(i=V,C:IPCAPTAXi);
