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
regle 831000:
application : iliad , batch ;


RRFI = RFON + DRCF + max(0,RFMIC - MICFR -RFDANT * (1-positif(DEFRFNONI))
                   - min(RFDANT, max(0,RFDANT-DEFRFNONI)) * positif(DEFRFNONI));
RRFIPS = RRFI ; 

regle 831010:
application : iliad , batch ;


MICFR = present(RFMIC) * arr(RFMIC * TX_MICFON/100) ;

regle 831020:
application : iliad , batch ;


RMF = max(0,RFMIC - MICFR) ;
RMFN = max(0,RFMIC - MICFR - RFDANT * (1-positif(DEFRFNONI))
                   - min(RFDANT, max(0,RFDANT-DEFRFNONI)) * positif(DEFRFNONI));

regle 831030:
application : iliad , batch ;


RFCD = RFORDI + FONCI + REAMOR ;

regle 831040:
application : iliad , batch ;


RFCE = max(0,RFCD- RFDORD* (1-positif(DEFRFNONI))
                   - min(RFDORD, max(0,RFDORD+RFDHIS+RFDANT-DEFRFNONI)) * positif(DEFRFNONI));
RFCEAPS = max(0,RFORDI- RFDORD* (1-positif(DEFRFNONI))
                   - min(RFDORD, max(0,RFDORD+RFDHIS+RFDANT-DEFRFNONI)) * positif(DEFRFNONI));
RFCEPS = max(0,RFCD-RFDORD* (1-positif(DEFRFNONI))
                   - min(RFDORD, max(0,RFDORD+RFDHIS+RFDANT-DEFRFNONI)) * positif(DEFRFNONI));

DFCE = min(0,RFCD- RFDORD* (1-positif(DEFRFNONI))
                   - min(RFDORD, max(0,RFDORD+RFDHIS+RFDANT-DEFRFNONI)) * positif(DEFRFNONI));

RFCF = max(0,RFCE-RFDHIS);
RFCFPS = (RFCEPS-RFDHIS);
RFCFAPS = max(0,RFCEAPS-RFDHIS);

DRCF  = min(0,RFCE-RFDHIS);

RFCG = max(0,RFCF- RFDANT* (1-positif(DEFRFNONI))
                   - min(RFDANT, max(0,RFDANT-DEFRFNONI)) * positif(DEFRFNONI));
DFCG = min(0,RFCF- RFDANT* (1-positif(DEFRFNONI))
                   - min(RFDANT, max(0,RFDANT-DEFRFNONI)) * positif(DEFRFNONI));

regle 831050:
application : iliad , batch ;


RFON = arr(RFCG*RFORDI/RFCD);

2REVF = min( arr ((RFCG)*(FONCI)/RFCD) , RFCG-RFON) ;

3REVF = min( arr (RFCG*(REAMOR)/RFCD) , RFCG-RFON-2REVF) ;

RFQ = FONCI + REAMOR ;

regle 831060:
application : iliad ;

 
DEF4BB = min(RFDORD,RFORDI + RFMIC * 0.70 + FONCI + REAMOR) ;
DEFRF4BB = min(RFDORD,max(DEF4BB1731,max(DEF4BB_P,DEF4BBP2))) * positif(SOMMERF_2) * (1-PREM8_11) ;

regle 831070:
application : iliad ;
 
 
DEF4BD = min(RFDANT,RFORDI + RFMIC * 0.70 + FONCI + REAMOR-RFDORD - RFDHIS) ;
DEFRF4BD = min(RFDANT,max(DEF4BD1731,max(DEF4BD_P,DEF4BDP2)))* positif(SOMMERF_2) * (1-PREM8_11) ;

regle 831080:
application : iliad ;

DEF4BC = max(0, RFORDI+RFMIC*0.70+FONCI+REAMOR-RFDORD) ;
DEFRF4BC = max(0,RFDHIS-max(DEF4BC1731,max(DEF4BC_P,DEF4BCP2))) * positif(DFANTIMPU);
regle 834210:
application : iliad ;
DEFRFNONIBIS =  min(RFDORD,RFORDI + RFMIC * 0.70 + FONCI + REAMOR) + max(0,min(RFDANT,RFORDI + RFMIC * 0.70 + FONCI + REAMOR-RFDORD - RFDHIS));
regle 831090:
application : iliad ;
DEFRFNONI1 =  RFDORD + RFDANT - DEFRFNONIBIS;
DEFRFNONI2 = positif(SOMMERF_2) * null(PREM8_11) *
                  (max(0,RFDORD + RFDANT - max(DEFRFNONI1731,max(DEFRFNONI_P,DEFRFNONIP2))
                                         - max(0,DEFRFNONIBIS - DEFRFNONIP3)))
            + PREM8_11 * positif(RFORDI + RFMIC * 0.70 + FONCI + REAMOR) * DEFRFNONIBIS
            + 0;
DEFRFNONI = positif(null(PREM8_11) * positif(DEFRFNONI2-DEFRFNONI1) + PREM8_11 * positif(DEFRFNONI2)) * DEFRFNONI2 + 0;

 
