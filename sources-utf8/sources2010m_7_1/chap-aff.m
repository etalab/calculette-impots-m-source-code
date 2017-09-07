#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2011 
#au titre des revenus perçus en 2010. La présente version a permis la 
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
regle 111011:
application :  iliad;
CONST0 = 0;
CONST1 = 1;
CONST2 = 2;
CONST3 = 3;
CONST4 = 4;
CONST10 = 10;
CONST20 = 20;
CONST40 = 40;
regle 1110:
application : batch, pro  , oceans, iliad;
LIG0 = (1 - positif(IPVLOC)) * (1 - positif(RE168+TAX1649)) * IND_REV;
LIG1 = (1-positif(RE168+TAX1649)) ;
regle 1110010:
application : pro , oceans, iliad;
LIG0010 = ( INDV * INDC * INDP ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1110020:
application : pro , oceans, iliad;
LIG0020 = ( INDV * (1 - INDC) * (1 - INDP) ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1110030:
application : pro , oceans, iliad;
LIG0030 = ( INDC * (1 - INDV) * (1 - INDP) ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1110040:
application : pro , oceans, iliad;
LIG0040 = ( INDP * (1 - INDV) * (1 - INDC) ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1110050:
application : pro , oceans, iliad;
LIG0050 = ( INDV * INDC * (1 - INDP) ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1110060:
application : pro , oceans, iliad;
LIG0060 = ( INDV * INDP * (1 - INDC) ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1110070:
application : pro , oceans, iliad;
LIG0070 = ( INDC * INDP * (1 - INDV) ) * LIG0
           * (1-positif(ANNUL2042)) * TYPE4 ;
regle 11110:
application : pro  , oceans, iliad;
LIG10V = positif_ou_nul(TSBNV + PRBV + BPCOSAV + positif(F10AV*null(TSBNV+PRBV+BPCOSAV)));
LIG10C = positif_ou_nul(TSBNC + PRBC + BPCOSAC + positif(F10AC*null(TSBNC+PRBC+BPCOSAC)));
LIG10P = positif_ou_nul(somme(i=1..4:TSBNi + PRBi) + positif(F10AP*null(somme(i=1..4:TSBNi+PRBi))));
LIG10 = positif(LIG10V + LIG10C + LIG10P)*TYPE1 ;
regle 11000:
application : pro, oceans, iliad ;

LIG1100 = positif(positif(T2RV) * (1 - positif(IPVLOC)) * TYPE4) ;

LIG900 = positif((RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIG3RCMABT + LIG4RCMABT
		  + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 +TAX1649+ R1649+PREREV)
                 * TYPE4 ) ;

regle 111440:
application : pro , oceans, iliad;
LIG4401 =  positif(V_FORVA) * (1 - positif_ou_nul(BAFV))
    	  * LIG0 ;
LIG4402 =  positif(V_FORCA) * (1 - positif_ou_nul(BAFC))
    	  * LIG0 ;
LIG4403 =  positif(V_FORPA) * (1 - positif_ou_nul(BAFP)) 
    	  * LIG0 ;
regle 11113:
application : pro  , oceans, iliad,batch;
LIG13 =  positif(present(BACDEV)+ present(BACREV)
               + present(BAHDEV) +present(BAHREV)
               + present(BACDEC) +present(BACREC)
               + present(BAHDEC)+ present(BAHREC)
               + present(BACDEP)+ present(BACREP)
               + present(BAHDEP)+ present(BAHREP)
               + present(4BAHREV) + present(4BAHREC) + present(4BAHREP)
               + present(4BACREV) + present(4BACREC) + present(4BACREP)
               + present(BAFV) + present(BAFC) + present(BAFP)
	       + present(BAFORESTV) + present(BAFORESTC) 
	       + present(BAFORESTP)
               + present(BAFPVV) + present(BAFPVC) + present(BAFPVP))
	* (1 - positif(IPVLOC)) * LIG1 *TYPE1 ;

regle 111135:
application : pro  , oceans, iliad;
4BAQLV = positif(4BACREV + 4BAHREV);
4BAQLC = positif(4BACREC + 4BAHREC);
4BAQLP = positif(4BACREP + 4BAHREP);
regle 111134:
application : pro  , oceans, iliad,batch;
LIG134V = positif(present(BAFV) + present(BAHREV) + present(BAHDEV) + present(BACREV) + present(BACDEV)+ present(BAFPVV)+present(BAFORESTV));
LIG134C = positif(present(BAFC) + present(BAHREC) + present(BAHDEC) + present(BACREC) + present(BACDEC)+ present(BAFPVC)+present(BAFORESTC));
LIG134P = positif(present(BAFP) + present(BAHREP) + present(BAHDEP) + present(BACREP) + present(BACDEP)+ present(BAFPVP)+present(BAFORESTP));
LIG134 = positif(LIG134V + LIG134C + LIG134P+present(DAGRI6)+present(DAGRI5)+present(DAGRI4)+present(DAGRI3)+present(DAGRI2)+present(DAGRI1)) 
		* (1 - positif(IPVLOC)) * (1-positif(abs(DEFIBA)))*TYPE1 ;
LIGDBAIP = positif_ou_nul(DBAIP) * positif(DAGRI1+DAGRI2+DAGRI3+DAGRI4+DAGRI5+DAGRI6) * (1-positif(IPVLOC))*TYPE1
                          * positif(abs(abs(BAHQTOT)+abs(BAQTOT)-(DAGRI6+DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1)));
regle 111136:
application : pro  , oceans, iliad ,batch;
LIG136 = positif(4BAQV + 4BAQC + 4BAQP)
		* (1 - positif(IPVLOC)) * LIG1 *TYPE1 ;

regle 111590:
application : pro, oceans, iliad, batch ;
pour i = V,C,P:
LIG_BICPi =        (
  present ( BICNOi )                          
 + present (BICDNi )                          
 + present (BIHNOi )                          
 + present (BIHDNi )                          
                  ) * LIG0 ;
LIG_BICP = LIG_BICPV + LIG_BICPC + LIG_BICPP ;
LIG_DEFNPI = positif(
   present ( DEFBIC6 ) 
 + present ( DEFBIC5 ) 
 + present ( DEFBIC4 ) 
 + present ( DEFBIC3 ) 
 + present ( DEFBIC2 )
 + present ( DEFBIC1 )
            )
  * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGPLOC = positif(LOCPROCGAV + LOCPROCGAC + LOCPROCGAP + LOCDEFPROCGAV + LOCDEFPROCGAC + LOCDEFPROCGAP
		   + LOCPROV + LOCPROC + LOCPROP + LOCDEFPROV + LOCDEFPROC + LOCDEFPROP) 
		   * (1 - null(4 - V_REGCO)) ;

LIGNPLOC = positif(LOCNPCGAV + LOCNPCGAC + LOCNPCGAPAC + LOCDEFNPCGAV + LOCDEFNPCGAC + LOCDEFNPCGAPAC
		   + LOCNPV + LOCNPC + LOCNPPAC + LOCDEFNPV + LOCDEFNPC + LOCDEFNPPAC 
		   )
		   *  (1-null(4 - V_REGCO)) ;

LIGNPLOCF = positif(LOCNPCGAV + LOCNPCGAC + LOCNPCGAPAC + LOCDEFNPCGAV + LOCDEFNPCGAC + LOCDEFNPCGAPAC
		   + LOCNPV + LOCNPC + LOCNPPAC + LOCDEFNPV + LOCDEFNPC + LOCDEFNPPAC 
                   + LNPRODEF10 + LNPRODEF9 + LNPRODEF8 + LNPRODEF6 + LNPRODEF5
                   + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 + LNPRODEF1
		   )
		   *  (1-null(4 - V_REGCO)) ;

LIGDEFNPLOC = positif(TOTDEFLOCNP) *  (1-null(4 - V_REGCO)) ;

regle 1115901:
application : pro  , oceans, iliad,batch;

LIG_BICNPF = 
       positif(
   present (BICDEC)
 + present (BICDEP)
 + present (BICDEV)
 + present (BICHDEC)
 + present (BICHDEP)
 + present (BICHDEV)
 + present (BICHREC)
 + present (BICHREP)
 + present (BICHREV)
 + present (BICREC)
 + present (BICREP)
 + present (BICREV)
 + present ( DEFBIC6 ) 
 + present ( DEFBIC5 ) 
 + present ( DEFBIC4 ) 
 + present ( DEFBIC3 ) 
 + present ( DEFBIC2 )
 + present ( DEFBIC1 )
)
                   * LIG0
                     * (1-positif(ANNUL2042)) * TYPE1 ;
regle 11117:
application : pro  , oceans, iliad,batch;
LIG_BNCNF = positif (present(BNCV) + present(BNCC) + present(BNCP))*TYPE1 ;

LIGNOCEP = ( present ( NOCEPV ) + present ( NOCEPC ) + present( NOCEPP ))     
            * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGNOCEPIMP = ( present ( NOCEPIMPV ) + present ( NOCEPIMPC ) + present( NOCEPIMPP ))     
            * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDAB = positif(present(DABNCNP6)+present(DABNCNP5)+present(DABNCNP4)
		+present(DABNCNP3)+present(DABNCNP2)+present(DABNCNP1)) 
		* LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDIDAB = present(DIDABNCNP) * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGBNCIF = ( positif (LIGNOCEP) * (1 - positif(LIG3250) + null(BNCIF)) 
             + (null(BNCIF) * positif(LIGBNCDF)) 
	     + null(BNCIF)*(1-positif_ou_nul(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2-DABNCNP1)))
	    * (1-positif(ANNUL2042))  * (1-positif(LIGSPENPNEG+LIGSPENPPOS))* LIG0 * TYPE1;
regle 125:
application : pro  , oceans, iliad;
LIG910 = positif(
           present(RCMABD) + present(RCMTNC) +
           present(RCMAV) + present(RCMHAD) + present(RCMHAB) + 
           present(REGPRIV) + 
      (1-present(BRCMQ)) *(present(RCMFR))
                ) * LIG0  * (1-positif(ANNUL2042)) * TYPE1;
regle 111266:
application : pro  , oceans, iliad, batch;
LIGBPLIB= present(RCMLIB) * LIG0  * (1-null(4-V_REGCO))* (1-positif(ANNUL2042)) * TYPE1;
regle 1111130: 
application : pro  , oceans, iliad;
LIG1130 = positif(present(REPSOF)) * LIG0  * (1-positif(ANNUL2042)) * TYPE1;
regle 1111950:
application : pro  , oceans, iliad, batch;
LIG1950 =  ( INDREV1A8 *  positif_ou_nul(REVKIRE) 
                   * (1 - positif(positif_ou_nul(IND_TDR) * (1-(positif_ou_nul(TSELUPPEV + TSELUPPEC))))) 
                   * (1 - positif(null(2-V_REGCO)+null(4-V_REGCO)+positif(present(NRINET)+present(NRBASE))))*  TYPE1 ) ;
regle 11129:
application : pro  , oceans, iliad;
LIG29 = positif(present(RFORDI) + present(RFDHIS) + present(RFDANT) +
                present(RFDORD)) * (1 - positif(IPVLOC))
                *(1-positif(LIG30)) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * IND_REV ;
regle 11130:
application : pro, oceans, iliad, batch ;
LIG30 = present(RFMIC) * (1 - positif(IPVLOC)) * (1-positif(ANNUL2042))*TYPE1 ;
LIGREVRF = positif(present(FONCI) + present(REAMOR)) *(1 - positif(IPVLOC)) * (1-positif(ANNUL2042))*TYPE1 ;
regle 11149:
application : pro  , oceans, iliad;
LIG49 =  INDREV1A8 * positif_ou_nul(DRBG)  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 11152:
application : pro  , oceans, iliad, batch;
LIG52 = positif(present(CHENF1) + present(CHENF2) + present(CHENF3) + present(CHENF4) 
                 + present(NCHENF1) + present(NCHENF2) + present(NCHENF3) + present(NCHENF4)) 
	     * (1-positif(ANNUL2042)) * TYPE1 ;
regle 11158:
application : pro  , oceans, iliad, batch;
LIG58 = (present(PAAV) + present(PAAP)) 
	* positif(LIG52)  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 111585:
application : pro  , oceans, iliad, batch;
LIG585 = (present(PAAP) + present(PAAV)) 
	* (1-positif(LIG58))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIG65 = positif(LIG52 + LIG58 + LIG585 
                + present(CHRFAC) + present(CHNFAC) + present(CHRDED)
		+ present(DPERPV) + present(DPERPC) + present(DPERPP)
                + LIGREPAR)  
       * (1-positif(ANNUL2042)) * TYPE1 ;
regle 111555:
application : pro  , oceans, iliad, batch;
LIGDPREC = present(CHRFAC) * LIG1;

LIGDFACC = (positif(20-V_NOTRAIT+0) * positif(DFACC)
           + (1-positif(20-V_NOTRAIT+0)) * present(DFACC)) * LIG1;
regle 1111390:
application : pro  , oceans, iliad;
LIG1390 = positif(positif(ABMAR) + (1-positif(RI1)) * positif(V_0DN))  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 11168:
application : pro  , oceans, iliad;
LIG68 = INDREV1A8 * (1-positif(abs(RNIDF)))  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 111681:
application : pro  , oceans, iliad, batch;
LIGRNIDF = positif(abs(RNIDF))  * (1-positif(ANNUL2042)) * (1-null(4-V_REGCO)) * TYPE1 ;
LIGRNIDF0 = positif(abs(RNIDF0)) * positif(abs(RNIDF))  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRNIDF1 = positif(abs(RNIDF1)) * positif(abs(RNIDF))  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRNIDF2 = positif(abs(RNIDF2)) * positif(abs(RNIDF))  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRNIDF3 = positif(abs(RNIDF3)) * positif(abs(RNIDF))  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRNIDF4 = positif(abs(RNIDF4)) * positif(abs(RNIDF))  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRNIDF5 = positif(abs(RNIDF5)) * positif(abs(RNIDF))  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1111420:
application : pro  , oceans, iliad,batch;
LIGTTPVQ = positif(
              positif(CARTSV) + positif(CARTSC) + positif(CARTSP1) + positif(CARTSP2)+ positif(CARTSP3)+ positif(CARTSP4)
           +  positif(REMPLAV) + positif(REMPLAC) + positif(REMPLAP1) + positif(REMPLAP2)+ positif(REMPLAP3)+ positif(REMPLAP4)
           +  positif(PEBFV) + positif(PEBFC) + positif(PEBF1) + positif(PEBF2)+ positif(PEBF3)+ positif(PEBF4)
           +  positif(CARPEV) + positif(CARPEC) + positif(CARPEP1) + positif(CARPEP2)+ positif(CARPEP3)+ positif(CARPEP4)
           +  positif(PENSALV) + positif(PENSALC) + positif(PENSALP1) + positif(PENSALP2)+ positif(PENSALP3)+ positif(PENSALP4)
           +  positif(RENTAX) + positif(RENTAX5) + positif(RENTAX6) + positif(RENTAX7)
           +  positif(REVACT) + positif(REVPEA) + positif(PROVIE) + positif(DISQUO) + positif(RESTUC) + positif(INTERE)
           +  positif(FONCI) + positif(REAMOR)
           +  positif(4BACREV) + positif(4BACREC)+positif(4BACREP)+positif(4BAHREV)+positif(4BAHREC)+positif(4BAHREP)
           +  positif(GLD1V) + positif(GLD1C)+positif(GLD2V)+positif(GLD2V)+positif(GLD3V)+positif(GLD3V)
                  ) * LIG1  * (1-positif(ANNUL2042)) *(1-null(4-V_REGCO))* TYPE1 ;

regle 111721:
application : pro  , oceans, iliad;
LIG1430 =  positif(BPTP3) * LIG0  * (1-positif(ANNUL2042)) * TYPE2 ;

LIG1431 =  positif(BPTP18) * LIG0  * (1-positif(ANNUL2042)) * TYPE2 ;
regle 111722:
application : pro  , oceans, iliad;
LIG815 = V_EAD * positif(BPTPD) * LIG0  * (1-positif(ANNUL2042)) * TYPE2;
LIG816 = V_EAG * positif(BPTPG) * LIG0  * (1-positif(ANNUL2042)) * TYPE2;
LIGTXF225 = positif(PEA+0) * LIG0  * (1-positif(ANNUL2042)) * TYPE2;
LIGTXF30 = positif_ou_nul(BPCOPT) * LIG0  * (1-positif(ANNUL2042)) * TYPE2;
LIGTXF40 = positif(BPV40+0) * LIG0  * (1-positif(ANNUL2042)) * TYPE2;

regle 111723:
application : pro, batch, oceans, iliad ;

LIGCESDOM = positif( positif(BPVCESDOM) * positif(V_EAD + 0) * LIG0  * (1-positif(ANNUL2042)) * TYPE2 ) ;
LIGCESDOMG = positif( positif(BPVCESDOM) * positif(V_EAG + 0) * LIG0  * (1-positif(ANNUL2042)) * TYPE2 ) ;

regle 11181:
application : pro  , oceans, iliad;
LIG81 = positif(present(RDDOUP) + present(RDFDOU) + present(REPDON03) + present(REPDON04) 
		+ present(REPDON05) + present(REPDON06) + present(REPDON07)) 
               * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1111500:
application : pro  , oceans, iliad, batch ;

LIG1500 = positif((positif(IPMOND) * present(IPTEFP)) + positif(INDTEFF) * positif(TEFFREVTOT)) 
	      * ((V_REGCO+0) dans (1,3,5,6)) * (1-positif(ANNUL2042)) * TYPE1;

LIG1510 = positif((positif(IPMOND) * present(IPTEFN)) + positif(INDTEFF) * (1-positif(TEFFREVTOT))) 
	      * ((V_REGCO+0) dans (1,3,5,6)) * (1-positif(ANNUL2042)) * TYPE1;

regle 1111522:
application : pro, oceans, iliad, batch ;
LIG1522 = (1-present(IND_TDR))* (1 - INDTXMIN)*(1 - INDTXMOY) * V_CR2  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1111523:
application : pro  , oceans, iliad;
LIG1523 = (1-present(IND_TDR)) * null(V_REGCO - 4) * (1-positif(ANNUL2042)) * TYPE4 ;
regle 11175:
application : pro, oceans, iliad, batch ;
LIG75 = (1 - INDTXMIN) * (1 - INDTXMOY) * (1-LIG1500)*(1-LIG1510) 
        * INDREV1A8  * (1-positif(ANNUL2042)) * TYPE3;
LIG1545 = (1-present(IND_TDR))*INDTXMIN  * positif(IND_REV) * (1-positif(ANNUL2042)) * TYPE3;
LIG1760 = (1-present(IND_TDR))*INDTXMOY  * (1-positif(ANNUL2042)) * TYPE3;
LIG1546 = positif(PRODOM + PROGUY) * (1-positif(V_EAD + V_EAG)) * (1-positif(ANNUL2042)) * TYPE4;
LIG1550 = (1-present(IND_TDR))*INDTXMOY  * (1-positif(ANNUL2042)) * TYPE3;
LIG74 = (1-present(IND_TDR))*(1 - INDTXMIN) * positif(LIG1500+LIG1510) 
         * (1-positif(ANNUL2042)) * TYPE3;
regle 11180:
application : pro, oceans, iliad ;
LIG80 = positif(present(RDREP) + present(RDFREP)) 
        * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 11182:
application : pro  , oceans, iliad;
LIG82 = positif(present(RDSYVO) + present(RDSYCJ) + present(RDSYPP) +
	    present(COSBV) + present(COSBC) + present(COSBP))
	* LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 11188:
application : pro  , oceans, iliad, batch;
LIGRSOCREPR = positif( present(RSOCREPRISE))
        * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1111740:
application : pro  , oceans, iliad;
LIG1740 = positif(RECOMP)
         * (1-positif(ANNUL2042)) * TYPE2 ;
regle 1111780:
application : pro  , oceans, iliad;
LIG1780 = positif(RDCOM + NBACT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1;
regle 111981:
application : pro  , oceans, iliad;
LIG98B = positif(LIG80 + LIG82 + LIGFIPC + present(DAIDE)
                 + LIGREDAGRI + LIGFORET + LIGRESTIMO + LIGPECHE 
	         + LIGCINE + LIGTITPRISE + LIGRSOCREPR 
	         + present(PRESCOMP2000) + present(RDPRESREPORT) + present(FCPI) 
		 + present(DSOUFIP) + LIGRIRENOV + present(DFOREST) 
		 + present(DHEBE) + present(DPATNAT) + present(DSURV)
	         + LIGLOGDOM + LIGACHTOUR + LIGTOURHOT 
	         + LIGTRATOUR + LIGLOGRES + LIGREPTOUR + LIGLOCHOTR
	         + LIGREPHA + LIGCREAT + LIG1780 + LIG2040 + LIG81 + LIGLOGSOC
	         + LIGDOMSOC1 
		 + LIGCELDO + LIGCELDOP + LIGCELREDOP + LIGCELMET + LIGCELNP 
		 + LIGCELRENP + LIGCELRRED 
	         + LIGRESINEUV + LIGRESIVIEU + LIGMEUBLE + LIGREDMEUB 
		 + present(DNOUV) + LIGLOCENT + LIGCOLENT + LIGRIDOMPRO) 
           * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1111820:
application : pro  , oceans, iliad;
LIG1820 = positif(ABADO + ABAGU + RECOMP)  * (1-positif(ANNUL2042)) * TYPE2 ;
regle 111106:
application : oceans , iliad , pro , batch ;
LIG106 = TYPE2 * positif(RETIR);
LIGINRTAX = TYPE2 * positif(RETTAXA);
LIG10622 = TYPE2 * positif(RETIR22);
LIGINRTAX22 = TYPE2 * positif(RETTAXA22);
ZIG_INT22 = TYPE2 * positif(RETCS22+RETPS22+RETRD22+RETCSAL22);

ZIGINT22 = positif(RETCDIS22) * TYPE2 ;

regle 111107:
application : oceans, iliad, pro,batch;
LIG_172810    =TYPE2 * null(MAJTX1 - 10)
                     * positif(NMAJ1);
LIG_1728      =TYPE2 * (1-null(MAJTX1 - 10)) 
                     * positif(NMAJ1);
LIGTAXA17281    =TYPE2 * null(MAJTX1 - 10)
                       * positif(NMAJTAXA1);
LIGTAXA1728      =TYPE2 * (1-null(MAJTX1 - 10))
                       * positif(NMAJTAXA1);
LIG_NMAJ1 = TYPE2 * positif(NMAJ1);
LIG_NMAJ3 = TYPE2 * positif(NMAJ3);
LIG_NMAJ4 = TYPE2 * positif(NMAJ4);
LIGNMAJTAXA1 = TYPE2 * positif(NMAJTAXA1);
LIGNMAJTAXA3 = TYPE2 * positif(NMAJTAXA3);
LIGNMAJTAXA4 = TYPE2 * positif(NMAJTAXA4);
regle 111109:
application : pro  , oceans, iliad;
LIG109 = positif(IPSOUR + REGCI + LIGPVETR + LIGCULTURE + LIGMECENAT 
		  + LIGCORSE + LIG2305 
		  + LIGBPLIB + LIGCIGE + LIGDEVDUR + LIGDDUBAIL
                  + LIGVEHICULE + LIGVEACQ + LIGVEDESTR + LIGCICA + LIGCIGARD
		  + LIGPRETUD + LIGSALDOM + LIGHABPRIN
		  + LIGCREFAM + LIGCREAPP + LIGCREBIO + LIGCREPROSP + LIGINTER
		  + LIGCRETECH + LIGRESTAU + LIGRESERV + LIGCONGA + LIGMETART 
		  + LIGCREFORM + LIGLOYIMP + LIGMOBIL + LIGJEUNE
		  + LIGPPEVCP + LIGPPEV + LIGPPEC + LIGPPEP
		  + LIGPPEVC + LIGPPEVP + LIGPPECP + LIGPERT
		  + LIGRSA + LIGVERSLIB + LIGCITEC 
		   ) 
               * LIG1
               * (1-positif(ANNUL2042)) * TYPE3;
regle 1112030:
application : pro, oceans, iliad ;
LIGNRBASE = positif(present(NRINET) + present(NRBASE)) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBASRET = positif(present(IMPRET) + present(BASRET)) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1112332:
application : pro, oceans, iliad, batch ;
LIGAVFISC = positif(AVFISCOPTER) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1112040:
application : pro  , oceans, iliad;
LIG2040 = positif(DNBE + RNBE + RRETU) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 1112041:
application : pro, oceans, iliad, batch ;
LIGRDCSG = positif(positif(V_BTCSGDED)+present(DCSG)+present(RCMSOC)) * LIG1 *(1-positif(ANNUL2042)) * TYPE1  ;
regle 111973:
application : pro  , oceans, iliad, batch;
LIG2305 = positif(DIAVF2)  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCIGE = positif(RDTECH + RDGEQ + RDEQPAHA) * LIG1  * (1-positif(ANNUL2042)) * TYPE1;
regle 111117:
application : pro  , oceans, iliad;
LIG_IRNET = TYPE1*(1-positif(V_NOTRAIT-20)) + positif(V_NOTRAIT-20)*positif(present(CESSASSV) + present(CESSASSC));
regle 1112135:
application : pro  , oceans, iliad;
LIGANNUL = positif(ANNUL2042)  * TYPE1;
regle 1112050:
application : iliad , oceans;
LIG2053 = positif(V_NOTRAIT-20) * positif(IDEGR)*
          positif(IREST-SEUIL_REMBCP) *TYPE2 ;
LIG2051 = (1 - positif(20 - V_NOTRAIT))
          * positif (RECUMBIS)
          *TYPE1 ;
LIG2052 = (APPLI_ILIAD 
                 * (1 - positif(20 - V_NOTRAIT)) * positif (V_ANTIR)
          +
           APPLI_OCEANS * positif (ANTIRAFF)
          )
       	  * (1 - positif(LIG2080))   *  TYPE2 ;
LIGTAXANT =(APPLI_ILIAD
               * (1 - positif(20 - V_NOTRAIT)) * positif (V_TAXANT)
            +
             APPLI_OCEANS * positif (TAXANTAFF)
            )
       	      * (1 - positif(LIGTAXADEG))   * TYPE2 ;
regle 1112080:
application : pro  , oceans, iliad;
LIG2080 = positif(NATIMP - 71)  * (1-positif(ANNUL2042)) * TYPE1;
regle 1112081:
application : pro  , oceans, iliad;
LIGTAXADEG = positif(NATIMP - 71) * positif(TAXADEG)  * (1-positif(ANNUL2042)) * TYPE1;
regle 1112140:
application : pro , oceans, iliad,batch;
INDCTX = si (  (V_NOTRAIT+0 = 23) ou (V_NOTRAIT+0 = 25) 
            ou (V_NOTRAIT+0 = 33) ou (V_NOTRAIT+0 = 35)  
            ou (V_NOTRAIT+0 = 43) ou (V_NOTRAIT+0 = 45)  
            ou (V_NOTRAIT+0 = 53) ou (V_NOTRAIT+0 = 55)  
            ou (V_NOTRAIT+0 = 63) ou (V_NOTRAIT+0 = 65)  
            )
         alors (1)
         sinon (0)
         finsi;
LIG2140 = si (( ((V_CR2+0=0) et NATIMP=1 et ( IRNET+TAXANET + NRINET -NAPTOTA  = 0
                ou  IRNET + TAXANET + NRINET -NAPTOTA  >=SEUIL_REC_CP)) 
		ou ((V_CR2+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
          alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * (1-positif(ANNUL2042)) * TYPE3)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV))
          finsi;
regle 112141:
application : batch, pro , oceans, iliad;

LIG2141 = positif(null(IAN + RPEN - IAVT + RPPEACO + TAXASSUR - IRANT) 
                  * positif(IRANT)
                  * (1 - positif(LIG2501))
		  * null(V_IND_TRAIT - 4)
		  * (1 - positif(NRINET + 0)) * TYPE4) ;

regle 112145:
application : batch, pro , oceans, iliad;
LIGNETAREC = positif (IINET)  * positif(ANNUL2042) * TYPE2 ;
regle 1112150:
application : pro , oceans , iliad , batch ;

LIG2150 = (1 - INDCTX) 
	 * positif(IREST)
         * (1 - positif(LIG2140))
         * (1 - positif(IND_REST50))
         * (1-positif(ANNUL2042)) * TYPE2 ;

regle 1112160:
application : pro , oceans , iliad ;

LIG2161 =  INDCTX 
	  * positif(IREST) 
          * positif_ou_nul(IREST - SEUIL_REMBCP) 
	  * (1 - positif(IND_REST50)) ;


LIG2368 = INDCTX 
	 * positif(IREST)
         * positif ( positif(IND_REST50)
                     + positif(IDEGR) )
           ;

regle 1112171:
application : batch , pro , oceans , iliad ;

LIG2171 = (1 - INDCTX) 
	 * positif(IREST)
	 * (1 - positif(LIG2140))
         * positif(IND_REST50)  
	 * (1-positif(ANNUL2042)) * TYPE4 ;

regle 11121710:
application : pro , iliad ;

LIGTROP = positif(V_ANTRE) * null(IINET)* positif_ou_nul(abs(NAPTOTA)
             - IRESTIT - IRANT) * (1 - positif_ou_nul(abs(NAPTOTA) - IRESTIT
             - IRANT - SEUIL_REC_CP))
               * null(IDRS2 - IDEC + IREP)
               * (1 - INDCTX);

LIGTROPREST =  positif(V_ANTRE) * null(IINET)* positif_ou_nul(abs(NAPTOTA) 
               - IRESTIT - IRANT) * (1 - positif_ou_nul(abs(NAPTOTA) - IRESTIT
               - IRANT - SEUIL_REC_CP))
		 * (1 - positif(LIGTROP))
                 * (1 - INDCTX);

regle 1113210:
application : pro , oceans , iliad ;

LIGRESINF50 = positif (
              positif(IND_REST50) * positif(IREST) 
              + ( positif(IDEGR) 
                 * (1 - positif_ou_nul(IDEGR - SEUIL_REMBCP)) )
                      )  *  TYPE4 ;
regle 1112200:
application : pro , oceans , iliad ;
LIG2200 = (positif(IDEGR) 
         * positif_ou_nul(IDEGR - SEUIL_REMBCP)  * TYPE2);

regle 1112205:
application : pro , oceans, iliad;
LIG2205 = positif(IDEGR) 
         * (1 - positif_ou_nul(IDEGR - SEUIL_REMBCP))  * (1-positif(ANNUL2042)) * TYPE2 ;

regle 1112301:
application : batch, pro , oceans, iliad;
IND_NIRED = si ((CODINI=3 ou CODINI=5 ou CODINI=13)
               et (IAVIM-TAXASSUR) = 0 
                   et  V_CR2 = 0)
          alors (1 - INDCTX) 
          finsi;
regle 1112905:
application : batch, pro , oceans, iliad;
IND_IRNMR = si (CODINI=8 et NATIMP=0 et V_CR2 = 0)
          alors (1 - INDCTX)  
          finsi;
regle 1112310:
application : batch, pro , oceans, iliad;

 
IND_IRINF80 = si ( ((CODINI+0=9 et NATIMP+0=0) ou (CODINI +0= 99))
                  et V_CR2=0 
                  et  (IRNET+TAXASSUR < SEUIL_REC_CP)
                  et  (IAVIM >= SEUIL_PERCEP))
              alors ((1 - positif(INDCTX)) * (1 - positif(IREST))) 
              finsi;


regle 11123101:
application : batch, pro , oceans,iliad;

LIGNIIR = positif(
	   positif ( positif(NIAMENDE) 
                      * positif(IINET - LIM_AMENDE + 1)
                      * INDREV1A8* (1 - V_CR2)

                     + null(IRNETBIS)
                      * null(NRINET + 0)
                    )
           *  null(NATIMP +0)
           * null(TAXANET + 0)
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - positif(IRESTIT))
           * (1 - positif(RPPEACO))
           * (1 - positif(IDEGR))
           * (1 - positif(LIGIDB))
           * (1 - positif(LIGNIRI))
           * (1 - positif(LIG80F))
           * (1 - positif(LIG400RI))
           * (1 - positif(LIG400F))
           * (1 - positif(LIGAUCUN))
           * (1 - positif(LIG2141))
           * (1 - positif(LIG2501))
           * (1 - positif(LIG8FV))
           * (1 - positif(LIGAME))
           * (1 - positif(LIGAMEND))
           * (1 - positif(LIGNIDB))
           * (1 - null(V_REGCO-2 +0))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 );

LIGNIIRA = positif(
	    positif ( positif(NIAMENDE) 
                       * positif(IINET - LIM_AMENDE + 1)
                       * INDREV1A8 * (1 - V_CR2)

                     + null(IRNETBIS)
                      * null(NRINET + 0)
	   + positif (RPPEACO)
                   )
           *  null(NATIMP +0)
           * null(TAXANET + 0)
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - positif(IRESTIT))
           * (1- positif_ou_nul(IRB-IRE-INE+RPPEACO-SEUIL_REC_CP))
	   * positif (RPPEACO)
           * (1 - positif(IDEGR))
           * (1 - positif(NRINET)*positif(RPPEACO))
           * (1 - positif(LIGIDB))
           * (1 - positif(LIGNIRI))
           * (1 - positif(LIG80F))
           * (1 - positif(LIG400RI))
           * (1 - positif(LIG400F))
           * (1 - positif(LIGAUCUN))
           * (1 - positif(LIG2141))
           * (1 - positif(LIG2501))
           * (1 - positif(LIG8FV))
           * (1 - positif(LIGAME))
           * (1 - positif(LIGAMEND))
           * (1 - positif(LIGNIDB))
           * (1 - null(V_REGCO-2 +0))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 );

LIGNIIRDEG = positif( 
           null(IDRS3 - IDEC)
	   * null(IBM23)
           * (1 - V_CR2)
           * null(TAXASSUR)
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET - SEUIL_REC_CP))
	   * positif(V_NOTRAIT - 20)
	   * (1 - positif(INDCTX))
           * (1-positif(ANNUL2042)) * TYPE4 ) ;


regle 11123102:
application : batch, pro , oceans,iliad;


LIGCBAIL = positif(
	     positif(TAXANET)
           * positif(NAPT)
           * null(INDNIRI) * (1 - positif(IBM23))
	   * ((1-positif (RPPEACO)) + null(IRNET)*positif(RPPEACO))
           * positif_ou_nul(IINET-SEUIL_REC_CP)
	   * (1 - positif(LIGNIDB))
           * positif(1 - null(2-V_REGCO)) * INDREV1A8
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 );
                       
LIGNITSUP = positif(
	     positif_ou_nul(TAXASSUR - SEUIL_PERCEP)
           * null(IDRS2-IDEC+IREP)
           * positif_ou_nul(TAXANET - SEUIL_REC_CP)
	   * (1 - positif (RPPEACO))
	   * (1 - positif(LIG0TSUP))
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(V_NOTRAIT - 20)
	   * (1 - positif(INDCTX))
           * (1-positif(ANNUL2042)) * TYPE4 );
                       
LIGNITDEG = positif(
	     positif(TAXANET)
           * positif(IRB2 - SEUIL_PERCEP)
           * positif_ou_nul(TAXANET - SEUIL_REC_CP)
           * null(INDNIRI) * (1 - positif(IBM23))
	   * ((1-positif (RPPEACO)) + null(IRNET)*positif(RPPEACO))
           * positif(1 - null(2-V_REGCO)) * INDREV1A8
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * positif(INDCTX)
           * (1-positif(ANNUL2042)) * TYPE4 );
                       
regle 11123103:
application : batch, pro , oceans,iliad;




LIGNIDB = positif(
	 (null( IDOM11 - DEC11)
        * null((NAPT)*(1-positif(RPPEACO)))
        * positif (TAXASSUR)
        * positif(SEUIL_PERCEP - TAXASSUR)
        * null((IRNETBIS)*(1-positif(RPPEACO)))
	* ((1 - positif(RPPEACO))+positif(SEUIL_REC_CP-IRNET)
	      *positif(IRNET)*positif(RPPEACO))
	* null(IRB)
        * (1 - null(V_REGCO-2))
        * (1 - positif(LIG80F))
        * (1 - positif(LIG400RI))
	* (1 - positif(LIGTROP))
	* (1 - positif(LIGTROPREST))
	* (1 - positif(IMPRET))
	* positif(20 - V_NOTRAIT)
        + 0)
 * (1-positif(ANNUL2042)) * TYPE4) ;  

LIGNI61SUP = positif(
	 null( IDOM11 - DEC11)
        * positif (TAXASSUR)
        * positif(SEUIL_PERCEP - TAXASSUR)
        * null((IRNETBIS)*(1-positif(RPPEACO)))
	* ((1 - positif(RPPEACO))+positif(SEUIL_REC_CP-IRNET)
	      *positif(IRNET)*positif(RPPEACO))
	* null(IRB)
        * (1 - null(V_REGCO-2))
	* (1 - positif(LIGTROP))
	* (1 - positif(LIGTROPREST))
	* (1 - positif(IMPRET))
	* positif(V_NOTRAIT - 20)
	* (1 - positif(INDCTX))
 * (1-positif(ANNUL2042)) * TYPE4) ;  

LIGNI61DEG = positif(
	 null(IDRS2 - IDEC + IREP)
        * positif(SEUIL_PERCEP - TAXASSUR)
        * positif(TAXANET)
	* (1 - positif(RPPEACO))
        * (1 - null(V_REGCO-2))
	* (1 - positif(LIGTROP))
	* (1 - positif(LIGTROPREST))
	* (1 - positif(IMPRET))
	* positif(INDCTX)
        * (1-positif(ANNUL2042)) * TYPE4) ;  

regle 11123104:
application : batch, pro , oceans,iliad;
	


LIGNIRI = positif(
	   INDNIRI
           * null(IRNETBIS)
           * null(NATIMP)
           * (1 - positif (LIGIDB))
	   * (1 - positif (RPPEACO))
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - null(V_REGCO-2))
           * (1 - positif(TAXANET))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 ) ;

regle 11123105:
application : batch, pro , oceans,iliad;
	


LIGIDB = positif( INDNIRI
                 * null(NAPT*(1-positif(RPPEACO)))
                 * null(IRNETBIS*(1-positif(RPPEACO)))
                 * positif (TAXASSUR)
	         * positif(TAXANET+IRNET)
                 * positif(SEUIL_PERCEP - TAXASSUR)
                 * (1 - positif(REI))
	         * (1 - positif( BPTP2 + BPTP3 + BPTP4 + BPTP40 + BPTP18+ BPTPD + BPTPG))
                 * (1 - positif(IPROP))
	         * ((1 - positif(RPPEACO))+positif(SEUIL_REC_CP-IRNET)*positif(RPPEACO))
                 * (1 - null(V_REGCO-2))
		 * (1 - positif(LIGTROP))
		 * (1 - positif(LIGTROPREST))
	         * (1 - positif(IMPRET))
	         * positif(20 - V_NOTRAIT) )
                 * (1-positif(ANNUL2042)) * TYPE4;

regle 11123106:
application : batch, pro, oceans, iliad ;



LIGRIDB = positif(
	   INDNIRI
           * null(IRNETBIS)
           * positif(NAPT)
           * positif (TAXASSUR)
           * (1 - positif(SEUIL_PERCEP - TAXASSUR))
           * (1 - positif(IREP))
           * ((1 - positif(RPPEACO))+null(IRNET)*positif(RPPEACO)) 
           * (1 - positif(IPROP))
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 ) ;

LIG0TSUP = positif(
	    INDNIRI
           * null(IRNETBIS)
           * positif (TAXASSUR)
           * (1 - positif(SEUIL_PERCEP - TAXASSUR))
           * (1 - positif(IREP))
           * ((1 - positif(RPPEACO))+null(IRNET)*positif(RPPEACO)) 
           * (1 - positif(IPROP))
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(V_NOTRAIT - 20)
	   * (1 - positif(INDCTX))
           * (1-positif(ANNUL2042)) * TYPE4) ;

LIG0TDEG = positif(
	    INDNIRI
           * null(IRNETBIS)
           * positif (TAXASSUR)
           * (1 - positif(SEUIL_PERCEP - TAXASSUR))
           * (1 - positif(IREP))
           * ((1 - positif(RPPEACO))+null(IRNET)*positif(RPPEACO)) 
           * (1 - positif(IPROP))
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(INDCTX)
           * (1-positif(ANNUL2042)) * TYPE4) ;

regle 11123111:
application : batch, pro , oceans,iliad;
	


LIG400F = positif(
	   INDNMR1 * positif(IAMD2+RPPEACO) * (1 - INDNIRI)
          * null(NAPT)
	  * ((1 - positif(RPPEACO))
	     + positif(RPPEACO) * (1 - positif(IRNET - SEUIL_REC_CP)))
          * (1 - positif(LIG400RI))
          * (1 - null(V_REGCO-2))
          * (1 - positif(LIGNIDB))
	  * (1 - positif(LIGTROP))
	  * (1 - positif(LIGTROPREST))
	  * (1 - positif(IMPRET))
	  * positif(20 - V_NOTRAIT)
          * (1-positif(ANNUL2042)) * TYPE4 );

LIG12ANTRE = positif(
              positif(SEUIL_REC_CP - IRNET)
	     * positif(IRNET)
             * positif_ou_nul(V_ANTRE - SEUIL_REMBCP)
	     * (1 - positif(NIAMENDE))
             * (1 - positif(NRINET))
	     * (1 - positif(IMPRET))
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * positif(V_NOTRAIT - 20)
	     * (1 - positif(INDCTX))
             * (1-positif(ANNUL2042)) * TYPE4 );

LIG61ANTRE = positif(
              positif(IAVIM - RPPEACO)
             * positif(SEUIL_PERCEP - IAVIM)
             * positif(SEUIL_PERCEP - IRNET)
             * positif_ou_nul(IRNET - SEUIL_REC_CP)
             * positif_ou_nul(V_ANTRE - SEUIL_REMBCP)
	     * (1 - positif(NIAMENDE))
             * (1 - positif(NRINET))
	     * (1 - positif(IMPRET))
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * positif(V_NOTRAIT - 20)
	     * (1 - positif(INDCTX))
             * (1-positif(ANNUL2042)) * TYPE4 );

LIG400DEG = positif(
             positif(IAVIM - RPPEACO)
	    * positif (SEUIL_PERCEP - IAVIM + RPPEACO)
	    * positif (IRNET)
	    * (1 - positif(IRNET - SEUIL_PERCEP))
	    * (1 - positif_ou_nul(RPPEACO - SEUIL_REC_CP)) 
	    * (1 - positif(LIG12ANTRE + LIG61ANTRE))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET - SEUIL_REC_CP))
	    * positif(V_NOTRAIT - 20)
	    * (1 - positif(INDCTX))
            * (1-positif(ANNUL2042)) * TYPE4 );

regle 11123112:
application : batch, pro , oceans,iliad;
	



LIG400RI =  INDNMR1 
          * null(NAPT)
	  * positif(ITRED)
          * (1 - null(IRB))
          * (1 - positif(RPPEACO))   
          * (1 - positif(INDNMR2))
          * (1 - null(V_REGCO-2))
	  * (1 - positif(LIGTROP))
	  * (1 - positif(LIGTROPREST))
	   * positif(20 - V_NOTRAIT)
          * (1-positif(ANNUL2042)) * TYPE4;

LIG61NRSUP = positif(
              (1 - positif_ou_nul(NAPT))
             * positif(ITRED)
	     * positif(IAVIM)  
             * positif(SEUIL_PERCEP - IAVIM)
             * (1 - positif(RPPEACO))   
             * (1 - positif_ou_nul(V_ANTRE - SEUIL_REMBCP))
             * (1 - positif(INDNMR2))
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(V_NOTRAIT - 20) 
	     * (1 - positif(INDCTX))
             * (1-positif(ANNUL2042)) * TYPE4 ) ;

LIG61DEG = positif(
             positif(ITRED)
	    * positif(IAVIM)  
            * positif(SEUIL_PERCEP - IAVIM)
            * (1 - positif(RPPEACO))   
            * (1 - positif(INDNMR2))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
            * positif(INDCTX)
            * (1-positif(ANNUL2042)) * TYPE4) ;

regle 11123113:
application : batch, pro , oceans,iliad;
	



LIG80F = 0 + positif (  positif( INDNMR2)
                   + positif(NAT1BIS) *  null(NAPT)
                      * (positif (max(0,IRNET2) + TAXANET))
                  +0)
          * (1 - null(V_REGCO-2))
          * null(NAPT)
	  * positif_ou_nul (IRB2-SEUIL_PERCEP)
	  * positif(SEUIL_REC_CP-TOTNET)
          * (1 - positif (IRANT))
          * null(V_IND_TRAIT - 4)
	  * (1 - positif(LIGTROP))
	  * (1 - positif(LIGTROPREST))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4;
regle 11123114:
application : batch, pro , oceans,iliad;
	



LIGAUCUN =  positif_ou_nul(IAMD1 - SEUIL_PERCEP)
            * null(IRCUMBIS)
            * null(NAPT)
            * (1 - null(V_REGCO-2))
            * (1 - positif(LIG80F))
            * (1 - positif(NRINET)*positif(RPPEACO))
            * (1-positif(ANNUL2042))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET - SEUIL_REC_CP))
	    * positif(20 - V_NOTRAIT)
	    * TYPE4;


