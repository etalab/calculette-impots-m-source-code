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
#                                                                         #####
  ####   #    #    ##    #####      #     #####  #####   ######         #     #
 #    #  #    #   #  #   #    #     #       #    #    #  #                    #
 #       ######  #    #  #    #     #       #    #    #  #####           #####
 #       #    #  ######  #####      #       #    #####   #                    #
 #    #  #    #  #    #  #          #       #    #   #   #              #     #
  ####   #    #  #    #  #          #       #    #    #  ###### #######  #####
 #
 #
 #
 #
 #
 #
 #
 #                       CALCUL DE L'IMPOT NET
 #
 #
 #
 #
 #
 #
regle 301000:
application : bareme , iliad , batch  ;

IRN = min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) * positif( IAMD1 + 1 - SEUIL_61) ;


regle 301010:
application : bareme , iliad , batch ;


IAR = min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) ;

regle 301020:
application : iliad , batch ;

CREREVET =  min(arr((BPTP3 + BPTPD + BPTPG) * TX16/100),arr(CIIMPPRO * TX_CREREVET/100 ))
	  + min(arr(BPTP19 * TX19/100),arr(CIIMPPRO2 * TX19/100 ));

CIIMPPROTOT = CIIMPPRO + CIIMPPRO2 ;

regle 301030:
application : iliad , batch ;

ICI8XFH = min(arr(BPTP18 * TX18/100),arr(COD8XF * TX18/100 ))
      + min(arr(BPTP4I * TX30/100),arr(COD8XG * TX30/100 ))
      + min(arr(BPTP40 * TX41/100),arr(COD8XH * TX41/100 ));
ICI8XV  = min(arr(RCM2FA * TX24/100),arr(COD8XV * TX24/100 )) * (1 - V_CNR);
ICIGLO = min(arr(BPTP18 * TX18/100),arr(COD8XF * TX18/100 ))
      + min(arr(RCM2FA * TX24/100),arr(COD8XV * TX24/100 )) * (1 - V_CNR)
      + min(arr(BPTP4I * TX30/100),arr(COD8XG * TX30/100 ))
      + min(arr(BPTP40 * TX41/100),arr(COD8XH * TX41/100 ));

CIGLOTOT = COD8XF + COD8XG + COD8XH; 
CI8XV = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET,ICI8XV));
CI8XFH = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET-CI8XV,ICI8XFH));
CIGLO = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET,ICIGLO));

regle 301040:
application : iliad , batch ;


ICREREVET = max(0,min(IAD11 + ITP - CIRCMAVFT - IRETS , min(ITP , CREREVET))) ;

regle 301050:
application : iliad , batch , bareme ;

INE = (CIRCMAVFT + IRETS + ICREREVET + CIGLO + CICULTUR + CIGPA + CIDONENTR + CICORSE + CIRECH + CICOMPEMPL)
            * (1-positif(RE168+TAX1649));

IAN = max( 0, (IRB - AVFISCOPTER + ((- CIRCMAVFT
				     - IRETS
                                     - ICREREVET
                                     - CIGLO
                                     - CICULTUR
                                     - CIGPA
                                     - CIDONENTR
                                     - CICORSE
				     - CIRECH 
                                     - CICOMPEMPL)
                                   * (1 - positif(RE168 + TAX1649)))
                  + min(TAXASSUR+0 , max(0,INE-IRB+AVFISCOPTER)) 
                  + min(IPCAPTAXTOT+0 , max(0,INE-IRB+AVFISCOPTER - min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))))
                  + min(TAXLOY+0 ,max(0,INE-IRB+AVFISCOPTER - min(IPCAPTAXTOT+0 , max(0,INE-IRB+AVFISCOPTER - min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))))
										  - min(TAXASSUR+0 , max(0,INE-IRB+AVFISCOPTER))))
	      )
         )
 ;

regle 301060:
application : iliad , batch ;


IRE = (1- positif(RE168+TAX1649+0)) * (
                      CIDIREPARGNE + EPAV + CRICH + CICORSENOW 
                    + CIGE + CIDEVDUR + CITEC
                    +  IPELUS + CICA + CIGARD + CISYND 
                    + CIPRETUD + CIADCRE + CIHABPRIN + CREFAM 
                    + CREAPP +CREAGRIBIO + CREPROSP + CRESINTER 
                    + CREFORMCHENT + CREINTERESSE + CREARTS + CICONGAGRI 
                    + CRERESTAU + CILOYIMP + AUTOVERSLIB
                    + PPEFINAL
                    + CI2CK + CIFORET + CIEXCEDENT
                    + CIHJA
                    + COD8TL * (1 - positif(RE168 + TAX1649))
	                              );

IRE2 = IRE + (BCIGA * (1 - positif(RE168+TAX1649))); 

regle 301065:
application : iliad , batch ;

CIHJA = CODHJA * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;

regle 301070:
application : iliad , batch ;

CRICH =  IPRECH * (1 - positif(RE168+TAX1649));

regle 301080:
application : iliad , batch ;


CIRCMAVFT = max(0,min(IRB + TAXASSUR + IPCAPTAXTOT +TAXLOY - AVFISCOPTER , RCMAVFT * (1 - V_CNR)));

regle 301090:
application : iliad , batch ;


CIEXCEDENT =  arr((COD3VE * TX45/100) + (COD3UV * TX30/100))* (1 - positif(RE168 + TAX1649));

regle 301100:
application : iliad , batch ;
CIDIREPARGNE = DIREPARGNE * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR);
CI2CK = COD2CK * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR);

regle 301110:
application : batch, iliad;


CICA =  arr(BAILOC98 * TX_BAIL / 100) * (1 - positif(RE168 + TAX1649)) ;

regle 301130:
application : iliad , batch ;

IRETS = max(0,min(min(COD8PA,IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT)*present(COD8PA)+(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT)*(1-present(COD8PA)) , (IPSOUR * (1 - positif(RE168+TAX1649))))) ;

regle 301150:
application : iliad , batch ;

BCIAQCUL = arr(CIAQCUL * TX_CIAQCUL / 100);
CICULTUR = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-REI-IRETS-ICREREVET-CIGLO,min(IAD11+ITP+TAXASSUR+TAXLOY +IPCAPTAXTOT+CHRAPRES,BCIAQCUL)));

regle 301160:
application : iliad , batch ;

BCIGA = CRIGA;
CIGPA = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET-CIGLO-CICULTUR,BCIGA));

regle 301170:
application : iliad , batch ;

BCIDONENTR = RDMECENAT * (1-V_CNR) ;
CIDONENTR = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-REI-IRETS-ICREREVET-CIGLO-CICULTUR-CIGPA,BCIDONENTR));

regle 301180:
application : iliad , batch ;

CICORSE = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IPPRICORSE-IRETS-ICREREVET-CIGLO-CICULTUR-CIGPA-CIDONENTR,CIINVCORSE+IPREPCORSE));
CICORSEAVIS = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY-AVFISCOPTER-CIRCMAVFT-IPPRICORSE-IRETS-ICREREVET-CIGLO-CICULTUR-CIGPA-CIDONENTR,CIINVCORSE+IPREPCORSE))+CICORSENOW;
TOTCORSE = CIINVCORSE + IPREPCORSE + CICORSENOW;

regle 301190:
application : iliad , batch ;

CIRECH = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET-CIGLO-CICULTUR-CIGPA-CIDONENTR-CICORSE,IPCHER));

regle 301200:
application : iliad , batch ;

CICOMPEMPL = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET-CIGLO-CICULTUR-CIGPA-CIDONENTR-CICORSE-CIRECH,COD8UW));

DIEMPLOI = (COD8UW + COD8TL) * (1 - positif(RE168+TAX1649)) ;

CIEMPLOI = (CICOMPEMPL + COD8TL) * (1 - positif(RE168+TAX1649)) ;

IRECR = abs(min(0 ,IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-ICREREVET-CIGLO-CICULTUR-CIGPA-CIDONENTR-CICORSE-CIRECH-CICOMPEMPL));

regle 301210:
application : iliad , batch ;
  
REPCORSE = abs(CIINVCORSE+IPREPCORSE-CICORSE) ;
REPRECH = abs(IPCHER - CIRECH) ;
REPCICE = abs(COD8UW - CICOMPEMPL) ;

regle 301220:
application : iliad , batch ;

CICONGAGRI = CRECONGAGRI * (1-V_CNR) ;

regle 301230:
application : iliad , batch ;

BCICAP = min(IPCAPTAXTOT,arr((PRELIBXT - arr(PRELIBXT * TX10/100))*T_PCAPTAX/100));
BCICAPAVIS = max(0,(PRELIBXT - arr(PRELIBXT * TX10/100)));
CICAP = max(0,min(IRB + TAXASSUR + IPCAPTAXTOT +TAXLOY +CHRAPRES - AVFISCOPTER ,min(IPCAPTAXTOT,BCICAP)));

regle 301240:
application : iliad , batch ;

BCICHR = arr(CHRAPRES * (REGCI*(1-present(COD8XY))+COD8XY+0) / (REVKIREHR - TEFFHRC+COD8YJ));
CICHR = max(0,min(IRB + TAXASSUR + IPCAPTAXTOT +TAXLOY +CHRAPRES - AVFISCOPTER-CICAP ,min(CHRAPRES,BCICHR)));

regle 301250:
application : iliad , batch ;

BCOS = max(0 , min(RDSYVO+0,arr(TX_BASECOTSYN/100*
                                   (TSBV - BPCOSAV + EXPRV)*IND_10V))) 
       + max(0 , min(RDSYCJ+0,arr(TX_BASECOTSYN/100*
                                   (TSBC - BPCOSAC + EXPRC)*IND_10C))) 
       + min(RDSYPP+0,arr(TX_BASECOTSYN/100* (somme(i=1..4:TSBi + EXPRi)*IND_10P)))  ;

CISYND = arr(TX_REDCOTSYN/100 * BCOS) * (1 - V_CNR) ;

DSYND = RDSYVO + RDSYCJ + RDSYPP ;

ASYND = BCOS * (1-V_CNR) ;

regle 301260:
application : iliad , batch ;


IAVF = IRE - EPAV + CICORSE + CICULTUR + CIGPA + CIRCMAVFT ;


DIAVF2 = (BCIGA + IPRECH + IPCHER + IPELUS + RCMAVFT + DIREPARGNE + COD3VE + COD3UV) * (1 - positif(RE168+TAX1649)) + CIRCMAVFT * positif(RE168+TAX1649);


