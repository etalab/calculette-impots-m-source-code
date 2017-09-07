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
 #####   ######   ####    #####     #     #####   ########
 #    #  #       #          #       #       #     #      #
 #    #  #####    ####      #       #       #      #    #
 #####   #            #     #       #       #       ####
 #   #   #       #    #     #       #       #      #    #
 #    #  ######   ####      #       #       #     ########
 #
 #
 #
 #
 #                 RES-SER1.m
 #                 ===========
 #
 #
 #                      zones restituees par l'application
 #
 #
 #
 #
 #
 #
regle 111000:
application : iliad , bareme , batch ;

MCDV = 1 * positif(V_0AM + 0)
     + 2 * positif(V_0AC + 0)
     + 3 * positif(V_0AD + 0)
     + 4 * positif(V_0AV + 0)
     + 5 * positif(V_0AO + 0);

SFM = si  ( BOOL_0AM=1 ) 
          alors ( si (V_0AP+0=1)
                  alors ( si (V_0AF+0=1)
                          alors (1)
                          sinon (2)
                          finsi)
                  sinon ( si (V_0AF+0=1) 
                          alors (3)
                          sinon ( si ( V_0AS+0=1 et
                          (AGV >= LIM_AGE_LET_S ou AGC >= LIM_AGE_LET_S)
                                      )
                                  alors (4)
                                  finsi)
                          finsi)
                  finsi)
       finsi;

regle 111010:
application : batch , iliad , bareme ;


BOOL_V = positif(V_0AV+0) * positif(1 - BOOL_0AZ) 
			  * ((1 - positif(PAC + V_0CH + 0))
			     + positif(PAC + V_0CH + 0) * (3 - null(EAC + V_0CH + 0))) ;

BOOL_CDV = positif( BOOL_V + V_0AC + V_0AD + 0);

BOOL_PACSFL = 1 - positif( PAC +V_0CH + 0);

BOOL_W = positif(V_0AW + 0) * positif_ou_nul( AGV - LIM_AGE_LET_S );

SFCD1 = ( 15 * positif(V_0AN + 0) * (1 - positif(V_0AP + 0)) * (1 - positif(V_0AG + 0)) * (1 - BOOL_W)         
 
       + 2 * positif(V_0AP + 0) * (1-positif(V_0AL+0))          


       + 14 * positif(V_0AG + 0) * (1 - positif(V_0AP + 0)) * (1 - BOOL_W)                   

       + 7 * BOOL_W * (1 - positif(V_0AP + 0)))
       
       * (1-positif(V_0AL+0)) * BOOL_CDV * BOOL_PACSFL;


regle 111020:
application : batch , iliad , bareme ;

SFL = positif (V_0AL + 0) * BOOL_CDV * BOOL_PACSFL *

      ( 2 * positif(V_0AP + 0) 

      + 9 * ( 1 - BOOL_W ) * positif( 1- V_0AP + 0) * positif(1-(V_0AG + 0)) * positif (1-(V_0AN+0))  

      + 7 * BOOL_W * positif(1-(V_0AP + 0)) 

      + 15 * positif (V_0AN +0) * ( 1 - BOOL_W ) * positif(1-(V_0AG + 0)) * positif(1-(V_0AP + 0)) 

      + 14 * positif (V_0AG +0) * ( 1 - BOOL_W ) * positif(1-(V_0AP + 0))) ;

regle 111030:
application : batch , iliad , bareme ;



SFCD2 = positif(PAC+V_0CH) * positif(V_0AC + V_0AD + null(2- BOOL_V)) *
	(
		positif(V_0AP+0) * ( 10 * positif(V_0BT+0) * (1-positif(V_0AV))
 			            + 2 * positif(V_0AV)
                                    + 2 * (1 - positif(V_0AV)) *(1 - positif(V_0BT+0)))
          + (1-positif(V_0AP+0)) * ( 11 * positif(V_0BT+0)) * (1-positif(V_0AV+0))
	);

regle 111040:
application : batch , iliad , bareme ;


SFV1 = 2 * positif(V_0AP + 0) * null(BOOL_V - 3) ;

regle 111050:
application : batch , iliad , bareme ;


SFV2 = si ( V_0AV+0=1 et BOOL_0AZ =1)
       alors (si (V_0AP+0=1)
              alors (si (V_0AF+0=1)
                     alors (1)
                     sinon (2)
                     finsi)
              sinon (si (V_0AF+0=1)
                     alors (3)
                     sinon (si (V_0AW+0=1)
                            alors (7)
                            finsi)
                     finsi)  
              finsi)
        finsi;

regle 111060:
application : batch , iliad , bareme ;


BOOL_0AM = positif(positif(V_0AM + 0) + positif(V_0AO + 0)) ;

regle 111070:
application : batch , iliad , bareme ;



SFUTILE = SFM + SFCD1 + SFCD2 + SFV1 + SFV2 + SFL ;

regle 111080:
application : batch , iliad ;

NATPENA = si ((APPLI_COLBERT+APPLI_ILIAD+APPLI_COLBERT=1) et  
	     (CMAJ =7 ou CMAJ =8 ou CMAJ=9 ou CMAJ=10 ou CMAJ=11 ou CMAJ=12 ou CMAJ=17 ou CMAJ=18 ))
          alors (1)
          sinon ( si ( CMAJ = 2 )
                  alors (2)
                  sinon ( si ( CMAJ=3 ou CMAJ=4 ou CMAJ=5 ou CMAJ=6 ) 
                          alors (4)
                          finsi
                        )
                  finsi
                 )
           finsi;

regle 111090:
application : iliad ;


TSALV = TSBNV ;
TSALC = TSBNC ;

