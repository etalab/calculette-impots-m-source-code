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
regle 831:
application : iliad , batch  ;
RRFI = RFON + DRCF + max(0,RFMIC - MICFR - (min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS)) );
RRFIPS = RFON + DRCF + max(0,RFMIC - MICFR - RFDANT);
regle 8311:
application : iliad ;
RRFI1731R = RFON + DRCF1731R + max(0,RFMIC - MICFR - RFDANT );
regle 8312:
application : iliad , batch  ;
MICFR = present(RFMIC) * arr(RFMIC * TX_MICFON/100);
regle 8313:
application : iliad ;
MICFR1731R = present(RFMIC) * arr(RFMIC * TX_MICFON/100);
regle 8316:
application : iliad , batch ;
RMF = max(0,RFMIC - MICFR);
RMFN = max(0,RFMIC - MICFR - (min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS)));
regle 83161:
application : iliad ;
RMF1731R = max(0,RFMIC - MICFR1731R);
RMFN1731R = max(0,RFMIC - MICFR1731R - RFDANT );
regle 832:
application : iliad , batch  ;
RFCD = RFORDI + FONCI + REAMOR;
regle 83211:
application : iliad ;
RFCD1731R = RFORDI + FONCI + REAMOR;
regle 833:
application : iliad , batch  ;
VARRFDORD = min(RFCD,RFDORD);
RFCE = max(0,RFCD-(min(RFDORD,RFDORD1731+0) * positif(ART1731BIS) + RFDORD * (1 - ART1731BIS)));
RFCEAPS = max(0,RFORDI-(min(RFDORD,RFDORD1731+0) * positif(ART1731BIS) + RFDORD * (1 - ART1731BIS)));
RFCEPS = max(0,RFCD-RFDORD* (1 - positif(ART1731BIS)));

DFCE = min(0,RFCD-(min(RFDORD,RFDORD1731+0) * positif(ART1731BIS) + RFDORD * (1 - ART1731BIS)));

RFCF = max(0,RFCE-(RFDHIS * (1 - positif(ART1731BIS))));
RFCFPS = max(0,RFCEPS-RFDHIS* (1 - positif(ART1731BIS)));
RFCFAPS = max(0,RFCEAPS-(RFDHIS * (1 - positif(ART1731BIS))));

DRCF  = min(0,RFCE-(RFDHIS * (1 - positif(ART1731BIS))));
VARRFDANT = min(RFCF+RFMIC - MICFR,RFDANT);
RFCG = max(0,RFCF-(min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS)));
DFCG = min(0,RFCF-(min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS)));
regle 83311:
application : iliad ;
RFCE1731R = max(0,RFCD1731R- RFDORD );

DFCE1731R = min(0,RFCD1731R- RFDORD);

RFCF1731R = max(0,RFCE1731R-RFDHIS);

DRCF1731R  = min(0,RFCE1731R-RFDHIS);
RFCG1731R = max(0,RFCF1731R- RFDANT);
DFCG1731R = min(0,RFCF1731R- RFDANT);
regle 834:
application : iliad , batch  ;
RFON = arr(RFCG*RFORDI/RFCD);
2REVF = min( arr (RFCG*(FONCI)/RFCD) , RFCG-RFON);
3REVF = min( arr (RFCG*(REAMOR)/RFCD) , RFCG-RFON-2REVF);
RFQ = FONCI + REAMOR;
regle 83411:
application : iliad ;
RFON1731R = arr(RFCG1731R*RFORDI/RFCD1731R);
2REVF1731R = min( arr (RFCG1731R*(FONCI)/RFCD1731R) , RFCG1731R-RFON1731R);
3REVF1731R = min( arr (RFCG1731R*(REAMOR)/RFCD1731R) , RFCG1731R-RFON1731R-2REVF1731R);
RFQ1731R = FONCI + REAMOR;
 