IAVF2 = (CIDIREPARGNE + IPRECH + CIRECH + IPELUS + CIRCMAVFT + CIGPA + CIEXCEDENT + 0) * (1 - positif(RE168 + TAX1649))
        + CIRCMAVFT * positif(RE168 + TAX1649) ;

IAVFGP = IAVF2 + CREFAM + CREAPP ;

regle 301270:
application : iliad , batch ;


I2DH = EPAV ;

regle 301280:
application : iliad , batch ;

BTANTGECUM   = (V_BTGECUM * (1 - positif(present(COD7ZZ)+present(COD7ZY)+present(COD7ZX)+present(COD7ZW))) + COD7ZZ+COD7ZY+COD7ZX+COD7ZW);
P2GE = max( (   PLAF_GE2 * (1 + BOOL_0AM)
             + PLAF_GE2_PACQAR * (V_0CH + V_0DP)
             + PLAF_GE2_PAC * (V_0CR + V_0CF + V_0DJ + V_0DN)  
              ) - BTANTGECUM
             , 0
             ) ;
BGEDECL = RDTECH + RDEQPAHA ;
BGEPAHA = min(RDEQPAHA , P2GE) * (1 - V_CNR);
P2GEWL = max(0,PLAF20000);

BGTECH = min(RDTECH , P2GEWL) * (1 - V_CNR) ;
TOTBGE = BGTECH + BGEPAHA ;
RGEPAHA =  (BGEPAHA * TX25 / 100 ) * (1 - V_CNR) ;
RGTECH = (BGTECH * TX40 / 100 ) * (1 - V_CNR) ;
CIGE = arr (RGTECH + RGEPAHA ) * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;
GECUM = min(P2GE,BGEPAHA)+(V_BTGECUM * (1 - positif(present(COD7ZY)+present(COD7ZX)+present(COD7ZW))) + COD7ZW +COD7ZX + COD7ZY);
GECUMWL = max(0,BGTECH ) ;

DAIDC = CREAIDE ;
AAIDC = BADCRE * (1-V_CNR) ;
CIADCRE = arr (BADCRE * TX_AIDOMI /100) * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;

regle 301290:
application : iliad , batch ;

DLOYIMP = LOYIMP ;
ALOYIMP = DLOYIMP;
CILOYIMP = arr(ALOYIMP*TX_LOYIMP/100) * (1 - positif(RE168 + TAX1649)) ;

regle 301300:
application : iliad , batch ;


DDEVDUR = 
   COD7AA  + COD7AD  + COD7AF  + COD7AH  + COD7AK  + COD7AL + COD7AM  
 + COD7AN  + COD7AQ  + COD7AR  + COD7AV  + COD7AX + COD7AY  + COD7AZ  
 + COD7BB  + COD7BC  + COD7BD  + COD7BE + COD7BF  + COD7BH  + COD7BK  + COD7BL
 + CIBOIBAIL  + COD7SA  + CINRJBAIL  + COD7SB  + CRENRJ  + COD7SC  + TRAMURWC  
 + COD7WB  + CINRJ  + COD7RG  + TRATOIVG  + COD7VH      + CIDEP15  + COD7RH  
 + MATISOSI  + COD7RI  + TRAVITWT  + COD7WU  + MATISOSJ + COD7RJ  + VOLISO  
 + COD7RK  + PORENT  + COD7RL  + CHAUBOISN  + COD7RN    + POMPESP  + COD7RP  
 + POMPESR  + COD7RR  + CHAUFSOL  + COD7RS  + POMPESQ   + COD7RQ  + ENERGIEST  
 + COD7RT  + DIAGPERF  + COD7TV  + RESCHAL  + COD7TW    + COD7RV  + COD7RW  + COD7RZ  
 + COD7TA + COD7TB + COD7TC + COD7XB + COD7XC + COD7WH + COD7WI + COD7VI  
 + COD7WV + COD7WW + COD7VK + COD7VL + COD7TN + COD7TP + COD7TR + COD7TS  
 + COD7TQ + COD7TT + COD7TX + COD7TY + COD7RU + COD7SU + COD7RM + COD7SM 
 + COD7RO + COD7SO + COD7SZ
;

PDEVDUR = max( (   PLAF_DEVDUR * (1 + BOOL_0AM)
                  + PLAF_GE2_PACQAR * (V_0CH+V_0DP)
	          + PLAF_GE2_PAC * (V_0CR+V_0CF+V_0DJ+V_0DN) 
		 ) - (V_BTDEVDUR*(1-positif(present(COD7XD)+present(COD7XE)+present(COD7XF)+present(COD7XG)))+COD7XD+COD7XE+COD7XF+COD7XG) , 0 );
DEPENSESN1 = positif(CIBOIBAIL + CINRJBAIL + CRENRJ + CINRJ + CIDEP15 + MATISOSI + MATISOSJ + VOLISO + PORENT
                                          + CHAUBOISN + POMPESP + POMPESR + CHAUFSOL + POMPESQ + ENERGIEST + DIAGPERF + RESCHAL
                                          + TRAMURWC + TRATOIVG + TRAVITWT) * 1
        + 0;
DEPENSESN = positif(COD7TA+COD7TB+COD7XB+COD7WH+COD7WV+COD7TN+COD7TP+COD7TR+COD7TS+COD7TQ+COD7TT) * 1 + 0;

BQTRAV = positif((positif(TRAVITWT)+positif(COD7WU)+positif(COD7WV)) * (positif(TRAMURWC)+positif(COD7WB)+positif(COD7XB))
                +(positif(TRAVITWT)+positif(COD7WU)+positif(COD7WV)) * (positif(TRATOIVG)+positif(COD7VH)+positif(COD7WH))
                +(positif(TRAVITWT)+positif(COD7WU)+positif(COD7WV)) * (positif(CHAUBOISN)+positif(COD7RN)+positif(COD7TN))
                +(positif(TRAVITWT)+positif(COD7WU)+positif(COD7WV)) * (positif(POMPESR)+positif(COD7RR)+positif(CHAUFSOL)+positif(COD7RS)+positif(COD7TR)+positif(COD7TS))
                +(positif(TRAVITWT)+positif(COD7WU)+positif(COD7WV)) * (positif(CIBOIBAIL)+positif(COD7SA)+positif(CINRJBAIL)+positif(COD7SB)
                                                       +positif(POMPESP)+positif(COD7RP)+positif(POMPESQ)+positif(COD7RQ)
                                                       +positif(ENERGIEST)+positif(COD7RT)+positif(COD7TA)+positif(COD7TB)+positif(COD7TP)+positif(COD7TQ)+positif(COD7TT))
                +(positif(TRAMURWC)+positif(COD7WB)+positif(COD7XB)) * (positif(TRATOIVG)+positif(COD7VH)+positif(COD7WH))
                +(positif(TRAMURWC)+positif(COD7WB)+positif(COD7XB)) * (positif(CHAUBOISN)+positif(COD7RN)+positif(COD7TN))
                +(positif(TRAMURWC)+positif(COD7WB)+positif(COD7XB)) * (positif(POMPESR)+positif(COD7RR)+positif(CHAUFSOL)+positif(COD7RS)+positif(COD7TR)+positif(COD7TS))
                +(positif(TRAMURWC)+positif(COD7WB)+positif(COD7XB)) * (positif(CIBOIBAIL)+positif(COD7SA)+positif(CINRJBAIL)+positif(COD7SB)
                                                       +positif(POMPESP)+positif(COD7RP)+positif(POMPESQ)+positif(COD7RQ)
                                                       +positif(ENERGIEST)+positif(COD7RT)+positif(COD7TA)+positif(COD7TB)+positif(COD7TP)+positif(COD7TQ)+positif(COD7TT))
                +(positif(TRATOIVG)+positif(COD7VH)+positif(COD7WH)) * (positif(CHAUBOISN)+positif(COD7RN)+positif(COD7TN))
                +(positif(TRATOIVG)+positif(COD7VH)+positif(COD7WH)) * (positif(POMPESR)+positif(COD7RR)+positif(CHAUFSOL)+positif(COD7RS)+positif(COD7TR)+positif(COD7TS))
                +(positif(TRATOIVG)+positif(COD7VH)+positif(COD7WH)) * (positif(CIBOIBAIL)+positif(COD7SA)+positif(CINRJBAIL)+positif(COD7SB)
                                                       +positif(POMPESP)+positif(COD7RP)+positif(POMPESQ)+positif(COD7RQ)
                                                       +positif(ENERGIEST)+positif(COD7RT)+positif(COD7TA)+positif(COD7TB)+positif(COD7TP)+positif(COD7TQ)+positif(COD7TT))
                +(positif(CHAUBOISN)+positif(COD7RN)+positif(COD7TN)) * (positif(POMPESR)+positif(COD7RR)+positif(CHAUFSOL)+positif(COD7RS)+positif(COD7TR)+positif(COD7TS))
                +(positif(CHAUBOISN)+positif(COD7RN)+positif(COD7TN)) * (positif(CIBOIBAIL)+positif(COD7SA)+positif(CINRJBAIL)+positif(COD7SB)
                                                       +positif(POMPESP)+positif(COD7RP)+positif(POMPESQ)+positif(COD7RQ)
                                                       +positif(ENERGIEST)+positif(COD7RT)+positif(COD7TA)+positif(COD7TB)+positif(COD7TP)+positif(COD7TQ)+positif(COD7TT))
                +(positif(POMPESR)+positif(COD7RR)+positif(CHAUFSOL)+positif(COD7RS)+positif(COD7TR)+positif(COD7TS)) * (positif(CIBOIBAIL)+positif(COD7SA)+positif(CINRJBAIL)+positif(COD7SB)
                                                       +positif(POMPESP)+positif(COD7RP)+positif(POMPESQ)+positif(COD7RQ)
                                                       +positif(ENERGIEST)+positif(COD7RT)+positif(COD7TA)+positif(COD7TB)+positif(COD7TP)+positif(COD7TQ)+positif(COD7TT))
                ) * 1 + 0;

