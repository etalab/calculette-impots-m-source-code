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
                                                                           #
  ####   #    #    ##    #####      #     #####  #####   ######           ##
 #    #  #    #   #  #   #    #     #       #    #    #  #               # #
 #       ######  #    #  #    #     #       #    #    #  #####             #
 #       #    #  ######  #####      #       #    #####   #                 #
 #    #  #    #  #    #  #          #       #    #   #   #                 #
  ####   #    #  #    #  #          #       #    #    #  ###### #######  #####
 #
 #
 #
 #
 #
 #                         CALCUL DU NET A PAYER
 #
 #
 #
 #
 #
 #
regle 101:
application : bareme  ;
RC1 = positif( NAPI + 1 - SEUIL_12 ) +0 ;
regle 1010:
application : batch, iliad ;
NAPT = NAPTEMPCX-TOTIRPSANT;
NAPTIR = IRNET + TAXANET + TAXLOYNET + PCAPNET + HAUTREVNET
	    - IRESTITIR;

regle 10101:
application : batch, iliad ;
NAPCOROLIR = (TOTIRCUM - NONMER -RECUMIR + NONREST) * positif(20 - V_NOTRAIT) 
            + max(0, (TOTIRCUM - NONMER - RECUMIR+NONREST) - (V_TOTIRANT -V_NONMERANT - V_ANTREIR+V_NONRESTANT)) * positif_ou_nul(V_NOTRAIT-20);
NAPCOROLCS = max(0, NAPCR61 - V_ANTCR);
regle 10111:
application : iliad,batch ;
RC1 = si ( NAPINI - V_ANTIR - IRCUM_A + RECUMBIS >= SEUIL_12 )
      alors (1)
      sinon (0)
      finsi;
regle 1013 :
application : iliad , batch ;
IAVIMBIS = IRB + PIR ;
IAVIMO = (max(0,max(ID11-ADO1,IMI)-RED) + ITP + REI + PIR)
                 * V_CR2;
regle 1012:
application : bareme , iliad , batch ;
NAPI = ( IRD + PIRD - IRANT ) 
       + TAXASSUR
       + IPCAPTAXT
       + IHAUTREVT
       + TAXLOY
       + RASAR * V_CR2 ;
regle 104114:
application : iliad , batch ;
INTMS = inf( MOISAN / 10000 );
INTAN = (( MOISAN/10000 - INTMS )*10000)  * present(MOISAN) ;
TXINT = (positif(2006-arr(INTAN))*max(0, (INTAN - (V_ANREV+1) )* 12 + INTMS - 6 ) * TXMOISRETARD 
         + positif_ou_nul(V_ANREV-2006)*max(0, (INTAN - (V_ANREV+1) )* 12 + INTMS - 6 ) * TXMOISRETARD2 
         + (1-positif(2006-arr(INTAN)))*(1-positif_ou_nul(V_ANREV-2006))
	   * (((2006 - (V_ANREV+1))*12 - 6) * (TXMOISRETARD * positif(2006 - (V_ANREV+1)) + TXMOISRETARD2 * null(2006-(V_ANREV+1)))
	      + ((INTAN - 2006)*12 + INTMS) * TXMOISRETARD2)
          ) 
            * present(MOISAN);
COPETO = si (CMAJ = 7 ou CMAJ = 10 ou CMAJ = 17 ou CMAJ = 18)
         alors (10)
         sinon
              ( si (CMAJ = 8 ou CMAJ = 11)
                alors (40)
                sinon (80)
                finsi )
         finsi;
