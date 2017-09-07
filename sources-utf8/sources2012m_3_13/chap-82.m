#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2013 
#au titre des revenus percus en 2012. La présente version a permis la 
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
regle 82000:
application : iliad , batch  ;
RCMRABD = arr(RCMABD * 40/100) * (1-positif(RCMLIBDIV));
	  

2RCMRABD = arr(REVACT * 40/100) * (1-positif(RCMLIBDIV));

TRCMRABD = RCMRABD + 2RCMRABD;
RCMRTNC = arr(RCMTNC * 40/100);

2RCMRTNC = arr(REVPEA * 40/100);

TRCMRTNC = RCMRTNC + 2RCMRTNC;
RCMRNABD = RCMABD - RCMRABD;

2RCMRNABD = REVACT - 2RCMRABD;
RCMRNTNC = RCMTNC - RCMRTNC ;

2RCMRNTNC = REVPEA - 2RCMRTNC ;
REGPRIVM = arr(REGPRIV * MAJREV);

2REGPRIVM = arr(RESTUC * MAJREV);
TRCMABD = RCMABD + REVACT;
RCMAB = RCMRNABD + 2RCMRNABD ;
DRTNC = RCMTNC + REVPEA;
RTNC = RCMRNTNC + 2RCMRNTNC ;
RAVC = RCMAV + PROVIE;
RCMNAB = RCMHAD + DISQUO ;
RTCAR = RCMHAB + INTERE;
RCMPRIV = REGPRIV + RESTUC;
RCMPRIVM = REGPRIVM + 2REGPRIVM ;
regle 82001:
application : iliad , batch ;
FRAN = positif(RCMABD) *
	(positif(REVACT+RCMNAB) * arr(RCMFR * RCMABD / max (1,TRCMABD + RCMNAB))
	+ (1 - positif(REVACT+RCMNAB)) * RCMFR) ;
2FRAN = positif(REVACT) * (
          positif(RCMNAB)* arr(RCMFR * REVACT/ max (1,TRCMABD + RCMNAB) ) + 
          ((1 - positif(RCMNAB)) * (RCMFR - FRAN)));
FRAU = positif(RCMHAD) * (
      positif(DISQUO) * arr(RCMFR * RCMHAD / max (1,TRCMABD + RCMNAB) ) + 
      ((1 - positif(DISQUO)) 
	   * (RCMFR - FRAN - 2FRAN )));
2FRAU = ( RCMFR - FRAN - 2FRAN - FRAU ) * positif(DISQUO);
regle 82002:
application : iliad , batch ;
RAN = (1 - positif(EXFR)) * (RCMRNABD - FRAN)
	+ positif(EXFR) * 0;
2RAN = (1 - positif(EXFR)) * (2RCMRNABD - 2FRAN)
	+ positif(EXFR) * 0;
TRAN = RAN + 2RAN ;
1RAU = (1 - positif(EXFR)) * (RCMHAD - FRAU)
	+ positif(EXFR) * 0;
2RAU = (1 - positif(EXFR)) * (DISQUO - 2FRAU) + positif(EXFR) * 0;
TRAU = 1RAU + 2RAU ;
regle 82003:
application : iliad , batch ;
ABRCM2 = min( ABTAV , RAVC);
regle 82007:
application : iliad , batch ;
ABAVC = positif(RCMAV) * arr( ABRCM2 * RCMAV / RAVC );
2ABAVC = positif(PROVIE) * min(arr( ABRCM2 * PROVIE / RAVC ) , ABRCM2 - ABAVC);
TABAVC = ABAVC + 2ABAVC ;
regle 82008:
application : iliad , batch ;
RNTNC = RTNC ;
RNAVC = RAVC - TABAVC;
regle 82009:
application : iliad , batch ;
EXFR =  max( 0, RCMFR - RCMAB - RCMNAB);
regle 82010:
application : iliad , batch ;
RIA = RAN ;
2RIA = 2RAN ;
RNC = RCMRNTNC ;
2RNC = 2RCMRNTNC ;
RCAV = max ( 0 , RCMAV-ABAVC) ;
2RCAV = max ( 0 , PROVIE-2ABAVC) ;
RAR = max( 0 , RCMHAB);
2RAR = max( 0 , INTERE);
1RAO = max( 0 , REGPRIVM);
2RAO = max( 0 , 2REGPRIVM);
TR1 = RNC + RCAV + 1RAO + RAR;
TR = TR1 + 2RNC + 2RCAV + 2RAR + 2RAO ;
regle 82011:
application : iliad , batch ;
FRG1 = positif(EXFR) * arr( (EXFR * TR1)/ TR)
	+ (1 - positif(EXFR)) * 0 ;