regle 111100:
application : iliad , batch ;


TSALP = TSBN1 + TSBN2 + TSBN3 + TSBN4 ;

regle 111110:
application : iliad , batch ;


pour i = V,C,1..4:
F10Ai = positif(null(IND_10i) + positif(IND_10i)*null(IND_10MIN_0i)+PREM8_11*positif(DEDMINi-TSBi)* positif (FRNi - 10MINSi)) * max(FRDAi,DFNi);

regle 111120:
application : iliad , batch ;

F10AP = somme(i=1..4:F10Ai) ;  

regle 111130:
application : iliad , batch ;


pour i = V,C,1..4:
F10Bi = positif(positif(IND_10i)*positif(IND_10MIN_0i)*(1-positif(PREM8_11*positif(DEDMINi-TSBi)*positif (FRNi - 10MINSi)))) * 10MINSi ;

regle 111140:
application : iliad , batch ;

F10BP = somme(i=1..4:F10Bi) ;

regle 111150:
application : iliad , batch ;


pour i = V,C,1,2,3,4:
DEDSi =  (10MINSi - DFNi) * (1-positif(F10Bi)) * IND_10i ;

regle 111160:
application : iliad , batch ;

DEDSP = somme( i=1..4: DEDSi ) ;

regle 111170:
application : iliad , batch ;


PRV = PRBRV ;
PRC = PRBRC ;
PRP = PRBR1 + PRBR2 + PRBR3 + PRBR4 ;

PRZV = PENINV ;
PRZC = PENINC ;
PRZP = PENIN1 + PENIN2 + PENIN3 + PENIN4 ;
PALIP = PALI1 + PALI2 + PALI3 + PALI4 ;

regle 111180:
application : iliad , batch ;


pour i = V,C:
AB10i = APRi ;
AB10P = APR1 + APR2 + APR3 + APR4 ;

regle 111190:
application : iliad , batch ;


TSPRT =  (TSNNV + PRRV
        + TSNNC + PRRC
        + TSNN1 + PRR1
        + TSNN2 + PRR2
        + TSNN3 + PRR3
        + TSNN4 + PRR4) ;

regle 111200:
application : iliad , batch ;


pour i = V,C,P:
RBAi = BAHREi + 4BAHREi
     + BACREi + 4BACREi
     + BAFORESTi
     + BAFi + BAFPVi- BACDEi - BAHDEi;

regle 111210:
application : iliad , batch ;

pour i= V,C,P:
BIPi =
   BICNOi  
 - BICDNi
 + BIHNOi  
 - BIHDNi
  ; 

pour i= V,C,P:                                           
BIPNi = BIPTAi + BIHTAi ;                        
BIPN  = BIPNV + BIPNC + BIPNP ;                          
                                                         

pour i= V,C,P:                                           
MIBRi = MIBVENi + MIBPRESi ;
MIBR = somme(i=V,P,C: MIBRi);
pour i= V,C,P:                                           
MLOCDECi = MIBGITEi + LOCGITi + MIBMEUi ;
pour i= V,C,P:                                           
MIBRABi = MIB_ABVi + MIB_ABPi ;
pour i= V,C,P:                                           
MLOCABi = MIB_ABNPVLi + MIB_ABNPPLi ;
pour i= V,C,P:                                           
MIBRNETi = max (0,MIBRi - MIBRABi );
MIBRNET = somme(i=V,C,P:MIBRNETi);
pour i= V,C,P:                                           
MLOCNETi = max (0,MLOCDECi - MLOCABi );
MLOCNET = somme(i=V,C,P:MLOCNETi);
pour i= V,C,P:                                           
MIBNPRi = MIBNPVENi + MIBNPPRESi ;
pour i= V,C,P:                                           
MIBNPRABi = MIB_ABNPVi + MIB_ABNPPi ;
pour i= V,C,P:                                           
MIBNPRNETi = max (0,MIBNPRi - MIBNPRABi );

regle 111220:
application : iliad , batch ;


pour i=V,C,P:
BINi = 
   BICREi  
 - BICDEi 
 + BICHREi  
 - BICHDEi
 ;  

regle 111230:
application : iliad , batch ;


pour i=V,C,P:
BINNi= BINTAi + BINHTAi;

regle 111240:
application : iliad , batch ;


BNCV = BNHREV + BNCREV - BNHDEV - BNCDEV ;
BNCC = BNHREC + BNCREC - BNHDEC - BNCDEC ;
BNCP = BNHREP + BNCREP - BNHDEP - BNCDEP ;
BNCAFFV = positif(present(BNHREV) + present(BNCREV) + present(BNHDEV) + present(BNCDEV)) ;
BNCAFFC = positif(present(BNHREC) + present(BNCREC) + present(BNHDEC) + present(BNCDEC)) ;
BNCAFFP = positif(present(BNHREP) + present(BNCREP) + present(BNHDEP) + present(BNCDEP)) ;

regle 111250:
application : iliad , batch ;


DIDABNCNP = max(0,min(NOCEPIMP+SPENETNPF , DABNCNP1+DABNCNP2+DABNCNP3+DABNCNP4+DABNCNP5+DABNCNP6)) ;

regle 111260:
application : iliad , batch ;

BNCIF =  max (0,NOCEPIMP+SPENETNPF-DIDABNCNP+DEFBNCNPF);
regle 111270:
application : iliad , batch ;

BRCM = RCMABD + RCMTNC + RCMAV + RCMHAD + RCMHAB + REGPRIV ;

regle 111280:
application : iliad , batch ;

