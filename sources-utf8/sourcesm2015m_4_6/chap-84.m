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
regle 841000:
application : iliad , batch ;


BA1AF = BAF1AP + BAF1AC + BAF1AV ;

regle 841010:
application : iliad , batch ;

BARSV = BAHREV + 4BAHREV - BAHDEV;
BARSREVV = BAHREV +4BAHREV;
BARSC = BAHREC + 4BAHREC - BAHDEC;
BARSREVC = BAHREC +4BAHREC;
BARSP = BAHREP + 4BAHREP - BAHDEP;
BARSREVP = BAHREP +4BAHREP;
BARAV = BACREV + 4BACREV - BACDEV;
BARREVAV = BACREV + 4BACREV;
BARAC = BACREC  + 4BACREC - BACDEC;
BARREVAC = BACREC + 4BACREC;
BARAP = BACREP + 4BACREP -BACDEP;
BARREVAP = BACREP + 4BACREP;

regle 841020:
application : iliad , batch ;


pour i =V,C,P:
DEFBACREi = positif(4BACREi) * arr(BACDEi * BACREi / BARREVAi) 
				   + (1 - positif(4BACREi)) * BACDEi ;

pour i =V,C,P:
4DEFBACREi = positif(4BACREi) * (BACDEi - DEFBACREi) ;

regle 841030:
application : iliad , batch ;


BANV = (BACREV - DEFBACREV) * positif_ou_nul(BARAV) + BARAV * (1-positif(BARAV)) ;

BANC = (BACREC - DEFBACREC) * positif_ou_nul(BARAC) + BARAC * (1-positif(BARAC)) ;

BANP = (BACREP - DEFBACREP) * positif_ou_nul(BARAP) + BARAP * (1-positif(BARAP)) ;

BAEV = (4BACREV - 4DEFBACREV) * positif_ou_nul(BARAV) + 0 ;

BAEC = (4BACREC - 4DEFBACREC) * positif_ou_nul(BARAC) + 0 ;

BAEP = (4BACREP - 4DEFBACREP) * positif_ou_nul(BARAP) + 0 ;

regle 841040:
application : iliad , batch ;


pour i =V,C,P:
DEFBAHREi = positif(4BAHREi) * arr(BAHDEi * BAHREi / BARSREVi) 
					      + (1 - positif(4BAHREi)) * BAHDEi ;

pour i =V,C,P:
4DEFBAHREi = positif(4BAHREi) * (BAHDEi - DEFBAHREi) ;

regle 841050:
application : iliad , batch ;


BAMV = arr((BAHREV - DEFBAHREV) * MAJREV) * positif_ou_nul(BARSV) + BARSV * (1-positif(BARSV)) ;

BAMC = arr((BAHREC - DEFBAHREC) * MAJREV) * positif_ou_nul(BARSC) + BARSC * (1-positif(BARSC)) ;

BAMP = arr((BAHREP - DEFBAHREP) * MAJREV) * positif_ou_nul(BARSP) + BARSP * (1-positif(BARSP)) ;

BAEMV = (arr((4BAHREV - 4DEFBAHREV)* MAJREV)) * positif_ou_nul(BARSV) + 0 ;

BAEMC = (arr((4BAHREC - 4DEFBAHREC)* MAJREV)) * positif_ou_nul(BARSC) + 0 ;

BAEMP = (arr((4BAHREP - 4DEFBAHREP)* MAJREV)) * positif_ou_nul(BARSP) + 0 ;

regle 841060:
application : iliad , batch ;


BAFORV = arr(BAFV*MAJREV) + BAFORESTV + BAFPVV ;
BAFORC = arr(BAFC*MAJREV) + BAFORESTC + BAFPVC ;
BAFORP = arr(BAFP*MAJREV) + BAFORESTP + BAFPVP ;

regle 841070:
application : iliad , batch ;


