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
regle 821000:
application : iliad , batch ;

RCMRABD = arr(RCMABD * 40/100);

2RCMRABD = arr(REVACT * 40/100);

TRCMRABD = RCMRABD + 2RCMRABD;
RCMRTNC = arr(RCMTNC * 40/100);

2RCMRTNC = arr(REVPEA * 40/100);

TRCMRTNC = RCMRTNC + 2RCMRTNC;
RCMRNABD = max(0,RCMABD - RCMRABD);

2RCMRNABD = max(0,REVACT - 2RCMRABD);
RCMRNTNC = max(0,RCMTNC - RCMRTNC );

2RCMRNTNC = max(0,REVPEA - 2RCMRTNC) ;
REGPRIVM = arr(REGPRIV * MAJREV);

2REGPRIVM = arr(RESTUC * MAJREV);
TRCMABD = RCMABD + REVACT;
RCMAB = RCMRNABD + 2RCMRNABD ;
DRTNC = RCMTNC + REVPEA;
RTNC = RCMRNTNC + 2RCMRNTNC ;
RAVC = RCMAV + PROVIE;
ABRCM2 = min( ABTAV , RAVC);
ABACH  = positif(RCMAV) * arr( ABRCM2 * RCMAV / RAVC );
RCMRNCH = max(0,RCMAV - ABACH);
2ABACH = positif(PROVIE) * min(arr( ABRCM2 * PROVIE / RAVC ) , ABRCM2 - ABAVC);
2RCMRNCH = max(0,PROVIE - 2ABACH);
TRCMRNCH = RCMRNCH + 2RCMRNCH;
RCMNAB = RCMHAD + DISQUO ;
RTCAR = RCMHAB + INTERE;
RCMPRIV = REGPRIV + RESTUC;
RCMPRIVM = REGPRIVM + 2REGPRIVM ;

regle 821010:
application : iliad , batch ;

RCMORDTOT = RCMABD + RCMTNC + RCMAV + RCMHAD + RCMHAB + REGPRIV;
RCMQUOTOT = REVACT + REVPEA + PROVIE + DISQUO + INTERE + RESTUC;
RCMTOT = RCMORDTOT + RCMQUOTOT ;

RCMORDTOTNET = RCMRNABD + RCMRNTNC + RCMRNCH + RCMHAD + RCMHAB + REGPRIVM ;
RCMQUOTOTNET = 2RCMRNABD + 2RCMRNTNC + 2RCMRNCH + DISQUO + INTERE + 2REGPRIVM;
regle 821020:
application : iliad , batch ;

RCMFRORDI = arr(RCMORDTOT*RCMFR / RCMTOT) ;
RCMFRQUOT = max(0,RCMFR - RCMFRORDI) ;

regle 821030:
application : iliad , batch ;

RCMORDNET =  max(0,RCMORDTOTNET - RCMFRORDI);
2RCMFRDC = positif(REVPEA + PROVIE + DISQUO + INTERE + RESTUC) * arr(RCMFRQUOT * REVACT / RCMQUOTOT)
          + (1-positif(REVPEA + PROVIE + DISQUO + INTERE + RESTUC)) * RCMFRQUOT;
2RCMFRFU = positif(PROVIE + DISQUO + INTERE + RESTUC) * arr(RCMFRQUOT * REVPEA / RCMQUOTOT)
          + (1-positif(PROVIE + DISQUO + INTERE + RESTUC)) * max(0,RCMFRQUOT- 2RCMFRDC);
2RCMFRCH = positif(INTERE + DISQUO + RESTUC) * arr(RCMFRQUOT * PROVIE / RCMQUOTOT)
          + (1-positif(INTERE + DISQUO + RESTUC)) * max(0,RCMFRQUOT- 2RCMFRDC-2RCMFRFU);
2RCMFRTR = positif(DISQUO + RESTUC) * arr(RCMFRQUOT * INTERE / RCMQUOTOT)
          + (1-positif(DISQUO + RESTUC)) * max(0,RCMFRQUOT- 2RCMFRDC-2RCMFRFU-2RCMFRCH);
2RCMFRTS = positif(RESTUC) * arr(RCMFRQUOT * DISQUO / RCMQUOTOT)
          + (1-positif(RESTUC)) * max(0,RCMFRQUOT- 2RCMFRDC-2RCMFRFU-2RCMFRCH-2RCMFRTR);
2RCMFRGO = max(0,RCMFRQUOT - 2RCMFRDC-2RCMFRFU-2RCMFRCH-2RCMFRTR-2RCMFRTS);

regle 821040:
application : iliad , batch ;

RCMQNET = max(0,RCMQUOTOTNET - 2RCMFRDC-2RCMFRFU-2RCMFRCH-2RCMFRTR-2RCMFRTS-2RCMFRGO) ;
2RCMDCNET = max(0,2RCMRNABD - 2RCMFRDC) ;
2RCMFUNET = max(0,2RCMRNTNC - 2RCMFRFU) ;
2RCMCHNET = max(0,2RCMRNCH - 2RCMFRCH) ;
2RCMTRNET = max(0,INTERE - 2RCMFRTR) ;
2RCMTSNET = max(0,DISQUO - 2RCMFRTS) ; 
2RCMGONET = max(0,2REGPRIVM - 2RCMFRGO) ;
RCMTOTNET = RCMQNET + RCMORDNET ;

