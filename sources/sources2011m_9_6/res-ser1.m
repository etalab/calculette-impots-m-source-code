#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2012 
#au titre des revenus percus en 2011. La présente version a permis la 
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
regle 9500:
application :  iliad , pro, oceans , bareme ,batch;
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
regle 9501:
application : batch , iliad, pro, oceans , bareme ;

BOOL_V = positif(V_0AV+0) * positif(1 - BOOL_0AZ) 
			  * ((1 - positif(PAC + V_0CH + 0))
			     + positif(PAC + V_0CH + 0) * (3 - null(EAC + V_0CH + 0))) ;
BOOL_CDV = positif( BOOL_V + V_0AC + V_0AD + 0);
BOOL_PACSFL = 1 - positif( PAC +V_0CH + 0);
BOOL_W = positif(V_0AW + 0) * positif_ou_nul( AGV - LIM_AGE_LET_S );
SFCD1 = ( 15 * positif(V_0AN + 0) * (1 - positif(V_0AP + 0)) * (1 - positif(V_0AG + 0)) * (1 - BOOL_W)         
 
       + 2 * positif(V_0AP + 0) * (1-positif(V_0AL+0))          


	+ 5 * ( positif(V_0AE+0) * positif(V_BT0AE + ZONEANTEK + 0))
	     
	     * (1 - positif(V_0AN + 0)) * (1 - positif(V_0AP + 0)) * positif(1-(V_0AG + 0)) * (1 - BOOL_W)


       + 14 * positif(V_0AG + 0) * (1 - positif(V_0AP + 0)) * (1 - BOOL_W)                   

       + 7 * BOOL_W * (1 - positif(V_0AP + 0)))
       
       * (1-positif(V_0AL+0)) * BOOL_CDV * BOOL_PACSFL;

regle 9507:
application : batch , iliad , pro , oceans , bareme ;
SFL = positif (V_0AL + 0) * BOOL_CDV * BOOL_PACSFL *

      ( 2 * positif(V_0AP + 0) 

      + 9 * ( 1 - BOOL_W ) * positif( 1- V_0AP + 0) * positif(1-(V_0AG + 0)) * positif (1-(V_0AN+0))  

      + 7 * BOOL_W * positif(1-(V_0AP + 0)) 

      + 15 * positif (V_0AN +0) * ( 1 - BOOL_W ) * positif(1-(V_0AG + 0)) * positif(1-(V_0AP + 0)) 

      + 14 * positif (V_0AG +0) * ( 1 - BOOL_W ) * positif(1-(V_0AP + 0))) ;
regle 9502:
application : batch , iliad , pro , oceans , bareme ;


SFCD2 = positif(PAC+V_0CH) * positif(V_0AC + V_0AD + null(2- BOOL_V)) *
        (
            10 * positif(V_0BT+0) * (1 - positif(V_0AV)) * positif(V_0AP)
           + 2 * positif(V_0AV) * positif(V_0AP)
	   + 2 * (1 - positif(V_0AV)) *(1 - positif(V_0BT+0)) * positif(V_0AP)
           +11 * positif(V_0BT+0)*(1-positif(V_0AP))*(1-positif(V_0CR))
         );	



regle 9503:
application : batch , iliad , pro, oceans , bareme ;

SFV1 = 2 * positif(V_0AP + 0) * null(BOOL_V - 3) ;

regle 9504:
application : batch , iliad , pro, oceans , bareme ;
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
regle 9505:
application : batch , iliad , pro, oceans , bareme ;
BOOL_0AM = positif(positif(V_0AM + 0 )  + positif(V_0AO + 0)) ;
regle 9506:
application : batch , iliad , pro, oceans , bareme ;
SFUTILE = SFM + SFCD1 + SFCD2 + SFV1 + SFV2 + SFL ;
regle 9510:
application : pro , iliad ;
NATPENA = si (CMAJ =7 ou CMAJ =8 ou CMAJ=9 ou CMAJ=10 ou CMAJ=11 ou CMAJ=12 ou CMAJ=17 ou CMAJ=18 )
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
regle 901:
application : oceans ;
TSALV = TSBNV;
TSALC = TSBNC;
regle 902:
application : pro , oceans , iliad , batch  ;
TSALP = TSBN1 + TSBN2 + TSBN3 + TSBN4;
regle 903 :
application : pro ,  iliad , oceans , batch  ;
pour i = V,C,1..4:
F10Ai = si (IND_10i = 0 ou
       (IND_10i = 1 et IND_10MIN_0i = 0))
        alors (max(FRDi,DFNi))
       finsi;