BAHDEF = BAFV * MAJREV + BAFORESTV + BAFPVV + BACREV + BAHREV * MAJREV + BAFC * MAJREV + BAFORESTC + BAFPVC + BACREC + BAHREC * MAJREV + BAFP * MAJREV
       + BAFORESTP + BAFPVP + BACREP + BAHREP * MAJREV + 4BACREV + 4BAHREV * MAJREV + 4BACREC + 4BAHREC * MAJREV + 4BACREP + 4BAHREP * MAJREV+0;
BAHQV = (BANV + BAMV + BAFORV);
BAHQC = (BANC + BAMC + BAFORC);
BAHQP = (BANP + BAMP + BAFORP);
SFBAHQV = (BANV + BAMV);
SFBAHQC = (BANC + BAMC);
SFBAHQP = (BANP + BAMP);

regle 841080:
application : iliad , batch ;


4BAQV = (max(0,(4BACREV - 4DEFBACREV))*positif_ou_nul(BARAV)+arr(max(0,(4BAHREV - 4DEFBAHREV))*MAJREV) * positif_ou_nul(BARSV));
4BAQC = (max(0,(4BACREC - 4DEFBACREC))*positif_ou_nul(BARAC)+arr(max(0,(4BAHREC - 4DEFBAHREC))*MAJREV) * positif_ou_nul(BARSC));
4BAQP = (max(0,(4BACREP - 4DEFBACREP))*positif_ou_nul(BARAP)+arr(max(0,(4BAHREP - 4DEFBAHREP))*MAJREV) * positif_ou_nul(BARSP));

regle 841090:
application : iliad , batch ;


BAQV = BAEV + BAEMV ;
BAQC = BAEC + BAEMC ;
BAQP = BAEP + BAEMP ;

regle 841100:
application : iliad , batch ;


BA1V = BA1AV + BAF1AV ;
BA1C = BA1AC + BAF1AC ;
BA1P = BA1AP + BAF1AP ;

regle 841110:
application : iliad , batch ;


BAHQT = BAHQV + BAHQC + BAHQP ;
SFBAHQT = SFBAHQV + SFBAHQC + SFBAHQP ;

regle 841120:
application : iliad , batch ;


DAGRIIMP = max(0,min(BAHQV + BAHQC + BAHQP + BAQV + BAQC + BAQP,DAGRI6 + DAGRI5 + DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1)) ;
SFDAGRIIMP = max(0,min(SFBAHQV + SFBAHQC + SFBAHQP + BAQV + BAQC + BAQP,DAGRI6 + DAGRI5 + DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1)) ;
DBAIP =  DAGRIIMP;

regle 841130:
application : iliad , batch ;


BAHQTOT=BAHQV+BAHQC+BAHQP-DBAIP;
BAHQTOTMAXP=positif_ou_nul(BAHQT) * (max(0,BAHQV+BAHQC+BAHQP-DBAIP));
SFBAHQTOTMAXP=positif_ou_nul(SFBAHQT) * (max(0,SFBAHQV+SFBAHQC+SFBAHQP-SFDAGRIIMP));

regle 841140:
application : iliad , batch ;


BAHQTOTMAXN=positif_ou_nul(BAHQT) * min(0,BAHQV+BAHQC+BAHQP-DBAIP);
BAHQTOTMIN = positif(-BAHQT) * BAHQT ;
SFBAHQTOTMIN = positif(-SFBAHQT) * SFBAHQT ;

regle 841150:
application : iliad , batch ;

BAQT = BAQV + BAQC + BAQP;

BAQTOT = max(0,BAQV + BAQC + BAQP + BAHQTOTMAXN);
BAQTOTN = min(0,BAQV + BAQC + BAQP + BAHQTOTMAXN);
BAQTOTMIN = min(0,BAQV + BAQC + BAQP + BAHQTOTMIN);
SFBAQTOTMIN = min(0,BAQV + BAQC + BAQP + SFBAHQTOTMIN);
BAQTOTAV = positif_ou_nul(BAQT + BAHQT) * BAQTOT + (1 - positif(BAQT + BAHQT)) * 0 ;