BDEV30 =  min(PDEVDUR,COD7SA  + COD7SB  + COD7SC  + COD7WB  + COD7RG  + COD7VH  + COD7RH  + COD7RI
                      + COD7WU  + COD7RJ  + COD7RK  + COD7RL  + COD7RN  + COD7RP  + COD7RR  + COD7RS
                      + COD7RQ  + COD7RT  + COD7TV  + COD7TW  + COD7RV  + COD7RW  + COD7RZ
                      + COD7RM + COD7RO + COD7TA + COD7TB + COD7TC + COD7XB + COD7XC + COD7WH
                      + COD7WI + COD7VI + COD7WV + COD7WW + COD7VK + COD7VL + COD7TN + COD7TP
                      + COD7TR + COD7TS + COD7TQ + COD7TT + COD7TX + COD7TY + COD7RU + COD7SU
                      + COD7SM + COD7SO + COD7SZ)
              * positif(positif(DEPENSESN1)*positif(DEPENSESN)*positif(BQTRAV))
         + min(PDEVDUR,COD7TA + COD7TB + COD7TC + COD7XB + COD7XC + COD7WH
                       + COD7WI + COD7VI + COD7WV + COD7WW + COD7VK + COD7VL + COD7TN + COD7TP
                       + COD7TR + COD7TS + COD7TQ + COD7TT + COD7TX + COD7TY + COD7RU + COD7SU
                       + COD7SM + COD7SO + COD7SZ)
              * (1-positif(positif(DEPENSESN1)*positif(DEPENSESN)*positif(BQTRAV)))
          + min(PDEVDUR,COD7AA + COD7AD + COD7AF+ COD7AH+ COD7AK+ COD7AL+ COD7AM+ COD7AN+ COD7AQ+ COD7AR+ COD7AV+ COD7AX+ COD7AY+ COD7AZ
                      + COD7BB + COD7BC + COD7BD + COD7BE + COD7BF + COD7BH + COD7BK + COD7BL)
                  ;

BDEV25 =  min(max(0,PDEVDUR-BDEV30),CIBOIBAIL  + CINRJBAIL  + TRAMURWC  + TRATOIVG  + TRAVITWT
                                  + CHAUBOISN  + POMPESP  + POMPESR  + CHAUFSOL  + POMPESQ  + ENERGIEST)
              * positif(positif(DEPENSESN1)*positif(DEPENSESN)*positif(BQTRAV));

BDEV15 =  min(max(0,PDEVDUR-BDEV30-BDEV25),CRENRJ  + CINRJ  + CIDEP15  + MATISOSI  + MATISOSJ
                                         + VOLISO  + PORENT  + DIAGPERF  + RESCHAL)
              * positif(positif(DEPENSESN1)*positif(DEPENSESN)*positif(BQTRAV))
          ;

ADEVDUR = BDEV30 + BDEV25 + BDEV15; 

CIDEVDUR = arr( BDEV30 * TX30/100
               +BDEV25 * TX25/100
               +BDEV15 * TX15/100
      	      )  * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;

DEVDURCUM = ADEVDUR + ((V_BTDEVDUR*(1-positif(present(COD7XD)+present(COD7XE)+present(COD7XF))))+COD7XD+COD7XE+COD7XF);

regle 301310:
application : iliad , batch ;

DTEC = RISKTEC;
ATEC = positif(DTEC) * DTEC;
CITEC = arr (ATEC * TX40/100);

regle 301320:
application : iliad , batch ;

DPRETUD = PRETUD + PRETUDANT ;
APRETUD = max(min(PRETUD,LIM_PRETUD) + min(PRETUDANT,LIM_PRETUD*CASEPRETUD),0) * (1-V_CNR) ;

CIPRETUD = arr(APRETUD*TX_PRETUD/100) * (1 - positif(RE168 + TAX1649)) * (1-V_CNR) ;

regle 301330:
application : iliad , batch ;


EM7 = somme (i=0..7: min (1 , max(0 , V_0Fi + AG_LIMFG - V_ANREV)))
      + (1 - positif(somme(i=0..7:V_0Fi) + 0)) * V_0CF ;

EM7QAR = somme (i=0..5: min (1 , max(0 , V_0Hi + AG_LIMFG - V_ANREV)))
         + somme (j=0..3: min (1 , max(0 , V_0Pj + AG_LIMFG - V_ANREV)))
         + (1 - positif(somme(i=0..5: V_0Hi) + somme(j=0..3: V_0Pj) + 0)) * (V_0CH + V_0DP) ;

BRFG = min(RDGARD1,PLAF_REDGARD) + min(RDGARD2,PLAF_REDGARD)
       + min(RDGARD3,PLAF_REDGARD) + min(RDGARD4,PLAF_REDGARD)
       + min(RDGARD1QAR,PLAF_REDGARDQAR) + min(RDGARD2QAR,PLAF_REDGARDQAR)
       + min(RDGARD3QAR,PLAF_REDGARDQAR) + min(RDGARD4QAR,PLAF_REDGARDQAR)
       ;
RFG = arr ( (BRFG) * TX_REDGARD /100 ) * (1 -V_CNR);
DGARD = somme(i=1..4:RDGARDi)+somme(i=1..4:RDGARDiQAR);
AGARD = (BRFG) * (1-V_CNR) ;
CIGARD = RFG * (1 - positif(RE168 + TAX1649)) ;

regle 301340:
application : iliad , batch ;

PREHAB = PREHABT + PREHABTN + PREHABTN1 + PREHABT1 + PREHABT2 + PREHABTN2 + PREHABTVT ;

BCIHP = max(( PLAFHABPRIN * (1 + BOOL_0AM) * (1+positif(V_0AP+V_0AF+V_0CG+V_0CI+V_0CR))
                 + (PLAFHABPRINENF/2) * (V_0CH + V_0DP)
                 + PLAFHABPRINENF * (V_0CR + V_0CF + V_0DJ + V_0DN)
                  )
             ,0);

BCIHABPRIN1 = min(BCIHP , PREHABT) * (1 - V_CNR) ;
BCIHABPRIN2 = min(max(0,BCIHP-BCIHABPRIN1),PREHABT1) * (1 - V_CNR);
BCIHABPRIN3 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2),PREHABTN) * (1 - V_CNR);
BCIHABPRIN4 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3),PREHABTN1) * (1 - V_CNR);
BCIHABPRIN5 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4),PREHABT2) * (1 - V_CNR);
BCIHABPRIN6 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4-BCIHABPRIN5),PREHABTN2) * (1 - V_CNR);
BCIHABPRIN7 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4-BCIHABPRIN5-BCIHABPRIN6),PREHABTVT) * (1 - V_CNR);

BCIHABPRIN = BCIHABPRIN1 + BCIHABPRIN2 + BCIHABPRIN3 + BCIHABPRIN4 + BCIHABPRIN5 + BCIHABPRIN6 + BCIHABPRIN7 ;

CIHABPRIN = arr((BCIHABPRIN1 * TX40/100)
                + (BCIHABPRIN2 * TX40/100)
                + (BCIHABPRIN3 * TX30/100)
                + (BCIHABPRIN4 * TX25/100)
                + (BCIHABPRIN5 * TX20/100)
                + (BCIHABPRIN6 * TX15/100)
                + (BCIHABPRIN7 * TX10/100))
                * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR);

regle 301350:
application : iliad , batch ;

BDCIFORET  = COD7VP+ COD7TK+REPFOR3+ REPSINFOR5+RDFORESTRA + SINISFORET + COD7UA + COD7UB + RDFORESTGES + COD7UI;
BCIFORETVP = max(0,min(COD7VP,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)))) * (1-V_CNR);
BCIFORETTK = max(0,min(COD7TK,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP))) * (1-V_CNR);
BCIFORETUX = max(0,min(REPFOR3,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP-BCIFORETTK))) * (1-V_CNR);
BCIFORETTJ = max(0,min(REPSINFOR5,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP-BCIFORETTK-BCIFORETUX))) * (1-V_CNR);
BCIFORETUA = max(0,min(COD7UA,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP-BCIFORETTK-BCIFORETUX-BCIFORETTJ))) * (1-V_CNR);
BCIFORETUB = max(0,min(COD7UB,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP-BCIFORETTK-BCIFORETUX-BCIFORETTJ-BCIFORETUA))) * (1-V_CNR);
BCIFORETUP = max(0,min(RDFORESTRA,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP-BCIFORETTK-BCIFORETUX-BCIFORETTJ-BCIFORETUA-BCIFORETUB)) * (1-V_CNR);
BCIFORETUT = max(0,min(SINISFORET,max(0,PLAF_FOREST1 * (1 + BOOL_0AM)-BCIFORETVP-BCIFORETTK-BCIFORETUX-BCIFORETTJ-BCIFORETUA-BCIFORETUB-BCIFORETUP))) * (1-V_CNR);
BCIFORETUI = max(0,min(COD7UI,max(0,PLAF_FOREST2 * (1 + BOOL_0AM))))  * (1-V_CNR);
BCIFORETUQ = max(0,min(RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)-BCIFORETUI)) * (1-V_CNR);
BCIFORET  = BCIFORETUX+BCIFORETTJ+BCIFORETUP + BCIFORETUT+BCIFORETUQ + BCIFORETVP+BCIFORETTK+BCIFORETUA + BCIFORETUB+BCIFORETUI;
CIFORET = arr((BCIFORETUX+BCIFORETTJ+BCIFORETUP + BCIFORETUT+BCIFORETUQ) * TX18/100 + (BCIFORETVP+BCIFORETTK+BCIFORETUA + BCIFORETUB+BCIFORETUI) * TX25/100);

regle 301360:
application : iliad , batch ;

REPCIFAD = (positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5 - PLAF_FOREST1 * (1+ BOOL_0AM)) *  COD7UA
         + (1-positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5- PLAF_FOREST1 * (1+ BOOL_0AM))) * max(0,COD7UA - PLAF_FOREST1 * (1+ BOOL_0AM)-COD7VP-COD7TK-REPFOR3-REPSINFOR5)) * (1-V_CNR);
REPCIFADSIN = (positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5+COD7UA - PLAF_FOREST1 * (1+ BOOL_0AM)) * COD7UB
            + (1-positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5+COD7UA - PLAF_FOREST1 * (1+ BOOL_0AM))) * max(0,COD7UB - (PLAF_FOREST1 * (1+ BOOL_0AM)-COD7VP-COD7TK-REPFOR3-REPSINFOR5-COD7UA))) * (1-V_CNR);
REPCIF = (positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5+COD7UA + COD7UB - PLAF_FOREST1 * (1+ BOOL_0AM)) * RDFORESTRA
            + (1-positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5+COD7UA + COD7UB- PLAF_FOREST1 * (1+ BOOL_0AM))) 
                                                           * max(0,RDFORESTRA - (PLAF_FOREST1 * (1+ BOOL_0AM) - COD7VP-COD7TK-REPFOR3-REPSINFOR5-COD7UA-COD7UB))) * (1-V_CNR);
REPCIFSIN = (positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5+COD7UA + COD7UB +RDFORESTRA- PLAF_FOREST1 * (1+ BOOL_0AM)) * SINISFORET
            + (1-positif_ou_nul(COD7VP+COD7TK+REPFOR3+REPSINFOR5+COD7UA + COD7UB+RDFORESTRA- PLAF_FOREST1 * (1+ BOOL_0AM))) 
                                                           * max(0,SINISFORET - (PLAF_FOREST1 * (1+ BOOL_0AM) - COD7VP-COD7TK-REPFOR3-REPSINFOR5-COD7UA-COD7UB-RDFORESTRA))) * (1-V_CNR);