BRCMQ = REVACT + REVPEA + PROVIE + DISQUO + RESTUC + INTERE ;
BRCMTOT = RCMAB + RTNC + RAVC + RCMNAB + RTCAR + RCMPRIVM ;

regle 111290:
application : iliad , batch ;


RRCM = max(0,RCM) ;

regle 111300:
application : iliad , batch ;


B1FIS = max(RCM + 2RCM + 3RCM + 4RCM + 5RCM + 6RCM + 7RCM , 0) ;

regle 111310:
application : iliad , batch ;

DRFRP = ((abs (DFCE+DFCG) * (1-positif(RFMIC))
             + positif(RFMIC) *  abs(min(0,RFMIC - MICFR - RFDANT)) )) * null(4-V_IND_TRAIT)
             + null(5-V_IND_TRAIT) * (DEFRFNONI* positif(DEFRFNONI)
                                    + (1-positif(DEFRFNONI))
                                       * (RFDORD - min(RFDORD,RFORDI + RFMIC * 0.70 + FONCI + REAMOR)+RFDANT -max(0,min(RFDANT, RFORDI + RFMIC * 0.70 + FONCI + REAMOR-RFDORD-RFDHIS))));
regle 111320:
application : iliad , batch ;



DLMRN1TXM = - min(0,MIB_NETCT *(1-positif(MIBNETPTOT))
                          +SPENETCT * (1 - positif(SPENETPF)));
DLMRN1 = ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * abs(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                 + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                 * positif_ou_nul(DEFBIC5+DEFBIC4+DEFBIC3+DEFBIC2+DEFBIC1-(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))
                 * (DEFBIC5+DEFBIC4+DEFBIC3+DEFBIC2+DEFBIC1-(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))
                 * null(DLMRN6P+DLMRN5P+DLMRN4P+DLMRN3P+DLMRN2P)) * null(4 - V_IND_TRAIT)
                 + null(5 - V_IND_TRAIT)*
                                   ( max(0,DEFBICNPF-DEFNPI) * positif(DEFBICNPF)
                                    + (max(0,-(BINNV+BINNC+BINNP+MIBNETNPTOT))) * null(DEFBICNPF));
regle 111330:
application : iliad , batch ;

DLMRN2 = positif(DEFBIC1) * (
                 ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))* DEFBIC1
                 + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                 * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3-DEFBIC2,0)-DEFBIC1,DEFBIC1)*(-1)
                 * positif_ou_nul(DEFBIC1-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3-DEFBIC2,0)))*null(4-V_IND_TRAIT)
                  + (null(DEFBICNPF) * min(DEFBIC1,DEFNP - DEFNPI)
                  + positif(DEFBICNPF) * min(DEFBIC1,DEFBICNPF + DEFNP - DEFNPI - DLMRN1))*null(5-V_IND_TRAIT));
regle 111340:
application : iliad , batch ;

DLMRN3 = positif(DEFBIC2) * (
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))* DEFBIC2
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                    * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3,0)-DEFBIC2,DEFBIC2)*(-1)
                  * positif_ou_nul(DEFBIC2-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3,0)))
                 * (1-PREM8_11) + DEFBIC2 * PREM8_11)*null(4-V_IND_TRAIT)
                  + (null(DEFBICNPF) * min(DEFBIC2,DEFNP - DEFNPI -DLMRN2)
                  + positif(DEFBICNPF) * min(DEFBIC2,DEFBICNPF +DEFNP - DEFNPI- DLMRN1-DLMRN2))*null(5-V_IND_TRAIT);
regle 111350:
application : iliad , batch ;

DLMRN4 = positif(DEFBIC3) * (
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))  * DEFBIC3
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                  * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4,0)-DEFBIC3,DEFBIC3)*(-1)
                  * positif_ou_nul(DEFBIC3-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4,0)))
                 * (1-PREM8_11) + DEFBIC3 * PREM8_11)*null(4-V_IND_TRAIT)
                  + (null(DEFBICNPF) * min(DEFBIC3,DEFNP - DEFNPI -DLMRN2-DLMRN3)
                  + positif(DEFBICNPF) * min(DEFBIC3,DEFBICNPF +DEFNP - DEFNPI- DLMRN1-DLMRN2-DLMRN3))*null(5-V_IND_TRAIT);
regle 111360:
application : iliad , batch ;

DLMRN5 = positif(DEFBIC4) * (
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * DEFBIC4
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                  * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5,0)-DEFBIC4,DEFBIC4)*(-1)
                  * positif_ou_nul(DEFBIC4-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5,0)))
                 * (1-PREM8_11) + DEFBIC4 * PREM8_11)*null(4-V_IND_TRAIT)
                  + (null(DEFBICNPF) * min(DEFBIC4,DEFNP - DEFNPI -DLMRN2-DLMRN3-DLMRN4)
                  + positif(DEFBICNPF) * min(DEFBIC4,DEFBICNPF +DEFNP - DEFNPI- DLMRN1-DLMRN2-DLMRN3-DLMRN4))*null(5-V_IND_TRAIT);
regle 111370:
application : iliad , batch ;

DLMRN6 =  positif(DEFBIC5) * (
                  (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * DEFBIC5
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                  * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6,0)-DEFBIC5,DEFBIC5)*(-1)
                  * positif_ou_nul(DEFBIC5-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6,0)))*null(4-V_IND_TRAIT)
                  + (null(DEFBICNPF) * min(DEFBIC5,DEFNP - DEFNPI - DLMRN2-DLMRN3-DLMRN4-DLMRN5)
                  + positif(DEFBICNPF) * min(DEFBIC5,DEFBICNPF +DEFNP - DEFNPI- DLMRN1-DLMRN2-DLMRN3-DLMRN4-DLMRN5))*null(5-V_IND_TRAIT);