regle 841160:
application : iliad , batch ;


4BAQTOT = somme(x=V,C,P: 4BAQx) ;
4BAQTOTNET = positif(4BAQTOT) * max(0, 4BAQTOT + min(0,BAHQV+BAHQC+BAHQP-DBAIP)) ;
SF4BAQTOTNET = positif(4BAQTOT) * max(0, 4BAQTOT + min(0,SFBAHQV+SFBAHQC+SFBAHQP-SFDAGRIIMP)) ;
regle 841170:
application : iliad , batch ;


BA1 = BA1V + BA1C + BA1P ; 

regle 841180:
application : iliad , batch ;


BANOR = (BAHQTOTMAXP + BAQTOTMIN) ;
SFBANOR = (SFBAHQTOTMAXP + SFBAQTOTMIN) ;

regle 841190:
application : iliad , batch ;


BAGF1A = BANV + BAMV + BAFORV+BANC + BAMC + BAFORC+BANP + BAMP + BAFORP
        + (max(0,(4BACREV - 4DEFBACREV))*positif_ou_nul(BARAV)+arr(max(0,(4BAHREV - 4DEFBAHREV))*MAJREV) * positif_ou_nul(BARSV))
        + (max(0,(4BACREC - 4DEFBACREC))*positif_ou_nul(BARAC)+arr(max(0,(4BAHREC - 4DEFBAHREC))*MAJREV) * positif_ou_nul(BARSC))
        + (max(0,(4BACREP - 4DEFBACREP))*positif_ou_nul(BARAP)+arr(max(0,(4BAHREP - 4DEFBAHREP))*MAJREV) * positif_ou_nul(BARSP)) ;

DEFBA1 = ((1-positif(BAHQT+BAQT)) * (abs(BAHQT+BAQT)-abs(DEFIBA))
                 + positif(BAHQT+BAQT) *
                 positif_ou_nul(DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1-BAHQT-BAQT)
                 * (DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1-BAHQT-BAQT)
                  * null(DEFBA2P+DEFBA3P+DEFBA4P+DEFBA5P+DEFBA6P)) * null(4 - V_IND_TRAIT)
                 +  (positif(SHBA-SEUIL_IMPDEFBA) * positif(DEFBANIF) * max(0,DEFBANIF - DBAIP) * positif(DEFBANIF+0)
                 + positif(SHBA-SEUIL_IMPDEFBA) * max(0,-(BAHQV+BAHQC+BAHQP+4BAQV+4BAQC+4BAQP))* (1-positif(DEFBANIF+0))) * null(5 - V_IND_TRAIT);

regle 860:
application : iliad , batch  ;
DEFBA2 = ((1-positif(BAHQT+BAQT)) * (DAGRI1)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0)-DAGRI1,DAGRI1))
                 * positif_ou_nul(DAGRI1-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0))) * null(4-V_IND_TRAIT)
                  + (positif(DEFBANIF) * min(DAGRI1,DEFBANIF+DAGRI-DBAIP-DEFBA1)
                    + null(DEFBANIF) * min(DAGRI1,DAGRI-DBAIP))  * null(5-V_IND_TRAIT);
regle 862:
application : iliad , batch  ;
DEFBA3 = ((1-positif(BAHQT+BAQT)) * DAGRI2
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0)-DAGRI2,DAGRI2))
                 * positif_ou_nul(DAGRI2-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0))) * null(4-V_IND_TRAIT)
                  + (null(DEFBANIF) * min(DAGRI2,DAGRI-DBAIP-DEFBA2)
                    + positif(DEFBANIF) * min(DAGRI2,DEFBANIF+DAGRI-DBAIP-DEFBA1- DEFBA2))  * null(5-V_IND_TRAIT);