REPCIFADHSN1 = max(0,COD7VP - PLAF_FOREST1 * (1+ BOOL_0AM)) * (1-V_CNR);
REPCIFADSSN1 = (positif_ou_nul(COD7VP - PLAF_FOREST1 * (1+ BOOL_0AM)) * COD7TK
            + (1-positif_ou_nul(COD7VP - PLAF_FOREST1 * (1+ BOOL_0AM))) * max(0,COD7TK - (PLAF_FOREST1 * (1+ BOOL_0AM) - COD7VP))) * (1-V_CNR);
REPCIFHSN1 = (positif_ou_nul(COD7VP + COD7TK - PLAF_FOREST1 * (1+ BOOL_0AM)) * REPFOR3
            + (1-positif_ou_nul(COD7VP + COD7TK- PLAF_FOREST1 * (1+ BOOL_0AM))) * max(0,REPFOR3 - (PLAF_FOREST1 * (1+ BOOL_0AM) - COD7VP-COD7TK))) * (1-V_CNR);

REPCIFSN1 = (positif_ou_nul(COD7VP+COD7TK+REPFOR3 - PLAF_FOREST1 * (1+ BOOL_0AM)) * REPSINFOR5
            + (1-positif_ou_nul(COD7VP+COD7TK+REPFOR3- PLAF_FOREST1 * (1+ BOOL_0AM))) * max(0,REPSINFOR5 - (PLAF_FOREST1 * (1+ BOOL_0AM) - COD7VP-COD7TK-REPFOR3))) * (1-V_CNR);
regle 301365:
application : iliad , batch ;

REP7UP = REPCIF + REPCIFHSN1;
REP7UA = REPCIFAD + REPCIFADHSN1;
REP7UT = REPCIFSIN + REPCIFSN1;
REP7UB = REPCIFADSIN + REPCIFADSSN1; 
regle 301370:
application : iliad , batch ;

CICSG = min( CSGC , arr( IPPNCS * T_CSG/100 ));

CIRDS = min( RDSC , arr(( IPPNCS + min( REVCSXA , SALECS ) + min( REVCSXB , SALECSG+COD8SC )
                                 + min( REVCSXC , ALLECS ) + min( REVCSXD , INDECS+COD8SW  )
                                 + min( REVCSXE , PENECS + COD8SX ) + min( COD8XI , COD8SA )
                                 + min( COD8XJ , COD8SB)
                         ) * T_RDS/100 ));

CIPRS = min( PRSC , arr( IPPNCS * T_PREL_SOC/100 ));

CICVN = min( CVNSALC , arr( COD8XL * 10/100 )) ;

CIRSE1 = min( RSE1 , arr( REVCSXA * TX075/100 ));

RSE8TV = arr(BRSE8TV * TXTV/100) * (1 - positif(ANNUL2042));
RSE8SA = arr(BRSE8SA * TXTV/100) * (1 - positif(ANNUL2042));
CIRSE8TV = min( RSE8TV , arr( REVCSXC * TX066/100 )) ;
CIRSE8SA = min( RSE8SA , arr(COD8XI * TX066/100 )) ;
CIRSE2 = CIRSE8TV + CIRSE8SA ; 

CIRSE3 = min( RSE3 , arr( REVCSXD * TX062/100 ));

RSE8TX = arr(BRSE8TX * TXTX/100) * (1 - positif(ANNUL2042));
RSE8SB = arr(BRSE8SB * TXTX/100) * (1 - positif(ANNUL2042));
CIRSE8TX = min( RSE8TX , arr( REVCSXE * TX038/100 )) ;
CIRSE8SB = min( RSE8SB , arr( COD8XJ * TX038/100 ));
CIRSE4 = min( RSE4 , arr(( REVCSXE + COD8XJ) * TX038/100 ));

CIRSE5 = min( RSE5 , arr( REVCSXB * TX075/100 ));

CIRSE6 = min( RSE6 , arr(( min( REVCSXB , COD8SC ) +
                           min( REVCSXC , ALLECS ) +
                           min( COD8XI , COD8SA )
                         ) * TXCASA/100 ));

CIRSETOT = CIRSE1 + CIRSE2 + CIRSE3 + CIRSE4 + CIRSE5;

regle 301375:
application : iliad , batch ;

PPE_DATE_DEB = positif(V_0AV+0) * positif(V_0AZ+0) * (V_0AZ+0)
              + positif(DATRETETR+0) * (DATRETETR+0) * null(V_0AZ+0) ;

PPE_DATE_FIN = positif(BOOL_0AM) * positif(V_0AZ+0) * (V_0AZ+0)
              + positif(DATDEPETR+0) * (DATDEPETR+0) * null(V_0AZ+0) ;

PPE_DEBJJMMMM =  PPE_DATE_DEB + (01010000+V_ANREV) * null(PPE_DATE_DEB+0);
PPE_DEBJJMM = arr( (PPE_DEBJJMMMM - V_ANREV)/10000);
PPE_DEBJJ =  inf(PPE_DEBJJMM/100);
PPE_DEBMM =  PPE_DEBJJMM -  (PPE_DEBJJ*100);
PPE_DEBRANG= PPE_DEBJJ
             + (PPE_DEBMM - 1 ) * 30;

PPE_FINJJMMMM =  PPE_DATE_FIN + (30120000+V_ANREV) * null(PPE_DATE_FIN+0);
PPE_FINJJMM = arr( (PPE_FINJJMMMM - V_ANREV)/10000);
PPE_FINJJ =  inf(PPE_FINJJMM/100);
PPE_FINMM =  PPE_FINJJMM -  (PPE_FINJJ*100);
PPE_FINRANG = PPE_FINJJ + (PPE_FINMM - 1 ) * 30
             - 1 * positif (PPE_DATE_FIN);

PPE_DEBUT = PPE_DEBRANG ;
PPE_FIN   = PPE_FINRANG ;

PPENBJ = max(1, arr(min(PPENBJAN , PPE_FIN - PPE_DEBUT + 1))) ;


PPETX1 = PPE_TX1 ;
PPETX2 = PPE_TX2 ;
PPETX3 = PPE_TX3 ;

PPE_BOOL_ACT_COND = positif(

   positif ( TSHALLOV ) + positif ( TSHALLOC ) + positif ( TSHALLO1 ) + positif ( TSHALLO2 ) + positif ( TSHALLO3 ) + positif ( TSHALLO4 )
 + positif ( GLD1V ) + positif ( GLD2V ) + positif ( GLD3V ) + positif ( GLD1C ) + positif ( GLD2C ) + positif ( GLD3C )
 + positif ( BPCOSAV ) + positif ( BPCOSAC ) + positif ( TSASSUV ) + positif ( TSASSUC )
 + positif( CARTSV ) * positif( CARTSNBAV ) + positif( CARTSC ) * positif( CARTSNBAC ) + positif( CARTSP1 ) * positif( CARTSNBAP1 )
 + positif( CARTSP2 ) * positif( CARTSNBAP2 ) + positif( CARTSP3 ) * positif( CARTSNBAP3 ) + positif( CARTSP4 ) * positif( CARTSNBAP4 )
 + positif ( FEXV )
 + positif ( BAFV )
 + positif ( BAFPVV )
 + positif ( BAEXV )
 + positif ( BACREV ) + positif ( 4BACREV )
 + positif  (BACDEV * (1 - positif(ART1731BIS)) )
 + positif ( BAHEXV )
 + positif ( BAHREV ) + positif ( 4BAHREV )
 + positif ( BAHDEV * (1 - positif(ART1731BIS) ))
 + positif ( MIBEXV )
 + positif ( MIBVENV )
 + positif ( MIBPRESV )
 + positif ( MIBPVV )
 + positif ( BICEXV )
 + positif ( BICNOV )
 + positif ( BICDNV * (1 - positif(ART1731BIS) ) )
 + positif ( BIHEXV )
 + positif ( BIHNOV )
 + positif ( BIHDNV * (1 - positif(ART1731BIS) ))
 + positif ( FEXC )
 + positif ( BAFC )
 + positif ( BAFPVC )
 + positif ( BAEXC )
 + positif ( BACREC ) + positif ( 4BACREC )
 + positif (BACDEC * (1 - positif(ART1731BIS) ) )
 + positif ( BAHEXC )
 + positif ( BAHREC ) + positif ( 4BAHREC )
 + positif ( BAHDEC * (1 - positif(ART1731BIS) ) )
 + positif ( MIBEXC )
 + positif ( MIBVENC )
 + positif ( MIBPRESC )
 + positif ( MIBPVC )
 + positif ( BICEXC )
 + positif ( BICNOC )
 + positif ( BICDNC * (1 - positif(ART1731BIS) ) )
 + positif ( BIHEXC )
 + positif ( BIHNOC )
 + positif ( BIHDNC * (1 - positif(ART1731BIS) ))
 + positif ( FEXP )
 + positif ( BAFP )
 + positif ( BAFPVP )
 + positif ( BAEXP )
 + positif ( BACREP ) + positif ( 4BACREP )
 + positif  (BACDEP * (1 - positif(ART1731BIS)))
 + positif ( BAHEXP )
 + positif ( BAHREP ) + positif ( 4BAHREP )
 + positif ( BAHDEP * (1 - positif(ART1731BIS) ))
 + positif ( MIBEXP )
 + positif ( MIBVENP )
 + positif ( MIBPRESP )
 + positif ( BICEXP )
 + positif ( MIBPVP )
 + positif ( BICNOP )
 + positif ( BICDNP * (1 - positif(ART1731BIS) ))
 + positif ( BIHEXP )
 + positif ( BIHNOP )
 + positif ( BIHDNP * (1 - positif(ART1731BIS) ) )
 + positif ( BNCPROEXV )
 + positif ( BNCPROV )
 + positif ( BNCPROPVV )
 + positif ( BNCEXV )
 + positif ( BNCREV )
 + positif ( BNCDEV * (1 - positif(ART1731BIS) ))
 + positif ( BNHEXV )
 + positif ( BNHREV )
 + positif ( BNHDEV * (1 - positif(ART1731BIS) ) )
 + positif ( BNCCRV )
 + positif ( BNCPROEXC )
 + positif ( BNCPROC )
 + positif ( BNCPROPVC )
 + positif ( BNCEXC )
 + positif ( BNCREC )
 + positif ( BNCDEC * (1 - positif(ART1731BIS) ))
 + positif ( BNHEXC )
 + positif ( BNHREC )
 + positif ( BNHDEC * (1 - positif(ART1731BIS)))
 + positif ( BNCCRC )
 + positif ( BNCPROEXP )
 + positif ( BNCPROP )
 + positif ( BNCPROPVP )
 + positif ( BNCEXP )
 + positif ( BNCREP )
 + positif ( BNCDEP * (1 - positif(ART1731BIS) ))
 + positif ( BNHEXP )
 + positif ( BNHREP )
 + positif ( BNHDEP * (1 - positif(ART1731BIS) ) )
 + positif ( BNCCRP )
 + positif ( BIPERPV ) + positif ( BIPERPC ) + positif ( BIPERPP )
 + positif ( BAFORESTV ) + positif ( BAFORESTC ) + positif ( BAFORESTP )
 + positif ( AUTOBICVV ) + positif ( AUTOBICPV ) + positif ( AUTOBNCV )
 + positif ( AUTOBICVC ) + positif ( AUTOBICPC ) + positif ( AUTOBNCC )
 + positif ( AUTOBICVP ) + positif ( AUTOBICPP ) + positif ( AUTOBNCP )
 + positif ( LOCPROCGAV ) + positif ( LOCPROV ) + positif ( LOCDEFPROCGAV * (1 - positif(ART1731BIS) ))
 + positif ( LOCDEFPROV * (1 - positif(ART1731BIS) )) + positif ( LOCPROCGAC ) + positif ( LOCPROC )
 + positif ( LOCDEFPROCGAC * (1 - positif(ART1731BIS) ))
 + positif ( LOCDEFPROC * (1 - positif(ART1731BIS) ))
 + positif ( LOCPROCGAP )
 + positif ( LOCPROP )
 + positif ( LOCDEFPROCGAP * (1 - positif(ART1731BIS) ))
 + positif ( LOCDEFPROP * (1 - positif(ART1731BIS) ))
 + positif ( XHONOAAV ) + positif ( XHONOAAC ) + positif ( XHONOAAP )
 + positif ( XHONOV ) + positif ( XHONOC ) + positif ( XHONOP )
 + positif ( GLDGRATV ) + positif ( GLDGRATC )
 + positif ( CODDAJ ) + positif ( CODEAJ ) + positif ( CODDBJ ) + positif ( CODEBJ )
 + positif ( SALEXTV ) + positif ( SALEXTC )
 + positif ( SALEXT1 ) + positif ( SALEXT2 ) + positif ( SALEXT3 ) + positif ( SALEXT4 )
 + positif ( COD5XT ) + positif( COD5XV ) + positif( COD5XU ) + positif( COD5XW )
);