regle 11123115:
application : batch, pro , oceans,iliad;
	




LIG12ANT = positif(
	     positif (IRANT)
            * positif (SEUIL_REC_CP - TOTNET )
	    * positif( TOTNET)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(20 - V_NOTRAIT)
            * (1-positif(ANNUL2042)) * (1 - positif(null(2-V_REGCO) + ((V_REGCO+0) dans (1,3,5,6))) * positif(NRINET-SEUIL_REC_CP))
	    * (1 - positif(IMPRET - SEUIL_REC_CP)) * TYPE4 ) ;
regle 11123116:
application : batch , pro , oceans , iliad ;


LIG12NMR = positif(
	    positif (INDNMR)  
           * positif_ou_nul(SEUIL_REC_CP - (NAPIR +TAXANET- NAPTOTA - IRANT))
           * positif(TOTNET)
           * positif_ou_nul(IAMD1 - SEUIL_PERCEP)
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(V_NOTRAIT - 20)
	   * (1 - positif(INDCTX))
           * (1 - positif(null(2-V_REGCO) + ((V_REGCO+0) dans (1,3,5,6))) * positif(NRINET-SEUIL_REC_CP))
	   * (1 - positif(IMPRET - SEUIL_REC_CP))
           * TYPE4 );

regle 11123117:
application : batch, pro , oceans,iliad;
	