regle 864:
application : iliad , batch  ;
DEFBA4 = ((1-positif(BAHQT+BAQT)) * (DAGRI3)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0)-DAGRI3,DAGRI3))
                 * positif_ou_nul(DAGRI3-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0))) * null(4-V_IND_TRAIT)
                  + (null(DEFBANIF) * min(DAGRI3,DAGRI-DBAIP-DEFBA2-DEFBA3)
                    + positif(DEFBANIF) * min(DAGRI3,DEFBANIF+DAGRI-DBAIP-DEFBA1- DEFBA2-DEFBA3))  * null(5-V_IND_TRAIT);
regle 866:
application : iliad , batch  ;
DEFBA5 = ((1-positif(BAHQT+BAQT)) * (DAGRI4)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5,0)-DAGRI4,DAGRI4))
                 * positif_ou_nul(DAGRI4-max(BAHQT+BAQT-DAGRI6-DAGRI5,0))) * null(4-V_IND_TRAIT)
                  + (null(DEFBANIF) * min(DAGRI4,DAGRI-DBAIP-DEFBA2-DEFBA3-DEFBA4)
                    + positif(DEFBANIF) * min(DAGRI4,DEFBANIF+DAGRI-DBAIP-DEFBA1- DEFBA2-DEFBA3-DEFBA4))  * null(5-V_IND_TRAIT);
regle 868:
application : iliad , batch  ;
DEFBA6 = ((1-positif(BAHQT+BAQT)) * (DAGRI5)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6,0)-DAGRI5,DAGRI5))
                 * positif_ou_nul(DAGRI5-max(BAHQT+BAQT-DAGRI6,0))) * null(4-V_IND_TRAIT)
                  + (null(DEFBANIF) * min(DAGRI5,DAGRI-DBAIP-DEFBA2-DEFBA3-DEFBA4-DEFBA5)
                    + positif(DEFBANIF) * min(DAGRI5,DEFBANIF+DAGRI-DBAIP-DEFBA1- DEFBA2-DEFBA3-DEFBA4-DEFBA5))  * null(5-V_IND_TRAIT);
regle 870:
application : iliad , batch  ;
DEFBA2P = ((1-positif(BAHQT+BAQT)) * (DAGRI1)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0)-DAGRI1,DAGRI1))
                 * positif_ou_nul(DAGRI1-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3-DAGRI2,0)));
regle 87202:
application : iliad , batch  ;
DEFBA3P = ((1-positif(BAHQT+BAQT)) * DAGRI2
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0)-DAGRI2,DAGRI2))
                 * positif_ou_nul(DAGRI2-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4-DAGRI3,0)));
regle 874:
application : iliad , batch  ;
DEFBA4P = ((1-positif(BAHQT+BAQT)) * (DAGRI3)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0)-DAGRI3,DAGRI3))
                 * positif_ou_nul(DAGRI3-max(BAHQT+BAQT-DAGRI6-DAGRI5-DAGRI4,0)));
regle 87602:
application : iliad , batch  ;
DEFBA5P = ((1-positif(BAHQT+BAQT)) * (DAGRI4)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6-DAGRI5,0)-DAGRI4,DAGRI4))
                 * positif_ou_nul(DAGRI4-max(BAHQT+BAQT-DAGRI6-DAGRI5,0)));
regle 878:
application : iliad , batch  ;
DEFBA6P = ((1-positif(BAHQT+BAQT)) * (DAGRI5)
                 + positif(BAHQT+BAQT) *
                 abs(min(max(BAHQT+BAQT-DAGRI6,0)-DAGRI5,DAGRI5))
                 * positif_ou_nul(DAGRI5-max(BAHQT+BAQT-DAGRI6,0)));
regle 841210:
application : iliad , batch ;