regle 821050:
application : iliad , batch ;

RCMFRTEMP = min(RCMAB + RTNC + TRCMRNCH + RCMNAB + RTCAR + RCMPRIVM,RCMFR) ;

regle 821060:
application : iliad , batch ;

BRCMBIS = RCMAB + RTNC + TRCMRNCH + RCMNAB + RTCAR + RCMPRIVM ;
BRCMBISB = RCMRNABD + RCMRNTNC + RCMHAD + RCMHAB + REGPRIVM + RCMRNCH ;
BRCMBISQ = 2RCMRNABD + 2RCMRNTNC + DISQUO + INTERE + 2REGPRIVM + 2RCMRNCH ;
DEFRCMI = BRCMBISB + BRCMBISQ ;

regle 821070:
application : iliad , batch ;

DEFRCMIMPU = positif(null(PREM8_11)*positif(SOMMERCM_2))
                  * (max(0,RCMFR+REPRCM - max(DEFRCMI1731,max(DEFRCMI_P,DEFRCMIP2))
                                        - max(0,BRCMBISB + BRCMBISQ-DEFRCMIP3)))
           + PREM8_11 * (BRCMBISB + BRCMBISQ) *
                (RCMFR+REPRCM
                        - min(RCMFR,max(DEFRCMIP2,DEFRCMI1731)))
            + 0;

regle 821080:
application : iliad , batch ;

RCMFRART1731 = positif(positif(SOMMERCM_2)*null(PREM8_11) + PREM8_11 * positif(BRCMBISB+BRCMBISQ))
                         *max(0,RCMFR - max(0,DEFRCMIMPU- REPRCM))
               + (1-positif(positif(SOMMERCM_2)*null(PREM8_11) + PREM8_11 * positif(BRCM+BRCMQ))) * RCMFRTEMP;

regle 821090:
application : iliad , batch ;


R2FA = max(0,COD2FA) ;

regle 821100:
application : iliad , batch ;


DFRCMNBIS = min(0,RCMORDTOTNET - RCMFRORDI + RCMQUOTOTNET - 2RCMFRDC-2RCMFRFU-2RCMFRCH-2RCMFRTR-2RCMFRTS-2RCMFRGO) * (-1);
DFRCMN = DFRCMNBIS * null(V_IND_TRAIT-4) + (RCMFR - RCMFRART1731) *  null(V_IND_TRAIT-5);

regle 821110:
application : iliad , batch ;

1RCM_I = si( (V_REGCO + 0) dans (1,3,5,6,7) )
              alors  ((1-positif(DFRCMNBIS)) * RCMORDNET)
              sinon (0)
          finsi;
2RCM_I =  si( (V_REGCO + 0)  dans (1,3,5,6,7))
              alors ((1- positif(DFRCMNBIS)) * 2RCMDCNET)
              sinon (0)
          finsi;
3RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6,7))
             alors  ((1- positif(DFRCMNBIS)) * 2RCMFUNET)
             sinon (0)
         finsi;
4RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6,7))
             alors  ((1- positif(DFRCMNBIS)) * 2RCMCHNET)
             sinon (0)
         finsi;
5RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6,7))
             alors ((1- positif(DFRCMNBIS)) * 2RCMTSNET)
             sinon (0)
         finsi;
6RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6,7))
             alors  ((1- positif(DFRCMNBIS)) * 2RCMGONET)
             sinon (0)
         finsi;
7RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6,7))
             alors  ((1- positif(DFRCMNBIS)) * 2RCMTRNET) 
             sinon (0)
         finsi;

RCM_I = 1RCM_I + 2RCM_I + 3RCM_I + 4RCM_I + 5RCM_I + 6RCM_I + 7RCM_I ;

regle 82014:
application : iliad , batch ;
REPRCM = (DEFRCM + DEFRCM2 + DEFRCM3 + DEFRCM4 + DEFRCM5 + DEFRCM6);
regle 8201402:
application : iliad , batch ;
REPRCMB =  max(0,BRCMBISB + BRCMBISQ - RCMFRTEMP);
regle 8201404:
application : iliad , batch ;
REPRCMBIS = positif(positif(SOMMERCM_2)*null(PREM8_11) + PREM8_11 * positif(BRCMBISB + BRCMBISQ))
           * max(0,REPRCM - DEFRCMIMPU)
            + (1-positif(positif(SOMMERCM_2)*null(PREM8_11) + PREM8_11 * positif(BRCMBISB + BRCMBISQ)))
             * min(REPRCM,REPRCMB) + 0;
REPRCM1 = positif(REPRCMBIS) * arr( (REPRCMBIS * 1RCM_I)/ RCM_I)
        + (1 - positif(REPRCMBIS)) * 0 ;
REPRCM2 = positif(REPRCMBIS) * min(arr((REPRCMBIS * 2RCM_I)/ RCM_I), REPRCMBIS - REPRCM1)
        + (1 - positif(REPRCMBIS)) * 0 ;