regle 9030961 :
application :  iliad , batch  ;
DLMRN6P =  positif(DEFBIC5) *
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * DEFBIC5
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                  * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6,0)-DEFBIC5,DEFBIC5)*(-1)
                  * positif_ou_nul(DEFBIC5-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6,0)))*null(4-V_IND_TRAIT);
DLMRN5P = positif(DEFBIC4) *
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * DEFBIC4
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                  * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5,0)-DEFBIC4,DEFBIC4)*(-1)
                  * positif_ou_nul(DEFBIC4-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5,0)))*null(4-V_IND_TRAIT);
DLMRN4P = positif(DEFBIC3) *
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))  * DEFBIC3
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                  * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4,0)-DEFBIC3,DEFBIC3)*(-1)
                  * positif_ou_nul(DEFBIC3-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4,0)))*null(4-V_IND_TRAIT);
DLMRN3P = positif(DEFBIC2) *
                  ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))* DEFBIC2
                  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                    * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3,0)-DEFBIC2,DEFBIC2)*(-1)
                  * positif_ou_nul(DEFBIC2-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3,0)))*null(4-V_IND_TRAIT);
DLMRN2P = positif(DEFBIC1) *
                 ((1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))* DEFBIC1
                 + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
                 * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3-DEFBIC2,0)-DEFBIC1,DEFBIC1)*(-1)
                 * positif_ou_nul(DEFBIC1-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3-DEFBIC2,0)))*null(4-V_IND_TRAIT);
regle 903096 :
application :  iliad , batch  ;

DEFBA7 = min(DAGRI6,DAGRI- DBAIP- DEFBA2- DEFBA3- DEFBA4- DEFBA5 - DEFBA6);
DLMRN7 = min(DEFBIC6,DEFNP- DEFNPI- DLMRN2- DLMRN3- DLMRN4- DLMRN5 - DLMRN6);
DEFLOC11 = min(LNPRODEF10,TOTDEFLOCNP- DNPLOCIMPU- DEFLOC2- DEFLOC3- DEFLOC4- DEFLOC5- DEFLOC6- DEFLOC7- DEFLOC8- DEFLOC9 - DEFLOC10);
BNCDF7 = min(DABNCNP6,DABNCNP- DIDABNCNP- BNCDF2- BNCDF3- BNCDF4- BNCDF5 - BNCDF6);
RNIDF6 = min(DEFAA5,RNIDF- RNIDF2- RNIDF3- RNIDF4 - RNIDF5);
regle 111380:
application : iliad , batch ;

DLMRN = max(0, DEFNP - BICNPV*positif(BICNPV)-BICNPC*positif(BICNPC)-BICNPP*positif(BICNPP)
                     + abs(BICNPV)*(1-positif(BICNPV))*null(DLMRN1)
                     + abs(BICNPC)*(1-positif(BICNPC))*null(DLMRN1)
                     + abs(BICNPP)*(1-positif(BICNPP))*null(DLMRN1)) + DLMRN1;
TOTDLMRN = somme(i=1..6:DLMRNi);
DLMRNTXM = max(0,DEFNP - BICNPV*positif(BICNPV)-BICNPC*positif(BICNPC)-BICNPP*positif(BICNPP)
         +MIB_NETCT+MIB_NETNPCT+SPENETCT+SPENETNPCT + DLMRN1 
               );

regle 111390: 
application : iliad , batch ;


DRCVM = DPVRCM ;

regle 111400:
application : iliad , batch ;


BALNP = max(0,NOCEPIMP) ;


regle 111410:
application : iliad , batch ;



DALNP = (BNCDF1 + BNCDF2 + BNCDF3 + BNCDF4 + BNCDF5 + BNCDF6) ;

regle 111420:
application : iliad , batch ;


DESV = REPSOF ;

regle 111440:
application : iliad , batch ;


DFANT = (DEFAA5 + DEFAA4 + DEFAA3 + DEFAA2 + DEFAA1 + DEFAA0) * (1 - positif(PREM8_11) );
DFANTPROV = min(0,(RGPROV - DAR )) + SOMDEFICIT;
SFDFANTPROV = min(0,(SFRGPROV - DAR )) + SFSOMDEFICIT;

regle 90432 :
application : iliad , batch  ;
DFANTIMPUBAR = DFANTIMPU - max(0,min(DFANTIMPU, min(TOTALQUO,-(DFANTPROV - TOTALQUO-SOMDEFICIT))));
SFDFANTIMPUBAR = SFDFANTIMPU - max(0,min(SFDFANTIMPU, min(TOTALQUO,-(SFDFANTPROV - TOTALQUO-SFSOMDEFICIT))));
regle 90433 :
application : iliad , batch  ;
DFANTIMPUQUO = max(0,DFANTIMPU - DFANTIMPUBAR);
SFDFANTIMPUQUO = max(0,SFDFANTIMPU - SFDFANTIMPUBAR);
regle 111450:
application : iliad , batch ;