regle 1041140:
application : iliad , batch ;
CSTOTSSPENA = max(0,CSG + RDSN + PRS + CVNSALC + CDIS + CGLOA + RSE1N  + RSE2N + RSE3N + RSE4N + RSE5N);
PTOIR = arr(BTO * COPETO / 100)                
	 + arr(BTO * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr((BTOINR) * TXINT / 100) ;
PTOPRS =( arr((PRS-PRSPROV) * COPETO / 100)                
         + arr((PRS-PRSPROV) * TXINT / 100) ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PTOCSG =( arr((CSG-CSGIM) * COPETO / 100)                
         + arr((CSG-CSGIM) * TXINT / 100) ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTORSE1 = (arr(max(0,RSE1 -CIRSE1 -CSPROVYD) * COPETO / 100) + arr(max(0,RSE1 -CIRSE1 -CSPROVYD) * TXINT / 100)) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTORSE2 = (arr(max(0,RSE2 -CIRSE2 -CSPROVYF) * COPETO / 100) + arr(max(0,RSE2 -CIRSE2 -CSPROVYF) * TXINT / 100)) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTORSE3 = (arr(max(0,RSE3 -CIRSE3 -CSPROVYG) * COPETO / 100) + arr(max(0,RSE3 -CIRSE3 -CSPROVYG) * TXINT / 100)) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTORSE4 = (arr(max(0,RSE4 -CIRSE4 -CSPROVYH) * COPETO / 100) + arr(max(0,RSE4 -CIRSE4 -CSPROVYH) * TXINT / 100)) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PTORSE5 = (arr(max(0,RSE5 -CIRSE5 -CSPROVYE) * COPETO / 100) + arr(max(0,RSE5 -CIRSE5 -CSPROVYE) * TXINT / 100)) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PTORDS =( arr((RDSN-CRDSIM) * COPETO / 100)                
         + arr((RDSN-CRDSIM) * TXINT / 100) ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PTOTAXA= arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * COPETO / 100)
	 + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT / 100) ;
PTOTPCAP= arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * COPETO / 100)
	 + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT / 100) ;