REPRCM3 = positif(REPRCMBIS) * min(arr((REPRCMBIS * 3RCM_I)/ RCM_I), REPRCMBIS - REPRCM1 - REPRCM2)
        + (1 - positif(REPRCMBIS)) * 0 ;
REPRCM4 = positif(REPRCMBIS) * min(arr((REPRCMBIS * 4RCM_I)/ RCM_I), REPRCMBIS - REPRCM1 - REPRCM2 - REPRCM3)
        + (1 - positif(REPRCMBIS)) * 0 ;
REPRCM5 = positif(REPRCMBIS) * min(arr((REPRCMBIS * 5RCM_I)/ RCM_I), REPRCMBIS - REPRCM1 - REPRCM2 - REPRCM3 - REPRCM4)
        + (1 - positif(REPRCMBIS)) * 0 ;
REPRCM6 = positif(REPRCMBIS) * min(arr((REPRCMBIS * 6RCM_I)/ RCM_I), REPRCMBIS - REPRCM1 - REPRCM2 - REPRCM3 - REPRCM4 - REPRCM5)
        + (1 - positif(REPRCMBIS)) * 0 ;
REPRCM7 = positif(REPRCMBIS) * max(0,REPRCMBIS - REPRCM1 -REPRCM2 - REPRCM3 - REPRCM4 - REPRCM5  - REPRCM6 )
        + (1 - positif(REPRCMBIS)) * 0 ;
regle 82015:
application : iliad , batch ;
DFRCM5 =   null(4-V_IND_TRAIT) * min(DEFRCM6,REPRCM - REPRCMBIS)
           + null(5-V_IND_TRAIT) * min(DEFRCM6,REPRCM - REPRCMBIS);
regle 821140:
application : iliad , batch ;



DFRCM4 =  null(4-V_IND_TRAIT) * min(DEFRCM5,REPRCM - REPRCMBIS - DFRCM5 )
           + null(5-V_IND_TRAIT) * min(DEFRCM5,REPRCM - REPRCMBIS - DFRCM5 );
regle 821150:
application : iliad , batch ;

DFRCM3 =  null(4-V_IND_TRAIT) * min(DEFRCM4,REPRCM - REPRCMBIS - DFRCM5 - DFRCM4 )
           + null(5-V_IND_TRAIT) * min(DEFRCM4,REPRCM - REPRCMBIS - DFRCM5 - DFRCM4 );
regle 821160:
application : iliad , batch ;

DFRCM2 =  null(4-V_IND_TRAIT) * min(DEFRCM3,REPRCM - REPRCMBIS - DFRCM5 - DFRCM4-DFRCM3)
           + null(5-V_IND_TRAIT) * min(DEFRCM3,REPRCM - REPRCMBIS - DFRCM5 - DFRCM4-DFRCM3);
regle 821170:
application : iliad , batch ;

DFRCM1 =  null(4-V_IND_TRAIT) * min(DEFRCM2,REPRCM-REPRCMBIS-DFRCM5-DFRCM4-DFRCM3-DFRCM2)
           + null(5-V_IND_TRAIT) * min(DEFRCM2,REPRCM-REPRCMBIS-DFRCM5-DFRCM4-DFRCM3-DFRCM2);
regle 821180:
application : iliad , batch ;


RCM = (1-V_CNR) * (
              max(0,(1RCM_I-REPRCM1)) +0);
RCM2FA = COD2FA * (1 - V_CNR); 
2RCM = (1-V_CNR) * (
                max(0,(2RCM_I-REPRCM2)) +0);
3RCM = (1-V_CNR) * (
                max(0,(3RCM_I-REPRCM3)) +0); 
4RCM = (1-V_CNR) * (
                max(0,(4RCM_I-REPRCM4)) +0);
5RCM = (1-V_CNR) * (
                max(0,(5RCM_I-REPRCM5)) +0);
6RCM = (1-V_CNR) * (
                max(0,(6RCM_I-REPRCM6)) +0);
7RCM = (1-V_CNR) * (
                max(0,(7RCM_I-REPRCM7)) +0);

DFRCM = (DFRCMN + DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5) * (1-V_CNR) ;
RCMEXCREF = max(0,TRCMRABD + TRCMRTNC) * (1 - V_CNR) ;

regle 821190:
application : iliad , batch ;


ABTAV = PLAF_RCMAV1 * (1 + BOOL_0AM) ;

regle 821200:
application : iliad , batch ;


BPLIB = (min( RCMLIB, max(0 , ABTAV - RAVC) ) * (1 - V_CNR)) ;

regle 821210:
application : iliad , batch ;


EPAV = arr(BPLIB * TX_PREVLIB/100) ;

regle 821220:
application : iliad , batch ;


VAREPRCM = min(DEFRCM + DEFRCM2 + DEFRCM3 + DEFRCM4 + DEFRCM5 + DEFRCM6,1RCM_I + 2RCM_I +3RCM_I +4RCM_I +5RCM_I +6RCM_I +7RCM_I ) ;