DEFIBAANT = positif_ou_nul(BAQT+BAHQTOT-DAGRI1 - DAGRI2 - DAGRI3 - DAGRI4 - DAGRI5 - DAGRI6 )
            * (DAGRI1 - DAGRI2 - DAGRI3 - DAGRI4 - DAGRI5 - DAGRI6)
            + positif_ou_nul(DAGRI1 + DAGRI2 + DAGRI3 + DAGRI4 + DAGRI5 + DAGRI6 -BAQT-BAHQTOT)
            * (BAQT+BAHQTOT);

regle 841220:
application : iliad , batch ;


DAGRI = DAGRI1 + DAGRI2 + DAGRI3 + DAGRI4 + DAGRI5 + DAGRI6 ;
VAREDAGRI = min(DAGRI,BAHQV + BAHQC + BAHQP) ;

regle 841230:
application : iliad , batch ;


BAQTOTAVIS = (4BAQTOTNET + DEFNIBAQ);
SFBAQTOTAVIS = (SF4BAQTOTNET + SFDEFNIBAQ);
regle 841240:
application : iliad , batch ;


SOMDEFBANI = max(0,BAFV*MAJREV+BAFORESTV+BAFPVV+BACREV+BAHREV*MAJREV+BAFC*MAJREV+BAFORESTC+BAFPVC+BACREC+BAHREC*MAJREV+BAFP*MAJREV+BAFORESTP+BAFPVP+BACREP+BAHREP*MAJREV
                 + 4BACREV + 4BAHREV * MAJREV + 4BACREC + 4BAHREC * MAJREV + 4BACREP + 4BAHREP * MAJREV - BAHQPROV) ;
SFSOMDEFBANI = max(0,BAFORESTV+BAFPVV+BACREV+BAHREV*MAJREV+BAFORESTC+BAFPVC+BACREC+BAHREC*MAJREV+BAFORESTP+BAFPVP+BACREP+BAHREP*MAJREV
                 + 4BACREV + 4BAHREV * MAJREV + 4BACREC + 4BAHREC * MAJREV + 4BACREP + 4BAHREP * MAJREV - SFBAHQPROV) ;

regle 841250:
application : iliad , batch ;


BAHQPROV = BANV + BAMV + BAFORV+BANC + BAMC + BAFORC+BANP + BAMP + BAFORP
        +(max(0,(4BACREV - 4DEFBACREV))*positif_ou_nul(BARAV)+arr(max(0,(4BAHREV - 4DEFBAHREV))*MAJREV) * positif_ou_nul(BARSV))
        +(max(0,(4BACREC - 4DEFBACREC))*positif_ou_nul(BARAC)+arr(max(0,(4BAHREC - 4DEFBAHREC))*MAJREV) * positif_ou_nul(BARSC))
        +(max(0,(4BACREP - 4DEFBACREP))*positif_ou_nul(BARAP)+arr(max(0,(4BAHREP - 4DEFBAHREP))*MAJREV) * positif_ou_nul(BARSP)) ;
SFBAHQPROV = BANV + BAMV +BANC + BAMC +BANP + BAMP 
        +(max(0,(4BACREV - 4DEFBACREV))*positif_ou_nul(BARAV)+arr(max(0,(4BAHREV - 4DEFBAHREV))*MAJREV) * positif_ou_nul(BARSV))
        +(max(0,(4BACREC - 4DEFBACREC))*positif_ou_nul(BARAC)+arr(max(0,(4BAHREC - 4DEFBAHREC))*MAJREV) * positif_ou_nul(BARSC))
        +(max(0,(4BACREP - 4DEFBACREP))*positif_ou_nul(BARAP)+arr(max(0,(4BAHREP - 4DEFBAHREP))*MAJREV) * positif_ou_nul(BARSP)) ;

regle 841260:
application : iliad , batch ;