regle 90301 :
application : pro , oceans , iliad , batch  ;
F10AP = somme(i=1..4:F10Ai);  
regle 90302 :
application : pro , oceans , iliad , batch  ;
pour i = V,C,1..4:
F10Bi = si (IND_10i = 1 et IND_10MIN_0i = 1)
        alors (10MINSi)
       finsi;
regle 90303 :
application : pro , oceans , iliad , batch  ;
F10BP = somme(i=1..4:F10Bi);
regle 904 :
application : pro , oceans , iliad , batch  ;
pour i = V,C,1,2,3,4:
DEDSi =  (10MINSi - DFNi) * (1-positif(F10Bi)) * IND_10i ;
regle 90401 :
application : pro , oceans , iliad , batch  ;
DEDSP = somme( i=1..4: DEDSi ) ;
regle 905 :
application : pro , oceans , iliad , batch ;
PRV = PRBRV;
PRC = PRBRC;
PRP = PRBR1 + PRBR2 + PRBR3 + PRBR4 ;
PALIP = PALI1 + PALI2 + PALI3 + PALI4;
regle 906 :
application : pro , oceans , iliad , batch  ;
pour i = V,C:
AB10i = APRi;
AB10P = APR1 + APR2 + APR3 + APR4 ;
regle 909:
application : pro , iliad , batch , oceans ;
TSPRT = TSPRV + TSPRC + TSPRP ;
regle 9011 :
application : pro , oceans , iliad , batch ;
pour i = V,C,P:
RBAi = BAHREi + 4BAHREi
     + BACREi + 4BACREi
     + BAFORESTi
     + BAFi + BAFPVi- BACDEi- BAHDEi;
regle 9013 :
application : pro , oceans , iliad , batch ;
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
MLOCDECi = MIBGITEi + MIBMEUi ;
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
regle 9014 :
application : pro , oceans , iliad , batch  ;

pour i=V,C,P:
BINi = 
   BICREi  
 - BICDEi  
 + BICHREi  
 - BICHDEi  
 ;  

regle 90141 :
application : pro , oceans , iliad , batch  ;

pour i=V,C,P:
BINNi= BINTAi + BINHTAi;
regle 9015 :
application : pro , oceans , iliad , batch  ;
BNCV = BNHREV + BNCREV - BNHDEV - BNCDEV;
BNCC = BNHREC + BNCREC - BNHDEC - BNCDEC;
BNCP = BNHREP + BNCREP - BNHDEP - BNCDEP;
regle 9016 :
application : pro , oceans ,  iliad , batch  ;
DIDABNCNP =  abs(min(NOCEPIMP+SPENETNPF,DABNCNP6+DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1)
	     *positif(DABNCNP6+DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1)*positif(NOCEPIMP+SPENETNPF));
BNCIF = max (0,NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2-DABNCNP1);
regle 9024 :
application : pro , iliad , oceans, batch ;
BRCM = RCMABD + RCMTNC + RCMAV + RCMHAD + RCMHAB + REGPRIV;
regle 90240 :
application : pro , iliad , oceans, batch ;
BRCMQ = REVACT + REVPEA + PROVIE + DISQUO + RESTUC + INTERE;
regle 90241 :
application : pro , oceans , iliad , batch  ;
RRCM = max(0,RCM);
regle 9026 :
application : pro , oceans , iliad , batch  ;
B1FIS = max( RCM+2RCM+3RCM+4RCM+5RCM+6RCM+7RCM , 0 );
regle 9028 :
application : pro , oceans , iliad , batch  ;
DRFRP = (1-positif(IPVLOC)) * (abs (DFCE+DFCG) * (1-positif(RFMIC))
             + positif(RFMIC) *  abs(min(0,RFMIC - MICFR - RFDANT)) );
