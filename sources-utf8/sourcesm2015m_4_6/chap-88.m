#*************************************************************************************************************************
#
#Copyright or Â© or Copr.[DGFIP][2017]
#
#Ce logiciel a Ã©tÃ© initialement dÃ©veloppÃ© par la Direction GÃ©nÃ©rale des 
#Finances Publiques pour permettre le calcul de l'impÃ´t sur le revenu 2016 
#au titre des revenus perÃ§us en 2015. La prÃ©sente version a permis la 
#gÃ©nÃ©ration du moteur de calcul des chaÃ®nes de taxation des rÃ´les d'impÃ´t 
#sur le revenu de ce millÃ©sime.
#
#Ce logiciel est rÃ©gi par la licence CeCILL 2.1 soumise au droit franÃ§ais 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffusÃ©e par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez accÃ©der Ã  cet en-tÃªte signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez acceptÃ© les termes.
#
#**************************************************************************************************************************
regle 881000:
application : iliad , batch ;

pour i = V,C;x=1..3:
GLNAVxi = max (GLDxi - ABGLxi,0) * INDEFTSi;
GLDOMAVDAJV = max (CODDAJ - ABDOMDAJ,0) * INDEFTSV;
GLDOMAVEAJV = max (CODEAJ - ABDOMEAJ,0) * INDEFTSV;
GLDOMAVDBJC = max (CODDBJ - ABDOMDBJ,0) * INDEFTSC;
GLDOMAVEBJC = max (CODEBJ - ABDOMEBJ,0) * INDEFTSC;
GLN1V = (max (GLD1V - ABGL1V,0) * INDEFTSV);
GLN2V = (max (GLD2V - ABGL2V,0) * INDEFTSV);
GLN3V = (max (GLD3V - ABGL3V,0) * INDEFTSV);
GLN4DAJV = (max(CODDAJ - ABDOMDAJ,0) * INDEFTSV);
GLN4V = (max(CODDAJ - ABDOMDAJ,0)+max(CODEAJ - ABDOMEAJ,0)) * INDEFTSV;
GLN1C = (max (GLD1C - ABGL1C,0) * INDEFTSC);
GLN2C = (max (GLD2C - ABGL2C,0) * INDEFTSC);
GLN3C = (max (GLD3C - ABGL3C,0) * INDEFTSC);
GLN4DBJC = (max(CODDBJ - ABDOMDBJ,0) * INDEFTSC);
GLN4C = (max(CODDBJ - ABDOMDBJ,0)+max(CODEBJ - ABDOMEBJ,0)) * INDEFTSC;

regle 881010:
application : iliad , batch ;

TSV = TSNV - somme(x=1..3: max(0,GLDxV - ABGLxV))-max(CODDAJ - ABDOMDAJ,0)-max(CODEAJ - ABDOMEAJ,0);
TSC = TSNC - somme(x=1..3: max(0,GLDxC - ABGLxC))-max(CODDBJ - ABDOMDBJ,0)-max(CODEBJ - ABDOMEBJ,0);
pour i=1..4:
TSi = TSNi;
pour i=V,C:
TPRi = TSNi + PRNi - somme(x=1..3: GLNxi);
pour i=1..4:
TPRi = TSNi + PRNi;
pour i = V,C :
TSNNi =  positif(TSi) *arr(TSi *(TSBNi + BPCOSAi + GLDGRATi)/EXTSi )
          + (1 -positif(TSi)) * TSi ;
pour i = 1..4 :
TSNNi = (positif(TSi) * arr(TSi * TSBNi /EXTSi )
            + (1 -positif(TSi)) * TSi)  ;
TSNN2V =  positif(TSV) * (
                  positif(CARTSV+REMPLAV)
                          * arr(TSV * 2TSNV / EXTSV )
                    + (1 -positif(CARTSV+REMPLAV))
                          * (TSV - TSNNV));
TSNN2C =  positif(TSC)
                * ( positif(CARTSC+REMPLAC)
                          * arr(TSC * 2TSNC / EXTSC )
                    + (1 -positif(CARTSC+REMPLAC))
                          * (TSC - TSNNC));
TSNN2VAFF =  positif(TSV)
                *  (positif(CARTSV+REMPLAV)
                          * arr(TSV * 2TSNV / EXTSV )
                    + (1 -positif(CARTSV+REMPLAV))
                          * (TSV - TSNNV)
         + positif(CODDAJ + CODEAJ) * (max(CODDAJ - ABDOMDAJ,0)+max(CODEAJ - ABDOMEAJ,0)));