DEFBANI = max(0,arr(BAFV*MAJREV)+BAFORESTV+BAFPVV+BACREV+arr(BAHREV*MAJREV)+arr(BAFC*MAJREV)+BAFORESTC+BAFPVC+BACREC+arr(BAHREC*MAJREV)+arr(BAFP*MAJREV)+BAFORESTP+BAFPVP+BACREP+arr(BAHREP*MAJREV)
                 +4BACREV + arr(4BAHREV * MAJREV) + 4BACREC + arr(4BAHREC * MAJREV) + 4BACREP + arr(4BAHREP * MAJREV)
                 + min(0,BAHQV+BAHQC+BAHQP+4BAQV+4BAQC+4BAQP) * (1-positif(SHBA-SEUIL_IMPDEFBA))) ;
SFDEFBANI = max(0,BAFORESTV+BAFPVV+BACREV+arr(BAHREV*MAJREV)+BAFORESTC+BAFPVC+BACREC+arr(BAHREC*MAJREV)+BAFORESTP+BAFPVP+BACREP+arr(BAHREP*MAJREV)
                 +4BACREV + arr(4BAHREV * MAJREV) + 4BACREC + arr(4BAHREC * MAJREV) + 4BACREP + arr(4BAHREP * MAJREV)
                 + min(0,SFBAHQV+SFBAHQC+SFBAHQP+4BAQV+4BAQC+4BAQP) * (1-positif(SHBA-SEUIL_IMPDEFBA))) ;
DEFBANIH470 = max(0,arr(BAFV*MAJREV)+BAFORESTV+BAFPVV+BACREV+arr(BAHREV*MAJREV)+arr(BAFC*MAJREV)+BAFORESTC+BAFPVC+BACREC+arr(BAHREC*MAJREV)+arr(BAFP*MAJREV)+BAFORESTP+BAFPVP+BACREP+arr(BAHREP*MAJREV)
                 +4BACREV + arr(4BAHREV * MAJREV) + 4BACREC + arr(4BAHREC * MAJREV) + 4BACREP + arr(4BAHREP * MAJREV));
SFDEFBANIH470 = max(0,BAFORESTV+BAFPVV+BACREV+arr(BAHREV*MAJREV)+BAFORESTC+BAFPVC+BACREC+arr(BAHREC*MAJREV)+BAFORESTP+BAFPVP+BACREP+arr(BAHREP*MAJREV)
                 +4BACREV + arr(4BAHREV * MAJREV) + 4BACREC + arr(4BAHREC * MAJREV) + 4BACREP + arr(4BAHREP * MAJREV));
DEFBANI470 =  max(0,-BAHQV-BAHQC-BAHQP-4BAQV-4BAQC-4BAQP) * (1-positif(SHBA-SEUIL_IMPDEFBA)) ;
SFDEFBANI470 =  max(0,-BAHQV-BAHQC-BAHQP-4BAQV-4BAQC-4BAQP) * (1-positif(SHBA-SEUIL_IMPDEFBA)) ;
regle 841270:
application : iliad , batch ;


DEFBANIF = (1-PREM8_11) * positif(SOMMEBAND_2) * positif(DEFBA_P+DEFBAP2 +DEFBA1731)
                      * max(0,min(min(DEFBA1731+DEFBA71731+ DEFBANI4701731 * positif(SHBA-SEUIL_IMPDEFBA),
                                            max(DEFBA_P+DEFBA7_P+DEFBANI470_P * positif(SHBA-SEUIL_IMPDEFBA),
                                                DEFBAP2+DEFBA7P2+DEFBANI470P2 * positif(SHBA-SEUIL_IMPDEFBA)))
                                                ,DBAIP+SOMDEFBANI
                                        -max(DEFBANIH4701731 + DEFBANI4701731 * (1-positif(SHBA-SEUIL_IMPDEFBA))
                                                   ,max(DEFBANIH470_P + DEFBANI470_P * (1-positif(SHBA-SEUIL_IMPDEFBA))
                                                       ,DEFBANIH470P2 + DEFBANI470P2 * (1-positif(SHBA-SEUIL_IMPDEFBA))))
                                                       - max(0,DEFBANI-DEFBANIH470P3 + DEFBANI470P3 * (1-positif(SHBA-SEUIL_IMPDEFBA)))))
         + PREM8_11 * positif(DEFBANI) * (DBAIP + SOMDEFBANI * positif(SHBA-SEUIL_IMPDEFBA));

