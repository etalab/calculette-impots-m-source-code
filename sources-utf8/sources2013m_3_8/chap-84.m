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
regle 801 :
application : iliad , batch  ;
BA1AF =  BAF1AP  + BAF1AC  + BAF1AV  ;
regle 840 :
application : iliad , batch  ;
VARBAHDEV = min(BAHREV + 4BAHREV,BAHDEV);
VARBAHDEC = min(BAHREC + 4BAHREC,BAHDEC);
VARBAHDEP = min(BAHREP + 4BAHREP,BAHDEP);
BARSV = BAHREV + 4BAHREV - (BAHDEV * (1 - positif(ART1731BIS))+ min(BAHDEV,max(BAHDEV_P,BAHDEV1731+0)) * positif(ART1731BIS));
BARSREVV = BAHREV +4BAHREV;
BARSC = BAHREC + 4BAHREC - (BAHDEC * (1 - positif(ART1731BIS))+ min(BAHDEC,max(BAHDEC_P,BAHDEC1731+0)) * positif(ART1731BIS));
BARSREVC = BAHREC +4BAHREC;
BARSP = BAHREP + 4BAHREP - (BAHDEP * (1 - positif(ART1731BIS))+ min(BAHDEP,max(BAHDEP_P,BAHDEP1731+0)) * positif(ART1731BIS));
BARSREVP = BAHREP +4BAHREP;
VARBACDEV = min(BACREV + 4BACREV,BACDEV);
VARBACDEC = min(BACREC + 4BACREC,BACDEC);
VARBACDEP = min(BACREP + 4BACREP,BACDEP);
BARAV = BACREV + 4BACREV - (BACDEV * (1 - positif(ART1731BIS))+ min(BACDEV,max(BACDEV_P,BACDEV1731+0)) * positif(ART1731BIS));
BARREVAV = BACREV + 4BACREV;
BARAC = BACREC  + 4BACREC - (BACDEC * (1 - positif(ART1731BIS))+ min(BACDEC,max(BACDEC_P,BACDEC1731+0)) * positif(ART1731BIS));
BARREVAC = BACREC + 4BACREC;
BARAP = BACREP + 4BACREP -(BACDEP * (1 - positif(ART1731BIS))+ min(BACDEP,max(BACDEP_P,BACDEP1731+0)) * positif(ART1731BIS));
BARREVAP = BACREP + 4BACREP;
regle 841 :
application : iliad  ;
BARSV1731R = BAHREV + 4BAHREV - BAHDEV;
BARSREVV1731R = BAHREV +4BAHREV;
BARSC1731R = BAHREC + 4BAHREC - BAHDEC;
BARSREVC1731R = BAHREC +4BAHREC;
BARSP1731R = BAHREP + 4BAHREP - BAHDEP;
BARSREVP1731R = BAHREP +4BAHREP;
BARAV1731R = BACREV + 4BACREV - BACDEV;
BARREVAV1731R = BACREV + 4BACREV;
BARAC1731R = BACREC  + 4BACREC - BACDEC;
BARREVAC1731R = BACREC + 4BACREC;
BARAP1731R = BACREP + 4BACREP -BACDEP;
regle 8421:
application : iliad , batch  ;
pour i =V,C,P:
DEFBACREi = positif(4BACREi) * arr((((BACDEi * (1 - positif(ART1731BIS)))+ min(BACDEi,max(BACDEi_P,BACDEi1731+0)) * positif(ART1731BIS)) * BACREi) / BARREVAi) 
				   + (1 - positif(4BACREi)) * (BACDEi * (1 - positif(ART1731BIS))+ min(BACDEi,max(BACDEi_P,BACDEi1731+0)) * positif(ART1731BIS)) ;
pour i =V,C,P:
4DEFBACREi = positif(4BACREi) * (((BACDEi * (1 - positif(ART1731BIS)))+ min(BACDEi,max(BACDEi_P,BACDEi1731+0)) * positif(ART1731BIS)) - DEFBACREi);
regle 8422:
application : iliad ;
pour i =V,C,P:
DEFBACREi1731R = positif(4BACREi) * arr((BACDEi * BACREi) / BARREVAi) 
				   + (1 - positif(4BACREi)) * BACDEi ;