TSNN2CAFF =  positif(TSC)
                *  (positif(CARTSC+REMPLAC)
                          * arr(TSC * 2TSNC / EXTSC )
                    + (1 -positif(CARTSC+REMPLAC))
                          * (TSC - TSNNC)
         + positif(CODDBJ + CODEBJ) * (max(CODDBJ - ABDOMDBJ,0)+max(CODEBJ - ABDOMEBJ,0)));
TSNN21 =  positif(TS1)
               * ( positif(CARTSP1+REMPLAP1)
                          * arr(TS1 * 2TSN1 /EXTS1 )
                    + (1 -positif(CARTSP1+REMPLAP1))
                          * (TS1 - TSNN1));
TSNN22 =  positif(TS2)
               * ( positif(CARTSP2+REMPLAP2)
                          * arr(TS2 * 2TSN2 /EXTS2 )
                    + (1 -positif(CARTSP2+REMPLAP2))
                          * (TS2 - TSNN2));
TSNN23 =  positif(TS3)
               * ( positif(CARTSP3+REMPLAP3)
                          * arr(TS3 * 2TSN3 /EXTS3 )
                    + (1 -positif(CARTSP3+REMPLAP3))
                          * (TS3 - TSNN3));
TSNN24 =  positif(TS4)
               * ( positif(CARTSP4+REMPLAP4)
                          * arr(TS4 * 2TSN4 /EXTS4 )
                    + (1 -positif(CARTSP4+REMPLAP4))
                          * (TS4 - TSNN4));
TSNN21AFF =  positif(TS1)
               *  (positif(CARTSP1+REMPLAP1)
                          * arr(TS1 * 2TSN1 /EXTS1 )
                    + (1 -positif(CARTSP1+REMPLAP1))
                          * (TS1 - TSNN1));
TSNN22AFF =  positif(TS2)
               *  (positif(CARTSP2+REMPLAP2)
                          * arr(TS2 * 2TSN2 /EXTS2 )
                    + (1 -positif(CARTSP2+REMPLAP2))
                          * (TS2 - TSNN2));
TSNN23AFF =  positif(TS3)
               *  (positif(CARTSP3+REMPLAP3)
                          * arr(TS3 * 2TSN3 /EXTS3 )
                    + (1 -positif(CARTSP3+REMPLAP3))
                          * (TS3 - TSNN3));
TSNN24AFF =  positif(TS4)
               *  (positif(CARTSP4+REMPLAP4)
                          * arr(TS4 * 2TSN4 /EXTS4 )
                    + (1 -positif(CARTSP4+REMPLAP4))
                          * (TS4 - TSNN4));

TSNN2PAFF = somme(i=1..4:TSNN2iAFF) ;
TSNN2TSV =  positif(TSV)
                * ( positif(REMPLAV)
                          * arr(TSV * CARTSV / EXTSV )
                    + (1 -positif(REMPLAV))
                          * (TSV - TSNNV)) ;
TSNN2TSC =  positif(TSC)
                * ( positif(REMPLAC)
                          * arr(TSC * CARTSC / EXTSC )
                    + (1 -positif(REMPLAC))
                          * (TSC - TSNNC)) ;
TSNN2TS1 =  positif(TS1)
               * ( positif(REMPLAP1)
                          * arr(TS1 * CARTSP1 /EXTS1 )
                    + (1 -positif(REMPLAP1))
                          * (TS1 - TSNN1)) ;
TSNN2TS2 =  positif(TS2)
               * ( positif(REMPLAP2)
                          * arr(TS2 * CARTSP2 /EXTS2 )
                    + (1 -positif(REMPLAP2))
                          * (TS2 - TSNN2)) ;
TSNN2TS3 =  positif(TS3)
               * ( positif(REMPLAP3)
                          * arr(TS3 * CARTSP3 /EXTS3 )
                    + (1 -positif(REMPLAP3))
                          * (TS3 - TSNN3)) ;
TSNN2TS4 =  positif(TS4)
               * ( positif(REMPLAP4)
                          * arr(TS4 * CARTSP4 /EXTS4 )
                    + (1 -positif(REMPLAP4))
                          * (TS4 - TSNN4)) ;
pour i = V,C :
TSNN2REMPi = (positif(TSi) * (TSi - TSNNi-TSNN2TSi)) ;
pour i = 1..4 :
TSNN2REMPi = (positif(TSi) * (TSi - TSNNi-TSNN2TSi)) ;


regle 881020:
application : iliad , batch ;