FRG2 = positif(EXFR) * min(arr(EXFR * 2RNC/ TR), EXFR - FRG1)
        + (1 - positif(EXFR)) * 0 ;
FRG3 = positif(EXFR) * min(arr(EXFR * 2RCAV/ TR), EXFR - FRG1 - FRG2)
        + (1 - positif(EXFR)) * 0 ;
FRG4 = positif(EXFR) * min(arr(EXFR * 2RAR/ TR), EXFR - FRG1 - FRG2 - FRG3)
        + (1 - positif(EXFR)) * 0 ;
FRG5 = positif(EXFR) * max(0,EXFR - FRG1 -FRG2 - FRG3 - FRG4)
        + (1 - positif(EXFR)) * 0 ;
regle 82012:
application : iliad , batch ;
DFRCMN = positif(RCMAB + RCMNAB)
	* (1 - positif(RTNC+RAVC+RTCAR+RCMPRIVM))
	* max(0, RCMFR 
			- RCMAB 
			- RCMNAB)

+ (1 - positif(RCMAB + RCMNAB))
	* positif(RTNC+RAVC+RTCAR+RCMPRIVM)
	* max(0, RCMFR 
			- RTNC
			- (RAVC - TABAVC)
			- RTCAR 
			- RCMPRIVM) 
+ positif(RCMAB + RCMNAB)
   * positif(RTNC+RAVC+RTCAR+RCMPRIVM)
   * max(0, RCMFR 
			- RCMAB 
			- RCMNAB
			- RTNC
			- (RAVC - TABAVC)
			- RTCAR 
			- RCMPRIVM) 
+ (1 - positif(RCMAB + RCMNAB))
	* (1 - positif(RTNC+RAVC+RTCAR+RCMPRIVM))
	* max(0, RCMFR)
			;
regle 82013:
application : iliad , batch ;
1RCM_I = si( (V_REGCO + 0) dans (1,3,5,6) )
alors  ((1-positif(DFRCMN)) * (RIA+RNC+1RAU+RAR+1RAO+RCAV-FRG1) -positif(DFRCMN)*0 )
sinon (0)
finsi;

2RCM_I =  si( (V_REGCO + 0)  dans (1,3,5,6))
              alors ((1- positif(DFRCMN)) * 2RIA)
              sinon (0)
          finsi;
3RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6))
             alors  ((1- positif(DFRCMN)) * (2RNC-FRG2))
             sinon (0)
         finsi;
4RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6))
             alors  ((1- positif(DFRCMN)) * (2RCAV-FRG3))
             sinon (0)
         finsi;
5RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6))
             alors ((1- positif(DFRCMN)) * 2RAU)
             sinon (0)
         finsi;
6RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6))
             alors  ((1- positif(DFRCMN)) * (2RAO-FRG5))
             sinon (0)
         finsi;
7RCM_I = si( (V_REGCO + 0)  dans (1,3,5,6))
             alors  ((1- positif(DFRCMN)) * (2RAR-FRG4))
             sinon (0)
         finsi;
RCM_I = 1RCM_I + 2RCM_I + 3RCM_I + 4RCM_I + 5RCM_I + 6RCM_I + 7RCM_I;
regle 82014:
application : iliad , batch ;
REPRCM = DEFRCM + DEFRCM2 + DEFRCM3+DEFRCM4+DEFRCM5+DEFRCM6;
REPRCM1 = positif(REPRCM) * arr( (REPRCM * 1RCM_I)/ RCM_I)
	+ (1 - positif(REPRCM)) * 0 ;
REPRCM2 = positif(REPRCM) * min(arr((REPRCM * 2RCM_I)/ RCM_I), REPRCM - REPRCM1)
        + (1 - positif(REPRCM)) * 0 ;
REPRCM3 = positif(REPRCM) * min(arr((REPRCM * 3RCM_I)/ RCM_I), REPRCM - REPRCM1 - REPRCM2)
        + (1 - positif(REPRCM)) * 0 ;
REPRCM4 = positif(REPRCM) * min(arr((REPRCM * 4RCM_I)/ RCM_I), REPRCM - REPRCM1 - REPRCM2 - REPRCM3)
        + (1 - positif(REPRCM)) * 0 ;