pour i =V,C,P:
4DEFBACREi1731R = positif(4BACREi) * (BACDEi  - DEFBACREi1731R);
regle 84211:
application : iliad , batch  ;
BANV = (BACREV - DEFBACREV) * positif_ou_nul(BARAV) + BARAV * (1-positif(BARAV));
BANC = (BACREC - DEFBACREC) * positif_ou_nul(BARAC) + BARAC * (1-positif(BARAC));
BANP = (BACREP - DEFBACREP) * positif_ou_nul(BARAP) + BARAP * (1-positif(BARAP));
BAEV = (4BACREV - 4DEFBACREV) * positif_ou_nul(BARAV) + 0;
BAEC = (4BACREC - 4DEFBACREC) * positif_ou_nul(BARAC) + 0;
BAEP = (4BACREP - 4DEFBACREP) * positif_ou_nul(BARAP) + 0;
regle 84212:
application : iliad , batch  ;
BANV1731R = (BACREV - DEFBACREV1731R) * positif_ou_nul(BARAV1731R) + BARAV1731R * (1-positif(BARAV1731R));
BANC1731R = (BACREC - DEFBACREC1731R) * positif_ou_nul(BARAC1731R) + BARAC1731R * (1-positif(BARAC1731R));
BANP1731R = (BACREP - DEFBACREP1731R) * positif_ou_nul(BARAP1731R) + BARAP1731R * (1-positif(BARAP1731R));
BAEV1731R = (4BACREV - 4DEFBACREV1731R) * positif_ou_nul(BARAV1731R) + 0;
BAEC1731R = (4BACREC - 4DEFBACREC1731R) * positif_ou_nul(BARAC1731R) + 0;
BAEP1731R = (4BACREP - 4DEFBACREP1731R) * positif_ou_nul(BARAP1731R) + 0;
regle 842111:
application : iliad , batch  ;
pour i =V,C,P:
DEFBAHREi = positif(4BAHREi) * arr(((BAHDEi * (1 - positif(ART1731BIS))+ min(BAHDEi,max(BAHDEi_P,BAHDEi1731+0)) * positif(ART1731BIS)) * BAHREi) / BARSREVi) 
						      + (1 - positif(4BAHREi)) * (BAHDEi * (1 - positif(ART1731BIS))+ min(BAHDEi,max(BAHDEi_P,BAHDEi1731+0)) * positif(ART1731BIS)) ;
pour i =V,C,P:
4DEFBAHREi = positif(4BAHREi) * ((BAHDEi * (1 - positif(ART1731BIS) )+ min(BAHDEi,max(BAHDEi_P,BAHDEi1731+0)) * positif(ART1731BIS)) - DEFBAHREi) ;
regle 842112:
application : iliad ;
pour i =V,C,P:
DEFBAHREi1731R = positif(4BAHREi) * arr((BAHDEi * BAHREi) / BARSREVi1731R) 
						      + (1 - positif(4BAHREi)) * BAHDEi ;