DFANTIMPU =  max(0,min(min(max(RNIDF_P+RNIDF_P,RNIDFP2+RNIDF6P2),RNIDF1731+RNIDF61731),
                   SOMDEFICIT-max(DFANTPROV1731-DEFBANI1731*(1-positif(SHBA1731-SEUIL_IMPDEFBA))* positif(SHBA-SEUIL_IMPDEFBA)
                              ,max(DFANTPROV_P-DEFBANI_P*(1-positif(SHBA_P-SEUIL_IMPDEFBA))* positif(SHBA-SEUIL_IMPDEFBA)
                              ,DFANTPROVP2-DEFBANIP2*(1-positif(SHBAP2-SEUIL_IMPDEFBA))* positif(SHBA-SEUIL_IMPDEFBA)))
                             -max(0,DFANTPROV - DFANTPROVP3 - DEFBANIP3 * positif(SEUIL_IMPDEFBA - SHBAP3)*positif(SHBA-SEUIL_IMPDEFBA))))
                                  * positif(positif(SOMMEGLOBAL_2)
                                          * positif(positif(SOMMEGLOBND_2)
                                          + (positif(SOMMEBAND_2)   * (1-positif(SHBA-SEUIL_IMPDEFBA)))
                                          + (positif(SOMMEBA_2)   * positif(RBAT+BAQTOTAVIS) * positif(SHBA-SEUIL_IMPDEFBA))
                                          + (positif(SOMMEBIC_2)  * positif(BICNPF))
                                          + (positif(SOMMELOC_2)  * positif(NPLOCNETF))
                                          + (positif(SOMMEBNC_2)  * positif(DEFBNCNPF))
                                          + (positif(SOMMERCM_2)  * positif(RCM))
                                          + (positif(SOMMERF_2)   * positif(RRFI+REVRF+RFDHIS))))
                                  * null(PREM8_11)
                         +  PREM8_11 * ( max(0,min(FRNV,min(-1 * TSPRVP2,-1 * TSPRV1731)))
                                       + max(0,min(FRNC,min(-1 * TSPRCP2,-1 * TSPRC1731)))
                                       + max(0,min(FRNP,min(-1 * TSPRPP2,-1 * TSPRP1731)))
                                      + SOMDEFBANI * (1-positif(SHBA-SEUIL_IMPDEFBA))
                                      + (BICPMVCTV+BICPMVCTC+BICPMVCTP - min(BICPMVCTV+BICPMVCTC+BICPMVCTP,max(MIBRNETVP2+MIBRNETCP2+MIBRNETPP2+MIBPVVP2+MIBPVCP2+MIBPVPP2,
                                                                                                                MIBRNETVP3+MIBRNETCP3+MIBRNETPP3+MIBPVVP3+MIBPVCP3+MIBPVPP3)))
                                      + (BICNOV + BICNOC + BICNOP
                                      + (BIHNOV + BIHNOC + BIHNOP) * MAJREV - (BIPNV+BIPNC+BIPNP))
                                      + (LOCPROCGAV + LOCPROCGAC + LOCPROCGAP
                                      + (LOCPROV + LOCPROC + LOCPROP) * MAJREV - (PLOCNETV+PLOCNETC+PLOCNETPAC))
                                      + (BNCREV + BNCREC + BNCREP
                                      + (BNHREV + BNHREC + BNHREP) * MAJREV - (BNRV+BNRC+BNRP))
                                      + (BNCPMVCTV+BNCPMVCTC+BNCPMVCTP-min(BNCPMVCTV+BNCPMVCTC+BNCPMVCTP,max(SPENETPVP2+SPENETPCP2+SPENETPPP2+BNCPROPVVP2+BNCPROPVCP2+BNCPROPVPP2,
                                                                                                           SPENETPVP3+SPENETPCP3+SPENETPPP3+BNCPROPVVP3+BNCPROPVCP3+BNCPROPVPP3)))
                                      + RFDHIS
                                      + DEFAA5 + DEFAA4 + DEFAA3 + DEFAA2 + DEFAA1 + DEFAA0
                                       )
                              ;
SFDFANTIMPU =  max(0,SFSOMDEFICIT-max(SFDFANTPROV1731-SFDEFBANI1731*(1-positif(SHBA1731-SEUIL_IMPDEFBA))* positif(SHBA-SEUIL_IMPDEFBA)
                              ,max(SFDFANTPROV_P-SFDEFBANI_P*(1-positif(SHBA_P-SEUIL_IMPDEFBA))* positif(SHBA-SEUIL_IMPDEFBA)
                              ,SFDFANTPROVP2-SFDEFBANIP2*(1-positif(SHBAP2-SEUIL_IMPDEFBA))* positif(SHBA-SEUIL_IMPDEFBA)))
                             -max(0,SFDFANTPROV - SFDFANTPROVP3 - SFDEFBANIP3 * positif(SEUIL_IMPDEFBA - SHBAP3)*positif(SHBA-SEUIL_IMPDEFBA)))
                                  * positif(positif(SOMMEGLOBAL_2)
                                          * positif(positif(SOMMEGLOBND_2)
                                          + (positif(SOMMEBAND_2)   * (1-positif(SHBA-SEUIL_IMPDEFBA)))
                                          + (positif(SOMMEBA_2)   * positif(RBAT) * positif(SHBA-SEUIL_IMPDEFBA))))
                                  * null(PREM8_11)
                         +  PREM8_11 * ( SFSOMDEFBANI * (1-positif(SHBA-SEUIL_IMPDEFBA))
                                       )
                              ;
DAR_REP =  somme (i=0..4:DEFAAi ) ;

regle 111460:
application : iliad , batch ;

SOMDFANTIMPU = DFANTIMPU+TSPRT + RBAT + MIBNETPTOT+BIPN+PLOCNETF+BICNPF+NPLOCNETF+SPENETPF+BNRTOT+BNCIF+RVTOT+RRCM+RRFI+DESV+VLHAB+ESFP+RE168+TAX1649+PREREV+R1649;

regle 111470:
application : iliad , batch ;


RRBG = (RG - DAR ) ;
RRRBG = max(0 , RRBG) ;
DRBG = min(0 , RRBG) ;

regle 111480:
application : iliad , batch ;