regle 9030 :
application : pro , oceans , iliad , batch  ;


DLMRN1TXM = - min(0,MIB_NETCT *(1-positif(MIBNETPTOT))
                          +SPENETCT * (1 - positif(SPENETPF)));
DLMRN6 =  positif(DEFBIC5) * (
	    (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * max(0,DEFBIC5-max(0,DEFNPI-DEFBIC6))
	  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
           * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6,0)-DEFBIC5,DEFBIC5)*(-1)
           * positif_ou_nul(DEFBIC5-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6,0))
			     );
DLMRN5 = positif(DEFBIC4) * (
	     (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * max(0,DEFBIC4+min(0,DEFBIC5-max(0,DEFNPI-DEFBIC6)))
	  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
           * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5,0)-DEFBIC4,DEFBIC4)*(-1)
           * positif_ou_nul(DEFBIC4-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5,0))     
			     );
DLMRN4 = positif(DEFBIC3) * (
	      (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))  * max(0,DEFBIC3+min(0,DEFBIC5+DEFBIC4-max(0,DEFNPI-DEFBIC6)))
	  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
           * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4,0)-DEFBIC3,DEFBIC3)*(-1)
           * positif_ou_nul(DEFBIC3-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4,0))
			     );
DLMRN3 = positif(DEFBIC2) * (
	      (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))* max(0,DEFBIC2+min(0,DEFBIC5+DEFBIC4+DEFBIC3-max(0,DEFNPI-DEFBIC6)))
	  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
           * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3,0)-DEFBIC2,DEFBIC2)*(-1)
           * positif_ou_nul(DEFBIC2-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3,0))
			     );
DLMRN2 = positif(DEFBIC1) * (
	      (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))* max(0,DEFBIC1+min(0,DEFBIC5+DEFBIC4+DEFBIC3+DEFBIC2-max(0,DEFNPI-DEFBIC6)))
	  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
           * min(max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3-DEFBIC2,0)-DEFBIC1,DEFBIC1)*(-1)
           * positif_ou_nul(DEFBIC1-max(somme(i=V,C,P:BICNPi)+MIB_NETNPCT-DEFBIC6-DEFBIC5-DEFBIC4-DEFBIC3-DEFBIC2,0))
			    );
DLMRN1 = (1-positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)) * abs(somme(i=V,C,P:BICNPi)-DEFNPI+MIB_NETNPCT)
	  + positif_ou_nul(somme(i=V,C,P:BICNPi)+MIB_NETNPCT)
		      * positif_ou_nul(DEFBIC5+DEFBIC4+DEFBIC3+DEFBIC2+DEFBIC1-(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))
                      * (DEFBIC5+DEFBIC4+DEFBIC3+DEFBIC2+DEFBIC1-(somme(i=V,C,P:BICNPi)+MIB_NETNPCT))
                      * null(DLMRN6+DLMRN5+DLMRN4+DLMRN3+DLMRN2) ;
DLMRN = max(0, DEFNP - BICNPV*positif(BICNPV)-BICNPC*positif(BICNPC)-BICNPP*positif(BICNPP)
                     + abs(BICNPV)*(1-positif(BICNPV))*null(DLMRN1)
                     + abs(BICNPC)*(1-positif(BICNPC))*null(DLMRN1)
                     + abs(BICNPP)*(1-positif(BICNPP))*null(DLMRN1)) + DLMRN1;
TOTDLMRN = somme(i=1..6:DLMRNi);
DLMRNTXM = max(0,DEFNP - BICNPV*positif(BICNPV)-BICNPC*positif(BICNPC)-BICNPP*positif(BICNPP)
         +MIB_NETCT+MIB_NETNPCT+SPENETCT+SPENETNPCT + DLMRN1 
               );