pour i =V,C,P:
4DEFBAHREi1731R = positif(4BAHREi) * (BAHDEi  - DEFBAHREi1731R) ;
regle 843:
application : iliad , batch  ;
BAMV = arr((BAHREV - DEFBAHREV) * MAJREV) * positif_ou_nul(BARSV) + BARSV * (1-positif(BARSV));
BAMC = arr((BAHREC - DEFBAHREC) * MAJREV) * positif_ou_nul(BARSC) + BARSC * (1-positif(BARSC));
BAMP = arr((BAHREP - DEFBAHREP) * MAJREV) * positif_ou_nul(BARSP) + BARSP * (1-positif(BARSP));
BAEMV = (arr((4BAHREV - 4DEFBAHREV)* MAJREV)) * positif_ou_nul(BARSV) + 0;
BAEMC = (arr((4BAHREC - 4DEFBAHREC)* MAJREV)) * positif_ou_nul(BARSC) + 0;
BAEMP = (arr((4BAHREP - 4DEFBAHREP)* MAJREV)) * positif_ou_nul(BARSP) + 0;
regle 8431:
application : iliad  ;
BAMV1731R = arr((BAHREV - DEFBAHREV1731R) * MAJREV) * positif_ou_nul(BARSV1731R) + BARSV1731R * (1-positif(BARSV1731R));
BAMC1731R = arr((BAHREC - DEFBAHREC1731R) * MAJREV) * positif_ou_nul(BARSC1731R) + BARSC1731R * (1-positif(BARSC1731R));
BAMP1731R = arr((BAHREP - DEFBAHREP1731R) * MAJREV) * positif_ou_nul(BARSP1731R) + BARSP1731R * (1-positif(BARSP1731R));
BAEMV1731R = (arr((4BAHREV - 4DEFBAHREV1731R)* MAJREV)) * positif_ou_nul(BARSV1731R) + 0;
BAEMC1731R = (arr((4BAHREC - 4DEFBAHREC1731R)* MAJREV)) * positif_ou_nul(BARSC1731R) + 0;
BAEMP1731R = (arr((4BAHREP - 4DEFBAHREP1731R)* MAJREV)) * positif_ou_nul(BARSP1731R) + 0;
regle 844:
application : iliad , batch  ;
BAFORV = arr(BAFV*MAJREV)+BAFORESTV+BAFPVV;
BAFORC = arr(BAFC*MAJREV)+BAFORESTC+BAFPVC;
BAFORP = arr(BAFP*MAJREV)+BAFORESTP+BAFPVP;
regle 8441:
application : iliad , batch  ;
BAHQV = BANV + BAMV + BAFORV;
BAHQC = BANC + BAMC + BAFORC;
BAHQP = BANP + BAMP + BAFORP;
regle 84411:
application : iliad ;
BAHQV1731R = BANV1731R + BAMV1731R + BAFORV;
BAHQC1731R = BANC1731R + BAMC1731R + BAFORC;
BAHQP1731R = BANP1731R + BAMP1731R + BAFORP;
regle 845:
application : iliad , batch  ;
4BAQV = max(0,(4BACREV - 4DEFBACREV))*positif_ou_nul(BARAV)+arr(max(0,(4BAHREV - 4DEFBAHREV))*MAJREV) * positif_ou_nul(BARSV);
4BAQC = max(0,(4BACREC - 4DEFBACREC))*positif_ou_nul(BARAC)+arr(max(0,(4BAHREC - 4DEFBAHREC))*MAJREV) * positif_ou_nul(BARSC);
4BAQP = max(0,(4BACREP - 4DEFBACREP))*positif_ou_nul(BARAP)+arr(max(0,(4BAHREP - 4DEFBAHREP))*MAJREV) * positif_ou_nul(BARSP);
regle 84511:
application : iliad ;
4BAQV1731R = max(0,(4BACREV - 4DEFBACREV1731R))*positif_ou_nul(BARAV1731R)+arr(max(0,(4BAHREV - 4DEFBAHREV1731R))*MAJREV) * positif_ou_nul(BARSV1731R);
4BAQC1731R = max(0,(4BACREC - 4DEFBACREC1731R))*positif_ou_nul(BARAC1731R)+arr(max(0,(4BAHREC - 4DEFBAHREC1731R))*MAJREV) * positif_ou_nul(BARSC1731R);
4BAQP1731R = max(0,(4BACREP - 4DEFBACREP1731R))*positif_ou_nul(BARAP1731R)+arr(max(0,(4BAHREP - 4DEFBAHREP1731R))*MAJREV) * positif_ou_nul(BARSP1731R);
regle 8451:
application : iliad , batch  ;
BAQV = BAEV + BAEMV;
BAQC = BAEC + BAEMC;
BAQP = BAEP + BAEMP;
regle 8455:
application : iliad , batch  ;
BAQV1731R = BAEV1731R + BAEMV1731R;
BAQC1731R = BAEC1731R + BAEMC1731R;
BAQP1731R = BAEP1731R + BAEMP1731R;
regle 84551:
application : iliad , batch  ;
BA1V = BA1AV + BAF1AV ;
BA1C = BA1AC + BAF1AC ;
BA1P = BA1AP + BAF1AP ;
regle 84552:
application : iliad , batch  ;
BAHQT=BAHQV+BAHQC+BAHQP;
TOTDAGRI = null(4-V_IND_TRAIT) * (DAGRI6 +DAGRI5 +DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1) * (1-ART1731BIS)
	 + null(5-V_IND_TRAIT) * max(0,min(DAGRI6 +DAGRI5 +DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1,TOTDAGRI1731*ART1731BIS
				  + (DAGRI6 +DAGRI5 +DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1) * (1-ART1731BIS)));