PPE_BOOL_SIFC   = (1 - BOOL_0AM)*(1 - positif (V_0AV)*positif(V_0AZ)) ;

PPE_BOOL_SIFM   = BOOL_0AM  + positif (V_0AV)*positif(V_0AZ) ;

PPESEUILKIR   = PPE_BOOL_SIFC * PPELIMC
                + PPE_BOOL_SIFM * PPELIMM
                + (NBPT - 1 - PPE_BOOL_SIFM - NBQAR) * 2 * PPELIMPAC
                + NBQAR * PPELIMPAC * 2 ;


PPE_KIRE =  REVKIRE * PPENBJAN / PPENBJ;

PPE_BOOL_KIR_COND =   (1 - null (IND_TDR)) * positif_ou_nul ( PPESEUILKIR - PPE_KIRE);

PPE_BOOL_NADAV = min(1 , positif(TSHALLOV + 0) * null(PPETPV + 0) * null(PPENHV + 0)
                         + positif(SALEXTV + 0) * null(PPETPV + 0) * null(PPEXTV + 0)) ;

PPE_BOOL_NADAC = min(1 , positif(TSHALLOC + 0) * null(PPETPC + 0) * null(PPENHC + 0)
                         + positif(SALEXTC + 0) * null(PPETPC + 0) * null(PPEXTC + 0)) ;

PPE_BOOL_NADA1 = min(1 , positif(TSHALLO1 + 0) * null(PPETPP1 + 0) * null(PPENHP1 + 0)
                         + positif(SALEXT1 + 0) * null(PPETPP1 + 0) * null(PPEXT1 + 0)) ;

PPE_BOOL_NADA2 = min(1 , positif(TSHALLO2 + 0) * null(PPETPP2 + 0) * null(PPENHP2 + 0)
                         + positif(SALEXT2 + 0) * null(PPETPP2 + 0) * null(PPEXT2 + 0)) ;

PPE_BOOL_NADA3 = min(1 , positif(TSHALLO3 + 0) * null(PPETPP3 + 0) * null(PPENHP3 + 0)
                         + positif(SALEXT3 + 0) * null(PPETPP3 + 0) * null(PPEXT3 + 0)) ;

PPE_BOOL_NADA4 = min(1 , positif(TSHALLO4 + 0) * null(PPETPP4 + 0) * null(PPENHP4 + 0)
                         + positif(SALEXT4 + 0) * null(PPETPP4 + 0) * null(PPEXT4 + 0)) ;

PPE_BOOL_NADAU = min(1 , positif(TSHALLO1 + TSHALLO2 + TSHALLO3 + TSHALLO4 + 0)
                           * null(PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4 + 0)
                           * null(PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4 + 0)
                         + positif(SALEXT1 + SALEXT2 + SALEXT3 + SALEXT4 + 0)
                           * null(PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4 + 0)
                           * null(PPEXT1 + PPEXT2 + PPEXT3 + PPEXT4 + 0)) ;

pour i=V,C:
PPENEXOi = null(PPETPi + 0) + positif(TSHALLOi + 0) + positif(SALEXTi + 0) + (4 * positif(PPENHi + 0)) + (8 * positif(PPEXTi + 0)) ;

pour i=1..4:
PPENEXOi = null(PPETPPi + 0) + positif(TSHALLOi + 0) + positif(SALEXTi + 0) + (4 * positif(PPENHPi + 0)) + (8 * positif(PPEXTi + 0)) ;

PPE_SALAVDEFV = TSHALLOV + BPCOSAV + GLD1V + GLD2V + GLD3V
                + TSASSUV + CARTSV * positif(CARTSNBAV)
                + CODDAJ + CODEAJ + SALEXTV
                + GLDGRATV ;

PPE_SALAVDEFC = TSHALLOC + BPCOSAC + GLD1C + GLD2C + GLD3C
                + TSASSUC + CARTSC * positif(CARTSNBAC)
                + CODDBJ + CODEBJ + SALEXTC
                + GLDGRATC ;

PPE_SALAVDEF1 = TSHALLO1 + CARTSP1 * positif(CARTSNBAP1) + SALEXT1 ;
PPE_SALAVDEF2 = TSHALLO2 + CARTSP2 * positif(CARTSNBAP2) + SALEXT2 ;
PPE_SALAVDEF3 = TSHALLO3 + CARTSP3 * positif(CARTSNBAP3) + SALEXT3 ;
PPE_SALAVDEF4 = TSHALLO4 + CARTSP4 * positif(CARTSNBAP4) + SALEXT4 ;

PPE_RPRO1V = FEXV + BAFV + BAEXV + BACREV + 4BACREV - (BACDEV * (1 - positif(ART1731BIS) )) + BAHEXV + BAHREV + 4BAHREV - (BAHDEV * (1 - positif(ART1731BIS) ))
             + BICEXV + BICNOV - (BICDNV * (1 - positif(ART1731BIS) )) + BIHEXV + BIHNOV - (BIHDNV * (1 - positif(ART1731BIS) )) + BNCEXV + BNCREV
             - (BNCDEV * (1 - positif(ART1731BIS) )) + BNHEXV + BNHREV - (BNHDEV * (1 - positif(ART1731BIS) )) + MIBEXV + BNCPROEXV + TMIB_NETVV + TMIB_NETPV
             + TSPENETPV + BAFPVV + MIBPVV + BNCPROPVV + BAFORESTV + LOCPROV + LOCPROCGAV - (LOCDEFPROCGAV * (1 - positif(ART1731BIS) ))
             - (LOCDEFPROV * (1 - positif(ART1731BIS) )) + XHONOAAV + XHONOV + COD5XT + COD5XV ;

PPE_RPRO1C = FEXC + BAFC + BAEXC + BACREC + 4BACREC - (BACDEC * (1 - positif(ART1731BIS) )) + BAHEXC + BAHREC + 4BAHREC - (BAHDEC * (1 - positif(ART1731BIS) ))
             + BICEXC + BICNOC - (BICDNC * (1 - positif(ART1731BIS) )) + BIHEXC + BIHNOC - (BIHDNC * (1 - positif(ART1731BIS) )) + BNCEXC + BNCREC
             - (BNCDEC * (1 - positif(ART1731BIS) )) + BNHEXC + BNHREC - (BNHDEC * (1 - positif(ART1731BIS) )) + MIBEXC + BNCPROEXC + TMIB_NETVC + TMIB_NETPC
             + TSPENETPC + BAFPVC + MIBPVC + BNCPROPVC + BAFORESTC + LOCPROC + LOCPROCGAC - (LOCDEFPROCGAC * (1 - positif(ART1731BIS) ))
             - (LOCDEFPROC * (1 - positif(ART1731BIS) )) + XHONOAAC + XHONOC + COD5XU + COD5XW ;

PPE_RPRO1P = FEXP + BAFP + BAEXP + BACREP + 4BACREP - (BACDEP * (1 - positif(ART1731BIS) )) + BAHEXP + BAHREP + 4BAHREP - (BAHDEP * (1 - positif(ART1731BIS) ))
             + BICEXP + BICNOP - (BICDNP * (1 - positif(ART1731BIS) )) + BIHEXP + BIHNOP - (BIHDNP * (1 - positif(ART1731BIS) )) + BNCEXP + BNCREP
             - (BNCDEP * (1 - positif(ART1731BIS) )) + BNHEXP + BNHREP - (BNHDEP * (1 - positif(ART1731BIS) )) + MIBEXP + BNCPROEXP + TMIB_NETVP + TMIB_NETPP
             + TSPENETPP + BAFPVP + MIBPVP + BNCPROPVP + BAFORESTP + LOCPROP + LOCPROCGAP - (LOCDEFPROCGAP * (1 - positif(ART1731BIS) ))
             - (LOCDEFPROP * (1 - positif(ART1731BIS) )) + XHONOAAP + XHONOP ;