regle 90305: 
application : pro , oceans , iliad , batch  ;
DRCVM = DPVRCM ;
regle 9031 :
application : pro , oceans , iliad , batch  ;
BALNP = max(0,NOCEPIMP);
NOCEP = ANOCEP - (DNOCEP + DABNCNP6+DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1);
regle 9032 :
application : pro , oceans , iliad , batch  ;
DALNP = (1-positif(IPVLOC)) * (BNCDF1+BNCDF2+BNCDF3+BNCDF4+BNCDF5+BNCDF6);
regle 9033 :
application :  pro , oceans , iliad , batch  ;
DESV =  REPSOF;
regle 9042 :
application : pro, batch, oceans , iliad  ;
VLHAB = max ( 0 , IPVLOC ) ;
regle 9043 :
application : pro , oceans , iliad , batch  ;
DFANT = DAR;
DAR_REP =  somme (i=0..4:DEFAAi) * (1 - positif(IPVLOC));
regle 9044 :
application : pro , oceans , iliad , batch  ;
RRBG = (RG - DAR ) *(1-positif(RE168+TAX1649)) + positif(RE168+TAX1649) * (RE168+TAX1649);
RRRBG = max(0 , RRBG);
DRBG = min(0 , RRBG);
regle 9045 :
application : pro , oceans , iliad , batch  ;
DDCSG = (V_BTCSGDED * (1-present(DCSG)) + DCSG) * (1-null(4 -V_REGCO)) 
	+ arr(RCMSOC * T_IDCSG/100) * (1 - positif(null(2-V_REGCO)+null(4-V_REGCO))) ;

RDCSG = max (min(DDCSG , RBG + TOTALQUO - SDD) , 0);
regle 9047 :
application : pro , oceans , iliad , batch  ;
DPALE =  somme(i=1..4:CHENFi+NCHENFi);
RPALE = max(0,min(somme(i=1..4:min(NCHENFi,LIM_PENSALENF)+min(arr(CHENFi*MAJREV),LIM_PENSALENF)),
                RBG-DDCSG+TOTALQUO-SDD)) *(1-V_CNR);
regle 9049 :
application : pro , oceans , iliad , batch  ;
DNETU = somme(i=1..4: CHENFi);
RNETU = max(0,min(somme(i=1..4:min(CHENFi,LIM_PENSALENF)),
                RBG+TOTALQUO-SDD-RPALE)) *(1-V_CNR);
regle 9050 :
application : pro , oceans , iliad , batch  ;
DPREC = CHNFAC;
regle 9051 :
application : pro , oceans , iliad , batch  ;
DFACC = CHRFAC;
RFACC = max( min(DFA,RBG - RPALE - RPALP  - DDCSG + TOTALQUO - SDD) , 0);
regle 9052 :
application : oceans ;
TRANSFERT = R1649+PREREV+RE168+TAX1649;
regle 9054 :
application : pro , oceans , iliad , batch  ;
RPALP = max( min(TOTPA,RBG - RPALE - DDCSG + TOTALQUO - SDD) , 0 ) * (1 -V_CNR);
DPALP = PAAV + PAAP ;
regle 9055 :
application : pro , oceans , iliad , batch  ;
DEDIV = (1-positif(RE168+TAX1649))*CHRDED;
RDDIV = max( min(DEDIV * (1 - V_CNR),RBG - RPALE - RPALP - RFACC - DDCSG + TOTALQUO - SDD ) , 0 );

regle 90551 :
application : pro , oceans , iliad , batch  ;

NUPROPT = REPGROREP2 + REPGROREP1 + NUPROP ;

NUREPAR = min(NUPROPT , max(0,min(PLAF_NUREPAR, RRBG - RPALE - RPALP - RFACC - RDDIV - APERPV - APERPC - APERPP - DDCSG + TOTALQUO - SDD))) 
	  * (1 - V_CNR) ;