BAHQTOT=BAHQV+BAHQC+BAHQP-TOTDAGRI;
BAHQTOTMAXP=positif_ou_nul(BAHQT) * max(0,BAHQV+BAHQC+BAHQP-TOTDAGRI);
BAHQTOTMAXN=positif_ou_nul(BAHQT) * min(0,BAHQV+BAHQC+BAHQP-TOTDAGRI);
BAHQTOTMIN=positif(-BAHQT) * BAHQT;
regle 845525:
application : iliad ;
BAHQT1731R=BAHQV1731R+BAHQC1731R+BAHQP1731R;
TOTDAGRI1731R = null(4-V_IND_TRAIT) * (DAGRI6 +DAGRI5 +DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1)
	 + null(5-V_IND_TRAIT) * max(0,min(DAGRI6 +DAGRI5 +DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1,TOTDAGRI1731*ART1731BIS
				  + (DAGRI6 +DAGRI5 +DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1) * (1-ART1731BIS)));
BAHQTOT1731R=BAHQV1731R+BAHQC1731R+BAHQP1731R-TOTDAGRI1731R;
BAHQTOTMAXP1731R=positif_ou_nul(BAHQT1731R) * max(0,BAHQV1731R+BAHQC1731R+BAHQP1731R-TOTDAGRI1731R);
BAHQTOTMAXN1731R=positif_ou_nul(BAHQT1731R) * min(0,BAHQV1731R+BAHQC1731R+BAHQP1731R-TOTDAGRI1731R);
BAHQTOTMIN1731R=positif(-BAHQT1731R) * BAHQT1731R;
regle 84513:
application : iliad , batch  ;
BAQT = BAQV + BAQC + BAQP;
BAQTOT = max(0,BAQV + BAQC + BAQP + BAHQTOTMAXN);
BAQTOTN = min(0,BAQV + BAQC + BAQP + BAHQTOTMAXN);
BAQTOTMIN = min(0,BAQV + BAQC + BAQP + BAHQTOTMIN);
BAQTOTAV = positif_ou_nul(BAQT + BAHQT) * BAQTOT + (1 - positif(BAQT + BAHQT)) * 0;
4BAQTOT = somme(x=V,C,P: 4BAQx) ;
4BAQTOTNET = positif(4BAQTOT) * max(0, 4BAQTOT + (BAHQTOTMIN + BAHQTOTMAXN) );
regle 845135:
application : iliad  ;
BAQT1731R = BAQV1731R + BAQC1731R + BAQP1731R;
BAQTOT1731R = max(0,BAQV1731R + BAQC1731R + BAQP1731R + BAHQTOTMAXN1731R);
BAQTOTN1731R = min(0,BAQV1731R + BAQC1731R + BAQP1731R + BAHQTOTMAXN1731R);
BAQTOTMIN1731R = min(0,BAQV1731R + BAQC1731R + BAQP1731R + BAHQTOTMIN1731R);
BAQTOTAV1731R = positif_ou_nul(BAQT1731R + BAHQT1731R) * BAQTOT1731R + (1 - positif(BAQT1731R + BAHQT1731R)) * 0;
4BAQTOT1731R = somme(x=V,C,P: 4BAQx1731R) ;
4BAQTOTNET1731R = positif(4BAQTOT1731R) * max(0, 4BAQTOT1731R + (BAHQTOTMIN1731R + BAHQTOTMAXN1731R) );
regle 845111:
application : iliad , batch  ;
BA1 = BA1V + BA1C + BA1P; 
regle 846:
application : iliad , batch  ;
BANOR = BAHQTOTMAXP + BAQTOTMIN;
regle 8461:
application : iliad  ;
BANOR1731R = BAHQTOTMAXP1731R + BAQTOTMIN1731R;