DDCSG = (V_BTCSGDED * (1-present(DCSG)) + DCSG) 
        + positif(RCMSOC+0) * (1 - V_CNR)
                            * (1 - positif(present(RE168)+present(TAX1649)))
          * arr( min( RCMSOC , RCMABD + REVACT + RCMAV + PROVIE + RCMHAD + DISQUO + RCMHAB + INTERE ) 
                    * TX051/100) ; 

RDCSG = max (min(DDCSG , RBG + TOTALQUO - SDD) , 0) ;

regle 111490:
application : iliad , batch ;


DPALE =  somme(i=1..4:CHENFi+NCHENFi) ;
RPALE = max(0,min(somme(i=1..4:min(NCHENFi,LIM_PENSALENF)+min(arr(CHENFi*MAJREV),LIM_PENSALENF)),
                RBG-DDCSG+TOTALQUO-SDD)) *(1-V_CNR) ;

regle 111500:
application : iliad , batch ;


DNETU = somme(i=1..4: CHENFi);
RNETU = max(0,min(somme(i=1..4:min(CHENFi,LIM_PENSALENF)),
                RBG+TOTALQUO-SDD-RPALE)) *(1-V_CNR);

regle 111510:
application : iliad , batch ;


DPREC = CHNFAC ;

regle 111520:
application : iliad , batch ;


DFACC = CHRFAC ;
RFACC = max( min(DDFA,RBG - RPALE - RPALP  - DDCSG + TOTALQUO - SDD) , 0) ;

regle 111530:
application : iliad ;


TRANSFERT = R1649 + PREREV + RE168 + TAX1649 ;

regle 111540:
application : iliad , batch ;


RPALP = max( min(TOTPA,RBG - RPALE - DDCSG + TOTALQUO - SDD) , 0 ) * (1 - V_CNR) ;
DPALP = PAAV + PAAP ;

regle 111550:
application : iliad , batch ;


DEDIV = (1-positif(RE168+TAX1649))*CHRDED ;
RDDIV = max( min(DEDIV * (1 - V_CNR),RBG - RPALE - RPALP - RFACC - DDCSG + TOTALQUO - SDD ) , 0 ) ;

regle 111560:
application : iliad , batch ;


NUPROPT = REPGROREP2 + REPGROREP1 + REPGROREP11 + REPGROREP12 + REPGROREP13 + REPGROREP14 + NUPROP ;

NUREPAR = min(NUPROPT , max(0,min(PLAF_NUREPAR, RRBG - RPALE - RPALP - RFACC - RDDIV - APERPV - APERPC - APERPP - DDCSG + TOTALQUO - SDD))) 
	  * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPNUREPART = max( NUPROPT - NUREPAR , 0 ) ;
 
REPAR6 = max( REPGROREP2 - NUREPAR , 0 ) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPAR5 = ( positif_ou_nul(REPGROREP2 - NUREPAR) * REPGROREP1
	 + (1-positif_ou_nul(REPGROREP2 - NUREPAR)) * max(REPGROREP1 + REPGROREP2 - NUREPAR , 0 )) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPAR4 = ( positif_ou_nul(REPGROREP1 + REPGROREP2 - NUREPAR) * REPGROREP11
	 + (1-positif_ou_nul(REPGROREP1 + REPGROREP2 - NUREPAR)) * max( REPGROREP11 + REPGROREP1 + REPGROREP2 - NUREPAR , 0 )) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPAR3 = ( positif_ou_nul(REPGROREP1 + REPGROREP2 + REPGROREP11 - NUREPAR) * REPGROREP12
	 + (1-positif_ou_nul(REPGROREP1 + REPGROREP2 + REPGROREP11 - NUREPAR)) * max( REPGROREP12 + REPGROREP11 + REPGROREP1 + REPGROREP2 - NUREPAR , 0 )) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPAR2 = ( positif_ou_nul(REPGROREP1 + REPGROREP2 + REPGROREP11 + REPGROREP12 - NUREPAR) * REPGROREP13
	 + (1-positif_ou_nul(REPGROREP1 + REPGROREP2 + REPGROREP11 + REPGROREP12 - NUREPAR)) 
                                                                     * max( REPGROREP13 + REPGROREP12 + REPGROREP11 + REPGROREP1 + REPGROREP2 - NUREPAR , 0 )) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPAR1 = ( positif_ou_nul(REPGROREP1 + REPGROREP2 + REPGROREP11 + REPGROREP12 + REPGROREP13 - NUREPAR) * REPGROREP14
	 + (1-positif_ou_nul(REPGROREP1 + REPGROREP2 + REPGROREP11 + REPGROREP12 + REPGROREP13 - NUREPAR)) 
                                                                     * max( REPGROREP14 + REPGROREP13 + REPGROREP12 + REPGROREP11 + REPGROREP1 + REPGROREP2 - NUREPAR , 0 )) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPAR = max( REPNUREPART - REPAR6 - REPAR5 - REPAR4 - REPAR3 - REPAR2 - REPAR1, 0 ) * ((V_REGCO+0) dans (1,3,5,6,7)) ;

REPNUREPAR =  REPAR6 + REPAR5 + REPAR4 + REPAR3 + REPAR2 + REPAR1 + REPAR ;

regle 111570:
application : iliad , batch ;


CHTOT = max( 0 , 
   min( DDPA + DDFA + (1-positif(RE168+TAX1649))*CHRDED + APERPV + APERPC + APERPP + NUREPAR , RBG
       - DDCSG + TOTALQUO - SDD) 
           )  * (1-V_CNR) ;

regle 111580:
application : iliad , batch ;