PPE_AVRPRO1V = present(FEXV) + present(BAFV) + present(BAEXV) + present(BACREV) + present(4BACREV)
               + present(BACDEV) + present(BAHEXV) + present(BAHREV) + present(4BAHREV) + present(BAHDEV)
               + present(BICEXV) + present(BICNOV) + present(BICDNV) + present(BIHEXV) + present(BIHNOV)
               + present(BIHDNV) + present(BNCEXV) + present(BNCREV) + present(BNCDEV) + present(BNHEXV)
               + present(BNHREV) + present(BNHDEV) + present(MIBEXV) + present(BNCPROEXV) + present(MIBVENV)
               + present(MIBPRESV) + present(BNCPROV) + present(BAFPVV) + present(MIBPVV) + present(BNCPROPVV)
               + present(BAFORESTV) + present(AUTOBICVV) + present(AUTOBICPV) + present(AUTOBNCV) + present(LOCPROV)
               + present(LOCPROCGAV) + present(LOCDEFPROCGAV) + present(LOCDEFPROV) + present(XHONOAAV) + present(XHONOV) 
               + present(COD5XT) + present(COD5XV) ;

PPE_AVRPRO1C = present(FEXC) + present(BAFC) + present(BAEXC) + present(BACREC) + present(4BACREC)
               + present(BACDEC) + present(BAHEXC) + present(BAHREC) + present(4BAHREC) + present(BAHDEC)
               + present(BICEXC) + present(BICNOC) + present(BICDNC) + present(BIHEXC) + present(BIHNOC)
               + present(BIHDNC) + present(BNCEXC) + present(BNCREC) + present(BNCDEC) + present(BNHEXC)
               + present(BNHREC) + present(BNHDEC) + present(MIBEXC) + present(BNCPROEXC) + present(MIBVENC)
               + present(MIBPRESC) + present(BNCPROC) + present(BAFPVC) + present(MIBPVC) + present(BNCPROPVC)
               + present(BAFORESTC) + present(AUTOBICVC) + present(AUTOBICPC) + present(AUTOBNCC) + present(LOCPROC)
               + present(LOCPROCGAC) + present(LOCDEFPROCGAC) + present(LOCDEFPROC) + present(XHONOAAC) + present(XHONOC) 
               + present(COD5XU) + present(COD5XW) ;

PPE_AVRPRO1P = present(FEXP) + present(BAFP) + present(BAEXP) + present(BACREP) + present(4BACREP)
               + present(BACDEP) + present(BAHEXP) + present(BAHREP) + present(4BAHREP) + present(BAHDEP)
               + present(BICEXP) + present(BICNOP) + present(BICDNP) + present(BIHEXP) + present(BIHNOP)
               + present(BIHDNP) + present(BNCEXP) + present(BNCREP) + present(BNCDEP) + present(BNHEXP)
               + present(BNHREP) + present(BNHDEP) + present(MIBEXP) + present(BNCPROEXP) + present(MIBVENP)
               + present(MIBPRESP) + present(BNCPROP) + present(BAFPVP) + present(MIBPVP) + present(BNCPROPVP)
               + present(BAFORESTP) + present(AUTOBICVP) + present(AUTOBICPP) + present(AUTOBNCP) + present(LOCPROP)
               + present(LOCPROCGAP) + present(LOCDEFPROCGAP) + present(LOCDEFPROP) + present(XHONOAAP) + present(XHONOP) ;

pour i=V,C,P:
PPE_RPROi = positif(PPE_RPRO1i) * arr((1+ PPETXRPRO/100) * PPE_RPRO1i )
           +(1-positif(PPE_RPRO1i)) * arr(PPE_RPRO1i * (1- PPETXRPRO/100));

pour i=V,C:
PPEPEXOi = positif(PPE_AVRPRO1i + 0) + positif(SALEXTi + 0) + (4 * positif(PPENJi + PPEACi + 0)) + (8 * positif(PPEXTi + PPETPi + 0)) ;

pour i=1..4:
PPEPEXOi = positif(PPE_AVRPRO1P + 0) + positif(SALEXTi + 0) + (4 * positif(PPEXTi + PPETPPi + 0)) ;

PPE_BOOL_SEULPAC = null(V_0CF + V_0CR + V_0DJ + V_0DN + V_0CH + V_0DP -1);

PPE_SALAVDEFU = (somme(i=1,2,3,4: PPE_SALAVDEFi))* PPE_BOOL_SEULPAC;

PPE_KIKEKU = 1 * positif(PPE_SALAVDEF1)
           + 2 * positif(PPE_SALAVDEF2)
           + 3 * positif(PPE_SALAVDEF3)
           + 4 * positif(PPE_SALAVDEF4) ;

pour i=V,C:
PPESALi = PPE_SALAVDEFi + PPE_RPROi*(1 - positif(PPE_RPROi)) ;

PPESALU = (PPE_SALAVDEFU + PPE_RPROP*(1 - positif(PPE_RPROP)))
          * PPE_BOOL_SEULPAC;

pour i = 1..4:
PPESALi =  PPE_SALAVDEFi * (1 - PPE_BOOL_SEULPAC) ;

pour i=V,C:
PPE_RTAi = max(0,PPESALi +  PPE_RPROi * positif(PPE_RPROi));

pour i =1..4:
PPE_RTAi = PPESALi;

PPE_RTAU = max(0,PPESALU + PPE_RPROP * positif(PPE_RPROP)) * PPE_BOOL_SEULPAC;
PPE_RTAN = max(0, PPE_RPROP ) * (1 - PPE_BOOL_SEULPAC) ;

pour i=V,C:
PPENBHi = PPENHi + PPEXTi ;

pour i=1..4:
PPENBHi = PPENHPi + PPEXTi ;

pour i=V,C:
PPE_BOOL_TPi = positif
             (
                 positif(PPETPi + 0) * positif(PPE_SALAVDEFi + 0)
               + null(PPENHi + PPEXTi + 0) * null(PPETPi + 0) * positif(PPE_SALAVDEFi)
               + positif(360/PPENBJ * ((PPENHi + PPEXTi) * positif(PPE_SALAVDEFi + 0) /1820
                                                + PPENJi * positif(PPE_AVRPRO1i + 0) /360 ) - 1 )
               + positif_ou_nul((PPENHi + PPEXTi) * positif(PPE_SALAVDEFi + 0) - 1820)
               + positif_ou_nul(PPENJi * positif(PPE_AVRPRO1i + 0) - 360)
               + positif(PPEACi * positif(PPE_AVRPRO1i + 0) + 0)
               + (1 - positif(PPENJi * positif(PPE_AVRPRO1i + 0))) * positif(PPE_AVRPRO1i + 0)
             ) ;

PPE_BOOL_TPU = positif
             (
               (  positif(PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4) * positif(PPE_SALAVDEF1 + PPE_SALAVDEF2 + PPE_SALAVDEF3 + PPE_SALAVDEF4)
               + null(PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4 + PPEXT1 + PPEXT2 + PPEXT3 + PPEXT4 + 0)
                 * null(PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4 + 0)
                 * positif(PPE_SALAVDEF1 + PPE_SALAVDEF2 + PPE_SALAVDEF3 + PPE_SALAVDEF4)
               + positif((360 / PPENBJ * ((PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4 + PPEXT1 + PPEXT2 + PPEXT3 + PPEXT4)
                                           * positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4))/1820
                          + PPENJP * positif(PPE_AVRPRO1P + 0) /360 ) - 1)
               + positif_ou_nul(((PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4 + PPEXT1 + PPEXT2 + PPEXT3 + PPEXT4)
                                 * positif(PPE_SALAVDEF1 + PPE_SALAVDEF2 + PPE_SALAVDEF3 + PPE_SALAVDEF4))-1820)
               + positif_ou_nul(PPENJP * positif(PPE_AVRPRO1P + 0) - 360)
               + positif(PPEACP * positif(PPE_AVRPRO1P + 0))
               + (1 - positif(PPENJP * positif(PPE_AVRPRO1P + 0))) * positif(PPE_AVRPRO1P + 0))
             * PPE_BOOL_SEULPAC
             ) ;

pour i =1,2,3,4:
PPE_BOOL_TPi = positif
             (positif(PPETPPi) * positif(PPE_SALAVDEFi + 0)
              + null(PPENHPi + PPEXTi + 0) * null(PPETPPi + 0)* positif(PPE_SALAVDEFi)
              + positif_ou_nul(360 / PPENBJ * (PPENHPi + PPEXTi) * positif(PPE_SALAVDEFi + 0) - 1820 )
             );

PPE_BOOL_TPN= positif
             (
                positif_ou_nul ( 360 / PPENBJ * PPENJP * positif(PPE_AVRPRO1P + 0) - 360)
              + positif(PPEACP * positif(PPE_AVRPRO1P + 0))
              + (1 - positif(PPENJP * positif(PPE_AVRPRO1P + 0))) * positif(PPE_AVRPRO1P + 0)
             ) ;

pour i =V,C:
PPE_COEFFi = PPE_BOOL_TPi * 360 / PPENBJ
             + (1 - PPE_BOOL_TPi) / ((PPENHi + PPEXTi) * positif(PPE_SALAVDEFi + 0) /1820
                                      + PPENJi * positif(PPE_AVRPRO1i + 0) /360) ;

PPE_COEFFU = PPE_BOOL_TPU * 360 / PPENBJ
             + (1 - PPE_BOOL_TPU) /
               ((PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4 + PPEXT1 + PPEXT2 + PPEXT3 + PPEXT4)/1820
                + PPENJP * positif(PPE_AVRPRO1P + 0) / 360)
               * PPE_BOOL_SEULPAC ;

pour i =1..4:
PPE_COEFFi = PPE_BOOL_TPi * 360 / PPENBJ
             + (1 - PPE_BOOL_TPi) / ((PPENHPi + PPEXTi) * positif(PPE_SALAVDEFi + 0) / 1820) ;

PPE_COEFFN = PPE_BOOL_TPN * 360 / PPENBJ
             + (1 -  PPE_BOOL_TPN) / (PPENJP * positif(PPE_AVRPRO1P + 0) / 360) ;

pour i= V,C,1,2,3,4,U,N:
PPE_RCONTPi = arr (  PPE_RTAi * PPE_COEFFi ) ;

pour i=V,C,U,N,1,2,3,4:
PPE_BOOL_MINi = positif_ou_nul (PPE_RTAi- PPELIMRPB) * (1 - PPE_BOOL_NADAi) ;

INDMONO =  BOOL_0AM
            * (
                   positif_ou_nul(PPE_RTAV  - PPELIMRPB)
                 * positif(PPELIMRPB - PPE_RTAC)
               +
                   positif_ou_nul(PPE_RTAC - PPELIMRPB )
                   *positif(PPELIMRPB - PPE_RTAV)
               );