REPRCM5 = positif(REPRCM) * min(arr((REPRCM * 5RCM_I)/ RCM_I), REPRCM - REPRCM1 - REPRCM2 - REPRCM3 - REPRCM4)
        + (1 - positif(REPRCM)) * 0 ;
REPRCM6 = positif(REPRCM) * min(arr((REPRCM * 6RCM_I)/ RCM_I), REPRCM - REPRCM1 - REPRCM2 - REPRCM3 - REPRCM4 - REPRCM5)
        + (1 - positif(REPRCM)) * 0 ;
REPRCM7 = positif(REPRCM) * max(0,REPRCM - REPRCM1 -REPRCM2 - REPRCM3 - REPRCM4 - REPRCM5  - REPRCM6 )
        + (1 - positif(REPRCM)) * 0 ;
regle 82015:
application : iliad , batch ;
DFRCM1 =  DEFRCM2 * positif(DFRCMN)
         + DEFRCM2 * positif(DEFRCM - RCM_I) * (1-positif(DFRCMN))
         + max( 0, DEFRCM2 - (RCM_I-DEFRCM)) * positif_ou_nul(RCM_I-DEFRCM) * (1-positif(DFRCMN));
DFRCM2 =  DEFRCM3 * positif(DFRCMN)
         + DEFRCM3 * positif(DEFRCM+DEFRCM2- RCM_I) * (1-positif(DFRCMN))
         + max( 0, DEFRCM3 - (RCM_I -DEFRCM- DEFRCM2)) * positif_ou_nul(RCM_I -DEFRCM-DEFRCM2) * (1-positif(DFRCMN));
DFRCM3 =  DEFRCM4 * positif(DFRCMN)
         + DEFRCM4 * positif(DEFRCM+DEFRCM2+DEFRCM3- RCM_I) * (1-positif(DFRCMN))
         + max( 0, DEFRCM4 - (RCM_I -DEFRCM- DEFRCM2-DEFRCM3)) * positif_ou_nul(RCM_I -DEFRCM-DEFRCM2-DEFRCM3) * (1-positif(DFRCMN));
DFRCM4 =  DEFRCM5 * positif(DFRCMN)
         + DEFRCM5 * positif(DEFRCM+DEFRCM2+DEFRCM3+DEFRCM4- RCM_I) * (1-positif(DFRCMN))
         + max( 0, DEFRCM5 - (RCM_I -DEFRCM- DEFRCM2-DEFRCM3-DEFRCM4)) 
			   * positif_ou_nul(RCM_I -DEFRCM-DEFRCM2-DEFRCM3-DEFRCM4) * (1-positif(DFRCMN));
DFRCM5 =  DEFRCM6 * positif(DFRCMN)
         + DEFRCM6 * positif(DEFRCM+DEFRCM2+DEFRCM3+DEFRCM4+DEFRCM5- RCM_I) * (1-positif(DFRCMN))
         + max( 0, DEFRCM6 - (RCM_I -DEFRCM- DEFRCM2-DEFRCM3-DEFRCM4-DEFRCM5)) 
			   * positif_ou_nul(RCM_I -DEFRCM-DEFRCM2-DEFRCM3-DEFRCM4-DEFRCM5) * (1-positif(DFRCMN));
regle 82016:
application : iliad , batch ;
RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1-positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(1RCM_I-REPRCM1))
         -positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)*0 
      )
sinon (0)
finsi;
2RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1- positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(2RCM_I-REPRCM2))
      )
sinon (0)
finsi;
3RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1- positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(3RCM_I-REPRCM3))
      )
sinon (0)
finsi;
4RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1- positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(4RCM_I-REPRCM4))
      )
sinon (0)
finsi;
5RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1- positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(5RCM_I-REPRCM5))
      )
sinon (0)
finsi;
6RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1- positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(6RCM_I-REPRCM6))
      )
sinon (0)
finsi;
7RCM = si( (V_REGCO + 0)  dans (1,3,5,6))
alors ( (1- positif(DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5)) * max(0,(7RCM_I-REPRCM7))
      )
sinon (0)
finsi;
DFRCM = DFRCMN + DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5;
RCMEXCREF = max(0,TRCMRABD + TRCMRTNC) * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO)));
regle 82100:
application : iliad , batch ;
ABTAV = PLAF_RCMAV1 * (1 + BOOL_0AM) ;
regle 82105:
application : iliad , batch ;
BPLIB = (min( RCMLIB, max(0 , ABTAV - RAVC) ) * (1 - V_CNR));
regle 82110:
application : iliad , batch ;
EPAV = arr(BPLIB * TX_PREVLIB/100);