regle 847:
application : iliad , batch  ;
DEFBA6 = ((1-positif(BAHQT+BAQT)) * (DAGRI5)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6,0)-DAGRI5,DAGRI5))
                 * positif_ou_nul(DAGRI5-max(BAHQT+BAQT-DAGRI6,0))
                 * (1 - positif(IPVLOC)))
                 * (1-positif(ART1731BIS))
                 + (min(DAGRI5,DEFBA61731) *positif_ou_nul(DEFBA61731) + DAGRI5 * (1-positif_ou_nul(DEFBA61731))) * positif(ART1731BIS)
                          ;
DEFBA5 = ((1-positif(BAHQT+BAQT)) * (DAGRI4)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5,0)-DAGRI4,DAGRI4))
                 * positif_ou_nul(DAGRI4-max(BAHQT+BAQT-DAGRI6-DAGRI5,0))
                 * (1 - positif(IPVLOC)))
                 * (1-positif(ART1731BIS))
                 + (min(DAGRI4,DEFBA51731) *positif_ou_nul(DEFBA51731) + DAGRI4 * (1-positif_ou_nul(DEFBA51731))) * positif(ART1731BIS)
                          ;
DEFBA4 = ((1-positif(BAHQT+BAQT)) * (DAGRI3)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0)-DAGRI3,DAGRI3))
                 * positif_ou_nul(DAGRI3-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0))
                 * (1 - positif(IPVLOC)))
                 * (1-positif(ART1731BIS))
                 + (min(DAGRI3,DEFBA41731) *positif_ou_nul(DEFBA41731) + DAGRI3 * (1-positif_ou_nul(DEFBA41731))) * positif(ART1731BIS)
                          ;
DEFBA3 = ((1-positif(BAHQT+BAQT)) * (DAGRI2)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0)-DAGRI2,DAGRI2))
                 * positif_ou_nul(DAGRI2-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0))
                 * (1 - positif(IPVLOC)))
                 * (1-positif(ART1731BIS))
                 + (min(DAGRI2,DEFBA31731) *positif_ou_nul(DEFBA31731) + DAGRI2 * (1-positif_ou_nul(DEFBA31731))) * positif(ART1731BIS)
                           ;
DEFBA2 = ((1-positif(BAHQT+BAQT)) * (DAGRI1)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0)-DAGRI1,DAGRI1))
                 * positif_ou_nul(DAGRI1-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0))
                 * (1 - positif(IPVLOC)))
                 * (1-positif(ART1731BIS))
                 + (min(DAGRI1,DEFBA21731) *positif_ou_nul(DEFBA21731) + DAGRI1 * (1-positif_ou_nul(DEFBA21731))) * positif(ART1731BIS)
                            ;