SFDEFBANIF = (1-PREM8_11) * positif(SOMMEBAND_2) * positif(DEFBA_P+DEFBAP2 +DEFBA1731)
                      * max(0,min(min(DEFBA1731+DEFBA71731+ SFDEFBANI4701731,
                                            max(DEFBA_P+DEFBA7_P+SFDEFBANI470_P,
                                                DEFBAP2+DEFBA7P2+SFDEFBANI470P2))
                                                ,SFDAGRIIMP+SFSOMDEFBANI
                                        -max(SFDEFBANIH4701731 + SFDEFBANI4701731 * (1-positif(SHBA-SEUIL_IMPDEFBA))
                                                   ,max(SFDEFBANIH470_P + SFDEFBANI470_P * (1-positif(SHBA-SEUIL_IMPDEFBA))
                                                       ,SFDEFBANIH470P2 + SFDEFBANI470P2 * (1-positif(SHBA-SEUIL_IMPDEFBA))))
                                                       - max(0,SFDEFBANI-SFDEFBANIH470P3 + SFDEFBANI470P3 * (1-positif(SHBA-SEUIL_IMPDEFBA)))))
         + PREM8_11 * positif(SFDEFBANI) * (SFDAGRIIMP + SFSOMDEFBANI * positif(SHBA-SEUIL_IMPDEFBA));
regle 841280:
application : iliad , batch ;


PRORATABA = (4BACREV + 4BACREC +4BACREP +arr(4BAHREV*MAJREV) +arr(4BAHREC*MAJREV) +arr(4BAHREP*MAJREV)-4BAQV-4BAQC-4BAQP-min(0,BAHQV+BAHQC+BAHQP))/SOMDEFBANI+0;
SFPRORATABA = (4BACREV + 4BACREC +4BACREP +arr(4BAHREV*MAJREV) +arr(4BAHREC*MAJREV) +arr(4BAHREP*MAJREV)-4BAQV-4BAQC-4BAQP-min(0,SFBAHQV+SFBAHQC+SFBAHQP))/SFSOMDEFBANI+0;
regle 841290:
application : iliad , batch ;


DEFNIBAQ = (DEFNIBAQ1+max(0,arr((DEFBANIF - DBAIP) * PRORATABA))) * positif(DEFBANIF-DBAIP)
         + DEFNIBAQ1 * (1-positif(DEFBANIF-DBAIP));
SFDEFNIBAQ = (SFDEFNIBAQ1+max(0,arr((SFDEFBANIF - SFDAGRIIMP) * SFPRORATABA))) * positif(SFDEFBANIF-SFDAGRIIMP)
         + SFDEFNIBAQ1 * (1-positif(SFDEFBANIF-SFDAGRIIMP));
regle 8509355:
application : iliad , batch  ;
DEFNIBAQ1 = max(0,min(DEFBANIF,min(4BAQV+4BAQC+4BAQP,DBAIP-max(0,BAHQV+BAHQC+BAHQP)))) * positif(DBAIP - max(0,BAHQV+BAHQC+BAHQP));
SFDEFNIBAQ1 = max(0,min(SFDEFBANIF,min(4BAQV+4BAQC+4BAQP,DBAIP-max(0,SFBAHQV+SFBAHQC+SFBAHQP)))) * positif(SFDAGRIIMP - max(0,SFBAHQV+SFBAHQC+SFBAHQP));
regle 841300:
application : iliad , batch ;


BATMARGV = COD5XT + arr(COD5XV * MAJREV) ;
BATMARGC = COD5XU + arr(COD5XW * MAJREV) ;
BATMARGTOT =  BATMARGV + BATMARGC ;

regle 841310:
application : iliad , batch ;


IBATMARG = arr(BATMARGTOT * TXMARJBA/100) ;