ABMAR = min(ABTMA,  max(RNG + TOTALQUO - SDD - SDC - ABTPA , 0)) ;

regle 111590:
application : iliad , batch ;


ABVIE = min(ABTPA,max(RNG+TOTALQUO-SDD-SDC,0)) ;

regle 111600:
application : iliad , batch ;


RNI = arr(RI1) ;

regle 111610:
application : iliad , batch ;

TOTALQUORET = min(TOTALQUO,max(TOTALQUO1731,max(TOTALQUO_P,TOTALQUOP2)));
RNIDF = ((1 - positif_ou_nul( RG-DAR+TOTALQUO )) 
         * (
         (1 - positif_ou_nul(RG + TOTALQUO)) *
          (((RG + TOTALQUO) * (-1)) + DAR_REP)
         + null(RG+TOTALQUO) * (DAR_REP)
         + positif(RG + TOTALQUO) *
           (positif(RG + TOTALQUO - DEFAA5) * (RG + TOTALQUO - DAR )
	   + (1 -positif(RG + TOTALQUO - DEFAA5)) * DAR_REP)
           ) * (1-positif(DFANTIMPU))
        +  positif(DFANTIMPU) * max(0,DFANTIMPU - DEFAA5 + max(0,min(DEFAA5,DFANT-DFANTIMPU))));

RNIDF1 = ((1-positif_ou_nul(RG + TOTALQUO)) * DEFAA0
        + positif_ou_nul(RG + TOTALQUO) *
        min(max(RG+TOTALQUO-DEFAA5 -DEFAA4 -DEFAA3 -DEFAA2 -DEFAA1,0) -DEFAA0, DEFAA0)*(-1)
     * positif_ou_nul(DEFAA0 -max(RG+TOTALQUO-DEFAA5 -DEFAA4 -DEFAA3 -DEFAA2 -DEFAA1,0)))
          * null(4-V_IND_TRAIT)
         + null(5-V_IND_TRAIT) * min(DEFAA0,RNIDF);
RNIDF2 = ((1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA1) * (1-PREM8_11)
        + positif_ou_nul(RG + TOTALQUO) *
        min(max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3-DEFAA2,0)-DEFAA1,DEFAA1)*(-1)
        * positif_ou_nul(DEFAA1-max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3-DEFAA2,0)))
          * null(4-V_IND_TRAIT)
         + null(5-V_IND_TRAIT) * min(DEFAA1,RNIDF - RNIDF1);
RNIDF3 = ((1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA2)
        + positif_ou_nul(RG + TOTALQUO) *
        min(max(RG+TOTALQUO-DEFAA5 -DEFAA4 -DEFAA3,0) -DEFAA2, DEFAA2)*(-1)
     * positif_ou_nul(DEFAA2 -max(RG+TOTALQUO-DEFAA5 -DEFAA4 -DEFAA3,0)))
          * null(4-V_IND_TRAIT)
         + null(5-V_IND_TRAIT) * min(DEFAA2,RNIDF - RNIDF1 - RNIDF2);

RNIDF4 = ((1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA3)
        + positif_ou_nul(RG + TOTALQUO) *
        min(max(RG+TOTALQUO-DEFAA5 -DEFAA4,0) -DEFAA3, DEFAA3)*(-1)
     * positif_ou_nul(DEFAA3 -max(RG+TOTALQUO-DEFAA5 -DEFAA4,0)))
          * null(4-V_IND_TRAIT)
         + null(5-V_IND_TRAIT) *  min(DEFAA3,RNIDF - RNIDF1 - RNIDF2 - RNIDF3);
RNIDF5 = ((1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA4)
        + positif_ou_nul(RG + TOTALQUO) *
        min(max(RG+TOTALQUO-DEFAA5,0) -DEFAA4, DEFAA4)*(-1) * positif_ou_nul(DEFAA4 -max(RG+TOTALQUO-DEFAA5,0)))
          * null(4-V_IND_TRAIT)
         + null(5-V_IND_TRAIT) *  min(DEFAA4,RNIDF - RNIDF1 - RNIDF2 - RNIDF3 - RNIDF4);
RNIDF0 = ((1-positif(RG + TOTALQUO)) * (RG + TOTALQUO) * (-1)) * null(4-V_IND_TRAIT)
         + null(5-V_IND_TRAIT) * (RNIDF - RNIDF1 - RNIDF2 - RNIDF3 - RNIDF4 - RNIDF5) ;

regle 111620:
application : batch , iliad ;


RNICOL = (RNI + RNIDF) ;

regle 111630:
application : iliad , batch ;

 
TTPVQ = TONEQUOHT + DFANTIMPUQUO;

regle 111640:
application : iliad , batch ;


TEFF = IPTEFP - IPTEFN + TEFFREVTOT ; 
TEFFP_1 = max(0, TEFF);
TEFFP_2 = (max(0, TEFF) * null(SOMMEMOND_2+0) * null(PREM8_11)
        + positif(positif(SOMMEMOND_2)+positif(PREM8_11))  *  max(0,(1-INDTEFF)*IPTEFP+TEFFREVTOT*INDTEFF+DEFZU-IPTEFN)) * (1-PREM8_11);
TEFFP = TEFFP_2;
TEFFN_1 = ((1-positif_ou_nul(TEFF)) * ( min(0, TEFF) * (-1) ) + 0);
TEFFN_2 = ((1-positif_ou_nul(TEFF)) * ( min(0, TEFF) * (-1) ) + 0) * null(SOMMEMOND_2+0) * null(PREM8_11) + 0;
TEFFN = TEFFN_2;
RDMO = TEFF + (VARRMOND * positif(SOMMEMOND_2) + RMOND * (1 - positif(SOMMEMOND_2*PREM8_11)))
                           - (VARDMOND * positif(SOMMEMOND_2) + DMOND * (1 - positif(SOMMEMOND_2*PREM8_11)));