LIGNIIRAF = positif(
	    null(IAD11)
           * (1 - positif_ou_nul(NAPT))
           * (1 - positif(INDNIRI))
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - positif (NAPT))
           * positif (IRE)
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 );

regle 11123118:
application : batch, pro , oceans,iliad;

	




LIGNIRIAF = positif( 
           INDNIRI
           * null(IBM23)
           * (1 - positif_ou_nul(NAPT))
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
	   * (1 - positif(IMPRET))
           * positif (IRE)
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(20 - V_NOTRAIT)
           * (1-positif(ANNUL2042)) * TYPE4 
	     ) ;
regle 11123120:
application : batch, pro , oceans,iliad;
	

LIGNIDEG = positif( 
           null(IDRS3-IDEC)
	   * null(IBM23)
	   * positif(SEUIL_PERCEP - TAXASSUR)
           * positif(SEUIL_REC_CP - IRNET)
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGDEG61))
	   * (1 - positif(LIGNI61DEG))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(INDCTX)
           * (1 - positif(ANNUL2042)) * TYPE4 ) ;

regle 11123121:
application : batch , pro , oceans , iliad ;


LIGDEG61 = positif(
	   positif (IRNETBIS)
           * positif (SEUIL_PERCEP - IAMD1) 
           * positif (SEUIL_PERCEP - NRINET) 
	   * positif (IBM23)
	   * (1 - positif(RPPEACO))
	   * (1 - positif(LIG61DEG))
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
           * positif (INDCTX)
           * (1-positif(ANNUL2042)) * TYPE4 );