pour i = V,C,1..4:
PRRi = arr(PRNi * PRBi / EXPRi);
PRR2V = positif(PEBFV+PENSALV+CODRAZ) * arr(PRNV * CARPEV / EXPRV)
           +  (1 -positif(PEBFV+PENSALV+CODRAZ)) * (PRNV -PRRV);
PRR2C = positif(PEBFC+PENSALC+CODRBZ) * arr(PRNC * CARPEC / EXPRC)
           +  (1 -positif(PEBFC+PENSALC+CODRBZ)) * (PRNC -PRRC)  ;
PRR21 = positif(PEBF1+PENSALP1+CODRCZ) * arr(PRN1 * CARPEP1 / EXPR1 )
           +  (1 -positif(PEBF1+PENSALP1+CODRCZ)) * (PRN1 -PRR1);
PRR22 = positif(PEBF2+PENSALP2+CODRDZ) * arr(PRN2 * CARPEP2 / EXPR2 )
           +  (1 -positif(PEBF2+PENSALP2+CODRDZ)) * (PRN2 -PRR2);
PRR23 = positif(PEBF3+PENSALP3+CODREZ) * arr(PRN3 * CARPEP3 / EXPR3 )
           +  (1 -positif(PEBF3+PENSALP3+CODREZ)) * (PRN3 -PRR3);
PRR24 = positif(PEBF4+PENSALP4+CODRFZ) * arr(PRN4 * CARPEP4 / EXPR4 )
           +  (1 -positif(PEBF4+PENSALP4+CODRFZ)) * (PRN4 -PRR4);
PRR2ZV = positif(PEBFV+PENSALV) * arr(PRNV * CODRAZ / EXPRV)
           +  (1 -positif(PEBFV+PENSALV)) * (PRNV -PRRV-PRR2V);
PRR2ZC = positif(PEBFC+PENSALC) * arr(PRNC * CODRBZ / EXPRC)
           +  (1 -positif(PEBFC+PENSALC)) * (PRNC -PRRC-PRR2C);
PRR2Z1 = positif(PEBF1+PENSALP1) * arr(PRN1 * CODRCZ / EXPR1 )
           +  (1 -positif(PEBF1+PENSALP1)) * (PRN1 -PRR1-PRR21);
PRR2Z2 = positif(PEBF2+PENSALP2) * arr(PRN2 * CODRDZ / EXPR2 )
           +  (1 -positif(PEBF2+PENSALP2)) * (PRN2 -PRR2-PRR22);
PRR2Z3 = positif(PEBF3+PENSALP3) * arr(PRN3 * CODREZ / EXPR3 )
           +  (1 -positif(PEBF3+PENSALP3)) * (PRN3 -PRR3-PRR23);
PRR2Z4 = positif(PEBF4+PENSALP4) * arr(PRN4 * CODRFZ / EXPR4 )
           +  (1 -positif(PEBF4+PENSALP4)) * (PRN4 -PRR4-PRR24);
PRR2ZP = PRR2Z1 + PRR2Z2 + PRR2Z3 + PRR2Z4;
PENFV =  (positif(PENSALV) * arr(PRNV * PEBFV / EXPRV)
       + (1 - positif(PENSALV)) * max(0,(PRNV -PRRV -PRR2V-PRR2ZV)));
PENFC =  (positif(PENSALC) * arr(PRNC * PEBFC / EXPRC)
       + (1 - positif(PENSALC)) * max(0,(PRNC -PRRC -PRR2C-PRR2ZC)));
PENF1 =  (positif(PENSALP1) * arr(PRN1 * PEBF1 / EXPR1)
       + (1 - positif(PENSALP1)) * max(0,(PRN1 -PRR1 -PRR21-PRR2Z1)));
PENF2 =  (positif(PENSALP2) * arr(PRN2 * PEBF2 / EXPR2)
       + (1 - positif(PENSALP2)) * max(0,(PRN2 -PRR2 -PRR22-PRR2Z2)));
PENF3 =  (positif(PENSALP3) * arr(PRN3 * PEBF3 / EXPR3)
       + (1 - positif(PENSALP3)) * max(0,(PRN3 -PRR3 -PRR23-PRR2Z3)));
PENF4 =  (positif(PENSALP4) * arr(PRN4 * PEBF4 / EXPR4)
       + (1 - positif(PENSALP4)) * max(0,(PRN4 -PRR4 -PRR24-PRR2Z4)));
pour i = V,C:
PENALIMi = positif(EXPRi) * (PRNi -PRRi -PRR2i -PRR2Zi- PENFi) ;
pour i = 1..4:
PENALIMi = positif(EXPRi) * (PRNi -PRRi -PRR2i -PRR2Zi- PENFi) ;