PTOTLOY = arr(max(0,TAXLOY- min(TAXLOY+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * COPETO / 100)
	 + arr(max(0,TAXLOY- min(TAXLOY+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,TAXLOY- min(TAXLOY+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT / 100) ;

PTOTCHR= arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * COPETO / 100)
	 + arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * TXINT / 100) ;

PTOCVN = (arr((CVNSALC - COD8YT) * COPETO / 100) + arr((CVNSALC - COD8YT) * TXINT / 100))                
         * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTOCDIS = (arr((CDIS-CDISPROV) * COPETO / 100) + arr((CDISC-CDISPROV) * TXINT / 100)) 
          * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTOGLOA = (arr((CGLOA-COD8YL) * COPETO / 100) + arr((CGLOA-COD8YL) * TXINT / 100)) 
          * positif_ou_nul(CSTOTSSPENA - SEUIL_61);


regle 1041141:
application : iliad , batch ;
BTO = max( 0 , IRN - IRANT )
           * positif( IAMD1 + 1 - SEUIL_61 );
BTOINR = max( 0 , IRN - ACODELAISINR - IRANT )
           * positif( IAMD1 + 1 - SEUIL_61 );

regle 10211:
application : bareme , batch , iliad ;
IRD = IRN * (positif(5 - V_IND_TRAIT)
              +
              (1-positif(5-V_IND_TRAIT)) * (
              positif_ou_nul(IRN+PIR-SEUIL_12) 
             + (1 - positif(IRN + PIR))
             ));
regle 10213:
application : iliad , batch;

PRSD = NAPPS - V_PSANT ;

CSGD = NAPCS - V_CSANT ;

RDSD = NAPRD - V_RDANT ;

CVND = NAPCVN - V_CVNANT ;
CGLOAD = NAPGLOA - V_GLOANT ;

CDISD = NAPCDIS - V_CDISANT ;
CRSE1D = NAPRSE1 - V_RSE1ANT ;
CRSE2D = NAPRSE2 - V_RSE2ANT ;
CRSE3D = NAPRSE3 - V_RSE3ANT ;
CRSE4D = NAPRSE4 - V_RSE4ANT ;
CRSE5D = NAPRSE5 - V_RSE5ANT ;

regle 10214:
application : iliad,batch ;
CSGAC = max(0,CSGC - CICSG);
CSNET = max(0,(CSGC + PCSG - CICSG - CSGIM)) ;
RDSAC = max(0,RDSC - CIRDS);
RDNET = max(0,(RDSC + PRDS - CIRDS - CRDSIM));
PRSNET = max(0,(PRSC + PPRS - CIPRS - PRSPROV))  ;
CVNAC  =  CVNSALC;
CVNNET  =  max(0,(CVNSALC + PCVN - COD8YT));
CDISAC = CDISC ;
CDISNET = max(0,(CDISC + PCDIS - CDISPROV))  ;
CGLOAAC = CGLOA ;
CGLOANET = max(0,(CGLOA + PGLOA-COD8YL ))  ;
regle 102141:
application : iliad,batch ;
RSE1AC = max(0,RSE1 - CIRSE1)  ;
RSE1NET = max(0,(RSE1 + PRSE1 - CIRSE1 - CSPROVYD))  ;
RSE2AC = max(0,RSE2 - CIRSE2)  ;
RSE2NET = max(0,(RSE2 + PRSE2 - CIRSE2 - CSPROVYF))  ;
RSE3AC = max(0,RSE3 - CIRSE3 )  ;
RSE3NET = max(0,(RSE3 + PRSE3 - CIRSE3 - CSPROVYG))  ;
RSE4AC = max(0,RSE4 - CIRSE4 )  ;
RSE4NET = max(0,(RSE4 + PRSE4 - CIRSE4 - CSPROVYH))  ;
RSE5AC = max(0,RSE5 - CIRSE5)  ;
RSE5NET = max(0,(RSE5 + PRSE5 - CIRSE5 - CSPROVYE))  ;
RSENETTOT = RSE1NET + RSE2NET + RSE3NET + RSE4NET + RSE5NET;
regle 102142:
application : iliad,batch ;
TOTCRBRUT = max(0,CSGC + PCSG - CICSG - CSGIM +RDSC + PRDS - CIRDS - CRDSIM+ PRSC + PPRS - CIPRS - PRSPROV
                       + CVNSALC + PCVN - COD8YT+CDISC + PCDIS - CDISPROV + CGLOA + PGLOA - COD8YL
                       +RSE1 + PRSE1+RSE2 + PRSE2+ RSE3 + PRSE3+RSE4 + PRSE4+ RSE5 + PRSE5
                       - CIRSE1 - CSPROVYD - CIRSE5 - CSPROVYE - CIRSE2 - CSPROVYF
                       - CIRSE3 - CSPROVYG - CIRSE4 - CSPROVYH);
TOTCRNET = CSNET+ RDNET+ PRSNET+ CVNNET+ CDISNET+CGLOANET+ RSE1NET+ RSE2NET+ RSE3NET+ RSE4NET+ RSE5NET;
regle 10201:
application : batch , iliad ;

IARD = IAR - IAR_A ;

regle 1041:
application :  iliad, batch ;
PIRD = PIR * (positif(5 - V_IND_TRAIT)
              +
              (1-positif(5-V_IND_TRAIT)) * (
              positif_ou_nul(IRN+PIR-SEUIL_12) 
              + 
              (1-positif(IRN+PIR)) 
             ))
    - 
              PIR_A * ( positif_ou_nul(PIR_A-SEUIL_12) 
               + 
              (1-positif(PIR_A))  
              );
PPRSD = PPRS * CSREC - PPRS_A * CSRECA ;
PCSGD = PCSG* CSREC - PCSG_A * CSRECA ;
PRDSD = PRDS * CSREC - PRDS_A * CSRECA;
PTOTD = PIRD  ;
regle 114:
application : iliad , batch ;
BPRS = arr(RDRFPS * (1-null(4-V_REGCO))
	  + (COD8XK + COD8YK + RDRV + RDRCM + RDNP + RDNCP + RDPTP + ESFP + R1649)*(1-V_CNR)) * (1 - present(RE168)) 
	 + RE168 * (1-V_CNR);
BPRSAPS = arr(RDRFAPS * (1-null(4-V_REGCO))
	  + (RDRVAPS + RDRCMAPS + RDNP + ESFP + R1649)*(1-V_CNR)) * (1 - present(RE168)) 
	 + RE168 * (1-V_CNR);
regle 113:
application : iliad , batch ;
PRSC = arr( BPRS * T_PREL_SOC /100 ) * (1 - positif(ANNUL2042)) ;
PRSCAPS = arr( BPRSAPS * T_PREL_SOC /100 ) * (1 - positif(ANNUL2042)) ;
regle 103103 :
application : iliad , batch ;
PRS = PRSC - CIPRS;
PRSAPS = PRSCAPS - CIPRSAPS;
regle 1031 :
application : iliad , batch ;
CSGC = arr( BCSG * T_CSG / 100) * (1 - positif(ANNUL2042)) ;
CSGCAPS = arr( BCSGAPS * T_CSG / 100) * (1 - positif(ANNUL2042)) ;
regle 103101 :
application : iliad , batch ;

RSE1 = arr(BRSE1 * TXTQ/100) * (1 - positif(ANNUL2042)) ;
RSE2 = arr(BRSE2 * TXTV/100) * (1 - positif(ANNUL2042)) ;
RSE3 = arr(BRSE3 * TXTW/100) * (1 - positif(ANNUL2042)) ;
RSE4 = arr(BRSE4 * TXTX/100) * (1 - positif(ANNUL2042)) ;
RSE5 = arr(BRSE5 * TX075/100) * (1 - positif(ANNUL2042)) ;

RSETOT = RSE1 + RSE2 + RSE3 + RSE4 + RSE5;
regle 1031011 :
application : iliad , batch ;
CSG = max(0,CSGC - CICSG) ;
CSGAPS = max(0,CSGCAPS - CICSGAPS) ;
RSE1N = max(0,RSE1 - CIRSE1) ;
RSE2N = max(0,RSE2  - CIRSE2) ;
RSE3N = max(0,RSE3 - CIRSE3);
RSE4N = max(0,RSE4  - CIRSE4) ;
RSE5N = max(0,RSE5 - CIRSE5) ;

regle 10311:
application : iliad , batch ;
RDRF = max(0 , RFCF + RFMIC - MICFR - (min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS)));
RDRFPS = max(0 , RFCFPS + RFMIC - MICFR - (min(RFDANT,RFDANT1731+0) * positif(ART1731BIS)+RFDANT* (1 - ART1731BIS)));
RDRFAPS = max(0 , RFCFAPS + RFMIC - MICFR - (min(RFDANT,RFDANT1731+0) * positif(ART1731BIS)+RFDANT* (1 - ART1731BIS)));
RDRCM1 =  TRCMABD + DRTNC + RAVC + RCMNAB + RTCAR + RCMPRIVM
		+ RCMIMPAT
		- RCMSOC
                  -  positif(RCMRDS)
		       * min(RCMRDS ,  
			 RCMABD + REVACT
                       + RCMAV + PROVIE
                       + RCMHAD  + DISQUO
                       + RCMHAB + INTERE
		       + RCMTNC + REVPEA
                       + COD2FA )
		       ;
RDRCM1NEG = min(0,RDRCM1);
RDRCM1NEGPLAF  = min(COD2FA,abs(RDRCM1));
RDRCM1BIS = (1-positif(RDRCM1)) * RDRCM1NEGPLAF * (-1)
           + positif_ou_nul(RDRCM1) * RDRCM1;
RDRCM = RDRCM1BIS + COD2FA;
RDRCM1APS =  RCMABD + RCMTNC + RCMAV + RCMHAD + RCMHAB + REGPRIVM
		+ RCMIMPAT
		- RCMSOC
                  -  positif(RCMRDS)
		       * min(RCMRDS ,  
			 RCMABD 
                       + RCMAV 
                       + RCMHAD 
                       + RCMHAB
		       + RCMTNC
                       + COD2FA )
		       ;
RDRCM1NEGAPS = min(0,RDRCM1APS);
RDRCM1NEGPLAFAPS  = min(COD2FA,abs(RDRCM1APS));
RDRCM1BISAPS = (1-positif(RDRCM1APS)) * RDRCM1NEGPLAFAPS * (-1)
           + positif_ou_nul(RDRCM1APS) * RDRCM1APS;
RDRCMAPS = RDRCM1BISAPS + COD2FA;
RDRV = RVBCSG ;
RDRVAPS = arr(RVB1 * TXRVT1 / 100)
         + arr(RVB2 * TXRVT2 / 100)
         + arr(RVB3 * TXRVT3 / 100)
         + arr(RVB4 * TXRVT4 / 100) ;
RDNP = 
   RCSV  
 + RCSC  
 + RCSP
 + max(0,NPLOCNETSF)
   ;

PVTAUXPS = (BPVSJ + BPVSK + BPV18V + BPV18C + BPCOPTV + BPCOPTC + BPV40V + BPV40C + BPCOSAV + BPCOSAC + PEA + PVJEUNENT + GAINPEA
          + PVPART + PVSURSIWG + PVIMPOS + ABPVNOSURSIS) ;
RDNCP = (PVBARPS + PVTAUXPS) * (1 - positif(IPVLOC)) ;
RDPTP = BAF1AV + BAF1AC + BAF1AP
       + BA1AV + BA1AC + BA1AP
       + max(0,MIB1AV - MIBDEV) + max(0,MIB1AC - MIBDEC) + max(0,MIB1AP - MIBDEP)
       + BI1AV + BI1AC + BI1AP
       + max(0,MIBNP1AV - MIBNPDEV) + max(0,MIBNP1AC - MIBNPDEC) + max(0,MIBNP1AP - MIBNPDEP)
       + BI2AV + BI2AC + BI2AP
       + max(0,BNCPRO1AV - BNCPRODEV) + max(0,BNCPRO1AC - BNCPRODEC) + max(0,BNCPRO1AP - BNCPRODEP)
       + BN1AV + BN1AC + BN1AP
       + max(0,BNCNP1AV - BNCNPDEV) + max(0,BNCNP1AC - BNCNPDEC) + max(0,BNCNP1AP - BNCNPDEP)
       + PVINVE + PVINCE + PVINPE
       + PVSOCV + PVSOCC
       ;
RGLOA = GLDGRATV + GLDGRATC;

BCSG = arr(RDRFPS * (1-null(4-V_REGCO))
	  + (COD8XK + COD8YK + RDRV + RDRCM + RDNP + RDNCP + RDPTP + ESFP + R1649 + PREREV)*(1-V_CNR)) * (1 - positif(present(RE168) + present(TAX1649))) 
	 + (RE168 + TAX1649) * (1-V_CNR);
BCSGAPS = arr(RDRFAPS * (1-null(4-V_REGCO))
	  + (RDRVAPS + RDRCMAPS + RDNP + ESFP + R1649 + PREREV)*(1-V_CNR)) * (1 - positif(present(RE168) + present(TAX1649))) 
	 + (RE168 + TAX1649) * (1-V_CNR);

BRSE1 = SALECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSE2 = ALLECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSE3 = INDECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSE4 = PENECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;
BRSE5 = SALECSG * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSETOT = BRSE1 + BRSE2 + BRSE3 + BRSE4 + BRSE5;
regle 10311111:
application : iliad , batch ;
PRSETOT = PRSE1 + PRSE2 + PRSE3 + PRSE4 + PRSE5;
RETRSETOT = RETRSE1 + RETRSE2 + RETRSE3 + RETRSE4 + RETRSE5;
RSEPROVTOT = CSPROVYD + CSPROVYE + CSPROVYF + CSPROVYG + CSPROVYH;
NMAJRSE1TOT = NMAJRSE11 + NMAJRSE21 + NMAJRSE31 + NMAJRSE41 + NMAJRSE51;
NMAJRSE4TOT = NMAJRSE14 + NMAJRSE24 + NMAJRSE34 + NMAJRSE44 + NMAJRSE54;

regle 103111:
application : iliad , batch ;
BDCSG = min ((BCSG) * (1-V_CNR), max( 0, (RDRFPS+RDRV +RDNP+ max(0,RDRCM1) + PVBARPS - IPPNCS)  * (1-V_CNR) ))  
			   * (1 - positif(present(RE168)+present(TAX1649)));
DGLOD = positif(CSREC+V_GLOANT) * arr((BGLOA-(COD8YL/0.075)) * TX051/100) * (1 - positif(present(RE168)+present(TAX1649)))
	  * positif(NAPCR61);
IDGLO = si (V_IND_TRAIT = 4) 
        alors ((arr((BGLOA -(COD8YL/0.075))* TX051 / 100)) * positif(CSREC))

        sinon  
              (abs(DGLOD - V_IDGLOANT))
        finsi ;

regle 103114 :
application :  batch , iliad ;
BDRSE1 = max(0,SALECS-REVCSXA-arr(CSPROVYD/(TX075/100))) * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BDRSE2 = max(0,ALLECS-REVCSXC-arr(CSPROVYF/(TX066/100))) * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BDRSE3 = max(0,INDECS-REVCSXD-arr(CSPROVYG/(TX062/100))) * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BDRSE4 = max(0,PENECS-REVCSXE-arr(CSPROVYH/(TX038/100))) * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;
BDRSE5 = max(0,SALECSG-REVCSXB-arr(CSPROVYE/(TX075/100))) * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;
DRSED = positif(CSREC+V_IDRSEANT) * (arr(BDRSE1 * TXTQDED/100) + arr(BDRSE2 * TXTVDED/100) 
	 + arr(BDRSE3 * TXTWDED/100) + arr(BDRSE4 * TXTXDED/100) + arr(BDRSE5 * TX051/100)) * positif(NAPCR61);

IDRSE = si (V_IND_TRAIT = 4)
	alors (positif(CSREC)*(arr(BDRSE1 * TXTQDED/100) + arr(BDRSE2 * TXTVDED/100) + arr(BDRSE3 * TXTWDED/100) + arr(BDRSE4 * TXTXDED/100) + arr(BDRSE5 * TX051/100)))
	
	sinon
	      (abs(DRSED - V_IDRSEANT))
	finsi ;

regle 1031121 :
application : batch,iliad ;
DCSGD = positif(CSREC+V_IDANT) * (arr(BDCSG * T_IDCSG / 100) - DCSGIM-DCSGIM_A)  * positif(NAPCR61);
IDCSG = si (V_IND_TRAIT = 4) 
        alors ((arr(BDCSG * T_IDCSG / 100)-DCSGIM) * positif(CSREC))
        sinon ( 
               si (CRDEG = 0 et NAPCRP = 0)
                   alors (0)
                   sinon (abs(DCSGD - V_IDANT ))
               finsi )
        finsi ;
regle 10312 :
application : iliad , batch ;
BRDS = arr(RDRFPS * (1-null(4-V_REGCO))
	  + (COD8XK + COD8YK + RDRV + RDRCM + RDNP + RDNCP + RDPTP + RGLOA * (1-V_CNR)
	  + SALECS + SALECSG + ALLECS + INDECS + PENECS + ESFP + R1649 + PREREV)
				  *(1-V_CNR)) * (1 - positif(present(RE168) + present(TAX1649))) 
	 + (RE168 + TAX1649) * (1-V_CNR);
BRDSAPS = arr(RDRFAPS * (1-null(4-V_REGCO))
	  + (RDRVAPS + RDRCMAPS + RDNP + SALECS + SALECSG + ALLECS + INDECS + PENECS + ESFP + R1649 + PREREV)
				  *(1-V_CNR)) * (1 - positif(present(RE168) + present(TAX1649))) 
	 + (RE168 + TAX1649) * (1-V_CNR);

regle 10313 :
application : iliad , batch ;
RDSC = arr( BRDS * T_RDS / 100 ) * (1 - positif(ANNUL2042));
RDSCAPS = arr( BRDSAPS * T_RDS / 100 ) * (1 - positif(ANNUL2042));
regle 103102 :
application : iliad , batch ;
RDSN = RDSC - CIRDS;
RDSNAPS = RDSCAPS - CIRDSAPS;
RDSNAC = RDSCAC - CIRDSAC;
regle 117180:                                                             
application : iliad , batch ;                               
                                                                          
CSRTF = (RDPTP + PVINVE+PVINCE+PVINPE 
         + somme(i=V,C,P:BN1Ai + BI1Ai                          
         + BI2Ai + BA1Ai )) * (1 - positif(IPVLOC)); 
RDRTF = CSRTF  ;                                                          
PSRTF = CSRTF  ;                                                          
regle 119:
application : iliad , batch ;
BASSURV3 = max(0,CESSASSV - LIM_ASSUR3);
BASSURV2 = max(0,CESSASSV - BASSURV3 - LIM_ASSUR2);
BASSURV1 = max(0,CESSASSV - BASSURV3 - BASSURV2 - LIM_ASSUR1);
BASSURC3 = max(0,CESSASSC - LIM_ASSUR3);
BASSURC2 = max(0,(CESSASSC -BASSURC3) - LIM_ASSUR2);
BASSURC1 = max(0,(CESSASSC - BASSURC3 -BASSURC2) - LIM_ASSUR1);
BASSURV = CESSASSV;
BASSURC = CESSASSC;
TAXASSURV = arr(BASSURV1 * TX_ASSUR1/100 + BASSURV2 * TX_ASSUR2/100 + BASSURV3 * TX_ASSUR3/100) * (1 - positif(RE168 + TAX1649));
TAXASSURC = arr(BASSURC1 * TX_ASSUR1/100 + BASSURC2 * TX_ASSUR2/100 + BASSURC3 * TX_ASSUR3/100) * (1 - positif(RE168 + TAX1649));
TAXASSUR = TAXASSURV + TAXASSURC;
regle 1120 :
application : iliad , batch ;

BCVNSAL = (CVNSALAV + CVNSALAC+GLDGRATV+GLDGRATC) * (1-positif(present(TAX1649)+present(RE168)));
B3SVN  = (CVNSALAV + CVNSALAC) * (1-positif(present(TAX1649)+present(RE168)));
CVNSALC = arr( BCVNSAL * TX10 / 100 ) * (1 - positif(ANNUL2042));

BGLOA = (GLDGRATV+GLDGRATC) * (1-V_CNR) * (1-positif(present(TAX1649)+present(RE168)));
CGLOA = arr( BGLOA * TX075 / 100 ) * (1 - positif(ANNUL2042));

BGLOACNR = (GLDGRATV+GLDGRATC) * V_CNR * (1-positif(present(TAX1649)+present(RE168)));

regle 1125 :
application : iliad , batch ;

BCDIS = (GSALV + GSALC) * (1 - V_CNR)* (1-positif(present(TAX1649)+present(RE168))) ;

CDISC = arr(BCDIS * TCDIS / 100) * (1 - positif(ANNUL2042)) ;

CDIS = CDISC ;