regle 11123122:
application : batch , pro , oceans , iliad ;
	

LIGDEG12 = positif(
	    positif (IRNET + TAXANET)
          * positif (SEUIL_REC_CP - IRNET - TAXANET)
          * (1 - null(V_REGCO-2))
          * (1 - positif(LIGNI61DEG))
          * (1 - positif(LIGNIDEG))
          * (1 - positif(LIGDEG61))
          * (1 - positif(LIG61DEG))
	  * (1 - positif(LIGTROP))
	  * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	  * positif(INDCTX)
          * (1 - positif(ANNUL2042)) * TYPE4);

regle 11123123:
application : batch, pro , oceans,iliad;

LIGAMEND =  positif(NIAMENDE)
          * positif_ou_nul(IINET - LIM_AMENDE)
          * INDREV1A8* (1 - V_CR2)
          * (1 - positif(IDEGR))
          * (1 - positif(RPPEACO))
          * (1 - positif(NRINET))
	  * (1 - positif(IMPRET))
          * (1 - null(V_REGCO-2))
	  * (1 - positif(LIGTROP))
	  * (1 - positif(LIGTROPREST))
	  * positif(20 - V_NOTRAIT)
          * (1-positif(ANNUL2042)) * TYPE4 ;

regle 11123124:
application : batch , pro , oceans , iliad ;


LIGDIPLOI = positif(INDREV1A8)
           * null(NATIMP - 01)
           * positif(REVFONC) * ((V_REGCO+0) dans (1,3,5,6)) 
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * positif(20 - V_NOTRAIT)
           * LIG1 * TYPE4;

regle 11123125:
application : batch , pro , oceans , iliad ;


LIGDIPLONI = positif(INDREV1A8)
            * positif(REVFONC) * ((V_REGCO+0) dans (1,3,5,6)) 
            * (null(NATIMP) + positif(IREST))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(20 - V_NOTRAIT)
            * LIG1 * TYPE4;

regle 1112355:
application : pro , iliad , oceans ;
LIG2355 = positif (
		   IND_NI
                 + INDNMR1
                 + INDNMR2
                 + positif(NAT1BIS) *  null(NAPT) * (positif (IRNET + TAXANET))
		 + positif(SEUIL_REC_CP - (IAN + RPEN - IAVT + RPPEACO + TAXASSUR - IRANT))
				 * positif_ou_nul(IAN + RPEN - IAVT + RPPEACO + TAXASSUR - IRANT) 
                  )
          * positif(INDREV1A8)
          * (1 - null(NATIMP - 01) + null(NATIMP - 01)*positif(IRANT) )  
	  * (1-positif(ANNUL2042)) * TYPE1 ;

regle 1112380:
application : pro , oceans, iliad;
LIG2380 = si (NATIMP=0 ou NATIMP=21 ou NATIMP=70 ou NATIMP=91)
         alors (IND_SPR * positif_ou_nul(V_8ZT - RBG) * positif(V_8ZT)
          * (1 - present(BRAS)) * (1 - present(IPSOUR))
          * V_CR2  * (1-positif(ANNUL2042)) * TYPE4 )
         finsi;
regle 1112383:
application : pro , oceans, iliad;
LIG2383 = si (IAVIM<=(IPSOUR * LIG1 ))
         alors ( positif(RBG - V_8ZT) * present(IPSOUR) 
          * V_CR2  * (1-positif(ANNUL2042)) * TYPE4 )
         finsi;
regle 1112501:
application : pro , oceans, iliad,batch;

LIG2501 = (1 - positif(IND_REV)) * (1 - null(2 - V_REGCO)) 
           * (1-positif(ANNUL2042)) * TYPE4 ;
LIG25012 = (1 - positif(IND_REV)) * null(2 - V_REGCO) 
           * (1-positif(ANNUL2042)) * TYPE4 ;

LIG8FV = positif(REVFONC) * (1 - IND_REV8FV);
LIGAME = positif(AME) * (1 - IND_REVAME);
LIGAME2 = positif(AME2) * (1 - IND_REVAME);
regle 1112503:
application : pro , oceans, iliad;
LIG2503 =   (1 - positif(IND_REV))
          * (1 - positif_ou_nul(IND_TDR))
          * (1 - positif(ANNUL2042))
          * (1 - null(2 - V_REGCO)) * TYPE4 ;

regle 1113200:
application : pro, oceans, iliad ;
LIG_REPORT = positif(LIGRNIDF + somme(i=0..5:LIGRNIDFi)
             + LIGDEFBA+LIGDRFRP+LIG3250+LIGIRECR+LIGDRCVM+LIGPVSOCP
             + somme(i=1..6:LIGDLMRNi)
             + somme(i=1..6:LIGBNCDFi)
             + somme(i=V,C,P:LIGMIBDREPi + LIGMIBDREPNPi + LIGSPEDREPi + LIGSPEDREPNPi)
             + LIGLOCNEUF + somme(i=1..6:LIGLOCNEUFi) 
             + LIGDEFBA + LIGLOCHOT
	     + LIGPATNATR
             + LIGRCELDO + LIGRCELM + LIGRCELDPA + LIGRCELMPA + LIGRCELDOP + LIGRCELNP
	     + LIGDCELPA + LIGDCEL 
	     + LIGNEUV + LIGRNEUV + LIGVIEU
             + LIGCOMP01
             + LIGREPDOMPX1 + LIGREPDOMPX2 + LIGREPDOMPX3 + LIGREPDOMPX4
             + LIGREPMM + LIGREPQF + LIGREPLG  
	     + LIGREPQG + LIGREPMA 
             + LIGREPQI + LIGREPKS + LIGREPQJ + LIGREPLS 
	     + LIGREPQO + LIGREPQP + LIGREPQE
	     + LIGREPQN 
	     + LIGREPQR + LIGREPQS + LIGREPKG + LIGREPQK  
             + LIGREPDOMENT + LIGREPDOMOUT + LIGPME3 + LIGPME2 + LIGPME1 + LIGPMER
             + LIGREPDON + LIGREPDONR + LIGREPDONR1 
             + LIGREPDONR2 + LIGREPDONR3 + LIGREPDONR4 
             + LIGREPDOM + LIGREPNEUV + LIGREPMEU + LIGREPREPAR + LIGLOCRES
             + LIGDFRCM + LIGPME + LIGREPCORSE + LIGREPRECH + LIGDEFPLOC
	     + LIGFOREST + LIGNFOREST )  
                 * (1-positif(ANNUL2042)) * TYPE4 ;

regle 1113250:
application : pro, oceans, iliad ;

LIG3250 = positif(DALNP) * LIG1  * (1-positif(ANNUL2042)) * TYPE4;

regle 1113500:
application : pro , oceans, iliad;
LIG3500 = positif(LIG3510) * LIG1  * (1-positif(ANNUL2042)) * TYPE4;
regle 1113510:
application : pro , oceans, iliad;
LIG3510 =  (positif(V_FORVA) * (1 - positif_ou_nul(BAFV))
          + positif(V_FORCA) * (1 - positif_ou_nul(BAFC))
          + positif(V_FORPA) * (1 - positif_ou_nul(BAFP)) )
       	   * (1 - positif(IPVLOC)) * LIG1 *TYPE4 ;
regle 1113710:
application : pro, oceans, iliad;
LIG3710 = positif(20 - V_NOTRAIT) 
          * positif(
              positif_ou_nul(((V_0AX -  inf(V_0AX/ 10000) * 10000)) - V_ANREV)
            + positif_ou_nul(((V_0AY -  inf(V_0AY/ 10000) * 10000)) - V_ANREV)
            + BOOL_0AZ
                 )
       	  * LIG1 *TYPE4 ;
regle 1113720:
application : pro, oceans, iliad;
LIG3720 =  ( 1 - positif(20 - V_NOTRAIT))
          *( 1 - positif(LIG3730))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4;
regle 1113730:
application : pro, oceans, iliad;
LIG3730 = (1 -positif(20 - V_NOTRAIT)) 
          * positif(
            positif_ou_nul(V_0AX - V_ANREV)
          + BOOL_0AZ
          + positif_ou_nul(V_0AY - V_ANREV)  
                   )
       	  * LIG1 *TYPE4 ;
regle 1113740:
application : pro , oceans, iliad;
LIG3740 = positif(INDTXMIN) 
       	  * LIG1 *TYPE4 * positif(IND_REV) ;
regle 1113750:
application : pro , oceans, iliad;
LIG3750 = present(V_ZDC) * null(abs(V_ZDC - 1))  
          * positif(IREST)
       	  * LIG1 *TYPE4 ;
regle 1113760:
application : pro , oceans, iliad;
LIG3760 = positif(IDEGR)  
          * positif(IREST)
       	  * LIG1 *TYPE4 ;
LIG_MEMO = (positif( LIGPRELIB + LIG3525*RTNC + LIGSURPLU 
              + LIGSURIMP + LIGREPPLU + LIG_SURSIS + LIGELURAS + LIGELURASC
	      + LIGABDET + LIGABDETP + LIGABDETM + LIGPVJEUNE + LIGRCMSOC 
	      + LIGLIBDIV + LIGRCMIMPAT + LIGABIMPPV + LIGABIMPMV 
	      + LIGCDIS + LIGROBOR + LIGPVSOCG) * (1-null(4-V_REGCO))
	      + positif(LIGOPTCS))
	      * LIG1 * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113870:
application : pro , oceans, iliad;
LIGPRELIB = positif(present(PPLIB) + present(RCMLIB))  * LIG0  * (1-positif(ANNUL2042)) * TYPE4;