DEFBA1 = ((1-positif(BAHQT+BAQT)) * (abs(BAHQT+BAQT)-abs(DEFIBA))
                 + positif(BAHQT+BAQT) *
                 positif_ou_nul(DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1-BAHQT-BAQT)
                 * (DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1-BAHQT-BAQT)
                 * null(DEFBA2+DEFBA3+DEFBA4+DEFBA5+DEFBA6)
                 * (1 - positif(IPVLOC)))
                 * (1-positif(ART1731BIS))
                 + ((BACDEV-min(BACDEV,max(BACDEV_P,BACDEV1731+0))
                   +BACDEC-min(BACDEC,max(BACDEC_P,BACDEC1731+0))
                   +BACDEP-min(BACDEP,max(BACDEP_P,BACDEP1731+0))
                   +BAHDEV-min(BAHDEV,max(BAHDEV_P,BAHDEV1731+0))
                   +BAHDEC-min(BAHDEC,max(BAHDEC_P,BAHDEC1731+0))
                   +BAHDEP-min(BAHDEP,max(BAHDEP_P,BAHDEP1731+0))) * positif_ou_nul(DEFBA11731)
                    + (BACDEV +BACDEC +BACDEP +BAHDEV +BAHDEC +BAHDEP) * (1-positif_ou_nul(DEFBA11731)))
                    * positif(SHBA+(REVTP-BA1) +REVQTOTQHT - SEUIL_IMPDEFBA)
                           * (1 - positif(IPVLOC)) * positif(ART1731BIS)
                               ;
regle 848:
application : iliad , batch  ;
DEFIBAANT = positif_ou_nul(BAQT+BAHQTOT-(min(DAGRI1,DAGRI11731+0) * positif(ART1731BIS) + DAGRI1 * (1 - ART1731BIS))
				       -(min(DAGRI2,DAGRI21731+0) * positif(ART1731BIS) + DAGRI2 * (1 - ART1731BIS))
				       -(min(DAGRI3,DAGRI31731+0) * positif(ART1731BIS) + DAGRI3 * (1 - ART1731BIS))
				       -(min(DAGRI4,DAGRI41731+0) * positif(ART1731BIS) + DAGRI4 * (1 - ART1731BIS))
				       -(min(DAGRI5,DAGRI51731+0) * positif(ART1731BIS) + DAGRI5 * (1 - ART1731BIS))
				       -(min(DAGRI6,DAGRI61731+0) * positif(ART1731BIS) + DAGRI6 * (1 - ART1731BIS)))
            * ((min(DAGRI1,DAGRI11731+0) * positif(ART1731BIS) + DAGRI1 * (1 - ART1731BIS))
	    -(min(DAGRI2,DAGRI21731+0) * positif(ART1731BIS) + DAGRI2 * (1 - ART1731BIS))
	    -(min(DAGRI3,DAGRI31731+0) * positif(ART1731BIS) + DAGRI3 * (1 - ART1731BIS))
	    -(min(DAGRI4,DAGRI41731+0) * positif(ART1731BIS) + DAGRI4 * (1 - ART1731BIS))
	    -(min(DAGRI5,DAGRI51731+0) * positif(ART1731BIS) + DAGRI5 * (1 - ART1731BIS))
	    -(min(DAGRI6,DAGRI61731+0) * positif(ART1731BIS) + DAGRI6 * (1 - ART1731BIS)))
            + positif_ou_nul((min(DAGRI1,DAGRI11731+0) * positif(ART1731BIS) + DAGRI1 * (1 - ART1731BIS))
	    +(min(DAGRI2,DAGRI21731+0) * positif(ART1731BIS) + DAGRI2 * (1 - ART1731BIS))
	    +(min(DAGRI3,DAGRI31731+0) * positif(ART1731BIS) + DAGRI3 * (1 - ART1731BIS))
	    +(min(DAGRI4,DAGRI41731+0) * positif(ART1731BIS) + DAGRI4 * (1 - ART1731BIS))
	    +(min(DAGRI5,DAGRI51731+0) * positif(ART1731BIS) + DAGRI5 * (1 - ART1731BIS))
	    +(min(DAGRI6,DAGRI61731+0) * positif(ART1731BIS) + DAGRI6 * (1 - ART1731BIS))-BAQT-BAHQTOT)
            * (BAQT+BAHQTOT);
regle 849:
application : iliad , batch  ;
DAGRI = DAGRI1+DAGRI2+DAGRI3+DAGRI4+DAGRI5+DAGRI6;
VAREDAGRI = min(DAGRI,BAHQV+BAHQC+BAHQP);
regle 850:
application : iliad , batch  ;
BAQTOTAVIS = 4BAQTOTNET;