REPNUREPAR = max( NUPROPT - NUREPAR , 0 ) ;
 
REPAR2 = max( REPGROREP2 - NUREPAR , 0 ) * (1 - V_CNR) ;

REPAR1 = ( positif_ou_nul(REPGROREP2 - NUREPAR) * REPGROREP1
	 + (1-positif_ou_nul(REPGROREP2 - NUREPAR)) * max( REPGROREP1 + REPGROREP2 - NUREPAR , 0 )) * (1 - V_CNR) ;

REPAR = max( REPNUREPAR - REPAR1 - REPAR2, 0 ) * (1 - V_CNR) ;

regle 9059 :
application : pro , oceans , iliad , batch  ;
CHTOT = max( 0 , 
   min( DPA + DFA + (1-positif(RE168+TAX1649))*CHRDED + APERPV + APERPC + APERPP + NUREPAR , RBG
       - DDCSG + TOTALQUO - SDD) 
           )  * (1-V_CNR);
regle 9060 :
application : pro , oceans , iliad , batch  ;
ABMAR = min(ABTMA,  max(RNG + TOTALQUO - SDD - SDC - ABTPA , 0));
regle 9061 :
application : pro , oceans , iliad , batch  ;
ABVIE = min(ABTPA,max(RNG+TOTALQUO-SDD-SDC,0));
regle 9062 :
application : pro , oceans , iliad , batch  ;
RNI =   positif(RG+R1649+PREREV) * arr(RI1) * (1-positif(RE168+TAX1649))
      + (RE168+TAX1649) * positif(RE168+TAX1649);
regle 9063 :
application : pro , oceans , iliad , batch  ;
RNIDF = (1 - positif_ou_nul( RG-DAR+TOTALQUO )) 
         * (
         (1 - positif_ou_nul(RG + TOTALQUO)) *
          (((RG + TOTALQUO) * (-1)) + DAR_REP)
         + null(RG+TOTALQUO) * (DAR_REP)
         + positif(RG + TOTALQUO) *
           (positif(RG + TOTALQUO - DEFAA5) * (RG + TOTALQUO - DAR )
	   + (1 -positif(RG + TOTALQUO - DEFAA5)) * DAR_REP)
           );
RNIDF0 = (1-positif(RG + TOTALQUO)) * (RG + TOTALQUO) * (-1);

RNIDF1 = (1-positif_ou_nul(RG + TOTALQUO)) * (DEFAA0)
        + positif_ou_nul(RG + TOTALQUO) * 
        min(max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3-DEFAA2-DEFAA1,0)-DEFAA0,DEFAA0)*(-1)
     * positif_ou_nul(DEFAA0-max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3-DEFAA2-DEFAA1,0));

RNIDF2 = (1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA1)
        + positif_ou_nul(RG + TOTALQUO) * 
        min(max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3-DEFAA2,0)-DEFAA1,DEFAA1)*(-1)
     * positif_ou_nul(DEFAA1-max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3-DEFAA2,0));

RNIDF3 = (1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA2)
        + positif_ou_nul(RG + TOTALQUO) * 
        min(max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3,0)-DEFAA2,DEFAA2)*(-1)
     * positif_ou_nul(DEFAA2-max(RG+TOTALQUO-DEFAA5-DEFAA4-DEFAA3,0));

RNIDF4 = (1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA3)
        + positif_ou_nul(RG + TOTALQUO) * 
        min(max(RG+TOTALQUO-DEFAA5-DEFAA4,0)-DEFAA3,DEFAA3)*(-1)
     * positif_ou_nul(DEFAA3-max(RG+TOTALQUO-DEFAA5-DEFAA4,0));

RNIDF5 = (1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA4)
        + positif_ou_nul(RG + TOTALQUO) * 
        min(max(RG+TOTALQUO-DEFAA5,0)-DEFAA4,DEFAA4)*(-1)
     * positif_ou_nul(DEFAA4-max(RG+TOTALQUO-DEFAA5,0));