PPE_HAUTE = PPELIMRPH * (1 - BOOL_0AM)
          + PPELIMRPH * BOOL_0AM * null(INDMONO)
                      * positif_ou_nul(PPE_RCONTPV - PPELIMRPB)
                      * positif_ou_nul(PPE_RCONTPC - PPELIMRPB)
          + PPELIMRPH2 * INDMONO ;

pour i=V,C:
PPE_BOOL_MAXi = positif_ou_nul(PPE_HAUTE - PPE_RCONTPi) ;

pour i=U,N,1,2,3,4:
PPE_BOOL_MAXi = positif_ou_nul(PPELIMRPH - PPE_RCONTPi) ;

pour i = V,C,U,N,1,2,3,4:
PPE_FORMULEi = PPE_BOOL_KIR_COND
               * PPE_BOOL_ACT_COND
               * PPE_BOOL_MINi
               * PPE_BOOL_MAXi
               * arr(positif_ou_nul(PPELIMSMIC - PPE_RCONTPi)
                     * arr(PPE_RCONTPi * PPETX1/100)/PPE_COEFFi
                    +
                        positif(PPE_RCONTPi - PPELIMSMIC)
                      * positif_ou_nul(PPELIMRPH - PPE_RCONTPi )
                      * arr(arr((PPELIMRPH  - PPE_RCONTPi ) * PPETX2 /100)/PPE_COEFFi)
                    +
                      positif(PPE_RCONTPi - PPELIMRPHI)
                      * positif_ou_nul(PPE_HAUTE - PPE_RCONTPi )
                      * arr(arr((PPELIMRPH2 - PPE_RCONTPi ) * PPETX3 /100)/PPE_COEFFi)
                    ) ;

pour i = V,C:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
                 * (null(PPENBJ - 360) * PPE_COEFFi
                    + (1 - null(PPENBJ - 360))
                       * (PPENBJ * 1820/360 /
                           ((PPENHi + PPEXTi) * positif(PPE_SALAVDEFi + 0)
                            + PPENJi * positif(PPE_AVRPRO1i + 0) * 1820/360))
                   ) ;

pour i = U,N:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
                 * (null(PPENBJ - 360) * PPE_COEFFi
                    + (1 - null(PPENBJ - 360))
                       * (PPENBJ * 1820/360 /
                           ((PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4 + PPEXT1 + PPEXT2 + PPEXT3 + PPEXT4)
                            + PPENJP * positif(PPE_AVRPRO1P + 0) * 1820/360))
                   ) ;

pour i = 1,2,3,4:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
                 * (null(PPENBJ - 360) * PPE_COEFFi
                    + (1 - null(PPENBJ - 360))
                       * (PPENBJ * 1820/360 /
                           ((PPENHPi + PPEXTi) * positif(PPE_SALAVDEFi + 0)
                            + PPENJP * positif(PPE_AVRPRO1P + 0) * 1820/360))
                   ) ;

pour i =V,C,U,1,2,3,4,N:
PPENARPRIMEi =   PPE_FORMULEi * ( 1 + PPETXMAJ2)
               * positif_ou_nul(PPE_COEFFCONDi - 2)
               * (1 - PPE_BOOL_TPi)

              +  (arr(PPE_FORMULEi * PPETXMAJ1) + arr(PPE_FORMULEi * (PPE_COEFFi * PPETXMAJ2 )))
               * positif (2 - PPE_COEFFCONDi)
               * positif (PPE_COEFFCONDi  -1 )
               * (1 - PPE_BOOL_TPi)

              + PPE_FORMULEi  * positif(PPE_BOOL_TPi + positif_ou_nul (1 - PPE_COEFFCONDi))  ;

pour i =V,C,U,1,2,3,4,N:
PPEPRIMEi =arr( PPENARPRIMEi) ;

PPEPRIMEPAC = PPEPRIMEU + PPEPRIME1 + PPEPRIME2 + PPEPRIME3 + PPEPRIME4 + PPEPRIMEN ;

PPEPRIMETTEV = PPE_BOOL_KIR_COND *  PPE_BOOL_ACT_COND
               *(
                    ( PPE_PRIMETTE
                      * BOOL_0AM
                      * INDMONO
                      * positif_ou_nul (PPE_RTAV - PPELIMRPB)
                      * positif_ou_nul(PPELIMRPHI - PPE_RCONTPV)
                      * (1 - positif(PPE_BOOL_NADAV))
                     )
                   )
               * ( 1 -  V_CNR) ;

PPEPRIMETTEC = PPE_BOOL_KIR_COND * PPE_BOOL_ACT_COND
                *
                     ( PPE_PRIMETTE
                      * BOOL_0AM
                      * INDMONO
                      * positif_ou_nul(PPELIMRPHI - PPE_RCONTPC)
                      * positif_ou_nul (PPE_RTAC - PPELIMRPB)
                      * (1 - positif(PPE_BOOL_NADAC))
                      )
               * ( 1 -  V_CNR) ;

PPEPRIMETTE = PPEPRIMETTEV + PPEPRIMETTEC ;

BOOLENF = positif(V_0CF + V_0CH + V_0DJ + V_0CR + 0) ;

PPE_NB_PAC = V_0CF + V_0CR + V_0DJ + V_0DN ;
PPE_NB_PAC_QAR = V_0CH + V_0DP ;

TOTPAC = PPE_NB_PAC + PPE_NB_PAC_QAR ;

PPE_NBNONELI = somme(i=1,2,3,4,U,N: positif(PPEPRIMEi))
               + somme(i=1,2,3,4,U,N: positif_ou_nul(PPE_RTAi - PPELIMRPB) * positif(PPE_RCONTPi - PPELIMRPH)) ;

PPE_NBELIGI = PPE_NB_PAC + PPE_NB_PAC_QAR - PPE_NBNONELI ;

PPE_BOOL_BT = V_0BT * positif(2 - V_0AV - BOOLENF) ;

PPE_BOOL_MAJO = (1 - PPE_BOOL_BT)
               * positif (  positif_ou_nul (PPELIMRPH - PPE_RCONTPV)
                           *positif_ou_nul (PPE_RTAV - PPELIMRPB)
                           *(1 - positif(PPE_BOOL_NADAV))
                          +
                            positif_ou_nul (PPELIMRPH - PPE_RCONTPC)
                           *positif_ou_nul (PPE_RTAC - PPELIMRPB)
                           *(1 - positif(PPE_BOOL_NADAC))
                          )
                        ;
PPE_NBMAJO =    positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI)
                 *PPE_NBELIGI
               + (1 - positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI))
               *  PPE_NB_PAC ;
PPE_NBMAJOQAR =    positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI)
                 * 0
               + (1 - positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI))
                 * ( PPE_NBELIGI - PPE_NB_PAC ) ;

PPE_MAJO =   PPE_BOOL_MAJO
           * positif( PPE_NBELIGI )
           * ( PPE_NBMAJO * PPEMONMAJO
             + PPE_NBMAJOQAR * PPEMONMAJO / 2
             );

regle 301376:
application : iliad , batch ;

PPE_BOOL_MONO =  (1 - PPE_BOOL_MAJO )
                *  (1 - PPE_BOOL_MAJOBT)
                * positif( PPE_NB_PAC + PPE_NB_PAC_QAR - PPE_NBNONELI)
                * INDMONO
                *( ( positif( PPE_BOOL_BT + BOOL_0AM )
                    *  positif_ou_nul (PPE_RTAV - PPELIMRPB)
                    *  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPV)
                    *  (1 - positif(PPE_BOOL_NADAV))
                   )
                 + (  positif(  BOOL_0AM )
                    *  positif_ou_nul (PPE_RTAC - PPELIMRPB)
                    *  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPC)
                    *  (1 - positif(PPE_BOOL_NADAC))
                  )
                 );

PPE_MONO = PPE_BOOL_MONO * ( 1 + PPE_BOOL_BT)
          *( positif( PPE_NBMAJO) * PPEMONMAJO
            +
             null( PPE_NBMAJO)*positif(PPE_NBMAJOQAR) * PPEMONMAJO / 2
           )
           ;

regle 301377:
application : iliad , batch ;

PPE_BOOL_MAJOBT = positif (  positif_ou_nul (PPELIMRPH - PPE_RCONTPV)
                            *positif_ou_nul (PPE_RTAV - PPELIMRPB)
                            *(1 - positif(PPE_BOOL_NADAV))
                          )
                * PPE_BOOL_BT;

PPE_MABT =   PPE_BOOL_MAJOBT
           * positif( PPE_NBMAJO)
           * (( PPE_NBMAJO + 1) * PPEMONMAJO
             + PPE_NBMAJOQAR * PPEMONMAJO / 2
             )
         +   PPE_BOOL_MAJOBT
           * null( PPE_NBMAJO + 0)*positif(PPE_NBMAJOQAR)
           * (  positif(PPE_NBMAJOQAR-1) *  PPE_NBMAJOQAR * PPEMONMAJO / 2
                + PPEMONMAJO
             )
          +  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPV)
           * positif_ou_nul (PPE_RTAV - PPELIMRPB)
           * (1 - PPE_BOOL_MAJOBT)
           * (1 - positif(PPE_BOOL_NADAV))
           * PPE_BOOL_BT
           * ( positif( PPE_NB_PAC) * 2 * PPEMONMAJO
             + positif( PPE_NB_PAC_QAR ) * null ( PPE_NB_PAC + 0 ) * PPEMONMAJO
             )
            ;

regle 301378:
application : iliad , batch ;

PPEMAJORETTE = PPE_BOOL_KIR_COND
               * PPE_BOOL_ACT_COND
               * arr ( PPE_MONO + PPE_MAJO + PPE_MABT )
               * ( 1 -  V_CNR) ;