LIG3525 = (1 - V_CNR) * positif(RTNC) * LIG1  * (1-positif(ANNUL2042)) * TYPE4;
regle 111021:
application : pro , oceans , iliad , batch ;
LIGPRR2 = positif(PRR2V + PRR2C + PRR2P + PENALIMV + PENALIMC + PENALIMP + 0) ;
regle 111022:
application : pro  , oceans, iliad;
LIG022 = somme(i=1..4:2TSNi) ;
regle 111023:
application : pro  , oceans, iliad;
LIG023 = somme(i=1..4:3TSNi);
regle 111024:
application : pro  , oceans, iliad;
LIG024 = somme(i=1..4:4TSNi);
regle 111062:
application : pro  , oceans, iliad;
LIG062V = CARPEV + CARPENBAV + PENSALV + PENSALNBV ;
LIG062C = CARPEC + CARPENBAC + PENSALC + PENSALNBC ;
LIG062P = somme(i=1..4: CARPEPi + CARPENBAPi) + somme(i=1..4: PENSALPi + PENSALNBPi) ;
regle 111066:
application : pro  , oceans, iliad;
LIG066 = somme(i=1..4:PEBFi);
regle 111390:
application : pro  , oceans, iliad;
LIG390 = GLD1V + GLD1C ;
regle 111030:
application : pro  , oceans, iliad,batch;
LIGLOCNEUF = positif(REPINV) * LIG1;
LIGLOCNEUF1 = positif(RIVL1) * LIG1;
LIGLOCNEUF2 = positif(RIVL2) * LIG1;
LIGLOCNEUF3 = positif(RIVL3) * LIG1;
LIGLOCNEUF4 = positif(RIVL4) * LIG1;
LIGLOCNEUF5 = positif(RIVL5) * LIG1;
LIGLOCNEUF6 = positif(RIVL6) * LIG1;
LIGLOCRES = positif(REPINVRES) * LIG1;
LIGLOCRES1 = positif(RIVL1RES) * LIG1;
LIGLOCRES2 = positif(RIVL2RES) * LIG1;
LIGLOCRES3 = positif(RIVL3RES) * LIG1;
LIGLOCRES4 = positif(RIVL4RES) * LIG1;
LIGLOCRES5 = positif(RIVL5RES) * LIG1;
LIGLOCHOT = positif(INVLOCHOT) * positif(RIVLHOT1 + RIVLHOT2 + RIVLHOT3 + RIVLHOT4 + RIVLHOT5) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGLOCHOT1 = positif(INVLOCHOT) * positif(RIVLHOT1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGLOCHOT2 = positif(INVLOCHOT) * positif(RIVLHOT2) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGLOCHOT3 = positif(INVLOCHOT) * positif(RIVLHOT3) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGLOCHOT4 = positif(INVLOCHOT) * positif(RIVLHOT4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGLOCHOT5 = positif(INVLOCHOT) * positif(RIVLHOT5) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
regle 388:
application : pro , oceans, iliad, batch;
LIGCELDO = positif(DCELDO) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCELDOP = positif(DCELDOP) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCELREDOP = positif(DCELREPDOP9) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCELMET = positif(DCELMET) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCELNP = positif(DCELNP) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCELRENP = positif(DCELREPNP9) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCELRRED = positif(DCELRRED09) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
regle 3882:
application : pro  , oceans, iliad,batch;
LIGRCELDO =  positif(RIVCELDO1) * positif(present(CELLIERD))*((V_REGCO+0) dans (1,3,5,6)) 
	     * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGRCELDPA = positif(RIVCELDPA1) * positif(present(CELLIERD1)) * ((V_REGCO+0) dans (1,3,5,6))
             * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGRCELDOP = positif(RIVCELDOP1) * positif(present(CELLIERD2)) * ((V_REGCO+0) dans (1,3,5,6))
             * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGRCELM =   positif(RIVCELMET1) * positif(present(CELLIERM)) * ((V_REGCO+0) dans (1,3,5,6)) 
	     * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGRCELMPA = positif(RIVCELMPA1) * positif(present(CELLIERM1)) * ((V_REGCO+0) dans (1,3,5,6)) 
	     * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGRCELNP =  positif(RIVCELNP1) * positif(present(CELLIERM2)) * ((V_REGCO+0) dans (1,3,5,6))
	     * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGDCEL = positif(RCELRED + RCELRED09) * ((V_REGCO+0) dans (1,3,5,6)) 
          * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGDCEL1 = positif(CELRRED09) * positif(RCELRED09) * ((V_REGCO+0) dans (1,3,5,6)) 
          * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGDCEL2 = positif(CELLIERM+CELLIERD) * positif(RCELRED) * ((V_REGCO+0) dans (1,3,5,6)) 
          * (1-positif(ANNUL2042)) * TYPE1 * LIG1;
LIGDCELPA = positif(CELLIERM1+CELLIERD1+CELLIERM2+CELLIERD2+CELREPM09+CELREPD09) * positif(RCELREPA) 
	    * ((V_REGCO+0) dans (1,3,5,6)) * (1-positif(ANNUL2042)) * TYPE1 * LIG1; 
LIGDCELPA1 = positif(CELLIERM1+CELLIERD1+CELLIERM2+CELLIERD2+CELREPM09+CELREPD09) * positif(RCELREPA) 
	    * ((V_REGCO+0) dans (1,3,5,6)) * (1-positif(ANNUL2042)) * TYPE1 * LIG1;
regle 389:
application : pro  , oceans, iliad,batch;
LIGPATNAT = LIG1*(1-positif(ANNUL2042))*TYPE1
            *(positif(PATNAT) + null(PATNAT)*positif(V_NOTRAIT-20));
LIGPATNATR = positif(REPNATR6) * LIG1; 
regle 111031:
application : pro, oceans, iliad, batch ;

LIGREPMM = positif(REPMM) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQE = positif(REPQE) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPMMQE = positif(REPMM + REPQE) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPLG = positif(REPLG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQF = positif(REPQF) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQFLG = positif(REPQF + REPLG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPMA = positif(REPMA) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQG = positif(REPQG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQGMA = positif(REPQG + REPMA) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPKS = positif(REPKS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQI = positif(REPQI) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQIKS = positif(REPQI + REPKS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPLS = positif(REPLS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQJ = positif(REPQJ) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQJLS = positif(REPQJ + REPLS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQO = positif(REPQO) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQP = positif(REPQP) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQR = positif(REPQR) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQS = positif(REPQS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPKG = positif(REPKG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQK = positif(REPQK) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQKG = positif(REPQK + REPKG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQN = positif(REPQN) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPDOMPX1 = positif(REPDOMENTR1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMPX2 = positif(REPDOMENTR2) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMPX3 = positif(REPDOMENTR3) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMPX4 = positif(REPDOMENTR4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMENT = positif(REPDOMENTR2+REPDOMENTR3+REPDOMENTR4) 
		  * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMOUT = positif(REPDOMENTR5) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGPMER = positif(REPINVPME) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGPME1 = positif(REPINVPME1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGPME2 = positif(REPINVPME2) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGPME3 = positif(REPINVPME3) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDON = positif(REPDONR + REPDONR1 + REPDONR2 + REPDONR3 + REPDONR4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDONR1 = positif(REPDONR1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDONR2 = positif(REPDONR2) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDONR3 = positif(REPDONR3) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDONR4 = positif(REPDONR4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDONR = positif(REPDONR) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOM = positif(REPDOMENTR) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGRIDOMPRO = positif(RIDOMPRO) * LIG1 ;

LIGPERP = (1 - positif(PERPIMPATRIE+0))
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * (1 - positif(PERP_COND1+PERP_COND2))
		  * (1 - positif(LIGAME)) 
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
		  +0
		  ;
LIGPERPI = positif(PERPIMPATRIE+0)
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * (1 - positif(PERP_COND1+PERP_COND2))
		  * (1 - positif(LIGAME)) 
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
		  +0
		  ;
LIGPERPM = (1 - positif(PERPIMPATRIE+0))
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * positif(PERP_MUT) 
		  * positif(PERP_COND1+PERP_COND2)
		  * (1 - positif(LIGAME)) 
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
		  +0
		  ;
LIGPERPMI = positif(PERPIMPATRIE+0)
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * positif(PERP_MUT) 
		  * positif(PERP_COND1+PERP_COND2)
		  * (1 - positif(LIGAME)) 
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
		  +0
		  ;
LIGPERPFAM = positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
	      * positif(PERPINDC + PERPINDCC)* positif(PERPINDAFFC)
	      * positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
	      * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	      * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	      ;
LIGPERPV = positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
	   * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
	   * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
	   * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPC = positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC)
	  * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
	  * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
	  * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	  * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	  ;
LIGPERPP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
	   * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
	   * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
	   * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPCP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP) 
	   * positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFV) 
	   * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)) 
	   * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPVP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP) 
	   * positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV) 
	   * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
	   * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPMAR = positif(PERPINDV + PERPINDCV)  * positif(PERPINDAFFV)
	     * positif(PERPINDC + PERPINDCC)  * positif(PERPINDAFFC)
	     * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)) 
	     * LIG1 * (1-V_CNR) * (1 - positif(ANNUL2042))
	     * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
		     ;
regle 1113700:
application : pro  , oceans, iliad;
LIG3700 = positif(LIG3710 + LIG3720 + LIG3730)
      * LIG1 *TYPE4 ;
regle 111420:
application : pro  , oceans, iliad,batch;
LIGTAXANET = positif( (present(CESSASSV) + present(CESSASSC)) * INDREV1A8IR)
		* TYPE1;
regle 1113600:
application : pro , oceans, iliad;
EXOVOUS = 
 ( present ( TSASSUV ) 
 + present ( TSELUPPEV ) * ( 1 - V_CNR )
 + present ( XETRANV)
 + present ( EXOCETV)
 + present ( FEXV ) 
 + present ( MIBEXV ) 
 + present ( XBAV ) 
 + present ( XBIPV ) 
 + present ( XBINPV ) 
 + present ( MIBNPEXV ) 
 + present ( BNCPROEXV ) 
 + present ( XBNV ) 
 + present ( XBNNPV ) 
 + present ( BAPERPV ) 
 + present ( BIPERPV ) 
 + present ( BNCCREAV ) 
 + present ( HEURESUPV )
 + (present ( AUTOBICVV ) + present ( AUTOBICPV ) 
 + present ( AUTOBNCV ) 
 + present ( XHONOAAV ) + present ( XHONOV )) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))
 + present ( XSPENPV )) * (1-null(4-V_REGCO)) 
 ;
EXOCJT = 
 ( present ( TSASSUC ) 
 + present ( TSELUPPEC ) * ( 1 - V_CNR )
 + present ( XETRANC)
 + present ( EXOCETC)
 + present ( FEXC ) 
 + present ( MIBEXC ) 
 + present ( XBAC ) 
 + present ( XBIPC ) 
 + present ( XBINPC ) 
 + present ( XBNC ) 
 + present ( XBNNPC ) 
 + present ( MIBNPEXC ) 
 + present ( BNCPROEXC ) 
 + present ( BAPERPC ) 
 + present ( BIPERPC ) 
 + present ( BNCCREAC ) 
 + present ( HEURESUPC)
 + (present ( AUTOBICVC ) + present ( AUTOBICPC ) 
 + present ( AUTOBNCC ) 
 + present ( XHONOAAC ) + present ( XHONOC )) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))
 + present ( XSPENPC )) * (1-null(4-V_REGCO)) 
 ;
EXOPAC = 
 ( present ( FEXP ) 
 + present ( MIBEXP ) 
 + present ( XBAP ) 
 + present ( XBIPP ) 
 + present ( XBINPP ) 
 + present ( XBNP ) 
 + present ( XBNNPP ) 
 + present ( MIBNPEXP ) 
 + present ( BNCPROEXP ) 
 + present ( BAPERPP ) 
 + present ( BIPERPP ) 
 + present ( BNCCREAP ) 
 + present ( HEURESUPP1)
 + present ( HEURESUPP2)
 + present ( HEURESUPP3)
 + present ( HEURESUPP4)
 + (present ( AUTOBICVP ) + present ( AUTOBICPP ) 
 + present ( AUTOBNCP ) 
 + present ( XHONOAAP ) + present ( XHONOP )) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))
 + present ( XSPENPP )) * (1-null(4-V_REGCO)) 
 ;
regle 1113601:
application : pro , oceans, iliad;
LIGTITREXVCP =  positif ( EXOVOUS)
               * positif (EXOCJT)
               * positif (EXOPAC)
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113602:
application : pro , oceans, iliad;
LIGTITREXV = positif ( EXOVOUS)
               * (1 - positif (EXOCJT))
               * (1 - positif (EXOPAC))
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113603:
application : pro , oceans, iliad;
LIGTITREXC =  ( 1 - positif ( EXOVOUS))
               * positif (EXOCJT)
               * (1 - positif (EXOPAC))
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113604:
application : pro , oceans, iliad;
LIGTITREXP =  (1 - positif ( EXOVOUS))
               * (1 - positif (EXOCJT))
               * positif (EXOPAC)
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113605:
application : pro , oceans, iliad;
LIGTITREXVC =  positif ( EXOVOUS)
               * positif (EXOCJT)
               * (1 - positif (EXOPAC))
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113606:
application : pro , oceans, iliad;
LIGTITREXVP =  positif ( EXOVOUS)
               * ( 1 - positif (EXOCJT))
               * positif (EXOPAC)
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113607:
application : pro , oceans, iliad;
LIGTITREXCP =  (1 - positif ( EXOVOUS))
               * positif (EXOCJT) 
               * positif (EXOPAC)
	       * (1 - positif(LIG2501))
          * LIG1  * (1-positif(ANNUL2042)) * TYPE4 ;
regle 1113608:
application : pro , oceans, iliad;
LIGMXBIP =  positif(MIBEXV + MIBEXC + MIBEXP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGMXBINP =  positif(MIBNPEXV + MIBNPEXC + MIBNPEXP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGSXBN =  positif(BNCPROEXV + BNCPROEXC + BNCPROEXP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGXSPEN =  positif(XSPENPV + XSPENPC + XSPENPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGXBIP =  positif(XBIPV + XBIPC + XBIPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGXBINP =  positif(XBINPV + XBINPC + XBINPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGXBP =  positif(XBNV + XBNC + XBNP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGXBN =  positif(XBNNPV + XBNNPC + XBNNPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGBICAP = positif(ABICPDECV + ABICPDECC + ABICPDECP) * LIG1 * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) * (1-positif(ANNUL2042)) * TYPE4;
LIGBICANP = positif(ABICNPDECV + ABICNPDECC + ABICNPDECP) * LIG1 * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) * (1-positif(ANNUL2042)) * TYPE4;
LIGBNCAP = positif(ABNCPDECV + ABNCPDECC + ABNCPDECP) * LIG1 * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) * (1-positif(ANNUL2042)) * TYPE4;
LIGBNCANP = positif(ABNCNPDECV + ABNCNPDECC + ABNCNPDECP) * LIG1 * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) * (1-positif(ANNUL2042)) * TYPE4;
LIGHONO = positif(HONODECV + HONODECC + HONODECP) * LIG1 * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) * (1-positif(ANNUL2042)) * TYPE4;
LIGBAPERP =  positif(BAPERPV + BAPERPC + BAPERPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGBIPERP =  positif(BIPERPV + BIPERPC + BIPERPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;
LIGBNCCREA =  positif(BNCCREAV + BNCCREAC + BNCCREAP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE4;


regle 117010:
application : pro  , oceans, iliad;

ZIG_TITRECRP = positif(BCSG1 + V_CSANT) * positif(BRDS1 + V_RDANT) * positif(BPRS1 + V_PSANT) * (1 - positif(BCSAL + V_CSALANT))
                * (1 - V_CNR)
                * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIGTITRECRPS = positif(BCSG1 + V_CSANT) * positif(BRDS1 + V_RDANT) * positif(BPRS1 + V_PSANT) * positif(BCSAL + V_CSALANT)
                * (1 - V_CNR)
                * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIGTITRECRS = positif(BCSG1 + V_CSANT) * positif(BRDS1 + V_RDANT) * positif(BCSAL + V_CSALANT) * (1 - positif(BPRS1 + V_PSANT))
                * (1 - V_CNR)
                * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIGTITRERS = (1 - positif(BCSG1 + V_CSANT)) * positif(BRDS1 + V_RDANT) * (1 - positif(BPRS1 + V_PSANT)) * positif(BCSAL + V_CSALANT)
              * (1 - V_CNR)
              * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITRECR = positif(BCSG1 + V_CSANT) * positif(BRDS1 + V_RDANT) * (1 - positif(BPRS1 + V_PSANT)) * (1 - positif(BCSAL + V_CSALANT))
               * (1 - V_CNR)
               * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITRECP = positif(BCSG1 + V_CSANT) * (1 - positif(BRDS1 + V_RDANT)) * positif(BPRS1 + V_PSANT) * (1 - positif(BCSAL + V_CSALANT))
               * (1 - V_CNR)
               * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITRERP = (1 - positif(BCSG1 + V_CSANT)) * positif(BRDS1 + V_RDANT) * positif(BPRS1 + V_PSANT) * (1 - positif(BCSAL + V_CSALANT))
               * (1 - V_CNR)
               * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITREC = positif(BCSG1 + V_CSANT) * (1 - positif(BRDS1 + V_RDANT)) * (1 - positif(BPRS1 + V_PSANT)) * (1 - positif(BCSAL + V_CSALANT)) 
              * (1 - V_CNR)
              * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITRER = positif(BRDS1 + V_RDANT) * (1 - positif(BCSG1 + V_CSANT)) * (1 - positif(BPRS1 + V_PSANT)) * (1 - positif(BCSAL + V_CSALANT))
              * (1 - V_CNR)
              * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITREP = positif(BPRS1 + V_PSANT) 
              * (1 - V_CNR)
              * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIGTITRES = positif(BCSAL + V_CSALANT) * (1 - positif(BRDS1 + V_RDANT)) * (1 - positif(BCSG1 + V_CSANT)) * (1 - positif(BPRS1 + V_PSANT))
             * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIG_TITREPN = positif(BPRS1 + V_PSANT)
               * (1 - V_CNR)
               * (1 - positif(ANNUL2042)) * TYPE4 ;

ZIGSUIS = positif(REVSUIS)
           * (1 - V_CNR)
           * (1 - positif(ANNUL2042)) * TYPE4 ;

regle 117020:
application : pro ;

ZIGTITRE = positif( (((positif (BCSG +V_CSANT) + positif (BRDS+V_RDANT) + positif (BPRS+V_PSANT) + positif (BCDIS + V_CDISANT))
                       * (1 - V_CNR)) 
		       + positif (BCSAL + V_CSALANT))
		      * (1-positif(ANNUL2042)) * TYPE4 ) ;

ZIGBASECS1 = positif(BCSG + V_CSANT) ;
ZIGBASERD1 = positif(BRDS + V_RDANT) ;
ZIGBASEPS1 = positif(BPRS + V_PSANT) ;
ZIGBASESAL1 = positif(positif(BCSAL + V_CSALANT) + positif (BCDIS + V_CDISANT)) ;

regle 117030:
application : oceans, iliad ;

ZIGTITRE = positif( (((positif (BCSG +V_CSANT) + positif (BRDS+V_RDANT) + positif (BPRS+V_PSANT) + positif (BCDIS + V_CDISANT))
                       * (1 - V_CNR))
		       + positif (BCSAL + V_CSALANT))
		      * positif(INDCTX) * TYPE4 ) ;

ZIGBASECS1 = positif(BCSG + V_CSANT) * positif(INDCTX) ;
ZIGBASERD1 = positif(BRDS + V_RDANT) * positif(INDCTX) ;
ZIGBASEPS1 = positif(BPRS + V_PSANT) * positif(INDCTX) ;
ZIGBASESAL1 = positif(positif(BCSAL + V_CSALANT) + positif (BCDIS + V_CDISANT)) * positif(INDCTX) ;

regle 117080:
application : pro  , oceans, iliad;

CS_RVT = RDRV ;
RD_RVT = CS_RVT;
PS_RVT = CS_RVT;
IND_ZIGRVT =  0;

ZIG_RVTO = positif ( CS_RVT + RD_RVT + PS_RVT + IND_ZIGRVT)
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117100:
application : pro  , oceans, iliad;

CS_RCM =  RDRCM;
RD_RCM = CS_RCM;
PS_RCM = CS_RCM;
IND_ZIGRCM = positif(V_NOTRAIT - 20) * positif( present(RCMABD)  
                     +present(RCMAV)   
                     +present(RCMHAD) 
                     +present(RCMHAB)  
                     +present(RCMTNC)
                     +present(RCMAVFT)
                     +present(REGPRIV) 
                     );
ZIG_RCM = positif(CS_RCM + RD_RCM + PS_RCM + IND_ZIGRCM)
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117105:
application : pro  , oceans, iliad;
CS_REVCS = RDNP;
RD_REVCS = CS_REVCS;
PS_REVCS = CS_REVCS;
IND_ZIGPROF = positif(V_NOTRAIT - 20) * positif( present(RCSV)
                     +present(RCSC)
                     +present(RCSP));
ZIG_PROF = positif(CS_REVCS+RD_REVCS+PS_REVCS+IND_ZIGPROF)
                   * (1 - V_CNR) * LIG1 ;
regle 117110:
application : pro  , oceans, iliad;

CS_RFG = RDRF ;
RD_RFG = CS_RFG;
PS_RFG = CS_RFG;
IND_ZIGRFG = positif(V_NOTRAIT - 20) * positif( present(RFORDI)
                     +present(RFDORD)
                     +present(RFDHIS)
                     +present(RFMIC) );

ZIG_RF = positif(CS_RFG + RD_RFG + PS_RFG + IND_ZIGRFG)
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117181:
application : pro  , oceans, iliad;

CS_RTF = RDPTP ;
RD_RTF = CS_RTF  ;
PS_RTF = CS_RTF  ;
IND_ZIGRTF=  positif(V_NOTRAIT - 20) * positif (present (PEA) +
                      present ( BPCOPT )  +
                      present ( BPVRCM )  +
                      present ( BPVKRI )  
                     );
ZIG_RTF = positif (CS_RTF + RD_RTF + PS_RTF + IND_ZIGRTF)
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;

ZIGGAINLEV = positif(BPVOPTCS) * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117190:
application : pro  , oceans, iliad;

CS_REVETRANG = 0 ;
RD_REVETRANG = IPECO ;
PS_REVETRANG = 0 ;
IND_ZIGREVETRANG =  present(IPECO);
ZIG_REVETRANG = positif (CS_REVETRANG + RD_REVETRANG + PS_REVETRANG
                        + IND_ZIGREVETRANG)
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117200:
application : pro  , oceans, iliad;

CS_REVORIGIND =   ESFP;
RD_REVORIGIND =   ESFP;
PS_REVORIGIND =   ESFP;
IND_ZIGREVORIGIND = present(ESFP);
ZIG_REVORIGIND = positif (CS_REVORIGIND + RD_REVORIGIND + PS_REVORIGIND
                         + IND_ZIGREVORIGIND)
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117205:
application : pro, oceans, iliad ;

CS_RE168 = RE168 ;
RD_RE168 = RE168 ;
PS_RE168 = RE168 ;

CS_TAX1649 = TAX1649 ;
RD_TAX1649 = TAX1649 ;
PS_TAX1649 = TAX1649 ;

CS_R1649 = R1649 ;
RD_R1649 = R1649 ;
PS_R1649 = R1649 ;

CS_PREREV = PREREV ;
RD_PREREV = PREREV ;
PS_PREREV = PREREV ;

ZIGRE168 = positif(RE168) * (1 - V_CNR) * (1-positif(ANNUL2042)) * TYPE1 ;
ZIGTAX1649 = positif(TAX1649) * (1 - V_CNR) * (1-positif(ANNUL2042)) * TYPE1 ;

ZIGR1649 = positif(R1649) * (1 - V_CNR) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
ZIGPREREV = positif(PREREV) * (1 - V_CNR) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;

regle 117210:
application : pro  , oceans, iliad;

CS_BASE = BCSG1 ;
RD_BASE = BRDS1 ;
PS_BASE = BPRS1 ;
CSAL_BASE = BCSAL;
ZIGBASECS = positif(BCSG1 + V_CSANT);
ZIGBASERD = positif(BRDS1 + V_RDANT);
ZIGBASEPS = positif(BPRS1 + V_PSANT);
ZIGBASESAL = positif(BCSAL + V_CSALANT);
ZIG_BASE = positif(BCSG1 + BRDS1 + BPRS1 + BCSAL + V_CSANT + V_RDANT + V_PSANT + V_CSALANT)
                    * (1-positif(ANNUL2042)) * TYPE1;
ZIGCDIS = positif(BCDIS) * (1 - positif(ANNUL2042)) * TYPE1 ;
regle 117220:
application : pro  , oceans, iliad;
ZIG_TAUXCRP  = ZIG_TITRECRP * (1 - V_EAD) * (1 - V_EAG);
ZIGTAUXCRP   = ZIG_TITRECRP * (V_EAD + V_EAG);
ZIG_TAUXCR   = ZIG_TITRECR ;
ZIG_TAUXCP   = ZIG_TITRECP;
ZIG_TAUXRP   = ZIG_TITRERP;
ZIG_TAUXC    = ZIG_TITREC * (1 - V_EAD) * (1 - V_EAG);
ZIG_TAUXR    = ZIG_TITRER * (1 - V_EAD) * (1 - V_EAG);
ZIG_TAUXP    = ZIG_TITREP * (1 - V_EAD) * (1 - V_EAG);
ZIGTAUX1 = ZIGTITRECRPS * (1 - V_EAD) * (1 - V_EAG);
ZIGTAUX2 = ZIGTITRECRPS * (V_EAD + V_EAG);
ZIGTAUX3 = ZIGTITRECRS * (1 - V_EAD) * (1 - V_EAG) ;
ZIGTAUX4 = ZIG_TITRECR * (1 - V_EAD) * (1 - V_EAG) ;
ZIG_TAUXCD    = ZIG_TITREC * (V_EAD + V_EAG);
ZIG_TAUXRD    = ZIG_TITRER * (V_EAD + V_EAG);
ZIG_TAUXPD    = ZIG_TITREP * (V_EAD + V_EAG);
regle 117290:
application : pro  , oceans, iliad;
ZIGMONTCS = positif(BCSG1 + V_CSANT);
ZIGMONTRD = positif(BRDS1 + V_RDANT);
ZIGMONTPS = positif(BPRS1 + V_PSANT);
ZIGMONTS = positif(BCSAL + V_CSALANT);
ZIG_MONTANT = positif ( BCSG1 + BRDS1 + BPRS1 + BCSAL + V_CSANT + V_RDANT + V_PSANT + V_CSALANT) 
	       * TYPE1 ;
ZIGMONTANT = positif ( BCSG + BRDS + BPRS + BCSAL + V_CSANT + V_RDANT + V_PSANT + V_CSALANT) 
	      * positif(REVSUIS) * (1 - V_CNR) * TYPE1 ;

regle 117300:
application : pro  , oceans, iliad;
ZIG_INT =  positif (RETCS + RETRD + RETPS + RETCSAL)
               * (1-positif(ANNUL2042)) * TYPE2;

ZIGINT = positif( RETCDIS ) * (1 - positif(ANNUL2042)) * TYPE2 ;
regle 117330:
application : pro  , oceans, iliad;
ZIG_PENA1728_1 = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJCSAL1)
                   * null (10 - max(MAJTXC1,MAJTXR1))
                    * (1-positif(ANNUL2042)) * TYPE2;

ZIG_PENA1728 = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJCSAL1)
                   * (1-null (10 - max(MAJTXC1,MAJTXR1)))
                   * (1-null(max(MAJTXC1,MAJTXR1)))  * (1-positif(ANNUL2042)) * TYPE2;


ZIG_PENATAUX4 = ZIG_PENAMONT * positif(NMAJC4 + NMAJR4 + NMAJP4 + NMAJCSAL4) * (1-positif(ANNUL2042)) * TYPE2;
ZIG_PENATAUX = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJCSAL1) * (1-positif(ANNUL2042)) * TYPE2;

ZIGNONR30 = positif((1 - positif(R1649 + PREREV)) * (1-positif(ANNUL2042)) * TYPE2) ;
ZIGR30 = positif(positif(R1649 + PREREV) * (1-positif(ANNUL2042)) * TYPE2) ;

ZIGPENACDIS = positif(PCDIS) * positif(NMAJCDIS1) * (1-positif(ANNUL2042)) * TYPE2 ;
ZIGPENACDIS4 = positif(PCDIS) * positif(NMAJCDIS4) * (1-positif(ANNUL2042)) * TYPE2 ;

ZIG17281 = positif(PCDIS) * null (10 - max(MAJTXC1,MAJTXR1))  * (1-positif(ANNUL2042)) * TYPE2 ;
ZIG1728 = positif(PCDIS) * (1-null (10 - max(MAJTXC1,MAJTXR1))) * (1-null(max(MAJTXC1,MAJTXR1)))  * (1-positif(ANNUL2042)) * TYPE2 ;

regle 117350:
application : pro  , oceans, iliad;
ZIG_PENAMONT =  positif ( PCSG + PRDS + PPRS + PCSAL)
                    * (1-positif(ANNUL2042)) * TYPE2;
regle 117360:
application : pro  , oceans, iliad;
ZIG_CRDETRANG = present (IPPNCS) * (1-positif(ANNUL2042)) * TYPE2;
regle 117390:
application : pro  , oceans, iliad;
ZIG_CONTRIBANT = positif(V_ANTCR) * TYPE2;

ZIGCDISANT = positif(V_CDISANT) * TYPE2 ;
regle 117410:
application : pro  , oceans, iliad;
ZIG_CONTRIBPROV = positif (CSALPROV+PRSPROV+CSGIM+CRDSIM)
                    * (1-positif(ANNUL2042)) * TYPE2;
ZIG_CONTRIBPROV_A = positif (PRSPROV_A + CSGIM_A + CRDSIM_A)
                    * (1-positif(ANNUL2042)) * TYPE2;
regle 117430:
application : pro  , oceans, iliad;
IND_COLC = positif(BCSG) * (1-INDCTX) ;
IND_COLR = positif(BRDS) * (1-INDCTX) ;
IND_COLP = positif(BPRS) * (1-INDCTX) ;
IND_COLS = positif(BCSAL) * (1-INDCTX) ;
IND_COLD = positif(BCDIS) * (1-INDCTX) ;

IND_CTXC =  positif(CS_DEG) * positif(INDCTX) ;
IND_CTXR =  positif(CS_DEG) * positif(INDCTX) ;
IND_CTXP =  positif(CS_DEG) * positif(INDCTX) ;
IND_CTXS =  positif(CS_DEG) * positif(BPVOPTCS) * positif(INDCTX) ;
IND_CTXD =  positif(CS_DEG) * positif(BCDIS) * positif(INDCTX) ;

regle 117440:
application : pro  , oceans, iliad;
ZIG_NETAP =  positif (BCSG  + BRDS + BPRS + BCSAL + BCDIS)
             * (1 - positif(CS_DEG))
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117450:
application : pro  , oceans, iliad;
ZIG_TOTDEG = positif (CRDEG) * positif(INDCTX) * TYPE2;

ZIGANNUL = positif(INDCTX) * positif(ANNUL2042) * TYPE1 ;

regle 117660:
application : pro  , oceans, iliad;
ZIG_REMPLACE  = positif((1 - positif(20 - V_NOTRAIT)) 
               * positif(V_ANREV - V_0AX)
               * positif(V_ANREV - V_0AZ)
               * positif(V_ANREV - V_0AY) + positif(V_NOTRAIT - 20))
                * (1-positif(ANNUL2042)) * TYPE4 ;
regle 117710:
application : pro  , oceans , iliad;
ZIG_DEGINF61 = positif(V_CSANT+V_RDANT+V_PSANT+V_CSALANT+0)  
               * positif(CRDEG+0)
               * positif(SEUIL_PERCEP-TOTCRA-CSNET-RDNET-PRSNET-CSALNET-CDISNET+0)
               * (1 - null(CSTOT+0))
                * (1-positif(ANNUL2042)) * TYPE4;
regle 117820:
application : pro  , oceans, iliad;
ZIG_CSGDCOR = positif(ZIG_CSGDDO + ZIG_CSGDRS)  
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117821:
application : pro  , oceans, iliad;
ZIG_CSGDDO = positif(V_IDANT - DCSGD) * positif(IDCSG)
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117822:
application : pro  , oceans, iliad;
ZIG_CSGDRS = positif(V_CSANT+V_RDANT+V_PSANT+V_IDANT)  
           * positif(DCSGD - V_IDANT) * positif(IDCSG)
                    * (1-positif(ANNUL2042)) * TYPE1;
regle 117850:
application : pro  , oceans, iliad;
ZIG_PRIM = positif(NAPCR)  * (1-positif(ANNUL2042)) * TYPE4;
regle 117130:
application : pro  , oceans, iliad;

CS_BPCOS = RDNCP;
RD_BPCOS = CS_BPCOS;
PS_BPCOS = CS_BPCOS;

ZIG_BPCOS = positif (CS_BPCOS + RD_BPCOS + PS_BPCOS) 
                   * (1 - V_CNR) * LIG1
                    * (1-positif(ANNUL2042)) * TYPE2;
regle 117803:
application :     pro;
ANCSDED2 = V_ANCSDED;
regle 117801:
application :     oceans, iliad;
ANCSDED2 = positif (V_ROLCSG + 0) * ( 
           (V_ANCSDED) * positif(null(40 - V_ROLCSG) + null (50 - V_ROLCSG))
         + (V_ANCSDED + 1) * positif(null(44 - V_ROLCSG) + null (47 - V_ROLCSG))
                                    )
         + (1 - positif(V_ROLCSG + 0)) * V_ANCSDED;
ZIG_CSGDPRIM = (1-positif(V_CSANT+V_RDANT+V_PSANT+V_IDANT))
               * positif(IDCSG)
                    * (1-positif(ANNUL2042)) * TYPE1;
ZIG_CSGD99 = (null(40-V_ROLCSG) + null(50-V_ROLCSG)
           +  null(47-V_ROLCSG) + null(44-V_ROLCSG)) * ZIG_CSGDPRIM ;
regle 117802:
application : pro  ;
ZIG_CSGDPRIM = (1-positif(V_CSANT+V_RDANT+V_PSANT+V_IDANT))
               * positif(IDCSG)
                    * (1-positif(ANNUL2042)) * TYPE1;
ZIG_CSGD99 =  ZIG_CSGDPRIM ;
regle 113530:
application : pro  , oceans, iliad;
LIG_SURSIS = positif(BPTIMMED + SURPLU + SURIMP) * LIG1  * (1-positif(ANNUL2042)) * TYPE4;
regle 113531:
application : pro  , oceans, iliad;
LIG_CORRECTION = positif_ou_nul(IBM23) * INDREV1A8 * LIG1  * (1-positif(ANNUL2042)) * TYPE1;
regle 113532:
application : pro  , oceans, iliad;
LIG_R8ZT = positif(V_8ZT) * LIG1  * (1-positif(ANNUL2042)) * TYPE2;
regle 113533:
application : pro  , oceans, iliad;
LIGTXMOYPOS = present(RMOND) * LIG1  * (1-positif(ANNUL2042)) * TYPE1;
LIGTXMOYNEG = positif(DMOND) * LIG1  * (1-positif(ANNUL2042)) * TYPE1;
regle 114000:
application : pro  , oceans, iliad;
LIGAMEETREV = positif(INDREV1A8) * positif(AME) * LIG1  * (1-positif(ANNUL2042)) * TYPE1;
regle 114100:
application : pro , oceans, iliad;
LIG_SAL = positif( TSHALLOV + TSHALLOC + TSHALLOP ) * positif(ALLOV+ALLOC+ALLOP)
          * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIG_REVASS = positif( ALLOV + ALLOC + ALLOP ) * positif(TSHALLOV+TSHALLOC+TSHALLOP)
          * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIG_SALASS = positif( TSBNV + TSBNC + TSBNP + F10AV + F10AC + F10AP ) 
          * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGF10V = positif( F10AV + F10BV ) 
          * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGF10C = positif( F10AC + F10BC ) 
          * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGF10P = positif( F10AP + F10BP ) 
          * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 114300:
application : pro  , oceans, iliad,batch;
LIGMIBNPNEG = positif((MIBNPRV+MIBNPRC+MIBNPRP+MIB_NETNPCT) * (-1))  * (1-positif(ANNUL2042+0)) * TYPE1;
LIGMIBNPPOS = positif(MIBNPRV+MIBNPRC+MIBNPRP+MIB_NETNPCT) * (1 -positif(LIG_BICNPF)) * (1-positif(ANNUL2042+0)) * TYPE1;
LIG_MIBP = positif(somme(i=V,C,P:MIBVENi) + somme(i=V,C,P:MIBPRESi) + MIB_NETCT +0);
regle 114400:
application : pro  , oceans, iliad,batch;
LIGSPENPNEG = positif(SPENETNPF * (-1)) 
                     * (1 - positif(
 present( BNCAABV )+ 
 present( BNCAADV )+ 
 present( BNCAABC )+ 
 present( BNCAADC )+ 
 present( BNCAABP )+ 
 present( BNCAADP )+ 
 present( DNOCEP )+ 
 present( ANOVEP )+ 
 present( DNOCEPC )+ 
 present( ANOPEP )+ 
 present( DNOCEPP )+ 
 present( ANOCEP )+ 
 present( DABNCNP6 )+ 
 present( DABNCNP5 )+ 
 present( DABNCNP4 )+ 
 present( DABNCNP3 )+ 
 present( DABNCNP2 )+ 
 present( DABNCNP1 )
		     )) * (1-positif(ANNUL2042)) * TYPE1;
LIGSPENPPOS = (positif(SPENETNPF)+positif(BNCNPV+BNCNPC+BNCNPP)*null(SPENETNPF)) 
	    * positif_ou_nul(ANOCEP - (DNOCEP + DABNCNP6+DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1)+0) 
                     * (1 - positif(
 present( BNCAABV )+ 
 present( BNCAADV )+ 
 present( BNCAABC )+ 
 present( BNCAADC )+ 
 present( BNCAABP )+ 
 present( BNCAADP )+ 
 present( DNOCEP )+ 
 present( ANOVEP )+ 
 present( DNOCEPC )+ 
 present( ANOPEP )+ 
 present( DNOCEPP )+ 
 present( ANOCEP )+ 
 present( DABNCNP6 )+ 
 present( DABNCNP5 )+ 
 present( DABNCNP4 )+ 
 present( DABNCNP3 )+ 
 present( DABNCNP2 )+ 
 present( DABNCNP1 )
		     )) * (1-positif(ANNUL2042)) * TYPE1;
regle 114500:
application : pro  , oceans, iliad;
LIGRCMABT = positif(present(RCMABD) + present(RCMTNC)
                    + present(RCMHAD) + present(RCMHAB) + present(RCMAV) + present(REGPRIV) 
		    + present(RCMFR) + present(DEFRCM) + present(DEFRCM2) + present(DEFRCM3))
             * (1 - positif(IPVLOC)) *TYPE1 * (1-positif(ANNUL2042)) * positif(INDREV1A8IR) ;

LIG2RCMABT = positif(present(REVACT) + present(REVPEA) + present(PROVIE) + present(DISQUO) + present(RESTUC) + present(INTERE)) 
		* (1 - positif(IPVLOC)) *TYPE1 * (1-positif(ANNUL2042)) * positif(INDREV1A8IR) ;
regle 114909:
application : pro  , oceans, iliad;

LIGTXMOYIMP = positif(TXMOYIMP) * (1 - positif(V_CNR))
	       * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO) 
                              + positif(present(NRINET) + present(NRBASE) + present(IMPRET) + present(BASRET))))
               * IND_REV * (1 - positif(ANNUL2042)) * TYPE1 ;

regle 114600:
application : pro  , oceans, iliad, batch;
LIGACHTOUR = positif(INVLOCNEUF) * TYPE1 ;

LIGTRATOUR = positif(INVLOCT1 + INVLOCT2) * TYPE1 ;

LIGREPTOUR = positif(REPINVLOCINV + RINVLOCINV) * TYPE1 ;

LIGTOURHOT = positif(INVLOCHOT) * TYPE1 ;

LIGLOCHOTR = positif(INVLOCHOTR1 + INVLOCHOTR) * TYPE1 ;

LIGLOGRES = positif(INVLOCRES) * TYPE1 ;

LIGLOGDOM = positif(DLOGDOM) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGLOGSOC = positif(DLOGSOC) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGDOMSOC1 = positif(DDOMSOC1) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGLOCENT = positif(DLOCENT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGCOLENT = positif(DCOLENT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGREPHA  = positif(REPINVLOCREA + RINVLOCREA) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

regle 114700:
application : pro, oceans, iliad, batch ;
LIGCICA = positif(BAILOC98) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCIGARD = positif(DGARD) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPRETUD = positif(PRETUD+PRETUDANT) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSALDOM = present(CREAIDE) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPERT = positif(PERCRE) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGHABPRIN = positif(present(PREHABT) + present(PREHABT1) + present(PREHABT2) + present(PREHABTN)) 
				      * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEVDUR = positif(DDEVDUR) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDDUBAIL = positif(DEVDURBAIL) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;

LIGREDAGRI = positif(DDIFAGRI) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGFORET = positif(DFORET) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGFOREST = positif(REPBON + REPFOREST) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * (1 - V_CNR) ;
LIGREPBON = positif(REPBON) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * (1 - V_CNR) ;
LIGREPFOR = positif(REPFOREST) * (1 - positif(SINISFORET)) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * (1 - V_CNR) ;
LIGNFOREST = positif(REPSIN + REPFORSIN) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREPSIN = positif(REPSIN) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSINFOR = positif(REPFORSIN) * positif(SINISFORET) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

LIGFIPC = positif(DFIPC) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCINE = positif(DCINE) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCITEC = positif(DTEC) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRIRENOV = positif(DRIRENOV) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGTITPRISE = positif(DTITPRISE) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREPAR = positif(NUPROPT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREPREPAR = positif(REPAR + REPAR1) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 * (1 - V_CNR) ;
LIGREPARN = positif(REPAR) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 * (1 - V_CNR) ;
LIGREPAR1 = positif(REPAR1) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 * (1 - V_CNR) ;
LIGRESTIMO = (present(RESTIMOPPAU) + present(RESTIMOSAUV)) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPECHE = present(SOFIPECHE) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRSA = positif(PPERSATOT) * positif(PPETOT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGNEUV = positif(LOCRESINEUV) * positif(RESINEUV1 + RESINEUV2 + RESINEUV3 + RESINEUV4 + RESINEUV5 + RESINEUV6 + RESINEUV7 + RESINEUV8) 
	     * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV1 = positif(LOCRESINEUV) * positif(RESINEUV1) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV2 = positif(LOCRESINEUV) * positif(RESINEUV2) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV3 = positif(LOCRESINEUV) * positif(RESINEUV3) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV4 = positif(LOCRESINEUV) * positif(RESINEUV4) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV5 = positif(LOCRESINEUV) * positif(RESINEUV5) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV6 = positif(LOCRESINEUV) * positif(RESINEUV6) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV7 = positif(LOCRESINEUV) * positif(RESINEUV7) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGNEUV8 = positif(LOCRESINEUV) * positif(RESINEUV8) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGRNEUV = positif(MEUBLENP) * positif(RRESINEUV1 + RRESINEUV2 + RRESINEUV3 + RRESINEUV4 + RRESINEUV5 + RRESINEUV6 + RRESINEUV7 + RRESINEUV8) 
	     * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV1 = positif(MEUBLENP) * positif(RRESINEUV1) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV2 = positif(MEUBLENP) * positif(RRESINEUV2) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV3 = positif(MEUBLENP) * positif(RRESINEUV3) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV4 = positif(MEUBLENP) * positif(RRESINEUV4) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV5 = positif(MEUBLENP) * positif(RRESINEUV5) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV6 = positif(MEUBLENP) * positif(RRESINEUV6) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV7 = positif(MEUBLENP) * positif(RRESINEUV7) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRNEUV8 = positif(MEUBLENP) * positif(RRESINEUV8) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGVIEU = positif(RESIVIEU) * positif(RESIVIEU1 + RESIVIEU2 + RESIVIEU3 + RESIVIEU4 + RESIVIEU5 + RESIVIEU6 + RESIVIEU7 + RESIVIEU8) 
	     * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU1 = positif(RESIVIEU) * positif(RESIVIEU1) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU2 = positif(RESIVIEU) * positif(RESIVIEU2) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU3 = positif(RESIVIEU) * positif(RESIVIEU3) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU4 = positif(RESIVIEU) * positif(RESIVIEU4) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU5 = positif(RESIVIEU) * positif(RESIVIEU5) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU6 = positif(RESIVIEU) * positif(RESIVIEU6) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU7 = positif(RESIVIEU) * positif(RESIVIEU7) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGVIEU8 = positif(RESIVIEU) * positif(RESIVIEU8) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGREPNEUV = positif(REPRESINEUV + MEUBLERED) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPRESI = positif(REPRESINEUV) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPRED = positif(MEUBLERED) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPMEU = positif(REPRETREP) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 * ((V_REGCO+0) dans (1,3,5,6)) ;

regle 114750:
application : pro, oceans, iliad, batch ;
LIGCREAT = positif(DCREAT + DCREATHANDI) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCREFAM = positif(CREFAM) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCREAPP = positif(CREAPP) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCREBIO = positif(CREAGRIBIO) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCREPROSP = positif(CREPROSP) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCREFORM = positif(CREFORMCHENT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGINTER = positif(CREINTERESSE) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMETART = positif(CREARTS) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCONGA = positif(CRECONGAGRI) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRESTAU = positif(CRERESTAU) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGTABAC = positif(CIDEBITTABAC) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGLOYIMP = positif(LOYIMP) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRESINEUV = positif(DRESINEUV) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRESIVIEU = positif(DRESIVIEU) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMEUBLE = positif(DMEUBLE) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREDMEUB = positif(DREDMEUB) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGVERSLIB = positif(AUTOVERSLIB) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;

regle 114800:
application : pro  , oceans, iliad, batch ;
pour i=V,C,P:
PPESAISITPi = positif(PPEACi* positif(abs(PPERPROi)));

pour i=V,C,P:
PPESAISINBJi = positif(PPENJi* positif(abs(PPERPROi)));

INDPPEV = positif(   PPETPV*PPESALVTOT
                   + PPENHV*PPESALVTOT
                   + positif(
                              present ( BPCOSAV  )
                            + present ( GLD1V  )
                            + present ( GLD2V  )
                            + present ( GLD3V  )
                            + present ( TSASSUV  )
                            + present ( TSELUPPEV)
			    + present ( CARTSV ) * present ( CARTSNBAV )
                             ) * (PPEPRIMEVT + PPEMAJORETTE * null(PPEPRIMECT))
                   + (PPEACV+PPENJV) * abs(PPERPROV)
                                     * (null(TSHALLOV+0) + positif (PPETPV + PPENHV +0))
                   + abs(PPERPROV) * PPEPRIMEVT
                 );

INDPPEC = positif(   PPETPC*PPESALCTOT
                   + PPENHC*PPESALCTOT
                   + positif(
                              present ( BPCOSAC  )
                            + present ( GLD1C  )
                            + present ( GLD2C  )
                            + present ( GLD3C  )
                            + present ( TSASSUC  )
                            + present ( TSELUPPEC)
			    + present ( CARTSC ) * present ( CARTSNBAC )
                             )*PPEPRIMECT
                   + (PPEACC+PPENJC)*abs(PPERPROC)
				    *(null(TSHALLOC+0) + positif (PPETPC + PPENHC +0))
                   + abs(PPERPROC)*PPEPRIMECT
                 );

INDPPEP = positif(   somme(i=1..4:PPETPPi)*PPESALPTOT
                   + somme(i=1..4:PPENHPi)*PPESALPTOT
                   + (PPEACP+PPENJP)*abs(PPERPROP)*(null(  TSHALLO1+TSHALLO2+TSHALLO3+TSHALLO4+0)
                                                         + positif (somme (i=1..4:PPETPPi + PPENHPi + 0)))

                   + abs(PPERPROP)*PPEPRIMEPT
                 );

TYPEPPE  =  (1-null(2-V_REGCO)) * (1-null(4-V_REGCO)) * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;


LIGPPEVCP = (positif(INDPPEV) * positif(INDPPEC) * positif(INDPPEP))   * TYPEPPE;

LIGPPEV   = (positif(INDPPEV) *    null(INDPPEC) *    null(INDPPEP))  * TYPEPPE;
LIGPPEVC  = (positif(INDPPEV) * positif(INDPPEC) *    null(INDPPEP))  * TYPEPPE;
LIGPPEVP  = (positif(INDPPEV) *    null(INDPPEC) * positif(INDPPEP))  * TYPEPPE;

LIGPPEC   = (   null(INDPPEV) * positif(INDPPEC) *    null(INDPPEP))  * TYPEPPE;
LIGPPECP  = (   null(INDPPEV) * positif(INDPPEC) * positif(INDPPEP))  * TYPEPPE;

LIGPPEP   = (   null(INDPPEV) *    null(INDPPEC) * positif(INDPPEP))  * TYPEPPE;


INDLIGPPE = positif(   LIGPPEVCP 
                     + LIGPPEV
                     + LIGPPEVC
                     + LIGPPEVP
                     + LIGPPEC
                     + LIGPPECP
                     + LIGPPEP
                    )
            * (1-null(2-V_REGCO)) * (1-null(4-V_REGCO));

LIGPASPPE = INDLIGPPE * null(PPETOT);

LIGACOPPE = positif(RPPEACO) * TYPEPPE
	    * (1 - null(2 - V_REGCO)) * (1-null(4-V_REGCO));
regle 114850:
application : pro  , oceans, iliad, batch;
LIGTAXASSUR = positif(present(CESSASSV) + present(CESSASSC)) ;
LIGTAXASSURV = present(CESSASSV) ;
LIGTAXASSURC = present(CESSASSC) ;
regle 1149000:
application : pro  , oceans, iliad, batch;
LIGPIPPE = positif (PPETOT) * LIG0;
regle 1149001:
application : pro  , oceans, iliad, batch;
PPEREVSALV = positif(PPESALVTOT * INDLIGPPE
                    + PPESALV * positif(PPEPRIMEVT) * positif(PPETOT))
                    * (1-null(2 - V_REGCO)) * (1-null(4 - V_REGCO))
                    * INDPPEV
                    * INDLIGPPE;
PPEREVSALC = positif(PPESALCTOT * INDLIGPPE
                    + PPESALC * positif(PPEPRIMECT) * positif(PPETOT))
                    * (1-null(2 - V_REGCO)) * (1-null(4 - V_REGCO))
                    * INDPPEC
                    * INDLIGPPE;
PPEREVSALP = positif(PPESALPTOT + PPESALPTOT * INDLIGPPE
                    +PPESALPTOT * positif(PPEPRIMEPT) * positif(PPETOT))
                    * (1-null(2 - V_REGCO)) * (1-null(4 - V_REGCO))
                    * INDPPEP
                    * INDLIGPPE;
regle 114900:
application : pro  , oceans, iliad, batch;
TPLEINSALV = positif(PPETPV  * PPESALVTOT + positif(PPENHV - 1820)
                    + PPESALVTOT * INDLIGPPE * (1-positif(LIGPPEHV))
                    + positif(PPEPRIMEVT) * positif(PPETOT) 
                     * positif(PPESALV) * (1-positif(LIGPPEHV)) 
                    +positif(PPESALV)* (1-positif(LIGPPEHV)))
                    * INDPPEV
                    * positif(INDLIGPPE)         * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
TPLEINSALC = positif(  PPETPC*PPESALCTOT
                    + PPESALCTOT * INDLIGPPE * (1-positif(LIGPPEHC))
                     + positif(PPENHC - 1820)
                    + positif(PPEPRIMECT) * positif(PPETOT) 
                     * positif(PPESALC) * (1-positif(LIGPPEHC)) 
                     +positif(PPESALC) * (1-positif(LIGPPEHC)))
                    * INDPPEC
                    * positif(INDLIGPPE)        * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
TPLEINSALP =positif((PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4)*PPESALPTOT
              + positif(PPENHP1 - 1820) + positif(PPENHP2 - 1820)
              + positif(PPENHP3 - 1820) + positif(PPENHP4 - 1820) 
                    + PPESALPTOT * INDLIGPPE * (1-positif(LIGPPEHP))
                    + positif(PPEPRIMEPT) * positif(PPETOT) 
                     * positif(PPESALPTOT) * (1-positif(LIGPPEHP)) 
                    +positif(PPESALPTOT) * (1-positif(LIGPPEHP)))
              * INDPPEP
              * positif(INDLIGPPE)* LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
TPLEINNSALV =positif(positif(PPEACV + positif(PPENJV - 360)
              + positif(positif(1-null(PPE_AVRPRO1V+0))
               * positif(positif(PPETOT) + positif(PPEREVSALV))
                      * positif(abs(PPERPROV)))
              * (1-positif(LIGPPEJV))) * positif(INDLIGPPE)
              + positif(PPESAISITPV) * positif(PPEACV))
              * INDPPEV
              * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
TPLEINNSALC =positif(positif(PPEACC + positif(PPENJC - 360) 
              + positif(positif(1-null(PPE_AVRPRO1C+0))
               * positif(positif(PPETOT) + positif(PPEREVSALC))
                      * positif(abs(PPERPROC)))
              * (1-positif(LIGPPEJC)))* positif(INDLIGPPE)
              + positif(PPESAISITPC) * positif(PPEACC))
              * INDPPEC
              * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
TPLEINNSALP =positif(positif(PPEACP + positif(PPENJP - 360) 
              + positif(positif(1-null(PPE_AVRPRO1P+0))
               * positif(positif(PPETOT) + positif(PPEREVSALP))
                      * positif(abs(PPERPROP)))
              * (1-positif(LIGPPEJP)))* positif(INDLIGPPE)
              + positif(PPESAISITPP) * positif(PPEACP))
              * INDPPEP
              * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 114902:
application : pro  , oceans, iliad, batch;
LIGPPENSV = positif(positif(positif(1-null(PPE_AVRPRO1V+0)) 
              * positif(positif(PPETOT) + positif(PPEREVSALV))
                     * positif(INDLIGPPE))
                    + positif(PPESAISITPV + PPESAISINBJV))
                   * INDPPEV
                   * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPPENSC = positif(positif(positif(1-null(PPE_AVRPRO1C+0))
              * positif(positif(PPETOT) + positif(PPEREVSALC))
                   * positif(INDLIGPPE))
                    + positif(PPESAISITPC + PPESAISINBJC))
                   * INDPPEC
                   * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPPENSP = positif(positif(positif(1-null(PPE_AVRPRO1P+0)) 
              * positif(positif(PPETOT) + positif(PPEREVSALP))
                   * positif(INDLIGPPE))
                    + positif(PPESAISITPP + PPESAISINBJP))
                   * INDPPEP
                   * LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 114901:
application : pro  , oceans, iliad,batch;
LIGPPEHV = positif_ou_nul(1820 - PPENHV) * present(PPENHV) 
                        * INDPPEV
                        * positif(INDLIGPPE)* LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPPEHC = positif_ou_nul(1820 - PPENHC) * present(PPENHC) 
                        * INDPPEC
                        * positif(INDLIGPPE)* LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPPEHP = positif(
              positif_ou_nul(1820 - PPENHP1) * present(PPENHP1)  
            + positif_ou_nul(1820 - PPENHP2) * present(PPENHP2)
            + positif_ou_nul(1820 - PPENHP3) * present(PPENHP3)
            + positif_ou_nul(1820 - PPENHP4)  * present(PPENHP4)
                   )
            * INDPPEP
            * positif(INDLIGPPE)* LIG0  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPPEJV = positif_ou_nul(360 - PPENJV) * positif(INDLIGPPE) * LIG0  * (1-positif(ANNUL2042)) * TYPE1 
           * present(PPENJV)  
           * positif(PPENJV) 
              + positif(PPESAISITPV) * positif(PPEACV) ;
LIGPPEJC = positif_ou_nul(360 - PPENJC) * positif(INDLIGPPE) * LIG0  * (1-positif(ANNUL2042)) * TYPE1 
           * positif(PPENJC)   
           * present(PPENJC)
           + positif(PPESAISITPC) * positif(PPEACC) ;
LIGPPEJP = positif_ou_nul(360 - PPENJP) * positif(INDLIGPPE) * LIG0  * (1-positif(ANNUL2042)) * TYPE1 
           * positif(PPENJP)  
           * present(PPENJP) 
           + positif(PPESAISITPP) * positif(PPEACP) ;
regle 115100:
application : pro  , oceans, iliad , batch;
LIGCOMP01 = positif(BPRESCOMP01) * LIG1  * ((V_REGCO+0) dans (1,3,5,6)) * (1-positif(ANNUL2042)) * TYPE1 ;
regle 115200:
application : pro  , oceans, iliad, batch;
LIGHEURESUP = positif(HEURESUPV + HEURESUPC + HEURESUPP1 + HEURESUPP2
		      + HEURESUPP3 + HEURESUPP4) * LIG1  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA = positif(DEFBA1 + DEFBA2 + DEFBA3 + DEFBA4 + DEFBA5 + DEFBA6) 
	       * LIG1  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF = positif(BNCDF1 + BNCDF2 + BNCDF3 + BNCDF4 + BNCDF5 + BNCDF6) 
	       * LIG1  * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA1 = positif(DEFBA1) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA2 = positif(DEFBA2) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA3 = positif(DEFBA3) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA4 = positif(DEFBA4) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA5 = positif(DEFBA5) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDEFBA6 = positif(DEFBA6) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDFRCM = positif(DFRCMN+DFRCM1+DFRCM2+DFRCM3+DFRCM4) * LIG1  * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDFRCMN = positif(DFRCMN) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDFRCM1 = positif(DFRCM1) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDFRCM2 = positif(DFRCM2) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDFRCM3 = positif(DFRCM3) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDFRCM4 = positif(DFRCM4) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDRCVM = positif(DPVRCM) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPVSOCP = positif(PVSOCP) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDRFRP = positif(DRFRP) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN = positif(DLMRN6+DLMRN5+DLMRN4+DLMRN3+DLMRN2+DLMRN1) 
	      * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN6 = positif(DLMRN6) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN5 = positif(DLMRN5) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN4 = positif(DLMRN4) * LIG1 * (1-null(4-V_REGCO))* (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN3 = positif(DLMRN3) * LIG1 * (1-null(4-V_REGCO))* (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN2 = positif(DLMRN2) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGDLMRN1 = positif(DLMRN1) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF6 = positif(BNCDF6) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF5 = positif(BNCDF5) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF4 = positif(BNCDF4) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF3 = positif(BNCDF3) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF2 = positif(BNCDF2) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGBNCDF1 = positif(BNCDF1) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGIRECR = positif(IRECR) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMIBDREPNPV = positif(MIBDREPNPV) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMIBDREPNPC = positif(MIBDREPNPC) * LIG1 * (1-null(4-V_REGCO))* (1-positif(ANNUL2042)) * TYPE1 ;
LIGMIBDREPNPP = positif(MIBDREPNPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMIBDREPV = positif(MIBDREPV) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMIBDREPC = positif(MIBDREPC) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMIBDREPP = positif(MIBDREPP) * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSPEDREPNPV = positif(SPEDREPNPV) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSPEDREPNPC = positif(SPEDREPNPC) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSPEDREPNPP = positif(SPEDREPNPP) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSPEDREPV = positif(SPEDREPV) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSPEDREPC = positif(SPEDREPC) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSPEDREPP = positif(SPEDREPP) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREPPLU = positif(REPPLU) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGELURAS = positif(ELURASV) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGELURASC = positif(ELURASC) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSURPLU = positif(SURPLU) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGSURIMP = positif(SURIMP) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGABDET = positif(GAINABDET) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGABDETP = positif(ABDETPLUS) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGABDETM = positif(ABDETMOINS) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPVJEUNE = positif(PVJEUNENT) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGRCMSOC = positif(RCMSOC) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGLIBDIV = positif(RCMLIBDIV) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGRCMIMPAT = positif(RCMIMPAT) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGABIMPPV = positif(ABIMPPV) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGABIMPMV = positif(ABIMPMV) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGOPTCS = positif(BPVOPTCS) * LIG1 * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCDIS = positif(GSALV + GSALC) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGROBOR = positif(RFROBOR) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGPVSOCG = positif(PVSOCG) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
EXOCET = EXOCETC + EXOCETV ;
LIGEXOCET = positif(EXOCET) * LIG1 * (1-positif(ANNUL2042)) * ((V_REGCO+0) dans (1,3,5,6)) * TYPE1 ;
LIGDEFPLOC = positif(DEFLOC1 + DEFLOC2 + DEFLOC3 + DEFLOC4 + DEFLOC5 + DEFLOC6 + DEFLOC7 + DEFLOC8 + DEFLOC9 + DEFLOC10) 
		 * LIG1 *(1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC1 = positif(DEFLOC1) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC2 = positif(DEFLOC2) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC3 = positif(DEFLOC3) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC4 = positif(DEFLOC4) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC5 = positif(DEFLOC5) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC6 = positif(DEFLOC6) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC7 = positif(DEFLOC7) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC8 = positif(DEFLOC8) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC9 = positif(DEFLOC9) * LIG1 *(1-null(4-V_REGCO))  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPLOC10 = positif(DEFLOC10) * LIG1 * (1-null(4-V_REGCO)) * (1-positif(ANNUL2042)) * TYPE1 ;
regle 115101:
application : pro, batch  , oceans, iliad;
LIGDCSGD = positif(DCSGD) * null(5 - V_IND_TRAIT) * INDCTX * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 115102:
application : pro, batch  , oceans, iliad;
LIGPVETR = present(CREREVET) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGCORSE = positif(present(CIINVCORSE)+present(IPREPCORSE)) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREPCORSE = positif(REPCORSE) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGREPRECH = positif(REPRECH) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGPME = positif(REPINVPME3 + REPINVPME2 + REPINVPME1 + REPINVPME) 
	   * LIG1 * (1-positif(ANNUL2042)) * (1-positif(V_CNR)) 
                   * (1-null(2-V_REGCO)) * (1-null(4-V_REGCO)) * TYPE1 ;
LIGCULTURE = present(CIAQCUL) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
LIGMECENAT = present(RDMECENAT) * LIG1  * (1-positif(ANNUL2042)) * TYPE1 ;
regle 115103:
application : pro, batch  , oceans, iliad;
LIGIBAEX = positif(REVQTOT) * LIG1  * (1-positif(ANNUL2042)) 
	     * (1-INDTXMIN) * (1-INDTXMOY) 
	     * (1-null(2-V_REGCO) * (1-LIG1522))
	     * (1-null(4-V_REGCO)) 
	     * TYPE1 ;
regle 115105:
application : pro, oceans, iliad, batch;
LIGANNUL2042 = (1-positif(ANNUL2042)) * LIG0;
regle 115107:
application : pro, oceans, iliad, batch;
LIGREGCO = (null(2-V_REGCO) + null(4-V_REGCO)) * positif(IND_REV) ;
regle 115109:
application : pro, oceans, iliad, batch;

INDRESTIT = positif(IREST + 0) ;

INDIMPOS = positif(null(1 - NATIMP) + 0) ;