regle 881030:
application : iliad , batch ;

pour i = 1,2,3,4:
RVi = arr(RVBi * TXRVTi / 100);
RVTOT = RV1 + RV2 + RV3 + RV4 ;

regle 881040:
application : iliad , batch ;

2RV1 = arr(RENTAX * TXRVT1 / 100) ;
2RV2 = arr(RENTAX5 * TXRVT2 / 100) ;
2RV3 = arr(RENTAX6 * TXRVT3 / 100) ;
2RV4 = arr(RENTAX7 * TXRVT4 / 100) ;
T2RV = 2RV1 + 2RV2 + 2RV3 + 2RV4 ;

regle 881050:
application : iliad , batch ;

RVBCSG = arr((RVB1 + RENTAX) * TXRVT1 / 100) 
       + arr((RVB2 + RENTAX5) * TXRVT2 / 100) 
       + arr((RVB3 + RENTAX6) * TXRVT3 / 100) 
       + arr((RVB4 + RENTAX7) * TXRVT4 / 100) ;

regle 881060:
application : iliad , batch ;

TSPR = TSPRT + RVTOT ;

regle 881070:
application : iliad , batch ;


TSPRV = (TSNNV + PRRV);
TSPRC = (TSNNC + PRRC);
TSPR1 = (TSNN1 + PRR1);
TSPR2 = (TSNN2 + PRR2);
TSPR3 = (TSNN3 + PRR3);
TSPR4 = (TSNN4 + PRR4);

TSPRP = somme(i=1..4:TSPRi);
TSPRTOT = somme(i=V,C,1..4:TSPRi);
TSPRDP = somme(i=1..4:TSPRDi) ;
TSNNT = abs(TSNNV + PRRV
          + TSNNC + PRRC
          + TSNN1 + PRR1
          + TSNN2 + PRR2
          + TSNN3 + PRR3
          + TSNN4 + PRR4) 
         * (1-positif(TSNNV + PRRV + TSNNC + PRRC+ TSNN1 + PRR1 + TSNN2 + PRR2 + TSNN3 + PRR3 + TSNN4 + PRR4 )) ;

regle 881080:
application : iliad , batch ;

TSNN2P = somme(i=1..4: TSNN2i);
PRR2P =somme(i=1..4: PRR2i);
PENFP = PENF1 + PENF2 + PENF3 + PENF4 ;
PENALIMP = PENALIM1 + PENALIM2 + PENALIM3 + PENALIM4;

regle 881090:
application : iliad , batch ;


TSQVO = 2TSNV+CODDAJ+CODEAJ;
TSQCJ = 2TSNC+CODDBJ+CODEBJ;
TSQPC = somme(i=1..4: 2TSNi ) ;
PRQVO =  CARPEV + PEBFV;
PRQCJ =  CARPEC + PEBFC; 
PRQPC =  CARPEP1+PEBF1 
      +  CARPEP2+PEBF2
      +  CARPEP3+PEBF3
      +  CARPEP4+PEBF4;
PRQZV =  CODRAZ;
PRQZC =  CODRBZ; 
PRQZP =  CODRCZ +CODRDZ+CODREZ+CODRFZ;

PENSALP = PENSALP1 + PENSALP2 + PENSALP3 + PENSALP4 ;

regle 881100:
application : iliad , batch ;

PRQNV = 2PRBV;
PRQNC = 2PRBC; 
PRQNP = somme(i=1..4: 2PRBi) ;
PENSTOTV = (PRR2V + PRR2ZV + PENALIMV);
PENSTOTC = (PRR2C + PRR2ZC + PENALIMC);
PENSTOT1 = (PRR21 + PRR2Z1 + PENALIM1);
PENSTOT2 = (PRR22 + PRR2Z2 + PENALIM2);
PENSTOT3 = (PRR23 + PRR2Z3 + PENALIM3);
PENSTOT4 = (PRR24 + PRR2Z4 + PENALIM4);
PENSTOTP = PENSTOT1+PENSTOT2+PENSTOT3+PENSTOT4;

regle 881110:
application : iliad , batch ;

pour i=V,C:
BPCAPTAXi = PCAPTAXi - arr(PCAPTAXi * TX_DEDPER/100);
pour i=V,C:
IPCAPTAXi = arr(BPCAPTAXi * T_PCAPTAX/100) * (1 - positif(RE168 + TAX1649));
IPCAPTAXTOT = somme(i=V,C:IPCAPTAXi);

regle 881120:
application : iliad , batch ;

IPCAPTAXT = (IPCAPTAXTOT - CICAP) * (1 - positif(RE168 + TAX1649));