PPETOT = positif ( somme(i=V,C,U,1,2,3,4,N:PPENARPRIMEi)
                   +PPEPRIMETTE
                   +PPEMAJORETTE +0
                   +somme(i=V,C,U,1,2,3,4,N :( 1 - positif(PPELIMRPH - PPE_RCONTPi - 10))
                     *  PPE_BOOL_KIR_COND
                     *  PPE_BOOL_ACT_COND
                     *  PPE_BOOL_MINi
                     *  PPE_BOOL_MAXi)
                   +somme(i=V,C,U,1,2,3,4,N :( 1 - positif(PPELIMRPH2 - PPE_RCONTPi - 10))
                     *  PPE_BOOL_KIR_COND
                     *  PPE_BOOL_ACT_COND
                     *  PPE_BOOL_MINi
                     *  PPE_BOOL_MAXi)
                 )

           * max(0,arr( (somme(i=V,C,U,1,2,3,4,N :PPEPRIMEi)
                                +PPEPRIMETTE
                                +PPEMAJORETTE
                        )
                      )
                )
           * positif_ou_nul(arr( (somme(i=V,C,U,1,2,3,4,N :PPEPRIMEi)
                                +PPEPRIMETTE
                                +PPEMAJORETTE
                                - PPELIMTOT                  ))
                           )
       * (1 - positif(V_PPEISF + PPEISFPIR + PPEREVPRO))
       * (1 - positif(RE168 + TAX1649))
       * (1 - null(7 - PPENEXOV)) * (1 - null(11 - PPENEXOV))
       * (1 - null(7 - PPENEXOC)) * (1 - null(11 - PPENEXOC))
       * (1 - null(7 - PPENEXO1)) * (1 - null(11 - PPENEXO1))
       * (1 - null(7 - PPENEXO2)) * (1 - null(11 - PPENEXO2))
       * (1 - null(7 - PPENEXO3)) * (1 - null(11 - PPENEXO3))
       * (1 - null(7 - PPENEXO4)) * (1 - null(11 - PPENEXO4))
       * (1 - null(2 - PPEPEXOV))
       * (1 - null(2 - PPEPEXOC))
       * (1 - null(2 - PPEPEXO1))
       * (1 - null(2 - PPEPEXO2))
       * (1 - null(2 - PPEPEXO3))
       * (1 - null(2 - PPEPEXO4))
       * (1 - V_CNR) ;

PPETOT2 = PPETOT ;

PPETOTMAY = arr(PPETOT * 88 / 100) * positif_ou_nul(arr(PPETOT * 88 / 100) - PPELIMTOT) * null(7 - V_REGCO) ;


regle 301379:
application : iliad , batch ;


PPENATREST = positif(IRE) * positif(IREST) *
           (
            (1 - V_CNR)  *
            (
             ( null(IRE - PPEFINAL) * 1                                              * 1
             + (1 - positif(PPEFINAL))                                                 * 2
             + null(IRE) * (1 - positif(PPEFINAL))                                     * 3
             + positif(PPEFINAL) * positif(IRE-PPEFINAL)                          * 4
             )
            )
           + 2 * V_CNR
           )
            ;

PPERESTA = positif(PPENATREST) * max(0,min(IREST , PPEFINAL)) ;

PPENATIMPA = positif(PPEFINAL) * (positif(IINET - PPEFINAL - ICREREVET) + positif(PPEFINAL - PPERESTA));

PPEIMPA = positif(PPENATIMPA) * positif_ou_nul(PPERESTA) * (PPEFINAL - PPERESTA) ;

PPENATREST2 = (positif(IREST - V_ANTRE + V_ANTIR) + positif(V_ANTRE - IINET)) * positif(IRE) *
             (
              (1 - V_CNR)  *
               (
                ( null(IRE - PPEFINAL) * 1                                              * 1
                + (1 - positif(PPEFINAL))                                                 * 2
                + null(IRE) * (1 - positif(PPEFINAL))                                     * 3
                + positif(PPEFINAL) * positif(IRE-PPEFINAL)                          * 4
                )
               )
              + 2 * V_CNR
             )
            ;

PPEREST2A = positif(IRE) * positif(IRESTITIR) * max(0,min(PPEFINAL , IRESTITIR)) ; 

PPEIMP2A = positif_ou_nul(PPEREST2A) * (PPEFINAL - PPEREST2A) ;

regle 301380:
application : iliad , batch ;

CRESINTER = PRESINTER ;

regle 301390:
application : iliad , batch ;

REST = positif(IRE) * positif(IRESTITIR) ;

LIBREST = positif(REST) * max(0,min(AUTOVERSLIB , IRESTITIR-PPEFINAL)) ;

LIBIMP = positif_ou_nul(LIBREST) * (AUTOVERSLIB - LIBREST) ;

LOIREST = positif(REST) * max(0,min(CILOYIMP , IRESTITIR-PPEFINAL-AUTOVERSLIB)) ;

LOIIMP = positif_ou_nul(LOIREST) * (CILOYIMP - LOIREST) ;

TAUREST = positif(REST) * max(0,min(CRERESTAU , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP)) ;

TAUIMP = positif_ou_nul(TAUREST) * (CRERESTAU - TAUREST) ;

AGRREST = positif(REST) * max(0,min(CICONGAGRI , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU)) ;

AGRIMP = positif_ou_nul(AGRREST) * (CICONGAGRI - AGRREST) ;

ARTREST = positif(REST) * max(0,min(CREARTS , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI)) ;

ARTIMP = positif_ou_nul(ARTREST) * (CREARTS - ARTREST) ;

INTREST = positif(REST) * max(0,min(CREINTERESSE , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS)) ;

INTIMP = positif_ou_nul(INTREST) * (CREINTERESSE - INTREST) ;

FORREST = positif(REST) * max(0,min(CREFORMCHENT , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE)) ;

FORIMP = positif_ou_nul(FORREST) * (CREFORMCHENT - FORREST) ;

PSIREST = positif(REST) * max(0,min(CRESINTER , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT)) ; 

PSIIMP = positif_ou_nul(PSIREST) * (CRESINTER - PSIREST) ;

PROREST = positif(REST) * max(0,min(CREPROSP , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                               -CRESINTER)) ;

PROIMP = positif_ou_nul(PROREST) * (CREPROSP - PROREST) ;

BIOREST = positif(REST) * max(0,min(CREAGRIBIO , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                                 -CRESINTER-CREPROSP)) ;

BIOIMP = positif_ou_nul(BIOREST) * (CREAGRIBIO - BIOREST) ;

APPREST = positif(REST) * max(0,min(CREAPP , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO)) ;

APPIMP = positif_ou_nul(APPREST) * (CREAPP - APPREST) ;

FAMREST = positif(REST) * max(0,min(CREFAM , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP)) ;

FAMIMP = positif_ou_nul(FAMREST) * (CREFAM - FAMREST) ;

HABREST = positif(REST) * max(0,min(CIHABPRIN , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                                -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM)) ;

HABIMP = positif_ou_nul(HABREST) * (CIHABPRIN - HABREST) ;

ROFREST = positif(REST) * max(0,min(CIFORET , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                              -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN)) ;

ROFIMP = positif_ou_nul(ROFREST) * (CIFORET - ROFREST) ;

SALREST = positif(REST) * max(0,min(CIADCRE , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                              -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET)) ;

SALIMP = positif_ou_nul(SALREST) * (CIADCRE - SALREST) ;

PREREST = positif(REST) * max(0,min(CIPRETUD , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                               -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE)) ;

PREIMP = positif_ou_nul(PREREST) * (CIPRETUD - PREREST) ;

SYNREST = positif(REST) * max(0,min(CISYND , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD)) ;

SYNIMP = positif_ou_nul(SYNREST) * (CISYND - SYNREST) ;

GARREST = positif(REST) * max(0,min(CIGARD , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND)) ;

GARIMP = positif_ou_nul(GARREST) * (CIGARD - GARREST) ;

BAIREST = positif(REST) * max(0,min(CICA , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                           -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD)) ;
 
BAIIMP = positif_ou_nul(BAIREST) * (CICA - BAIREST) ;

ELUREST = positif(REST) * max(0,min(IPELUS , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA)) ;
 
ELUIMP = positif_ou_nul(ELUREST) * (IPELUS - ELUREST) ;

TECREST = positif(REST) * max(0,min(CITEC , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                            -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS)) ;

TECIMP = positif_ou_nul(TECREST) * (CITEC - TECREST) ;

DEPREST = positif(REST) * max(0,min(CIDEVDUR , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                               -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                               -CITEC)) ;

DEPIMP = positif_ou_nul(DEPREST) * (CIDEVDUR - DEPREST) ;

AIDREST = positif(REST) * max(0,min(CIGE , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                           -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                           -CITEC-CIDEVDUR)) ;

AIDIMP = positif_ou_nul(AIDREST) * (CIGE - AIDREST) ;

HJAREST = positif(REST) * max(0,min(CIHJA , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                            -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                            -CITEC-CIDEVDUR-CIGE)) ;

HJAIMP = positif_ou_nul(HJAREST) * (CIHJA - HJAREST) ;

ASSREST = positif(REST) * max(0,min(I2DH , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                           -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                           -CITEC-CIDEVDUR-CIGE-CIHJA)) ;

ASSIMP = positif_ou_nul(ASSREST) * (I2DH - ASSREST) ;

2CKREST = positif(REST) * max(0,min(CI2CK , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                            -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                            -CITEC-CIDEVDUR-CIGE-CIHJA-I2DH)) ;

2CKIMP = positif_ou_nul(2CKREST) * (CI2CK - 2CKREST) ;

EMPREST = positif(REST) * max(0,min(COD8TL , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                             -CITEC-CIDEVDUR-CIGE-CIHJA-I2DH-CI2CK)) ;

EMPIMP = positif_ou_nul(EMPREST) * (COD8TL - EMPREST) ;

EPAREST = positif(REST) * max(0,min(CIDIREPARGNE , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                                   -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                                   -CITEC-CIDEVDUR-CIGE-CIHJA-I2DH-CI2CK-COD8TL)) ;

EPAIMP = positif_ou_nul(EPAREST) * (CIDIREPARGNE - EPAREST) ;


RECREST = positif(REST) * max(0,min(IPRECH , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                             -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                             -CITEC-CIDEVDUR-CIGE-CIHJA-I2DH-CI2CK-COD8TL-CIDIREPARGNE)) ;

RECIMP = positif_ou_nul(RECREST) * (IPRECH - RECREST) ;

EXCREST = positif(REST) * max(0,min(CIEXCEDENT , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                                 -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                                 -CITEC-CIDEVDUR-CIGE-CIHJA-I2DH-CI2CK-COD8TL-CIDIREPARGNE-IPRECH)) ;

EXCIMP = positif_ou_nul(EXCREST) * (CIEXCEDENT - EXCREST) ;

CORREST = positif(REST) * max(0,min(CICORSENOW , IRESTITIR-PPEFINAL-AUTOVERSLIB-CILOYIMP-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE-CREFORMCHENT
                                                 -CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIFORET-CIADCRE-CIPRETUD-CISYND-CIGARD-CICA-IPELUS
                                                 -CITEC-CIDEVDUR-CIGE-CIHJA-I2DH-CI2CK-COD8TL-CIDIREPARGNE-IPRECH-CIEXCEDENT)) ;

CORIMP = positif_ou_nul(CORREST) * (CICORSENOW - CORREST) ;