RMONDT = positif(RMOND + DEFZU - DMOND) * (RMOND + DEFZU - DMOND) ;

DMONDT = max(0 , RMOND + DEFZU - DMOND) ;
RMOND_1 =  RMOND;
RMOND_2 =  max(0,RMOND + DEFZU - DMOND) * positif(positif(SOMMEMOND_2) + positif(PREM8_11))
           + RMOND *  null(SOMMEMOND_2+0) * null(PREM8_11);
DMOND_1 =  DMOND;
DMOND_2 =  DMOND *  null(SOMMEMOND_2+0)* null(PREM8_11) +0;

regle 111650:
application : iliad , batch ;


FRF = somme (i=V,C,1,2,3,4: FRDi * (1-IND_10i))*(1-positif(APPLI_COLBERT+APPLI_OCEANS)) ;

regle 111660:
application : iliad , batch ;


QUOHPV = somme(i=VO,CJ,PC:TSQi + PRQi)+ PALIQV + PALIQC + PALIQP
       + BAQV + BAQC + BAQP
       + BRCMQ + RFQ + somme(x=1..3;i=V,C:GLDxi) ;

regle 111670:
application : iliad ;


TX_CSG = T_CSG * (1-positif(APPLI_OCEANS));
TX_RDS = T_RDS * (1-positif(APPLI_OCEANS));
TX_PREL_SOC = (positif(V_EAG + V_EAD) * (T_PREL_SOCDOM)
              + positif(( 1-V_EAD ) * ( 1-V_EAG )) * (T_PREL_SOC))
	      * (1-V_CNR) * (1-positif(APPLI_OCEANS));
TX_IDCSG = T_IDCSG * (1-positif(APPLI_OCEANS));

regle 111680:
application : batch , iliad ;

SURIMP = IPSURSI ;

REPPLU = CREDPVREP + V_BTPVREP * (1-present(CREDPVREP)) ;

regle 111690:
application : iliad ;

INDM14 = positif_ou_nul(IREST - LIM_RESTIT) * (1-positif(APPLI_OCEANS)) ;

regle 111700:
application : iliad ;

INDDEFICIT = positif(RNIDF1 + DEFBA6 + DEFBA5 + DEFBA4 + DEFBA3 + DEFBA2 +DEFBA1
		   + DRFRP + DLMRN1 + DALNP + IRECR + DPVRCM + MIBDREPV + MIBDREPC
                   + MIBDREPP + MIBDREPNPV + MIBDREPNPC + MIBDREPNPP + SPEDREPV + SPEDREPC
                   + SPEDREPP + SPEDREPNPV + SPEDREPNPC + SPEDREPNPP) * (1-positif(APPLI_OCEANS)) ;

regle 111710:
application : iliad , batch ;

RP = somme (i=V,C: TSNNi + TSNN2i + BICIMPi + BICNPi + BNNi +  max(0,BANi) + BAEi)
                 + (min (0,BANV) + min (0,BANC)) *
                 (1 - positif(1 + SEUIL_IMPDEFBA - SHBA - REVQTOTQHT
                 - (REVTP - BA1)  ))
                 + max(0 , ANOCEP - ((min(DNOCEP,DNOCEP1731+0) * positif(DEFRI) + DNOCEP * (1 - positif(DEFRI)))
		 +(min(DABNCNP6,DABNCNP61731+0) * positif(DEFRI) + DABNCNP6 * (1 - positif(DEFRI)))
		 +(min(DABNCNP5,DABNCNP51731+0) * positif(DEFRI) + DABNCNP5 * (1 - positif(DEFRI)))
		 +(min(DABNCNP4,DABNCNP41731+0) * positif(DEFRI) + DABNCNP4 * (1 - positif(DEFRI)))
		 +(min(DABNCNP3,DABNCNP31731+0) * positif(DEFRI) + DABNCNP3 * (1 - positif(DEFRI)))
		 +(min(DABNCNP2,DABNCNP21731+0) * positif(DEFRI) + DABNCNP2 * (1 - positif(DEFRI)))
		 +(min(DABNCNP1,DABNCNP11731+0) * positif(DEFRI) + DABNCNP1 * (1 - positif(DEFRI)))
		 ) ) + somme(i=1..3:GLNi) ;

regle 111720:
application : iliad , batch ;


AGREPAPER = PALIV + PALIC + PALIP + PENSALV + PENSALC + PENSALP ;

AGREPARET = RPALE + RPALP ;

AGREPPE = max(0,PPETOTX-PPERSA) ;

AGREDTARDIF = positif(RETIR + RETTAXA + RETPCAP + RETLOY + RETHAUTREV + RETCS + RETRD + RETPS
                      + RETCVN + RETCDIS + RETGLOA + RETRSE1 + RETRSE2 + RETRSE3 + RETRSE4 
                      + RETRSE5 + RETRSE6
                      + RETARPRIM + FLAG_RETARD + 0) ;
AGABAT = ABVIE + ABMAR ;
AGREVTP = REVTP ;
AGREI = REI ;
AGPENA = PTOTIRCS ;
AGRECI = max(0,INE + IRE + CICAP + CICHR - AGREPPE) ;
AGRECITOT = INE + IRE + CICAP + CICHR ;
AGRRCM = RRCM + 2RCM;
AGRCVM = BPVRCM + COD3SG + CODRVG;
AGRRF = RRFI + REVRF;
AGRBAR = SFRBAT + SFBAQTOTAVIS;