RNIDF6 = (1 - positif_ou_nul(RG + TOTALQUO)) * (DEFAA5)
        + positif_ou_nul(RG + TOTALQUO) * 
        min(RG+TOTALQUO-DEFAA5,DEFAA5)*(-1)
     * positif_ou_nul(DEFAA5-max(RG+TOTALQUO,0));
regle 90631 :
application : pro,iliad ;
RNICOL = RNI + RNIDF;
regle 9064 :
application : pro , oceans , iliad , batch  ;
TTPVQ = TONEQUO;
regle 9067 :
application : pro , oceans , iliad , batch ;
BPTPD = BTP3A * positif(V_EAD)*(1-positif(present(TAX1649)+present(RE168)));
BPTPG = BTP3A * positif(V_EAG)*(1-positif(present(TAX1649)+present(RE168)));
BPTP2 = BTP2*(1-positif(present(TAX1649)+present(RE168)));
BPTP4 = BPCOPT * (1 - positif(IPVLOC))*(1-positif(present(TAX1649)+present(RE168)));
BPTP3 = BTP3A * (1 - positif(V_EAD + V_EAG))*(1-positif(present(TAX1649)+present(RE168)));

BPTP40 = BTP40 * (1-positif(present(TAX1649)+present(RE168))) ;
BPTP18 = BTP18 * (1-positif(present(TAX1649)+present(RE168))) ; 
BPTP19 = (BTP3G + BTP3N + BTP5*(1-positif(null(5-V_REGCO)+null(6-V_REGCO)))) * (1-positif(present(TAX1649)+present(RE168))) ; 
BPTP5 = BTP5 * (1-positif(present(TAX1649)+present(RE168))) ;
BPTPDIV = (BPVCESDOM * (1-positif(IPVLOC)) + BTP5) * (1-positif(present(TAX1649)+present(RE168))) ;

regle 9069 :
application : pro , oceans , iliad , batch  ;
TEFF = IPTEFP - IPTEFN + TEFFREVTOT ; 
TEFFP = max(0, TEFF);
TEFFN = si (TEFF + 0 < 0)
        alors
          ( min(0, TEFF) * (-1) )
        sinon
          ( 0 )
        finsi;
RDMO = TEFF + RMOND - DMOND ;
regle 90691 :
application : iliad , batch ;
FRF = somme (i=V,C,1,2,3,4: FRDi * (1-IND_10i));
regle 9070 :
application : pro , oceans , iliad , batch;
QUOHPV = somme(i=VO,CJ,PC:TSQi + PRQi)+ PALIQV + PALIQC + PALIQP
       + BAQV + BAQC + BAQP
       + BRCMQ + RFQ + somme(x=1..3;i=V,C:GLDxi) ;
regle 90705:
application : iliad ;
TX_CSG = T_CSG;
TX_RDS = T_RDS;
TX_PREL_SOC = (positif(V_EAG + V_EAD) * (T_PREL_SOCDOM)
              + positif(( 1-V_EAD ) * ( 1-V_EAG )) * (T_PREL_SOC))
	      * (1-V_CNR);
TX_IDCSG = T_IDCSG;
regle 90707:
application : batch, pro, oceans , iliad ;

SURIMP = IPSURSI ;

REPPLU = CREDPVREP + V_BTPVREP * (1-present(CREDPVREP)) ;

regle 90708:
application : iliad ;
INDM14 = positif_ou_nul(IREST - LIM_RESTIT);
regle 90709:
application : iliad ;
INDDEFICIT = positif(RNIDF1 + DEFBA6 + DEFBA5 + DEFBA4 + DEFBA3 + DEFBA2 +DEFBA1
		   + DRFRP + DLMRN1 + DALNP + IRECR + DPVRCM + MIBDREPV + MIBDREPC
                   + MIBDREPP + MIBDREPNPV + MIBDREPNPC + MIBDREPNPP + SPEDREPV + SPEDREPC
                   + SPEDREPP + SPEDREPNPV + SPEDREPNPC + SPEDREPNPP);
