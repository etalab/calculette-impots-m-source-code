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
application : batch, iliad;
LIG0 = (1 - positif(IPVLOC)) * (1 - positif(RE168 + TAX1649)) * IND_REV ;
LIG1 = (1 - positif(RE168 + TAX1649)) ;
LIG2 = (1 - positif(ANNUL2042)) ;
regle 1110010:
application : batch , iliad ;


LIG0010 = (INDV * INDC * INDP) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG0020 = (INDV * (1 - INDC) * (1 - INDP)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG0030 = (INDC * (1 - INDV) * (1 - INDP)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG0040 = (INDP * (1 - INDV) * (1 - INDC)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG0050 = (INDV * INDC * (1 - INDP)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG0060 = (INDV * INDP * (1 - INDC)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG0070 = (INDC * INDP * (1 - INDV)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG0 * LIG2 ;

LIG10YT = (INDV * INDC * INDP) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

LIG20YT = (INDV * (1 - INDC) * (1 - INDP)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

LIG30YT = (INDC * (1 - INDV) * (1 - INDP)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

LIG40YT = (INDP * (1 - INDV) * (1 - INDC)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

LIG50YT = (INDV * INDC * (1 - INDP)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

LIG60YT = (INDV * INDP * (1 - INDC)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

LIG70YT = (INDC * INDP * (1 - INDV)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG0 * LIG2 ;

regle 11110:
application : batch , iliad ;
LIG10V = positif_ou_nul(TSBNV + PRBV + BPCOSAV + GLDGRATV + positif(F10AV * null(TSBNV + PRBV + BPCOSAV + GLDGRATV))) ;
LIG10C = positif_ou_nul(TSBNC + PRBC + BPCOSAC + GLDGRATC + positif(F10AC * null(TSBNC + PRBC + BPCOSAC + GLDGRATC))) ;
LIG10P = positif_ou_nul(somme(i=1..4:TSBNi + PRBi) + positif(F10AP * null(somme(i=1..4:TSBNi + PRBi)))) ;
LIG10 = positif(LIG10V + LIG10C + LIG10P) ;
regle 11000:
application : batch , iliad ;

LIG1100 = positif(T2RV) * (1 - positif(IPVLOC)) ;

LIG899 = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIG3RCMABT + LIG4RCMABT
		  + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * (1 - positif(LIG0010 + LIG0020 + LIG0030 + LIG0040 + LIG0050 + LIG0060 + LIG0070)) 
		 * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) ;

LIG900 = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIG3RCMABT + LIG4RCMABT
		  + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * positif(LIG0010 + LIG0020 + LIG0030 + LIG0040 + LIG0050 + LIG0060 + LIG0070) 
		 * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) ;

LIG899YT = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIG3RCMABT + LIG4RCMABT
		   + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * (1 - positif(LIG10YT + LIG20YT + LIG30YT + LIG40YT + LIG50YT + LIG60YT + LIG70YT)) 
		 * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) ;

LIG900YT = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIG3RCMABT + LIG4RCMABT
		   + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * positif(LIG10YT + LIG20YT + LIG30YT + LIG40YT + LIG50YT + LIG60YT + LIG70YT) 
		 * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) ;

regle 111440:
application : batch , iliad ;
LIG4401 =  positif(V_FORVA) * (1 - positif_ou_nul(BAFV)) * LIG0 ;

LIG4402 =  positif(V_FORCA) * (1 - positif_ou_nul(BAFC)) * LIG0 ;

LIG4403 =  positif(V_FORPA) * (1 - positif_ou_nul(BAFP)) * LIG0 ;

regle 11113:
application : iliad,batch;
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
	* (1 - positif(IPVLOC)) * LIG1 ;

regle 111135:
application : batch, iliad;
4BAQLV = positif(4BACREV + 4BAHREV) ;
4BAQLC = positif(4BACREC + 4BAHREC) ;
4BAQLP = positif(4BACREP + 4BAHREP) ;
regle 111134:
application : iliad , batch ;

LIG134V = positif(present(BAFV) + present(BAHREV) + present(BAHDEV) + present(BACREV) + present(BACDEV)+ present(BAFPVV)+present(BAFORESTV)) ;
LIG134C = positif(present(BAFC) + present(BAHREC) + present(BAHDEC) + present(BACREC) + present(BACDEC)+ present(BAFPVC)+present(BAFORESTC)) ;
LIG134P = positif(present(BAFP) + present(BAHREP) + present(BAHDEP) + present(BACREP) + present(BACDEP)+ present(BAFPVP)+present(BAFORESTP)) ;
LIG134 = positif(LIG134V + LIG134C + LIG134P+present(DAGRI6)+present(DAGRI5)+present(DAGRI4)+present(DAGRI3)+present(DAGRI2)+present(DAGRI1)) 
		* (1 - positif(IPVLOC)) * (1 - positif(abs(DEFIBA))) * LIG1 ;
LIGDBAIP = positif_ou_nul(DBAIP) * positif(DAGRI1 + DAGRI2 + DAGRI3 + DAGRI4 + DAGRI5 + DAGRI6) * (1 - positif(IPVLOC))
                          * positif(abs(abs(BAHQTOT)+abs(BAQTOT)-(DAGRI6+DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1))) * LIG1 ;
regle 111136:
application : iliad ,batch;
LIG136 = positif(4BAQV + 4BAQC + 4BAQP) * (1 - positif(IPVLOC)) * LIG1 ;

regle 111590:
application : iliad, batch ;
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
  * LIG0 * LIG2 ;

LIGMLOC = positif(present(MIBMEUV) + present(MIBMEUC) + present(MIBMEUP)
		+ present(MIBGITEV) + present(MIBGITEC) + present(MIBGITEP)
		+ present(LOCGITV) + present(LOCGITC) + present(LOCGITP))
	  * LIG0 * LIG2 ;
 
LIGMLOCAB = positif(MLOCABV + MLOCABC + MLOCABP) * LIG0  * LIG2 ; 

LIGMIBMV = positif(BICPMVCTV + BICPMVCTC + BICPMVCTP) * (1 - null(4 - V_REGCO)) * LIG0 ;

LIGBNCMV = positif(BNCPMVCTV + BNCPMVCTC + BNCPMVCTP) * (1 - null(4 - V_REGCO)) * LIG0 ;

LIGPLOC = positif(LOCPROCGAV + LOCPROCGAC + LOCPROCGAP + LOCDEFPROCGAV + LOCDEFPROCGAC + LOCDEFPROCGAP
		   + LOCPROV + LOCPROC + LOCPROP + LOCDEFPROV + LOCDEFPROC + LOCDEFPROP) 
		   * (1 - null(4 - V_REGCO)) * LIG0 ;

LIGNPLOC = positif(LOCNPCGAV + LOCNPCGAC + LOCNPCGAPAC + LOCDEFNPCGAV + LOCDEFNPCGAC + LOCDEFNPCGAPAC
		   + LOCNPV + LOCNPC + LOCNPPAC + LOCDEFNPV + LOCDEFNPC + LOCDEFNPPAC 
		   + LOCGITCV + LOCGITCC + LOCGITCP + LOCGITHCV + LOCGITHCC + LOCGITHCP)
		   *  (1-null(4 - V_REGCO)) * LIG0 ;

LIGNPLOCF = positif(LOCNPCGAV + LOCNPCGAC + LOCNPCGAPAC + LOCDEFNPCGAV + LOCDEFNPCGAC + LOCDEFNPCGAPAC
		   + LOCNPV + LOCNPC + LOCNPPAC + LOCDEFNPV + LOCDEFNPC + LOCDEFNPPAC 
                   + LNPRODEF10 + LNPRODEF9 + LNPRODEF8 + LNPRODEF6 + LNPRODEF5
                   + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 + LNPRODEF1
		   + LOCGITCV + LOCGITCC + LOCGITCP + LOCGITHCV + LOCGITHCC + LOCGITHCP)
		   *  (1-null(4 - V_REGCO)) * LIG0 ;

LIGDEFNPLOC = positif(TOTDEFLOCNP) *  (1-null(4 - V_REGCO)) ;

LIGLOCNSEUL = positif(LIGNPLOC + LIGDEFNPLOC + LIGNPLOCF) ;

LIGLOCSEUL = 1 - positif(LIGNPLOC + LIGDEFNPLOC + LIGNPLOCF) ;

regle 1115901:
application : iliad,batch;

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
                   * LIG0 * LIG2 ;
regle 11117:
application : iliad,batch;
LIG_BNCNF = positif (present(BNCV) + present(BNCC) + present(BNCP)) ;

LIGNOCEP = (present(NOCEPV) + present(NOCEPC) + present(NOCEPP)) * LIG0 * LIG2 ;

LIGNOCEPIMP = (present(NOCEPIMPV) + present(NOCEPIMPC) + present(NOCEPIMPP)) * LIG0 * LIG2 ;

LIGDAB = positif(present(DABNCNP6) + present(DABNCNP5) + present(DABNCNP4)
		 + present(DABNCNP3) + present(DABNCNP2) + present(DABNCNP1)) 
		* LIG0 * LIG2 ;

LIGDIDAB = present(DIDABNCNP) * LIG0 * LIG2 ;

LIGBNCIF = ( positif (LIGNOCEP) * (1 - positif(LIG3250) + null(BNCIF)) 
             + (null(BNCIF) * positif(LIGBNCDF)) 
	     + null(BNCIF) * (1 - positif_ou_nul(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2-DABNCNP1)))
	    * (1 - positif(LIGSPENPNEG + LIGSPENPPOS)) * LIG0 * LIG2 ;
regle 125:
application : batch, iliad;
LIG910 = positif(present(RCMABD) + present(RCMTNC) + present(RCMAV) + present(RCMHAD) 
	         + present(RCMHAB) + present(REGPRIV) + (1-present(BRCMQ)) *(present(RCMFR))
                ) * LIG0 * LIG2 ;
regle 111266:
application : iliad , batch ;
LIGBPLIB = present(RCMLIB) * LIG0 * (1 - null(4-V_REGCO)) * LIG2 ;
regle 1111130: 
application : iliad , batch ;
LIG1130 = positif(present(REPSOF)) * LIG0 * LIG2 ;
regle 1111950:
application : iliad, batch;
LIG1950 = INDREV1A8 *  positif_ou_nul(REVKIRE) 
                    * (1 - positif(positif_ou_nul(IND_TDR) * (1-(positif_ou_nul(TSELUPPEV + TSELUPPEC))))) 
                    * (1 - LIGPS) ;

LIG1950S = INDREV1A8 *  positif_ou_nul(REVKIRE) 
                     * (1 - positif(positif_ou_nul(IND_TDR) * (1-(positif_ou_nul(TSELUPPEV + TSELUPPEC))))) 
                     * LIGPS ;
regle 11129:
application : batch, iliad;
LIG29 = positif(present(RFORDI) + present(RFDHIS) + present(RFDANT) +
                present(RFDORD)) * (1 - positif(IPVLOC))
                * (1 - positif(LIG30)) * LIG1 * LIG2 * IND_REV ;
regle 11130:
application : iliad, batch ;
LIG30 = positif(RFMIC) * (1 - positif(IPVLOC)) * LIG1 * LIG2 ;
LIGREVRF = positif(present(FONCI) + present(REAMOR)) * (1 - positif(IPVLOC)) * LIG1 * LIG2 ;
regle 11149:
application : batch, iliad;
LIG49 =  INDREV1A8 * positif_ou_nul(DRBG) * LIG2 ;
regle 11152:
application :  iliad, batch;
LIG52 = positif(present(CHENF1) + present(CHENF2) + present(CHENF3) + present(CHENF4) 
                 + present(NCHENF1) + present(NCHENF2) + present(NCHENF3) + present(NCHENF4)) 
	     * LIG1 * LIG2 ;
regle 11158:
application : iliad, batch;
LIG58 = (present(PAAV) + present(PAAP)) * positif(LIG52) * LIG1 * LIG2 ;
regle 111585:
application : iliad, batch;
LIG585 = (present(PAAP) + present(PAAV)) * (1 - positif(LIG58)) * LIG1 * LIG2 ;
LIG65 = positif(LIG52 + LIG58 + LIG585 
                + present(CHRFAC) + present(CHNFAC) + present(CHRDED)
		+ present(DPERPV) + present(DPERPC) + present(DPERPP)
                + LIGREPAR)  
       * LIG1 * LIG2 ;
regle 111555:
application : iliad, batch;
LIGDPREC = present(CHRFAC) * LIG1;

LIGDFACC = (positif(20-V_NOTRAIT+0) * positif(DFACC)
           + (1 - positif(20-V_NOTRAIT+0)) * present(DFACC)) * LIG1 ;
regle 1111390:
application : batch, iliad;
LIG1390 = positif(positif(ABMAR) + (1 - positif(RI1)) * positif(V_0DN)) * LIG1 * LIG2 ;
regle 11168:
application : batch, iliad;
LIG68 = INDREV1A8 * (1 - positif(abs(RNIDF))) * LIG2 ;
regle 111681:
application : iliad, batch;
LIGRNIDF = positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
LIGRNIDF0 = positif(abs(RNIDF0)) * positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
LIGRNIDF1 = positif(abs(RNIDF1)) * positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
LIGRNIDF2 = positif(abs(RNIDF2)) * positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
LIGRNIDF3 = positif(abs(RNIDF3)) * positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
LIGRNIDF4 = positif(abs(RNIDF4)) * positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
LIGRNIDF5 = positif(abs(RNIDF5)) * positif(abs(RNIDF)) * (1 - null(4-V_REGCO)) * LIG1 * LIG2 ;
regle 1111420:
application : iliad,batch;
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
                  ) * LIG1 * LIG2 * (1 - null(4-V_REGCO)) ;

regle 111721:
application : batch, iliad;

LIG1430 = positif(BPTP3) * LIG0 * LIG2 ;

LIG1431 = positif(BPTP18) * LIG0 * LIG2 ;

LIG1432 = positif(BPTP19) * LIG0 * LIG2 ;
regle 111722:
application : batch, iliad;
LIG815 = V_EAD * positif(BPTPD) * LIG0 * LIG2 ;
LIG816 = V_EAG * positif(BPTPG) * LIG0 * LIG2 ;
LIGTXF225 = positif(PEA+0) * LIG0 * LIG2 ;
LIGTXF24 = positif(BPTP24) * LIG0 * LIG2 ;
LIGTXF30 = positif_ou_nul(BPCOPTV + BPCOPTC + BPVSK) * LIG0  * LIG2 ;
LIGTXF40 = positif(BPV40V + BPV40C + 0) * LIG0 * LIG2 ;

regle 111723:
application : batch, iliad ;

LIGCESDOM = positif(BPTPDIV) * positif(PVTAXSB) * positif(V_EAD + 0) * LIG0 * LIG2 ;
LIGCESDOMG = positif(BPTPDIV) * positif(PVTAXSB) * positif(V_EAG + 0) * LIG0 * LIG2 ;

LIGDOMPRO = positif(BPTPDIV) * positif(PVTAXSC) * positif(V_EAD + 0) * LIG0 * LIG2 ;
LIGDOMPROG = positif(BPTPDIV) * positif(PVTAXSC) * positif(V_EAG + 0) * LIG0 * LIG2 ;
regle 11181:
application : batch, iliad;
LIG81 = positif(present(RDDOUP) + present(RDFDOU) + present(DONAUTRE) + present(RDFDAUTRE) + present(REPDON03) 
		+ present(REPDON04) + present(REPDON05) + present(REPDON06) + present(REPDON07))
               * LIG1 * LIG2 ;
regle 1111500:
application : iliad, batch ;

LIG1500 = positif((positif(IPMOND) * present(IPTEFP)) + positif(INDTEFF) * positif(TEFFREVTOT)) 
	      * ((V_REGCO+0) dans (1,3,5,6)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG1 * LIG2 ;

LIG1510 = positif((positif(IPMOND) * present(IPTEFN)) + positif(INDTEFF) * (1 - positif(TEFFREVTOT))) 
	      * ((V_REGCO+0) dans (1,3,5,6)) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG1 * LIG2 ;

LIG1500YT = positif((positif(IPMOND) * present(IPTEFP)) + positif(INDTEFF) * positif(TEFFREVTOT)) 
	      * ((V_REGCO+0) dans (1,3,5,6)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG1 * LIG2 ;

LIG1510YT = positif((positif(IPMOND) * present(IPTEFN)) + positif(INDTEFF) * (1 - positif(TEFFREVTOT))) 
	      * ((V_REGCO+0) dans (1,3,5,6)) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG1 * LIG2 ;

regle 1111522:
application : iliad, batch ;
LIG1522 = (1 - present(IND_TDR)) * (1 - INDTXMIN) * (1 - INDTXMOY) * V_CR2 * LIG2 ;
regle 1111523:
application : batch, iliad;
LIG1523 = (1 - present(IND_TDR)) * null(V_REGCO - 4) * LIG2 ;
regle 11175:
application : iliad, batch ;
LIG75 = (1 - INDTXMIN) * (1 - INDTXMOY) * (1 - LIG1500) * (1 - LIG1510) * INDREV1A8 * LIG2 ;

LIG1545 = (1 - present(IND_TDR)) * INDTXMIN * positif(IND_REV) * LIG2 ;

LIG1760 = (1 - present(IND_TDR)) * INDTXMOY * LIG2 ;

LIG1546 = positif(PRODOM + PROGUY) * (1 - positif(V_EAD + V_EAG)) * LIG2 ;

LIG1550 = (1 - present(IND_TDR)) * INDTXMOY * LIG2 ;

LIG74 = (1 - present(IND_TDR)) * (1 - INDTXMIN) * positif(LIG1500 + LIG1510) * LIG2 ;

regle 11180:
application : batch, iliad ;
LIG80 = positif(present(RDREP) + present(RDFREP) + present(DONETRAN) + present(RDFDONETR)) * LIG1 * LIG2 ;
regle 11182:
application : batch, iliad;
LIG82 = positif(present(RDSYVO) + present(RDSYCJ) + present(RDSYPP) 
		+ present(COSBV) + present(COSBC) + present(COSBP))
	* LIG1 * LIG2 ;
regle 11188:
application : iliad , batch ;
LIGRSOCREPR = positif(present(RSOCREPRISE)) * LIG1 * LIG2 ;
regle 1111740:
application : batch , iliad ;
LIG1740 = positif(RECOMP) * LIG2 ;
regle 1111780:
application : batch , iliad ;
LIG1780 = positif(RDCOM + NBACT) * LIG1 * LIG2 ;
regle 111981:
application : batch, iliad;
LIG98B = positif(LIG80 + LIGFIPC + LIGFIPDOM + present(DAIDE)
                 + LIGREDAGRI + LIGFORET + LIGRESTIMO  
	         + LIGCINE + LIGRSOCREPR + LIGCOTFOR 
	         + present(PRESCOMP2000) + present(RDPRESREPORT) + present(FCPI) 
		 + present(DSOUFIP) + LIGRIRENOV + present(DFOREST) 
		 + present(DHEBE) + present(DSURV)
	         + LIGLOGDOM + LIGACHTOUR  
	         + LIGTRATOUR + LIGLOGRES + LIGREPTOUR + LIGLOCHOTR
	         + LIGREPHA + LIGCREAT + LIG1780 + LIG2040 + LIG81 + LIGLOGSOC
	         + LIGDOMSOC1 
		 + somme (i=A,B,E,C,D,F : LIGCELLi)
		 + somme (i=A,B,D,E,F,H,G,L,M,S,R,U,T,Z,X,W,V : LIGCELHi) 
		 + LIGCELHNO + LIGCELHJK + LIGCELNQ + LIGCELCOM + LIGCELNBGL
		 + LIGCEL + LIGCELJP + LIGCELJBGL + LIGCELJOQR + LIGCEL2012
		 + LIGREDMEUB + LIGREDREP + LIGILMIX + LIGINVRED + LIGILMIH + LIGILMIZ + LIGMEUBLE 
		 + LIGPROREP + LIGREPNPRO + LIGMEUREP + LIGILMIC + LIGILMIB + LIGILMIA 
		 + LIGRESIMEUB + LIGRESINEUV + LIGRESIVIEU + LIGLOCIDEFG
		 + present(DNOUV) + LIGLOCENT + LIGCOLENT + LIGRIDOMPRO
		 + LIGPATNAT + LIGPATNAT1 + LIGPATNAT2) 
           * LIG1 * LIG2 ;

LIGRED = LIG98B * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG1 * LIG2 ;

LIGREDYT = LIG98B * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG1 * LIG2 ;

regle 1111820:
application : batch , iliad ;

LIG1820 = positif(ABADO + ABAGU + RECOMP) * LIG2 ;

regle 111106:
application : iliad , batch ;

LIG106 = positif(RETIR) ;
LIGINRTAX = positif(RETTAXA) ;
LIG10622 = positif(RETIR22) ;
LIGINRTAX22 = positif(RETTAXA22) ;
ZIG_INT22 = positif(RETCS22 + RETPS22 + RETRD22 + RETCVN22) ;

LIGINRPCAP = positif(RETPCAP) ;
LIGINRPCAP2 = positif(RETPCAP22) ;
LIGINRLOY = positif(RETLOY) ;
LIGINRLOY2 = positif(RETLOY22) ;

LIGINRHAUT = positif(RETHAUTREV) ;
LIGINRHAUT2 = positif(RETCHR22) ;
regle 111107:
application : iliad, batch;

LIG_172810 = TYPE2 * positif(NMAJ1) ;

LIGTAXA17281 = TYPE2 * positif(NMAJTAXA1) ;

LIGPCAP17281 = TYPE2 * positif(NMAJPCAP1) ;

LIGCHR17281 = TYPE2 * positif(NMAJCHR1) ;

LIG_NMAJ1 = TYPE2 * positif(NMAJ1) ;
LIG_NMAJ3 = TYPE2 * positif(NMAJ3) ;
LIG_NMAJ4 = TYPE2 * positif(NMAJ4) ;

LIGNMAJTAXA1 = TYPE2 * positif(NMAJTAXA1) ;
LIGNMAJTAXA3 = TYPE2 * positif(NMAJTAXA3) ;
LIGNMAJTAXA4 = TYPE2 * positif(NMAJTAXA4) ;

LIGNMAJPCAP1 = TYPE2 * positif(NMAJPCAP1) ;
LIGNMAJPCAP3 = TYPE2 * positif(NMAJPCAP3) ;
LIGNMAJPCAP4 = TYPE2 * positif(NMAJPCAP4) ;
LIGNMAJLOY1 = TYPE2 * positif(NMAJLOY1) ;
LIGNMAJLOY3 = TYPE2 * positif(NMAJLOY3) ;
LIGNMAJLOY4 = TYPE2 * positif(NMAJLOY4) ;

LIGNMAJCHR1 = TYPE2 * positif(NMAJCHR1) ;
LIGNMAJCHR3 = TYPE2 * positif(NMAJCHR3) ;
LIGNMAJCHR4 = TYPE2 * positif(NMAJCHR4) ;

regle 111109:
application : batch, iliad;
LIG109 = positif(IPSOUR + REGCI + LIGPVETR + LIGCULTURE + LIGMECENAT 
		  + LIGCORSE + LIG2305 + LIGCICAP + LIGREGCI
		  + LIGBPLIB + LIGCIGE + LIGDEVDUR + LIGDDUBAIL
                  + LIGVEHICULE + LIGVEACQ + LIGVEDESTR + LIGCICA + LIGCIGARD + LIG82
		  + LIGPRETUD + LIGSALDOM + LIGHABPRIN
		  + LIGCREFAM + LIGCREAPP + LIGCREBIO  + LIGPRESINT + LIGCREPROSP + LIGINTER
		  + LIGCRETECH + LIGRESTAU + LIGRESERV + LIGCONGA + LIGMETART 
		  + LIGCREFORM + LIGLOYIMP + LIGMOBIL + LIGJEUNE
		  + LIGVERSLIB + LIGCITEC + LIGTABAC
		  + LIGPPEVCP + LIGPPEV + LIGPPEC + LIGPPEP 
		  + LIGPPEVP + LIGPPEVC + LIGPPECP 
		   ) 
               * LIG1 * LIG2 ;

LIGCRED1 = positif(REGCI + LIGPVETR + LIGCICAP + LIGREGCI + 0) 
	    * (1 - positif(IPSOUR + LIGCULTURE + LIGMECENAT + LIGCORSE + LIG2305 + LIGBPLIB + LIGCIGE + LIGDEVDUR + LIGDDUBAIL + LIGVEHICULE
		           + LIGVEACQ + LIGVEDESTR + LIGCICA + LIGCIGARD + LIG82 + LIGPRETUD + LIGSALDOM + LIGHABPRIN + LIGCREFAM + LIGCREAPP 
		           + LIGCREBIO + LIGPRESINT + LIGCREPROSP + LIGINTER + LIGCRETECH + LIGRESTAU + LIGRESERV + LIGCONGA + LIGMETART
		           + LIGCREFORM + LIGLOYIMP + LIGMOBIL + LIGJEUNE + LIGVERSLIB + LIGCITEC + LIGTABAC + 0))
	    ;

LIGCRED2 = (1 - positif(REGCI + LIGPVETR + LIGCICAP + LIGREGCI + 0)) 
	    * positif(IPSOUR + LIGCULTURE + LIGMECENAT + LIGCORSE + LIG2305 + LIGBPLIB + LIGCIGE + LIGDEVDUR + LIGDDUBAIL + LIGVEHICULE 
		      + LIGVEACQ + LIGVEDESTR + LIGCICA + LIGCIGARD + LIG82 + LIGPRETUD + LIGSALDOM + LIGHABPRIN + LIGCREFAM + LIGCREAPP 
		      + LIGCREBIO + LIGPRESINT + LIGCREPROSP + LIGINTER + LIGCRETECH + LIGRESTAU + LIGRESERV + LIGCONGA + LIGMETART
		      + LIGCREFORM + LIGLOYIMP + LIGMOBIL + LIGJEUNE + LIGVERSLIB + LIGCITEC + LIGTABAC + 0)
	    ;

LIGCRED3 = positif(REGCI + LIGPVETR + LIGCICAP + LIGREGCI + 0) 
	    * positif(IPSOUR + LIGCULTURE + LIGMECENAT + LIGCORSE + LIG2305 + LIGBPLIB + LIGCIGE + LIGDEVDUR + LIGDDUBAIL + LIGVEHICULE 
		      + LIGVEACQ + LIGVEDESTR + LIGCICA + LIGCIGARD + LIG82 + LIGPRETUD + LIGSALDOM + LIGHABPRIN + LIGCREFAM + LIGCREAPP 
		      + LIGCREBIO + LIGPRESINT + LIGCREPROSP + LIGINTER + LIGCRETECH + LIGRESTAU + LIGRESERV + LIGCONGA + LIGMETART
		      + LIGCREFORM + LIGLOYIMP + LIGMOBIL + LIGJEUNE + LIGVERSLIB + LIGCITEC + LIGTABAC + 0)
           ;
regle 1112030:
application : batch, iliad ;
LIGNRBASE = positif(present(NRINET) + present(NRBASE)) * LIG1 * LIG2 ;
LIGBASRET = positif(present(IMPRET) + present(BASRET)) * LIG1 * LIG2 ;
regle 1112332:
application :  iliad, batch ;
LIGAVFISC = positif(AVFISCOPTER) * LIG1 * LIG2 ; 
regle 1112040:
application : batch, iliad;
LIG2040 = positif(DNBE + RNBE + RRETU) * LIG1 * LIG2 ;
regle 1112041:
application : iliad, batch ;
LIGRDCSG = positif(positif(V_BTCSGDED) + present(DCSG) + present(RCMSOC)) * LIG1 * LIG2 ;
regle 111973:
application : iliad, batch;
LIG2305 = positif(DIAVF2) * LIG1 * LIG2 ;
LIGCIGE = positif(RDTECH + RDGEQ + RDEQPAHA) * LIG1 * LIG2 ;
regle 111117:
application : batch, iliad;
LIG_IRNET = (1 - positif(V_NOTRAIT - 20)) 
	    + positif(V_NOTRAIT - 20) * positif(ANTIRAFF + TAXANET + PCAPNET  + TAXLOYNET + HAUTREVNET 
						+ TAXANTAFF + PCAPANTAFF + TAXLOYANTAFF + HAUTREVANTAF) ;
regle 1112135:
application : batch, iliad;
LIGANNUL = positif(ANNUL2042) * (1 - LIGPS) ;

LIGANNULS = positif(ANNUL2042) * LIGPS ;
regle 1112050:
application : batch, iliad;
LIG2053 = positif(V_NOTRAIT - 20) * positif(IDEGR) * positif(IREST - SEUIL_8) * (1 - LIGPS) * TYPE2 ;

LIG2053S = positif(V_NOTRAIT - 20) * positif(IDEGR) * positif(IREST - SEUIL_8) * LIGPS * TYPE2 ;
regle 1112051:
application : batch,iliad ;
LIG2051 = (1 - positif(20 - V_NOTRAIT)) 
          * positif (RECUMBIS) ;

LIGBLOC = positif(V_NOTRAIT - 15) ;

LIGSUP = positif((V_NOTRAIT + 0) dans (16,26,36,46,56,66)) ;

LIGDEG = null(IRESTITIR) * positif((V_NOTRAIT + 0) dans (23,33,43,53,63)) ;

LIGRES = positif(V_ANTREIR + 0) * positif((V_NOTRAIT + 0) dans (23,33,43,53,63)) ;

LIGDEGRES = positif(IRESTITIR + 0) * null(V_ANTREIR) * positif((V_NOTRAIT + 0) dans (23,33,43,53,63)) ;

LIGNEMP = (1 - null(NAPTEMP)) ;

LIGEMP = null(NAPTEMP) ;

LIG2052 = (
	   APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_ANTIR + LIG_IRNET)
	  ) * ( 1 - APPLI_OCEANS) * (1 - positif(LIG2051)) * TYPE2 ;

LIGTAXANT = (
	     APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_TAXANT + LIGTAXANET * positif(TAXANET))
            ) * (1 - positif(LIG2051)) * TYPE2 ;

LIGPCAPANT = (
	      APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_PCAPANT + LIGPCAPNET * positif(PCAPNET))
             ) * (1 - positif(LIG2051)) * TYPE2 ;
LIGLOYANT = (
	      APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_TAXLOYANT + LIGLOYNET * positif(TAXLOYNET))
             ) * (1 - positif(LIG2051)) * TYPE2 ;

LIGHAUTANT = (
	      APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_CHRANT + LIGHAUTNET * positif(HAUTREVNET))
             ) * (1 - positif(LIG2051)) * TYPE2 ;

LIGANTREIR = positif(V_ANTREIR + 0) * null(V_ANTCR) ;

LIGNANTREIR = positif(V_ANTREIR + 0) * positif(V_ANTCR + 0) ;

LIGNONREST = positif(V_NONRESTANT + 0) ;

LIGIINET = LIGSUP * positif(NAPT + 0) ;

LIGIINETC = LIGSUP * null(NAPT) ;

LIGIDEGR = LIGDEG * positif_ou_nul(IDEGR - SEUIL_8) ;

LIGIDEGRC = LIGDEG * positif(SEUIL_8 - IDEGR) ;

LIGIREST = LIGRES * positif_ou_nul(IREST - SEUIL_8) ;

LIGIRESTC = LIGRES * positif(SEUIL_8 - IREST) ;

LIGNMRR = LIGIINETC * positif(V_ANTRE + 0) ;

LIGNMRS = LIGIINETC * null(V_ANTRE) ;

LIGRESINF = LIGIDEGRC * LIGIRESTC ;

regle 1112080:
application : batch, iliad ;

LIG2080 = positif(NATIMP - 71) * LIG2 ;

regle 1112081:
application : batch, iliad ;

LIGTAXADEG = positif(NATIMP - 71) * positif(TAXADEG) * LIG2 ;

LIGPCAPDEG = positif(NATIMP - 71) * positif(PCAPDEG) * LIG2 ;

LIGLOYDEG = positif(NATIMP - 71) * positif(TAXLOYDEG) * LIG2 ;

LIGHAUTDEG = positif(NATIMP - 71) * positif(HAUTREVDEG) * LIG2 ;

regle 1112140:
application : iliad,batch;
INDCTX = si (  (V_NOTRAIT+0 = 23)  
            ou (V_NOTRAIT+0 = 33)   
            ou (V_NOTRAIT+0 = 43)   
            ou (V_NOTRAIT+0 = 53)   
            ou (V_NOTRAIT+0 = 63)  
            )
         alors (1)
         sinon (0)
         finsi;

INDIS = si (  (V_NOTRAIT+0 = 14)
            ou (V_NOTRAIT+0 = 16)
	    ou (V_NOTRAIT+0 = 26)
	    ou (V_NOTRAIT+0 = 36)
	    ou (V_NOTRAIT+0 = 46)
	    ou (V_NOTRAIT+0 = 56)
	    ou (V_NOTRAIT+0 = 66)
           )
        alors (1)
        sinon (0)
	finsi;


LIG2140 = si (( ((V_CR2+0=0) et NATIMP=1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		ou ((V_CR2+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
          alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * (1 - LIGPS))
          finsi;

LIG2140S = si (( ((V_CR2+0=0) et NATIMP=1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		ou ((V_CR2+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
           alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * LIGPS)
           finsi;

LIG21401 = si (( ((V_CR2+0=0) et NATIMP=1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		ou ((V_CR2+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
           alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * positif(20 - V_NOTRAIT))
           finsi ;

LIG21402 = si (( ((V_CR2+0=0) et NATIMP=1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		ou ((V_CR2+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
           alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * positif(V_NOTRAIT - 20))
           finsi ;

LIGTRAIT = LIGPS + LIG2140 ;

regle 112141:
application : batch,  iliad;

LIG2141 = null(IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - IRANT) 
                  * positif(IRANT)
                  * (1 - positif(LIG2501))
		  * null(V_IND_TRAIT - 4)
		  * (1 - LIGPS)
		  * (1 - positif(NRINET + 0)) ;

LIG2141S = null(IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - IRANT) 
                  * positif(IRANT)
                  * (1 - positif(LIG2501))
		  * null(V_IND_TRAIT - 4)
		  * LIGPS
		  * (1 - positif(NRINET + 0)) ;

regle 112145:
application : batch,  iliad;
LIGNETAREC = positif (IINET) * (1 - LIGPS) * positif(ANNUL2042) * TYPE2 ;

LIGNETARECS = positif (IINET) * LIGPS * positif(ANNUL2042) * TYPE2 ;

regle 1112150:
application : iliad , batch ;

LIG2150 = (1 - INDCTX) 
	 * positif(IREST)
         * (1 - positif(LIG2140))
         * (1 - positif(IND_REST50))
	 * (1 - LIGPS)
         * LIG2 ;

LIG2150S = (1 - INDCTX) 
	  * positif(IREST)
          * (1 - positif(LIG2140))
          * (1 - positif(IND_REST50))
	  * LIGPS
          * LIG2 ;

regle 1112160:
application : batch, iliad ;

LIG2161 =  INDCTX 
	  * positif(IREST) 
          * positif_ou_nul(IREST - SEUIL_8) 
	  * (1 - positif(IND_REST50)) ;


LIG2368 = INDCTX 
	 * positif(IREST)
         * positif ( positif(IND_REST50)
                     + positif(IDEGR) )
           ;

regle 1112171:
application : batch , iliad ;

LIG2171 = (1 - INDCTX) 
	 * positif(IREST)
	 * (1 - positif(LIG2140))
         * positif(IND_REST50)  
	 * (1 - LIGPS)
	 * LIG2 ;

LIG2171S = (1 - INDCTX) 
	  * positif(IREST)
	  * (1 - positif(LIG2140))
          * positif(IND_REST50)  
	  * LIGPS
	  * LIG2 ;

regle 11121710:
application : batch, iliad ;

LIGTROP = positif(V_ANTRE+V_ANTCR) * null(IINET)* positif_ou_nul(abs(NAPTOTA)
             - IRESTIT - IRANT) * (1 - positif_ou_nul(abs(NAPTOTA) - IRESTIT
             - IRANT - SEUIL_12))
               * null(IDRS2 - IDEC + IREP)
	       * (1 - LIGPS)
               * (1 - INDCTX);

LIGTROPS = positif(V_ANTRE+V_ANTCR) * null(IINET)* positif_ou_nul(abs(NAPTOTA)
             - IRESTIT - IRANT) * (1 - positif_ou_nul(abs(NAPTOTA) - IRESTIT
             - IRANT - SEUIL_12))
               * null(IDRS2 - IDEC + IREP)
	       * LIGPS
               * (1 - INDCTX);

LIGTROPREST =  positif(V_ANTRE+V_ANTCR) * null(IINET)* positif_ou_nul(abs(NAPTOTA) 
               - IRESTIT - IRANT) * (1 - positif_ou_nul(abs(NAPTOTA) - IRESTIT
               - IRANT - SEUIL_12))
		 * (1 - positif(LIGTROP))
	         * (1 - LIGPS)
                 * (1 - INDCTX);

LIGTROPRESTS =  positif(V_ANTRE+V_ANTCR) * null(IINET)* positif_ou_nul(abs(NAPTOTA) 
                - IRESTIT - IRANT) * (1 - positif_ou_nul(abs(NAPTOTA) - IRESTIT
                - IRANT - SEUIL_12))
		 * (1 - positif(LIGTROP))
	         * LIGPS
                 * (1 - INDCTX);

regle 1113210:
application : batch, iliad ;

LIGRESINF50 = positif(positif(IND_REST50) * positif(IREST) 
                      + positif(IDEGR) * (1 - positif_ou_nul(IDEGR - SEUIL_8)))  
	      * (1 - LIGPS) ;

LIGRESINF50S = positif(positif(IND_REST50) * positif(IREST) 
                      + positif(IDEGR) * (1 - positif_ou_nul(IDEGR - SEUIL_8)))  
	       * LIGPS ;
regle 1112200:
application : batch,iliad ;
LIG2200 = (positif(IDEGR) * positif_ou_nul(IDEGR - SEUIL_8) * (1 - LIGPS) * TYPE2) ;

LIG2200S = (positif(IDEGR) * positif_ou_nul(IDEGR - SEUIL_8) * LIGPS * TYPE2) ;

regle 1112205:
application : batch, iliad;
LIG2205 = positif(IDEGR) * (1 - positif_ou_nul(IDEGR - SEUIL_8)) * (1 - LIGPS) * LIG2 ;

LIG2205S = positif(IDEGR) * (1 - positif_ou_nul(IDEGR - SEUIL_8)) * LIGPS * LIG2 ;

regle 1112301:
application : batch, iliad;
IND_NIRED = si ((CODINI=3 ou CODINI=5 ou CODINI=13)
               et ((IAVIM +NAPCRPAVIM)- TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT) = 0 
                   et  V_CR2 = 0)
          alors (1 - INDCTX) 
          finsi;
regle 1112905:
application : batch, iliad;
IND_IRNMR = si (CODINI=8 et NATIMP=0 et V_CR2 = 0)
          alors (1 - INDCTX)  
          finsi;
regle 1112310:
application : batch, iliad;

 
IND_IRINF80 = si ( ((CODINI+0=9 et NATIMP+0=0) ou (CODINI +0= 99))
                  et V_CR2=0 
                  et  (IRNET +TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT + NAPCR < SEUIL_12)
                  et  ((IAVIM+NAPCRPAVIM) >= SEUIL_61))
              alors ((1 - positif(INDCTX)) * (1 - positif(IREST))) 
              finsi;


regle 11123101:
application : batch , iliad ;

LIGNIIR = positif( positif(NIAMENDE) 
                      * positif(IINET - LIM_AMENDE + 1)
                      * INDREV1A8* (1 - V_CR2)
                     + null(IRNETBIS)
                      * null(NRINET + 0)
                 )
           * null(NATIMP +0)
           * null(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + 0)
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - positif(IRESTIT))
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
           * (1 - positif(LIGNIDB))
           * (1 - null(V_REGCO-2 +0))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - positif(NRINET))
	   * (1 - LIGPS)
	   * positif(20 - V_NOTRAIT)
           * LIG2 ;

LIGNIIRS = positif( positif(NIAMENDE) 
                      * positif(IINET - LIM_AMENDE + 1)
                      * INDREV1A8* (1 - V_CR2)
                     + null(IRNETBIS)
                      * null(NRINET + 0)
                  )
            * null(NATIMP +0)
            * null(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NAPCRP + 0)
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - positif(IRESTIT))
            * (1 - positif(IDEGR))
            * (1 - positif(LIGIDBS))
            * (1 - positif(LIGNIRIS))
            * (1 - positif(LIG80FS))
            * (1 - positif(LIG400RIS))
            * (1 - positif(LIG400FS))
            * (1 - positif(LIGAUCUNS))
            * (1 - positif(LIG2141S))
            * (1 - positif(LIG2501S))
            * (1 - positif(LIG8FVS))
            * (1 - positif(LIGNIDBS))
            * (1 - null(V_REGCO-2 +0))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
	    * (1 - positif(NRINET))
	    * LIGPS
	    * positif(20 - V_NOTRAIT)
            * LIG2 ;

LIGNIIRDEG = null(IDRS3 - IDEC)
	      * null(IBM23)
              * (1 - V_CR2)
              * null(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT)
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - positif(IMPRET - SEUIL_12))
	      * (1 - positif(NRINET - SEUIL_12))
	      * (1 - LIGPS)
	      * positif(V_NOTRAIT - 20)
	      * (1 - positif(INDCTX))
              * LIG2 ;

LIGNIIRDEGS = null(IDRS3 - IDEC)
	       * null(IBM23)
               * (1 - V_CR2)
               * null(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT + NAPCR)
               * (1 - null(V_REGCO-2))
	       * (1 - positif(LIGTROP))
	       * (1 - positif(LIGTROPREST))
	       * (1 - positif(IMPRET - SEUIL_12))
	       * (1 - positif(NRINET - SEUIL_12))
	       * LIGPS
	       * positif(V_NOTRAIT - 20)
	       * (1 - positif(INDCTX))
               * LIG2 ;

regle 11123102:
application : batch , iliad ;

LIGCBAIL = positif(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
            * positif(NAPT)
            * null(INDNIRI) * (1 - positif(IBM23))
            * positif_ou_nul(IINET-SEUIL_12)
            * INDREV1A8
	    * (1 - positif(LIGNIDB))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
	    * (1 - positif(NRINET))
            * (1 - null(V_REGCO-2))
	    * (1 - LIGPS)
            * LIG2 ;

LIGCBAILS = null(IDOM11 - DEC11)
             * (1 - positif(IBM23))
	     * positif_ou_nul(TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES + NAPCRP - SEUIL_61)
	     * positif_ou_nul(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NAPCRP - SEUIL_12)
             * positif(NAPT)
	     * (1 - positif(LIGNIDBS))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * (1 - positif(NRINET))
             * (1 - null(V_REGCO - 2))
	     * LIGPS
             * LIG2 ;

LIGNITSUP = positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - SEUIL_61)
             * null(IDRS2-IDEC+IREP)
             * positif_ou_nul(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - SEUIL_12)
	     * (1 - positif(LIG0TSUP))
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * positif(V_NOTRAIT - 20)
	     * (1 - positif(INDCTX))
             * LIG2 ;
                       
LIGNITDEG = positif(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
             * positif_ou_nul(IRB2 - SEUIL_61)
             * positif_ou_nul(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - SEUIL_12)
             * null(INDNIRI) * (1 - positif(IBM23))
             * positif(1 - null(2-V_REGCO)) * INDREV1A8
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(INDCTX)
             * LIG2 ;
                       
regle 11123103:
application : batch , iliad ;

LIGNIDB = null(IDOM11 - DEC11)
           * null(NAPT)
           * positif (TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT)
           * positif(SEUIL_61 - TAXASSUR) 
	   * positif(SEUIL_61 - IPCAPTAXT) 
	   * positif(SEUIL_61 - TAXLOY) 
	   * positif(SEUIL_61 - IHAUTREVT)
           * null(IRNETBIS)
	   * null(IRB)
           * (1 - positif(LIG80F))
           * (1 - positif(LIG400RI))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(NRINET))
	   * (1 - positif(IMPRET))
           * (1 - null(V_REGCO-2))
	   * (1 - LIGPS)
           * LIG2 ;  

LIGNIDBS = null(IDOM11 - DEC11)
	    * positif(SEUIL_61 - TAXASSUR - IPCAPTAXTOT - TAXLOY - CHRAPRES - NAPCRP)
	    * positif_ou_nul(NAPTIR)
	    * positif(NAPCRP)
            * null(IRNETBIS)
            * (1 - positif(LIG80FS))
            * (1 - positif(LIG400RIS))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(NRINET))
	    * (1 - positif(IMPRET))
            * (1 - null(V_REGCO - 2))
	    * LIGPS
            * LIG2 ;  

LIGNI61SUP = null(IDOM11 - DEC11)
              * positif(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT)
              * positif(SEUIL_61 - TAXASSUR) 
	      * positif(SEUIL_61 - IPCAPTAXT) 
	      * positif(SEUIL_61 - TAXLOY) 
	      * positif(SEUIL_61 - IHAUTREVT)
              * null(IRNETBIS)
	      * null(IRB)
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - positif(IMPRET))
	      * positif(V_NOTRAIT - 20)
	      * (1 - positif(INDCTX))
              * LIG2 ;  

LIGNI61DEG = null(IBM23)
              * positif(SEUIL_61 - TAXASSUR) 
	      * positif(SEUIL_61 - IPCAPTAXT) 
	      * positif(SEUIL_61 - TAXLOY) 
	      * positif(SEUIL_61 - IHAUTREVT)
              * positif(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - positif(IMPRET))
	      * positif(INDCTX)
              * LIG2 ;  

LIGREVSUP = INDREV1A8
	     * positif(REVFONC)
	     * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(V_NOTRAIT - 20)
	     * (1 - positif(INDCTX))
             * LIG2 ;  

LIGREVDEG = INDREV1A8
	     * positif(REVFONC)
	     * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(INDCTX)
             * LIG2 ;  

regle 11123104:
application : batch , iliad ;

LIGNIRI = INDNIRI
           * null(IRNETBIS)
           * null(NATIMP)
           * (1 - positif (LIGIDB))
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - positif(AVFISCOPTER))
           * (1 - null(V_REGCO-2))
           * (1 - positif(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - LIGPS)
	   * positif(20 - V_NOTRAIT)
           * LIG2 ;

LIGNIRIS = INDNIRI
            * null(IRNETBIS)
            * null(NATIMP)
	    * null(NAPCRP)
            * (1 - positif(LIGIDBS))
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - positif(AVFISCOPTER))
            * (1 - null(V_REGCO-2))
            * (1 - positif(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
	    * (1 - positif(NRINET))
	    * LIGPS
	    * positif(20 - V_NOTRAIT)
            * LIG2 ; 

regle 11123105:
application : batch , iliad ;

LIGIDB = positif( INDNIRI
                 * null(NAPT)
                 * null(IRNETBIS)
                 * positif(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT)
	         * positif(IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
                 * positif(SEUIL_61 - TAXASSUR) 
		 * positif(SEUIL_61 - IPCAPTAXT) 
		 * positif(SEUIL_61 - TAXLOY) 
		 * positif(SEUIL_61 - IHAUTREVT)
                 * (1 - positif(REI))
	         * (1 - positif( BPTP2 + BPTP3 + BPTP4 + BPTP40 + BPTP18+ BPTPD + BPTPG))
                 * (1 - positif(IPROP))
                 * (1 - positif(AVFISCOPTER))
                 * (1 - null(V_REGCO-2))
		 * (1 - positif(LIGTROP))
		 * (1 - positif(LIGTROPREST))
	         * (1 - positif(IMPRET))
	         * (1 - positif(NRINET))
		 * (1 - LIGPS))
                 * LIG2 ;

LIGIDBS = positif( INDNIRI
                 * null(NAPT)
                 * null(IRNETBIS)
                 * positif(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT)
	         * positif(IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
                 * positif(SEUIL_61 - TAXASSUR) 
		 * positif(SEUIL_61 - IPCAPTAXT) 
		 * positif(SEUIL_61 - TAXLOY) 
		 * positif(SEUIL_61 - IHAUTREVT)
                 * (1 - positif(REI))
	         * (1 - positif( BPTP2 + BPTP3 + BPTP4 + BPTP40 + BPTP18+ BPTPD + BPTPG))
                 * (1 - positif(IPROP))
                 * (1 - positif(AVFISCOPTER))
                 * (1 - null(V_REGCO-2))
		 * (1 - positif(LIGTROP))
		 * (1 - positif(LIGTROPREST))
	         * (1 - positif(IMPRET))
	         * (1 - positif(NRINET))
		 * LIGPS)
                 * LIG2 ;

regle 11123106:
application : batch , iliad ;

LIGRIDB = INDNIRI
           * null(IRNETBIS)
           * positif(NAPT)
           * positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - SEUIL_61)
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - null(V_REGCO-2))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - positif(NRINET))
	   * (1 - LIGPS)
           * LIG2 ;

LIGRIDBS = INDNIRI
	    * null(IRNETBIS)
	    * positif_ou_nul(TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES + NAPCRP - SEUIL_61)
	    * positif_ou_nul(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NAPCRP - SEUIL_12)
            * positif(NAPT)
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
	    * (1 - positif(NRINET))
	    * LIGPS
            * LIG2 ;

LIG0TSUP = INDNIRI
            * null(IRNETBIS)
            * positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - SEUIL_61)
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(V_NOTRAIT - 20)
	    * (1 - positif(INDCTX))
            * LIG2 ;

LIG0TDEG = INDNIRI
            * null(IRNETBIS)
            * positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - SEUIL_61)
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(INDCTX)
            * LIG2 ;

regle 11123111:
application : batch , iliad ;

LIG400F = INDNMR1 * positif(IAMD2) * (1 - INDNIRI)
           * (1 - positif(LIG400RI))
           * (1 - null(V_REGCO-2))
           * (1 - positif(LIGNIDB))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - positif(NRINET))
	   * (1 - LIGPS)
	   * positif(20 - V_NOTRAIT)
           * LIG2 ;

LIG400FS = INDNMR1 * positif(IAMD2) * (1 - INDNIRI) 
            * positif_ou_nul(NAPTIR)
            * (1 - positif(LIG400RIS))
            * (1 - null(V_REGCO-2))
            * (1 - positif(LIGNIDBS))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
	    * (1 - positif(NRINET))
	    * LIGPS
	    * positif(20 - V_NOTRAIT)
            * LIG2 ;

LIG12ANTRE = positif(SEUIL_12 - (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - (PIR + PTAXA + PPCAP + PTAXLOY + PHAUTREV)))
              * positif(IAVIM - (PIR + PTAXA + PPCAP + PTAXLOY + PHAUTREV) - SEUIL_61)
	      * positif(IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - (PIR + PTAXA + PPCAP + PTAXLOY + PHAUTREV))
              * positif_ou_nul(V_ANTRE - SEUIL_8)
              * (1 - positif(NRINET))
	      * (1 - positif(IMPRET))
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * positif(V_NOTRAIT - 20)
	      * (1 - positif(INDCTX))
              * LIG2 ;

LIG61ANTRE = positif(SEUIL_61 - (IAVIM - (PIR + PTAXA + PPCAP + PTAXLOY + PHAUTREV)))
	      * positif(IAVIM)
              * positif_ou_nul(V_ANTRE - SEUIL_8)
              * (1 - positif(NRINET))
	      * (1 - positif(IMPRET))
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - positif(INDCTX))
	      * positif(V_NOTRAIT - 20)
              * LIG2 ;

LIG400DEG = positif(IAVIM)
  	     * positif (SEUIL_61 - IAVIM)
	     * positif (IRNET)
	     * (1 - positif(IRNET - SEUIL_61))
	     * (1 - positif(LIG12ANTRE + LIG61ANTRE))
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET - SEUIL_12))
	     * (1 - positif(NRINET - SEUIL_12))
	     * (1 - positif(INDCTX))
	     * (1 - LIGPS)
	     * positif(V_NOTRAIT - 20)
             * LIG2 ;

LIG400DEGS = positif(IAVIM + NAPCRPAVIM)
  	      * positif (SEUIL_61 - (IAVIM + NAPCRPAVIM))
	      * positif (IRNET)
	      * (1 - positif(IRNET - SEUIL_61))
	      * (1 - positif(LIG12ANTRE + LIG61ANTRE))
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - positif(IMPRET - SEUIL_12))
	      * (1 - positif(NRINET - SEUIL_12))
	      * (1 - positif(INDCTX))
	      * LIGPS
	      * positif(V_NOTRAIT - 20)
              * LIG2 ;

regle 11123112:
application : batch , iliad ;

LIG400RI = INDNMR1 
	    * positif(ITRED)
            * (1 - null(IRB))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - LIGPS)
	    * positif(20 - V_NOTRAIT)
            * LIG2 ;

LIG400RIS = INDNMR1 
	     * positif(ITRED)
             * (1 - null(IRB))
             * (1 - null(V_REGCO-2))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * LIGPS
	     * positif(20 - V_NOTRAIT)
             * LIG2 ;

LIG61NRSUP = (1 - positif_ou_nul(NAPT))
              * positif(ITRED)
	      * positif(IAVIM)  
              * positif(SEUIL_61 - IAVIM)
              * (1 - positif_ou_nul(V_ANTRE - SEUIL_8))
              * (1 - positif(INDNMR2))
              * (1 - null(V_REGCO-2))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - positif(IMPRET))
	      * (1 - positif(NRINET))
	      * positif(V_NOTRAIT - 20) 
	      * (1 - LIGPS)
              * LIG2 ;

LIG61NRSUPS = (1 - positif_ou_nul(NAPT))
               * positif(ITRED)
	       * positif(IAVIM+NAPCRPAVIM)  
               * positif(SEUIL_61 - (IAVIM+NAPCRPAVIM))
               * (1 - positif_ou_nul(V_ANTRE - SEUIL_8))
               * (1 - positif(INDNMR2))
               * (1 - null(V_REGCO-2))
	       * (1 - positif(LIGTROP))
	       * (1 - positif(LIGTROPREST))
	       * (1 - positif(IMPRET))
	       * (1 - positif(NRINET))
	       * positif(V_NOTRAIT - 20) 
	       * LIGPS
               * LIG2 ;

LIG61DEG = positif(ITRED)
	    * positif(IAVIM)  
            * positif(SEUIL_61 - IAVIM)
            * (1 - positif(INDNMR2))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
            * positif(INDCTX)
            * LIG2 ;

regle 11123113:
application : batch , iliad ;
	

LIG80F = INDNMR2
	  * positif_ou_nul (IRB2 + IMPRET - SEUIL_61)
	  * positif(SEUIL_12 - TOTNET)
          * (1 - positif (IRANT))
	  * (1 - positif(LIGTROP))
	  * (1 - positif(LIGTROPREST))
	  * (1 - LIGPS)
	  * positif(20 - V_NOTRAIT)
          * (1 - null(V_REGCO - 2))
          * LIG2 ;

LIG80FS = INDNMR2
	   * positif_ou_nul(IRB2 + IMPRET + NAPCRP - SEUIL_61)
	   * positif(SEUIL_12 - TOTNET)
	   * positif(TOTNET)
           * (1 - positif (IRANT))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * LIGPS
	   * positif(20 - V_NOTRAIT)
           * (1 - null(V_REGCO - 2))
           * LIG2 ;

regle 11123114:
application : batch , iliad ;
	

LIGAUCUN = positif_ou_nul(IAMD1 - SEUIL_61)
            * null(IRCUMBIS)
            * null(NAPT)
            * (1 - null(V_REGCO-2))
            * (1 - positif(LIG80F))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET - SEUIL_12))
	    * (1 - positif(NRINET - SEUIL_12))
	    * (1 - LIGPS)
	    * positif(20 - V_NOTRAIT) 
	    * LIG2 ;

LIGAUCUNS = positif_ou_nul(IAMD1 + NAPCRPIAMD1 - SEUIL_61)
	     * null(TOTNET)
	     * (1 - positif(IREST))
             * (1 - positif(LIG80FS))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET - SEUIL_12))
	     * (1 - positif(NRINET - SEUIL_12))
	     * LIGPS
             * (1 - null(V_REGCO - 2))
	     * positif(20 - V_NOTRAIT) 
	     * LIG2 ;

regle 11123115:
application : batch , iliad ;

LIG12ANT = positif (IRANT)
            * positif (SEUIL_12 - TOTNET )
	    * positif( TOTNET)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - LIGPS)
	    * (1 - positif(null(2-V_REGCO) + ((V_REGCO+0) dans (1,3,5,6))) * positif(NRINET-SEUIL_12))
	    * (1 - positif(IMPRET - SEUIL_12)) 
	    * (1 - positif(NRINET - SEUIL_12))
	    * positif(20 - V_NOTRAIT)
	    * LIG2 ;

LIG12ANTS = positif (IRANT)
             * positif (SEUIL_12 - TOTNET )
	     * positif( TOTNET)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * LIGPS
	     * (1 - positif(null(2-V_REGCO) + ((V_REGCO+0) dans (1,3,5,6))) * positif(NRINET-SEUIL_12))
	     * (1 - positif(IMPRET - SEUIL_12)) 
	     * (1 - positif(NRINET - SEUIL_12))
	     * positif(20 - V_NOTRAIT)
             * LIG2 ; 

regle 11123116:
application : batch , iliad ;

LIG12NMR = positif (INDNMR)  
            * positif_ou_nul(SEUIL_12 - (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - NAPTOTA - IRANT))
            * positif(TOTNET)
            * positif_ou_nul(IAMD1 - SEUIL_61)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(V_NOTRAIT - 20)
            * (1 - positif(null(2-V_REGCO) + ((V_REGCO+0) dans (1,3,5,6))) * positif(NRINET-SEUIL_12))
	    * (1 - positif(IMPRET - SEUIL_12)) 
	    * (1 - positif(NRINET - SEUIL_12))
	    * (1 - positif(INDCTX))
	    * (1 - LIGPS) ;

LIG12NMRS = positif (INDNMR)  
             * positif_ou_nul(SEUIL_12 - (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - NAPTOTA - IRANT))
             * positif(TOTNET)
             * positif_ou_nul(IAMD1 + NAPCRPIAMD1 - SEUIL_61)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * positif(V_NOTRAIT - 20)
             * (1 - positif(null(2-V_REGCO) + ((V_REGCO+0) dans (1,3,5,6))) * positif(NRINET-SEUIL_12))
	     * (1 - positif(IMPRET - SEUIL_12)) 
	     * (1 - positif(NRINET - SEUIL_12))
	     * (1 - positif(INDCTX))
	     * LIGPS ;

regle 11123117:
application : batch , iliad ;

LIGNIIRAF = null(IAD11)
             * positif (IRE)
             * (1 - positif_ou_nul(NAPT))
             * (1 - positif(INDNIRI))
             * (1 - positif(IREP))
             * (1 - positif(IPROP))
             * (1 - positif (NAPT))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - LIGPS)
             * LIG2 ;

LIGNIIRAFS = null(IAD11)
              * positif (IRE)
              * (1 - positif_ou_nul(NAPT))
              * (1 - positif(INDNIRI))
              * (1 - positif(IREP))
              * (1 - positif(IPROP))
              * (1 - positif (NAPT))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * LIGPS
              * LIG2 ;

regle 11123118:
application : batch , iliad ;

LIGNIRIAF = INDNIRI
             * null(IBM23)
             * positif (IRE)
             * (1 - positif_ou_nul(NAPT))
             * (1 - positif(IREP))
             * (1 - positif(IPROP))
	     * (1 - positif(IMPRET))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - LIGPS)
             * LIG2 ;

LIGNIRIAFS = INDNIRI
              * positif(IREST)
              * null(IBM23)
              * positif (IRE)
              * (1 - positif_ou_nul(NAPT))
              * (1 - positif(IREP))
              * (1 - positif(IPROP))
	      * (1 - positif(IMPRET))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * LIGPS
              * LIG2 ;

regle 11123120:
application : batch , iliad ;

LIGNIDEG = null(IDRS3-IDEC)
	    * null(IBM23)
	    * positif(SEUIL_61 - TAXASSUR)
	    * positif(SEUIL_61 - IPCAPTAXT)
	    * positif(SEUIL_61 - TAXLOY)
	    * positif(SEUIL_61 - IHAUTREVT)
            * positif(SEUIL_12 - IRNET)
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGDEG61))
	    * (1 - positif(LIGNI61DEG))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(INDCTX)
            * LIG2 ;

regle 11123121:
application : batch , iliad ;

LIGDEG61 = positif (IRNETBIS)
            * positif (SEUIL_61 - IAMD1) 
            * positif (SEUIL_61 - NRINET) 
	    * positif (IBM23)
	    * (1 - positif(LIG61DEG))
            * (1 - null(V_REGCO-2))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
            * positif (INDCTX)
            * LIG2 ;

regle 11123122:
application : batch , iliad ;

LIGDEG12 = positif (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
            * positif (SEUIL_12 - IRNET - TAXANET - PCAPNET - TAXLOYNET - HAUTREVNET)
            * (1 - null(V_REGCO-2))
            * (1 - positif(LIGNI61DEG))
            * (1 - positif(LIGNIDEG))
            * (1 - positif(LIGDEG61))
            * (1 - positif(LIG61DEG))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
            * (1 - positif(IMPRET))
	    * positif(INDCTX)
            * LIG2 ;

regle 11123124:
application : batch , iliad ;

LIGDIPLOI = positif(INDREV1A8)
             * null(NATIMP - 01)
             * positif(REVFONC) * ((V_REGCO+0) dans (1,3,5,6)) 
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - LIGPS)
             * LIG1 ;

LIGDIPLOIS = positif(INDREV1A8)
              * null(NATIMP - 01)
              * positif(REVFONC) * ((V_REGCO+0) dans (1,3,5,6)) 
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * LIGPS
              * LIG1 ;

regle 11123125:
application : batch , iliad ;

LIGDIPLONI = positif(INDREV1A8)
              * positif(REVFONC) * ((V_REGCO+0) dans (1,3,5,6)) 
              * (null(NATIMP) + positif(IREST))
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - LIGPS)
              * LIG1 ;

LIGDIPLONIS = positif(INDREV1A8)
               * positif(REVFONC) * ((V_REGCO+0) dans (1,3,5,6)) 
               * (null(NATIMP) + positif(IREST))
	       * (1 - positif(LIGTROP))
	       * (1 - positif(LIGTROPREST))
	       * LIGPS
               * LIG1 ;

regle 1112355:
application : batch, iliad ;
LIG2355 = positif (
		   IND_NI * (1 - positif(V_ANTRE)) + INDNMR1 + INDNMR2
                   + positif(NAT1BIS) *  null(NAPT) * (positif (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET))
		   + positif(SEUIL_12 - (IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - IRANT))
				 * positif_ou_nul(IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT - IRANT) 
                  )
          * positif(INDREV1A8)
          * (1 - null(NATIMP - 1) + null(NATIMP - 1) * positif(IRANT))  
	  * (1 - LIGPS)
	  * LIG2 ;

regle 1112380:
application : batch, iliad;

LIG2380 = si (NATIMP=0 ou NATIMP=21 ou NATIMP=70 ou NATIMP=91)
          alors (IND_SPR * positif_ou_nul(V_8ZT - RBG) * positif(V_8ZT)
                * (1 - present(BRAS)) * (1 - present(IPSOUR))
                * V_CR2 * LIG2 * (1 - LIGPS))
          finsi ;

LIG2380S = si (NATIMP=0 ou NATIMP=21 ou NATIMP=70 ou NATIMP=91)
           alors (IND_SPR * positif_ou_nul(V_8ZT - RBG) * positif(V_8ZT)
                 * (1 - present(BRAS)) * (1 - present(IPSOUR))
                 * V_CR2 * LIG2 * LIGPS)
           finsi ;
regle 1112383:
application : batch , iliad ;

LIG2383 = si ((IAVIM+NAPCRPAVIM)<=(IPSOUR * LIG1 ))
          alors ( positif(RBG - V_8ZT) * present(IPSOUR) 
                * V_CR2 * LIG2 * (1 - LIGPS))
          finsi ;

LIG2383S = si ((IAVIM+NAPCRPAVIM)<=(IPSOUR * LIG1 ))
           alors ( positif(RBG - V_8ZT) * present(IPSOUR) 
                 * V_CR2 * LIG2 * LIGPS)
           finsi ;
regle 1112501:
application : iliad,batch;

LIG2501 = (1 - positif(IND_REV)) * (1 - null(2 - V_REGCO)) * LIG2 * (1 - LIGPS) ;

LIG2501S = (1 - positif(IND_REV)) * (1 - null(2 - V_REGCO)) * LIG2 * LIGPS ;

LIG25012 = (1 - positif(IND_REV)) * null(2 - V_REGCO) * LIG2 * (1 - LIGPS) ;

LIG25012S = (1 - positif(IND_REV)) * null(2 - V_REGCO) * LIG2 * LIGPS ;

LIG8FV = positif(REVFONC) * (1 - IND_REV8FV) * (1 - LIGPS) ;

LIG8FVS = positif(REVFONC) * (1 - IND_REV8FV) * LIGPS ;
regle 1112503:
application : batch, iliad;
LIG2503 = (1 - positif(IND_REV))
          * (1 - positif_ou_nul(IND_TDR))
          * LIG2
          * (1 - null(2 - V_REGCO)) * (1 - LIGPS) ;

LIG2503S = (1 - positif(IND_REV))
           * (1 - positif_ou_nul(IND_TDR))
           * LIG2 
           * (1 - null(2 - V_REGCO)) * LIGPS ;
 
regle 1113200:
application : batch, iliad ;
LIG_REPORT = positif(LIGRNIDF + somme(i=0..5:LIGRNIDFi)
             + LIGDEFBA + LIGDRFRP + LIG3250 + LIGIRECR + LIGDRCVM 
             + somme(i=1..6:LIGDLMRNi)
             + somme(i=1..6:LIGBNCDFi)
             + somme(i=V,C,P:LIGMIBDREPi + LIGMBDREPNPi + LIGSPEDREPi + LIGSPDREPNPi)
             + LIGLOCNEUF + somme(i=1..6:LIGLOCNEUFi) 
             + LIGDEFBA 
	     + LIGPATNATR
	     + LIGRCEL2012 + LIGRCELJBGL + LIGRCELJOQR + LIGRCELJP
             + LIGRCEL + LIGRCELNBGL + LIGRCELCOM + LIGRCELNQ + LIGRCELHJK + LIGRCELHNO
	     + LIGRCELHLM + LIGRRCEL1 +  LIGRRCEL2 +  LIGRRCEL3 +  LIGRRCEL4
	     + LIGRLOCIDFG + LIGREPLOCIE + LIGNEUV + LIGRNEUV + LIGVIEU
             + LIGCOMP01
             + LIGREPDOMPX3 + LIGREPDOMPX4
	     + LIGREPQKG + LIGREPQNH
	     + LIGREPQUS + LIGREPQW + LIGREPMMQE
             + LIGREPLG + LIGREPLI + LIGREPMA + LIGREPMC + LIGREPKS + LIGREPKU
	     + LIGREPLH + LIGREPMB + LIGREPKT + LIGREPQV + LIGREPQO + LIGREPQP 
	     + LIGREPQR + LIGREPQF + LIGREPQG + LIGREPQI + LIGREPPA + LIGREPPB
	     + LIGREPPD + LIGREPPE + LIGREPPF + LIGREPPH + LIGREPPI + LIGREPPJ + LIGREPPL
	     + LIGREPPM + LIGREPPN + LIGREPPO + LIGREPPP + LIGREPPR + LIGREPPS
	     + LIGREPPT + LIGREPPU + LIGREPPW + LIGREPPX + LIGREPPY 
	     + LIGREPRG + LIGREPRI + LIGREPRK + LIGREPRL + LIGREPRM
	     + LIGREPRO + LIGREPRP + LIGREPRQ
	     + LIGREPRR + LIGREPRT + LIGREPRU + LIGREPRV + LIGREPRW + LIGREPRY
	     + LIGREPNU + LIGREPNV + LIGREPNW + LIGREPNY
             + LIGREPDOMENT + LIGREPDOMOUT + LIGPME3 + LIGPME2 + LIGPME1 + LIGPMER + LIGPMECU
             + LIGREPDON + LIGREPDONR + LIGREPDONR1 
             + LIGREPDONR2 + LIGREPDONR3 + LIGREPDONR4 
             + LIGREPDOM + LIGREPNEUV + LIGREPLOCNT + LIGRESIREP + LIGREPMEU + LIGREPREPAR + LIGLOCRES
             + LIGDFRCM + LIGPME + LIGREPCORSE + LIGREPRECH + LIGDEFPLOC
	     + LIGFOREST + LIGNFOREST )  
                 * LIG2 ;

regle 1113250:
application : batch, iliad ;

LIG3250 = positif(DALNP) * LIG1  * LIG2 ;

regle 1113500:
application : batch, iliad;
LIG3500 = positif(LIG3510) * LIG1  * LIG2 ;
regle 1113510:
application : batch, iliad;
LIG3510 =  (positif(V_FORVA) * (1 - positif_ou_nul(BAFV))
           + positif(V_FORCA) * (1 - positif_ou_nul(BAFC))
           + positif(V_FORPA) * (1 - positif_ou_nul(BAFP)))
       	   * (1 - positif(IPVLOC)) * (1 - LIGPS) * LIG1 ;

LIG3510S =  (positif(V_FORVA) * (1 - positif_ou_nul(BAFV))
            + positif(V_FORCA) * (1 - positif_ou_nul(BAFC))
            + positif(V_FORPA) * (1 - positif_ou_nul(BAFP)))
       	    * (1 - positif(IPVLOC)) * LIGPS * LIG1 ;
regle 1113710:
application : batch , iliad ;

LIG4271 = positif(positif(V_0AB) * LIG1) * (1 - LIGPS) ;

LIG4271S = positif(positif(V_0AB) * LIG1) * LIGPS ;

LIG3710 = positif(20 - V_NOTRAIT) * positif(BOOL_0AZ) * (1 - LIGPS) * LIG1 ;

LIG3710S = positif(20 - V_NOTRAIT) * positif(BOOL_0AZ) * LIGPS * LIG1 ;

regle 1113720:
application : batch, iliad ;

LIG3720 = (1 - positif(20 - V_NOTRAIT)) * (1 - positif(LIG3730)) * LIG1 * LIG2 ;

regle 1113730:
application : batch, iliad ;

LIG3730 = (1 - positif(20 - V_NOTRAIT))
          * positif(BOOL_0AZ)
          * LIG1 ;

regle 1113740:
application : batch, iliad;
LIG3740 = positif(INDTXMIN) * LIG1 * positif(IND_REV) * (1 - LIGPS) ;

LIG3740S = positif(INDTXMIN) * LIG1 * positif(IND_REV) * LIGPS ;
regle 1113750:
application : batch, iliad;
LIG3750 = present(V_ZDC) * null(abs(V_ZDC - 1)) * positif(IREST) * LIG1 * (1 - LIGPS) ;

LIG3750S = present(V_ZDC) * null(abs(V_ZDC - 1)) * positif(IREST) * LIG1 * LIGPS ;
regle 1113760:
application : batch, iliad;
LIG3760 = positif(IDEGR)  
          * positif(IREST)
       	  * LIG1 ;

LIG_MEMO = ( positif(LIGPRELIB + LIG_SURSIS + LIGREPPLU + LIGELURAS + LIGELURASC + LIGABDET + LIGABDETP 
		   + LIGABDETM + LIGPVJEUNE + LIGROBOR + LIGPVPART + LIGPVIMMO 
		   + LIGPVTISOC + LIGMOBNR + LIGDEPCHO + LIGDEPMOB)
           + positif(LIG3525 + LIGRCMSOC + LIGLIBDIV + LIGRCMIMPAT + LIGABIMPPV + LIGABIMPMV) 
	          * (1-null(2-V_REGCO)) * (1-null(4-V_REGCO))
           ) * LIG1 * LIG2 ;

regle 1113870:
application : batch, iliad;
LIGPRELIB = positif(present(PPLIB) + present(RCMLIB)) * LIG0 * LIG2 ;

LIG3525 = (1 - V_CNR) * positif(RTNC) * LIG1 * LIG2 ;

regle 111021:
application : iliad , batch ;
LIGPRR2 = positif(PRR2V + PRR2C + PRR2P + PENALIMV + PENALIMC + PENALIMP + 0) ;
regle 111022:
application : batch, iliad;
LIG022 = somme(i=1..4:2TSNi) ;
regle 111023:
application : batch, iliad;
LIG023 = somme(i=1..4:3TSNi);
regle 111024:
application : batch, iliad;
LIG024 = somme(i=1..4:4TSNi);
regle 111062:
application : batch, iliad;
LIG062V = CARPEV + CARPENBAV + PENSALV + PENSALNBV ;
LIG062C = CARPEC + CARPENBAC + PENSALC + PENSALNBC ;
LIG062P = somme(i=1..4: CARPEPi + CARPENBAPi) + somme(i=1..4: PENSALPi + PENSALNBPi) ;
regle 111066:
application : batch,iliad;
LIG066 = somme(i=1..4:PEBFi);
regle 111390:
application : batch, iliad;
LIG390 = GLD1V + GLD1C ;
regle 111030:
application : iliad,batch;
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
regle 388:
application : iliad, batch;

LIGCELLA = positif(DCELRREDLA) * LIG1 * LIG2 ;
LIGCELLB = positif(DCELRREDLB) * LIG1 * LIG2 ;
LIGCELLE = positif(DCELRREDLE) * LIG1 * LIG2 ;
LIGCELLC = positif(DCELRREDLC) * LIG1 * LIG2 ;
LIGCELLD = positif(DCELRREDLD) * LIG1 * LIG2 ;
LIGCELLF = positif(DCELRREDLF) * LIG1 * LIG2 ;
LIGCELHS = positif(DCELREPHS) * LIG1 * LIG2 ;
LIGCELHR = positif(DCELREPHR) * LIG1 * LIG2 ;
LIGCELHU = positif(DCELREPHU) * LIG1 * LIG2 ;
LIGCELHT = positif(DCELREPHT) * LIG1 * LIG2 ;
LIGCELHZ = positif(DCELREPHZ) * LIG1 * LIG2 ;
LIGCELHX = positif(DCELREPHX) * LIG1 * LIG2 ;
LIGCELHW = positif(DCELREPHW) * LIG1 * LIG2 ;
LIGCELHV = positif(DCELREPHV) * LIG1 * LIG2 ;
LIGCELHF = positif(DCELREPHF) * LIG1 * LIG2 ;
LIGCELHE = positif(DCELREPHE) * LIG1 * LIG2 ;
LIGCELHD = positif(DCELREPHD) * LIG1 * LIG2 ;
LIGCELHH = positif(DCELREPHH) * LIG1 * LIG2 ;
LIGCELHG = positif(DCELREPHG) * LIG1 * LIG2 ;
LIGCELHB = positif(DCELREPHB) * LIG1 * LIG2 ;
LIGCELHA = positif(DCELREPHA) * LIG1 * LIG2 ;
LIGCELHM = positif(DCELHM) * LIG1 * LIG2 ;
LIGCELHL = positif(DCELHL) * LIG1 * LIG2 ;
LIGCELHNO = positif(DCELHNO) * LIG1 * LIG2 ;
LIGCELHJK = positif(DCELHJK) * LIG1 * LIG2 ;
LIGCELNQ = positif(DCELNQ) * LIG1 * LIG2 ; 
LIGCELNBGL = positif(DCELNBGL) * LIG1 * LIG2 ; 
LIGCELCOM = positif(DCELCOM) * LIG1 * LIG2 ; 
LIGCEL = positif(DCEL) * LIG1 * LIG2 ; 
LIGCELJP = positif(DCELJP) * LIG1 * LIG2 ; 
LIGCELJOQR = positif(DCELJOQR) * LIG1 * LIG2 ; 
LIGCELJBGL = positif(DCELJBGL) * LIG1 * LIG2 ; 
LIGCEL2012 = positif(DCEL2012) * LIG1 * LIG2 ; 

regle 3882:
application : iliad,batch;

LIGRCEL =  positif(RIVCEL1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELNBGL =  positif(RIVCELNBGL1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELCOM =  positif(RIVCELCOM1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELNQ =  positif(RIVCELNQ1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELHJK =  positif(RIVCELHJK1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELHNO =  positif(RIVCELHNO1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELHLM =  positif(RIVCELHLM1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELJP =  positif(RIVCELJP1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELJOQR =  positif(RIVCELJOQR1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCELJBGL =  positif(RIVCELJBGL1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRCEL2012 = positif(RIV2012CEL1) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;


LIGRRCEL1 = positif(RRCELA2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL2 = positif(RRCELLF + RRCELB2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL21 = positif(RRCELLF) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL22 = positif(RRCELB2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL3 = positif(RRCELLC + RRCELLD + RRCELC2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL31 = positif(RRCELLC) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL32 = positif(RRCELLD) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL33 = positif(RRCELC2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL4 = positif(RRCELLA + RRCELLB + RRCELLE + RRCELD2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL41 = positif(RRCELLA) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL42 = positif(RRCELLB) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL43 = positif(RRCELLE) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

LIGRRCEL44 = positif(RRCELD2012) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 * LIG2 ;

regle 389:
application : iliad,batch;
LIGPATNAT2 = LIG1 * LIG2 * (positif(PATNAT2) + null(PATNAT2) * positif(V_NOTRAIT - 20)) ;

LIGPATNAT1 = LIG1 * LIG2 * (positif(PATNAT1) + null(PATNAT1) * positif(V_NOTRAIT - 20)) ;

LIGPATNAT = LIG1 * LIG2 * (positif(PATNAT) + null(PATNAT) * positif(V_NOTRAIT - 20)) ;

LIGPATNATR = positif(REPNATR + REPNATR1 + REPNATR2) * LIG1 ; 
LIGNATR2 = positif(REPNATR2) * LIG1 ; 
LIGNATR1 = positif(REPNATR1) * LIG1 ; 
LIGNATR = positif(REPNATR) * LIG1 ; 
regle 111031:
application : iliad, batch ;

LIGREPKG = positif(REPKG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPKI = positif(REPKI) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQK = positif(REPQK) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQX = positif(REPQX) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQKG = positif(REPQX + REPQK + REPKI + REPKG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPKH = positif(REPKH) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQN = positif(REPQN) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQJ = positif(REPQJ) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQNH = positif(REPQJ + REPQN + REPKH) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQU = positif(REPQU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQS = positif(REPQS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQUS = positif(REPQS + REPQU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQW = positif(REPQW) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPMM = positif(REPMM) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPMN = positif(REPMN) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQE = positif(REPQE) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPRJ = positif(REPRJ) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPMMQE = positif(REPRJ + REPMM + REPMN + REPQE) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPLG = positif(REPLG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPLI = positif(REPLI) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQFLG = positif(REPLI + REPLG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPMA = positif(REPMA) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPMC = positif(REPMC) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQGMA = positif(REPMC + REPMA) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPKS = positif(REPKS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPKU = positif(REPKU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPQIKS = positif(REPKU + REPKS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPLH = positif(REPLH) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPMB = positif(REPMB) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPKT = positif(REPKT) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQV = positif(REPQV) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQO = positif(REPQO) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQP = positif(REPQP) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQR = positif(REPQR) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQF = positif(REPQF) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQG = positif(REPQG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPQI = positif(REPQI) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPA = positif(REPPA) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPB = positif(REPPB) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPD = positif(REPPD) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPE = positif(REPPE) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPF = positif(REPPF) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPH = positif(REPPH) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPI = positif(REPPI) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPJ = positif(REPPJ) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPL = positif(REPPL) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPM = positif(REPPM) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPN = positif(REPPN) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPO = positif(REPPO) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPP = positif(REPPP) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPR = positif(REPPR) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPS = positif(REPPS) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPT = positif(REPPT) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPU = positif(REPPU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPW = positif(REPPW) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPX = positif(REPPX) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPPY = positif(REPPY) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRG = positif(REPRG) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRI = positif(REPRI) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRK = positif(REPRK) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRL = positif(REPRL) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRM = positif(REPRM) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRO = positif(REPRO) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRP = positif(REPRP) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRQ = positif(REPRQ) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRR = positif(REPRR) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRT = positif(REPRT) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRU = positif(REPRU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRV = positif(REPRV) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRW = positif(REPRW) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPRY = positif(REPRY) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPNU = positif(REPNU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPNV = positif(REPNV) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPNW = positif(REPNW) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;

LIGREPNY = positif(REPNY) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;


LIGREPDOMPX3 = positif(REPOMENTR3) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMPX4 = positif(REPDOMENTR4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMENT = positif(REPOMENTR3 + REPDOMENTR4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGREPDOMOUT = positif(REPDOMENTR4) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
LIGPMECU = positif(REPINVPMECU) * ((V_REGCO+0) dans (1,3,5,6)) * LIG1 ;
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
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * LIG2 
		  +0
		  ;
LIGPERPI = positif(PERPIMPATRIE+0)
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * (1 - positif(PERP_COND1+PERP_COND2))
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * LIG2 
		  +0
		  ;
LIGPERPM = (1 - positif(PERPIMPATRIE+0))
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * positif(PERP_MUT) 
		  * positif(PERP_COND1+PERP_COND2)
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * LIG2
		  +0
		  ;
LIGPERPMI = positif(PERPIMPATRIE+0)
		 * positif(PERPINDV + PERPINDC + PERPINDP
		  	+ PERPINDCV + PERPINDCC + PERPINDCP)
		 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
		  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
		  * positif(PERP_MUT) 
		  * positif(PERP_COND1+PERP_COND2)
		  * (1 - positif(LIG8FV)) 
		  * (1 - positif(LIG2501)) 
		  * LIG1 * (1-V_CNR) * LIG2 
		  +0
		  ;
LIGPERPFAM = positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
	      * positif(PERPINDC + PERPINDCC)* positif(PERPINDAFFC)
	      * positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
	      * LIG1 * (1-V_CNR) * LIG2
	      * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	      ;
LIGPERPV = positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
	   * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
	   * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
	   * LIG1 * (1-V_CNR) * LIG2 
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPC = positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC)
	  * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
	  * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
	  * LIG1 * (1-V_CNR) * LIG2 
	  * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	  ;
LIGPERPP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
	   * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
	   * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
	   * LIG1 * (1-V_CNR) * LIG2 
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPCP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP) 
	   * positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFV) 
	   * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)) 
	   * LIG1 * (1-V_CNR) * LIG2 
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPVP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP) 
	   * positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV) 
	   * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
	   * LIG1 * (1-V_CNR) * LIG2 
	   * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
	   ;
LIGPERPMAR = positif(PERPINDV + PERPINDCV)  * positif(PERPINDAFFV)
	     * positif(PERPINDC + PERPINDCC)  * positif(PERPINDAFFC)
	     * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)) 
	     * LIG1 * (1-V_CNR) * LIG2 
	     * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
		     ;
regle 1113700:
application : batch, iliad ;

LIG3700 = positif(LIG4271 + LIG3710 + LIG3720 + LIG3730) * LIG1 * TYPE4 ;

regle 111420:
application : iliad,batch;
LIGTAXANET = positif((present(CESSASSV) + present(CESSASSC)) * INDREV1A8IR + TAXANTAFF) * LIG1 ;

LIGPCAPNET = positif((present(PCAPTAXV) + present(PCAPTAXC)) * INDREV1A8IR + PCAPANTAFF) * LIG1 ;

LIGLOYNET = (present(LOYELEV) * INDREV1A8IR + TAXLOYANTAFF) * LIG1 ;

LIGHAUTNET = positif(BHAUTREV * INDREV1A8IR + HAUTREVANTAF) * LIG1 ;

regle 1113600:
application : batch,iliad;
EXOVOUS = 
   positif ( HEURESUPV )
 + present ( TSASSUV ) 
 + positif ( XETRANV )
 + positif ( EXOCETV ) 
 + positif ( SALINTV ) 
 + positif ( TSELUPPEV ) 
 + present ( FEXV ) 
 + positif ( MIBEXV ) 
 + positif ( MIBNPEXV ) 
 + positif ( BNCPROEXV ) 
 + positif ( XSPENPV ) 
 + positif ( XBAV ) 
 + positif ( XBIPV ) 
 + positif ( XBINPV ) 
 + positif ( XBNV ) 
 + positif ( XBNNPV ) 
 + positif ( ABICPDECV ) * ( 1 - V_CNR )
 + positif ( ABNCPDECV ) * ( 1 - V_CNR )
 + positif ( HONODECV ) * ( 1 - V_CNR )
 + positif ( AGRIV )
 + positif ( BIPERPV ) 
 + positif ( BNCCREAV ) 
 ;
EXOCJT = 
   positif ( HEURESUPC )
 + present ( TSASSUC ) 
 + positif ( XETRANC )
 + positif ( EXOCETC ) 
 + positif ( SALINTC ) 
 + positif ( TSELUPPEC ) 
 + present ( FEXC ) 
 + positif ( MIBEXC ) 
 + positif ( MIBNPEXC ) 
 + positif ( BNCPROEXC ) 
 + positif ( XSPENPC ) 
 + positif ( XBAC ) 
 + positif ( XBIPC ) 
 + positif ( XBINPC ) 
 + positif ( XBNC ) 
 + positif ( XBNNPC ) 
 + positif ( ABICPDECC ) * ( 1 - V_CNR )
 + positif ( ABNCPDECC ) * ( 1 - V_CNR )
 + positif ( HONODECC ) * ( 1 - V_CNR )
 + positif ( AGRIC )
 + positif ( BIPERPC ) 
 + positif ( BNCCREAC ) 
 ;
EXOPAC = 
   positif ( HEURESUPTOT )
 + present ( FEXP ) 
 + positif ( MIBEXP ) 
 + positif ( MIBNPEXP ) 
 + positif ( BNCPROEXP ) 
 + positif ( XSPENPP ) 
 + positif ( XBAP ) 
 + positif ( XBIPP ) 
 + positif ( XBINPP ) 
 + positif ( XBNP ) 
 + positif ( XBNNPP ) 
 + positif ( ABICPDECP ) * ( 1 - V_CNR )
 + positif ( ABNCPDECP ) * ( 1 - V_CNR )
 + positif ( HONODECP ) * ( 1 - V_CNR )
 + positif ( AGRIP )
 + positif ( BIPERPP ) 
 + positif ( BNCCREAP ) 
 ;
regle 1113601:
application : batch, iliad;
LIGTITREXVCP = positif(EXOVOUS)
               * positif(EXOCJT)
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;
regle 1113602:
application : batch, iliad;
LIGTITREXV = positif(EXOVOUS)
             * (1 - positif(EXOCJT))
             * (1 - positif(EXOPAC))
	     * (1 - positif(LIG2501))
             * LIG1 * LIG2 ;
regle 1113603:
application : batch, iliad;
LIGTITREXC =  (1 - positif(EXOVOUS))
               * positif(EXOCJT)
               * (1 - positif(EXOPAC))
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;
regle 1113604:
application : batch,iliad;
LIGTITREXP =  (1 - positif(EXOVOUS))
               * (1 - positif(EXOCJT))
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;
regle 1113605:
application : batch, iliad;
LIGTITREXVC =  positif(EXOVOUS)
               * positif(EXOCJT)
               * (1 - positif(EXOPAC))
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;
regle 1113606:
application : batch, iliad;
LIGTITREXVP =  positif(EXOVOUS)
               * (1 - positif(EXOCJT))
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;
regle 1113607:
application : batch, iliad;
LIGTITREXCP =  (1 - positif(EXOVOUS))
               * positif(EXOCJT) 
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;
regle 1113608:
application : batch , iliad ;

EXOCET = EXOCETC + EXOCETV ;
LIGEXOCET = positif(EXOCET) * LIG1 * LIG2 ;
LIGSALINT = positif(SALINTV + SALINTC) * LIG1 * LIG2 ;

LIGHEURESUP = positif(HEURESUPV + HEURESUPC + HEURESUPP1 + HEURESUPP2 + HEURESUPP3 + HEURESUPP4) * LIG1 * LIG2 ;
LIGMXBIP =  positif(MIBEXV + MIBEXC + MIBEXP) * LIG1 * LIG2 ;
LIGMXBINP =  positif(MIBNPEXV + MIBNPEXC + MIBNPEXP) * LIG1 * LIG2 ;
LIGSXBN =  positif(BNCPROEXV + BNCPROEXC + BNCPROEXP) * LIG1 * LIG2 ;
LIGXSPEN =  positif(XSPENPV + XSPENPC + XSPENPP) * LIG1 * LIG2 ;
LIGXBIP =  positif(XBIPV + XBIPC + XBIPP) * LIG1 * LIG2 ;
LIGXBINP =  positif(XBINPV + XBINPC + XBINPP) * LIG1 * LIG2 ;
LIGXBP =  positif(XBNV + XBNC + XBNP) * LIG1 * LIG2 ;
LIGXBN =  positif(XBNNPV + XBNNPC + XBNNPP) * LIG1 * LIG2 ;

LIGXTSA =  positif(present(TSASSUV) + present(TSASSUC)) * LIG1 * LIG2 ;
LIGXIMPA =  positif(XETRANV + XETRANC) * LIG1 * LIG2 ;
LIGXETR =  positif(DTSELUPPEV + DTSELUPPEC) * LIG1 * LIG2 ;
LIGXFORF =  positif(present(FEXV) + present(FEXC) + present(FEXP)) * LIG1 * LIG2 ;
LIGXBA =  positif(XBAV + XBAC + XBAP) * LIG1 * LIG2 ;

LIGBICAP = positif(ABICPDECV + ABICPDECC + ABICPDECP) * LIG1 * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) * LIG2 ;
LIGBNCAP = positif(ABNCPDECV + ABNCPDECC + ABNCPDECP) * LIG1 * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) * LIG2 ;
LIGHONO = positif(HONODECV + HONODECC + HONODECP) * LIG1 * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) * LIG2 ;

LIGBAPERP =  positif(BAPERPV + BAPERPC + BAPERPP + BANOCGAV + BANOCGAC + BANOCGAP) * LIG1 * LIG2 ;
LIGBIPERP =  positif(BIPERPV + BIPERPC + BIPERPP) * LIG1 * LIG2 ;
LIGBNCCREA =  positif(BNCCREAV + BNCCREAC + BNCCREAP) * LIG1 * LIG2 ;


regle 117010:
application : batch, iliad;

ZIG_TITRECRP = positif(BCSG + V_CSANT) * positif(BRDS + V_RDANT) * positif(BPRS + V_PSANT) * (1 - positif(BCVNSAL + V_CVNANT))
                * (1 - V_CNR) * LIG2 ;

ZIGTITRECRPS = positif(BCSG + V_CSANT) * positif(BRDS + V_RDANT) * positif(BPRS + V_PSANT) * positif(BCVNSAL + V_CVNANT)
                * (1 - V_CNR) * LIG2 ;

ZIGTITRECRS = positif(BCSG + V_CSANT) * positif(BRDS + V_RDANT) * positif(BCVNSAL + V_CVNANT) * (1 - positif(BPRS + V_PSANT))
                * (1 - V_CNR) * LIG2 ;

ZIGTITRERS = (1 - positif(BCSG + V_CSANT)) * positif(BRDS + V_RDANT) * (1 - positif(BPRS + V_PSANT)) * positif(BCVNSAL + V_CVNANT)
              * (1 - V_CNR) * LIG2 ;

ZIG_TITRECR = positif(BCSG + V_CSANT) * positif(BRDS + V_RDANT) * (1 - positif(BPRS + V_PSANT)) * (1 - positif(BCVNSAL + V_CVNANT))
               * (1 - V_CNR) * LIG2 ;

ZIG_TITRECP = positif(BCSG + V_CSANT) * (1 - positif(BRDS + V_RDANT)) * positif(BPRS + V_PSANT) * (1 - positif(BCVNSAL + V_CVNANT))
               * (1 - V_CNR) * LIG2 ;

ZIG_TITRERP = (1 - positif(BCSG + V_CSANT)) * positif(BRDS + V_RDANT) * positif(BPRS + V_PSANT) * (1 - positif(BCVNSAL + V_CVNANT))
               * (1 - V_CNR) * LIG2 ;

ZIG_TITREC = positif(BCSG + V_CSANT) * (1 - positif(BRDS + V_RDANT)) * (1 - positif(BPRS + V_PSANT)) * (1 - positif(BCVNSAL + V_CVNANT)) 
              * (1 - V_CNR) * LIG2 ;

ZIG_TITRER = positif(BRDS + V_RDANT) * (1 - positif(BCSG + V_CSANT)) * (1 - positif(BPRS + V_PSANT)) * (1 - positif(BCVNSAL + V_CVNANT))
              * (1 - V_CNR) * LIG2 ;

ZIGTITRES = positif(BCVNSAL + V_CVNANT) * (1 - positif(BRDS + V_RDANT)) * (1 - positif(BCSG + V_CSANT)) * (1 - positif(BPRS + V_PSANT))
             * LIG2 ;

ZIG_TITREPN = positif(BPRS + V_PSANT) * (1 - V_CNR) * LIG2 ;

regle 117030:
application : batch, iliad ;

ZIGTITRE = positif((positif(BCSG + V_CSANT + BRDS + V_RDANT + BPRS + V_PSANT) * (1 - (V_CNR * (1 - ZIG_RF))) 
		       + positif (BCVNSAL + V_CVNANT + BCSAL + V_CSALANT + BGAINSAL + V_GAINSALANT + BCDIS + V_CDISANT))
		      * TYPE4) ;

ZIGBASECS1 = positif(BCSG + V_CSANT) * positif(INDCTX) ;
ZIGBASERD1 = positif(BRDS + V_RDANT) * positif(INDCTX) ;
ZIGBASEPS1 = positif(BPRS + V_PSANT) * positif(INDCTX) ;
ZIGBASESAL1 = positif(BCVNSAL + V_CVNANT) * positif(INDCTX) ;

regle 117080:
application : batch, iliad;

CS_RVT = RDRV ;
RD_RVT = CS_RVT;
PS_RVT = CS_RVT;
IND_ZIGRVT =  0;

ZIG_RVTO = positif (CS_RVT + RD_RVT + PS_RVT + IND_ZIGRVT)
                   * (1 - V_CNR) * LIG1 * LIG2 ;
regle 117100:
application : batch, iliad;

CS_RCM =  RDRCM;
RD_RCM = CS_RCM;
PS_RCM = CS_RCM;
IND_ZIGRCM = positif(present(RCMABD) + present(RCMAV) + present(RCMHAD) + present(RCMHAB)  
                     + present(RCMTNC) + present(RCMAVFT) + present(REGPRIV)) 
	      * positif(V_NOTRAIT - 20) ;

ZIG_RCM = positif(CS_RCM + RD_RCM + PS_RCM + IND_ZIGRCM)
                   * (1 - V_CNR) * LIG1 * LIG2 ;
regle 117105:
application : batch, iliad;
CS_REVCS = RDNP;
RD_REVCS = CS_REVCS;
PS_REVCS = CS_REVCS;
IND_ZIGPROF = positif(V_NOTRAIT - 20) * positif( present(RCSV)
                     +present(RCSC)
                     +present(RCSP));
ZIG_PROF = positif(CS_REVCS+RD_REVCS+PS_REVCS+IND_ZIGPROF)
                   * (1 - V_CNR) * LIG1 ;
regle 117110:
application : batch, iliad;

CS_RFG = RDRF ;
RD_RFG = CS_RFG;
PS_RFG = CS_RFG;
IND_ZIGRFG = positif(V_NOTRAIT - 20) * positif( present(RFORDI)
                     +present(RFDORD)
                     +present(RFDHIS)
                     +present(RFMIC) );

ZIG_RF = positif(CS_RFG + RD_RFG + PS_RFG + IND_ZIGRFG) * (1 - null(4 - V_REGCO)) * LIG1 * LIG2 ;
regle 117181:
application :batch,  iliad;

CS_RTF = RDPTP + RDNCP ;
RD_RTF = CS_RTF ;
PS_RTF = CS_RTF ;
IND_ZIGRTF=  positif(V_NOTRAIT - 20) * positif (present (PEA) +
                      present ( BPCOPTV )  +
                      present ( BPVRCM )  +
                      present ( BPVKRI )  
                     );
ZIG_RTF = positif (CS_RTF + RD_RTF + PS_RTF + IND_ZIGRTF)
                   * (1 - V_CNR) * LIG1 * LIG2 ;

ZIGGAINLEV = positif(CVNSALC) * LIG1 * LIG2 ;
regle 117190:
application : batch, iliad;

CS_REVETRANG = 0 ;
RD_REVETRANG = SALECS + SALECSG + ALLECS + INDECS + PENECS ;
PS_REVETRANG = 0 ;


ZIG_REVETR = positif(SALECS + SALECSG + ALLECS + INDECS + PENECS)
                   * (1 - V_CNR) * LIG1 * LIG2 ;

regle 117200:
application : batch, iliad;

CS_RVORIGND =   ESFP;
RD_RVORIGND =   ESFP;
PS_RVORIGND =   ESFP;
IND_ZIGREVORIGIND = present(ESFP) ;

ZIG_RVORIGND = positif (CS_RVORIGND + RD_RVORIGND + PS_RVORIGND
                         + IND_ZIGREVORIGIND)
                   * (1 - V_CNR) * LIG1 * LIG2 ;
regle 117205:
application : batch, iliad ;

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

ZIGRE168 = positif(RE168) * (1 - V_CNR) * LIG2 ;
ZIGTAX1649 = positif(TAX1649) * (1 - V_CNR) * LIG2 ;

ZIGR1649 = positif(R1649) * (1 - V_CNR) * LIG1 * LIG2 ;
ZIGPREREV = positif(PREREV) * (1 - V_CNR) * LIG1 * LIG2 ;

regle 5000:
application : batch , iliad ;

LIGPS = positif(BCSG + BRDS + BPRS + BCVNSAL + BGAINSAL + BCSAL + BCDIS + BGLOA + BRSE1 + BRSE2 + BRSE3 + BRSE4 + BRSE5 + 0) ;

NONLIGPS = positif(1 - LIGPS) ;

INDIRPS =  (1 * (1 - LIGPS) * positif(3 - ANTINDIRPS))
	 + (2 * LIGPS * (1 - INDREV1A8)) * positif(positif_ou_nul(V_NOTRAIT - 14) + null(V_IND_TRAIT - 5))
	 + (3 * ((INDREV1A8 * LIGPS) + (null(3 - ANTINDIRPS) * (1 - LIGPS))))
	  ;
regle 117210:
application : batch, iliad;

CS_BASE = BCSG ;
RD_BASE = BRDS ;
PS_BASE = BPRS ;
GAIN_BASE = BGAINSAL ;
CSAL_BASE = BGAINSAL ;
ZIGBASECS = positif(BCSG + V_CSANT) ;
ZIGBASERD = positif(BRDS + V_RDANT) ;
ZIGBASEPS = positif(BPRS + V_PSANT) ;
ZIGBASECVN = positif(BCVNSAL + V_CVNANT) ;
ZIGBASESAL = positif(BGAINSAL + V_GAINSALANT) ;
ZIG_BASE = positif(BCSG + BRDS + BPRS + BCVNSAL + V_CSANT + V_RDANT + V_PSANT + V_CVNANT) * LIG2 ;
ZIGCSAL = positif(BCSAL + V_CSALANT) * LIG2 ;
ZIGCDIS = positif(BCDIS + V_CDISANT) * LIG2 ;
ZIGGLOA = positif(BGLOA) * LIG2 ;
ZIGRSE1 = positif(BRSE1) * LIG2 ; 
ZIGRSE2 = positif(BRSE2) * LIG2 ;
ZIGRSE3 = positif(BRSE3) * LIG2 ;
ZIGRSE4 = positif(BRSE4) * LIG2 ;
ZIGRSE5 = positif(BRSE5) * LIG2 ;
regle 117220:
application : batch, iliad;
ZIG_TAUXCRP  = ZIG_TITRECRP ;
ZIG_TAUXCR   = ZIG_TITRECR ;
ZIG_TAUXCP   = ZIG_TITRECP ;
ZIG_TAUXRP   = ZIG_TITRERP ;
ZIG_TAUXR    = ZIG_TITRER ;
ZIGTAUX1 = ZIGTITRECRPS ;
ZIGTAUX3 = ZIGTITRECRS ;
ZIGTAUX4 = ZIG_TITRECR ;
regle 117290:
application : batch, iliad;
ZIGMONTCS = positif(BCSG + V_CSANT) ;
ZIGMONTRD = positif(BRDS + V_RDANT) ;
ZIGMONTPS = positif(BPRS + V_PSANT) ;
ZIGMONTS = positif(BCVNSAL + V_CVNANT) ;
ZIG_MONTANT = positif (BCSG + BRDS + BPRS + BCVNSAL + V_CSANT + V_RDANT + V_PSANT + V_CVNANT) ;

regle 117300:
application : batch , iliad ;

ZIG_INT =  positif (RETCS + RETRD + RETPS + RETCVN) * LIG2 ;

ZIGSAL = positif(RETCSAL) * LIG2 ;

ZIGAIN = positif(RETGAIN) * LIG2 ;

ZIGINT = positif(RETCDIS) * LIG2 ;

ZIGLOA = positif(RETGLOA) * LIG2 ;

ZIGINT1 = positif(RETRSE1) * LIG2 ;
ZIGINT2 = positif(RETRSE2) * LIG2 ;
ZIGINT3 = positif(RETRSE3) * LIG2 ;
ZIGINT4 = positif(RETRSE4) * LIG2 ;
ZIGINT5 = positif(RETRSE5) * LIG2 ;

ZIGSAL22 = positif(RETCSAL22) ;
ZIGAIN22 = positif(RETGAIN22) ;
ZIGINT22 = positif(RETCDIS22) ;
ZIGLOA22 = positif(RETGLOA22) ;

ZIGINT122 = positif(RETRSE122) * LIG2 ;
ZIGINT222 = positif(RETRSE222) * LIG2 ;
ZIGINT322 = positif(RETRSE322) * LIG2 ;
ZIGINT422 = positif(RETRSE422) * LIG2 ;
ZIGINT522 = positif(RETRSE522) * LIG2 ;

regle 117330:
application : batch, iliad;
ZIG_PEN17281 = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJGAIN1) * LIG2 ;

ZIG_PENATX4 = ZIG_PENAMONT * positif(NMAJC4 + NMAJR4 + NMAJP4 + NMAJCVN4) * LIG2 ;
ZIG_PENATAUX = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJCVN1) * LIG2 ;

ZIGNONR30 = positif(ZIG_PENATX4) * positif(1 - positif(R1649 + PREREV)) * LIG2 ;
ZIGR30 = positif(ZIG_PENATX4) * positif(R1649 + PREREV) * LIG2 ;


ZIG17281S = positif(PCSAL) * positif(NMAJCSAL1) * LIG2 ;

ZIGPENACSAL = positif(PCSAL) * positif(NMAJCSAL1) * LIG2 ;

ZIGPENACSAL4 = positif(PCSAL) * positif(NMAJCSAL4) * LIG2 ;

ZIGNR30CSAL = positif(ZIGPENACSAL4) * LIG2 ;


ZIG17281G = positif(PGAIN) * positif(NMAJGAIN1) * LIG2 ;

ZIGPENAGAIN = positif(PGAIN) * positif(NMAJGAIN1) * LIG2 ;

ZIGPENAGAIN4 = positif(PGAIN) * positif(NMAJGAIN4) * LIG2 ;

ZIGNR30GAIN = positif(ZIGPENAGAIN4) * LIG2 ;


ZIGPENACDIS = positif(PCDIS) * positif(NMAJCDIS1) * LIG2 ;

ZIGPENAGLO1 = positif(PGLOA) * positif(NMAJGLO1) * LIG2 ;

ZIGPENARSE1 = positif(PRSE1) * positif(NMAJRSE11) * LIG2 ;
ZIGPENARSE2 = positif(PRSE2) * positif(NMAJRSE21) * LIG2 ;
ZIGPENARSE3 = positif(PRSE3) * positif(NMAJRSE31) * LIG2 ;
ZIGPENARSE4 = positif(PRSE4) * positif(NMAJRSE41) * LIG2 ;
ZIGPENARSE5 = positif(PRSE5) * positif(NMAJRSE51) * LIG2 ;

ZIGPENACDIS4 = positif(PCDIS) * positif(NMAJCDIS4) * LIG2 ;

ZIGPENAGLO4 = positif(PGLOA) * positif(NMAJGLO4) * LIG2 ;

ZIGPENARSE14 = positif(PRSE1) * positif(NMAJRSE14) * LIG2 ;
ZIGPENARSE24 = positif(PRSE2) * positif(NMAJRSE24) * LIG2 ;
ZIGPENARSE34 = positif(PRSE3) * positif(NMAJRSE34) * LIG2 ;
ZIGPENARSE44 = positif(PRSE4) * positif(NMAJRSE44) * LIG2 ;
ZIGPENARSE54 = positif(PRSE5) * positif(NMAJRSE54) * LIG2 ;

regle 117350:
application : batch, iliad;
ZIG_PENAMONT = positif(PCSG + PRDS + PPRS + PCVN) * LIG2 ;
regle 117360:
application : batch, iliad;
ZIG_CRDETR = positif(CICSG + CIRDS + CIPRS) * LIG2 ;

regle 117380 :
application : batch , iliad ;

ZIGCSALPROV = positif(CSALPROV) * TYPE2 ;

ZIGGAINPROV = positif(GAINPROV) * TYPE2 ;

ZIGCDISPROV = positif(CDISPROV) * TYPE2 ;

ZIGREVXA = positif(REVCSXA) * TYPE2 ;

ZIGREVXB = positif(REVCSXB) * TYPE2 ;

ZIGREVXC = positif(REVCSXC) * TYPE2 ;

ZIGREVXD = positif(REVCSXD) * TYPE2 ;

ZIGREVXE = positif(REVCSXE) * TYPE2 ;

ZIGPROVYD = positif(CSPROVYD) * TYPE2 ;
ZIGPROVYE = positif(CSPROVYE) * TYPE2 ;
ZIGPROVYF = positif(CSPROVYF) * TYPE2 ;
ZIGPROVYG = positif(CSPROVYG) * TYPE2 ;
ZIGPROVYH = positif(CSPROVYH) * TYPE2 ;
regle 117390 :
application : batch , iliad ;

ZIG_CTRIANT = positif(V_ANTCR) * TYPE2 ;

ZIGCSANT = positif(V_CSANT) * TYPE2 ;

ZIGRDANT = positif(V_RDANT) * TYPE2 ;

ZIGPSANT = positif(V_PSANT) * TYPE2 ;

ZIGCVNANT = positif(V_CVNANT) * TYPE2 ;

ZIGCSALANT = positif(V_CSALANT) * TYPE2 ;

ZIGAINANT = positif(V_GAINSALANT) * TYPE2 ;

ZIGCDISANT = positif(V_CDISANT) * TYPE2 ;

ZIGLOANT = positif(V_GLOANT) * TYPE2 ;

ZIGRSE1ANT = positif(V_RSE1ANT) * TYPE2 ;
ZIGRSE2ANT = positif(V_RSE2ANT) * TYPE2 ;
ZIGRSE3ANT = positif(V_RSE3ANT) * TYPE2 ;
ZIGRSE4ANT = positif(V_RSE4ANT) * TYPE2 ;
ZIGRSE5ANT = positif(V_RSE5ANT) * TYPE2 ;
regle 117410:
application : batch, iliad ;

ZIG_CTRIPROV = positif(PROVCVNSAL + PRSPROV + CSGIM + CRDSIM) * LIG2 ;

ZIG_CONTRIBPROV_A = positif(PRSPROV_A + CSGIM_A + CRDSIM_A) * LIG2 ;

regle 117430:
application : batch, iliad;
IND_COLC = positif(BCSG) * positif(PCSG + CICSG + CSGIM) * (1 - INDCTX) ;

IND_COLR = positif(BRDS) * positif(PRDS + CIRDS + CRDSIM) * (1 - INDCTX) ;

IND_COLP = positif(BPRS) * positif(PPRS + CIPRS + PRSPROV) * (1 - INDCTX) ;

INDCOLVN = positif(BCVNSAL) * positif(PCVN + PROVCVNSAL) * (1 - INDCTX) ;

INDCOL = positif(IND_COLC + IND_COLR + IND_COLP + INDCOLVN) ;

IND_COLS = positif(BGAINSAL) * positif(PGAIN + GAINPROV) * (1 - INDCTX) ;

INDCOLS = positif(BCSAL) * positif(PCSAL + CSALPROV) * (1 - INDCTX) ;

IND_COLD = positif(BCDIS) * positif(PCDIS + CDISPROV) * (1 - INDCTX) ;

INDGLOA = positif(BGLOA) * positif(PGLOA) * (1 - INDCTX) ;

INDRSE1 = positif(BRSE1) * positif(PRSE1 + CIRSE1 + CSPROVYD) * (1 - INDCTX) ;
INDRSE2 = positif(BRSE2) * positif(PRSE2 + CIRSE2 + CSPROVYF) * (1 - INDCTX) ;
INDRSE3 = positif(BRSE3) * positif(PRSE3 + CIRSE3 + CSPROVYG) * (1 - INDCTX) ;
INDRSE4 = positif(BRSE4) * positif(PRSE4 + CIRSE4 + CSPROVYH) * (1 - INDCTX) ;
INDRSE5 = positif(BRSE5) * positif(PRSE5 + CIRSE5 + CSPROVYE) * (1 - INDCTX) ;

IND_CTXC = positif(CS_DEG) * positif(BCSG) * positif(INDCTX) ;

IND_CTXR = positif(CS_DEG) * positif(BRDS) * positif(INDCTX) ;

IND_CTXP = positif(CS_DEG) * positif(BPRS) * positif(INDCTX) ;

IND_CTXS = positif(CS_DEG) * positif(BGAINSAL) * positif(INDCTX) ;

INDCTXS = positif(CS_DEG) * positif(BCSAL) * positif(INDCTX) ;

IND_CTXD = positif(CS_DEG) * positif(BCDIS) * positif(INDCTX) ;

INDRSE1X = positif(CS_DEG) * positif(BRSE1) * positif(INDCTX) ;
INDRSE2X = positif(CS_DEG) * positif(BRSE2) * positif(INDCTX) ;
INDRSE3X = positif(CS_DEG) * positif(BRSE3) * positif(INDCTX) ;
INDRSE4X = positif(CS_DEG) * positif(BRSE4) * positif(INDCTX) ;
INDRSE5X = positif(CS_DEG) * positif(BRSE5) * positif(INDCTX) ;
INDTRAIT = null(5 - V_IND_TRAIT) ;

INDT = positif(IND_COLC + IND_COLR + IND_COLP + IND_COLS + IND_CTXC + IND_CTXR + IND_CTXP + IND_CTXS) 
	* INDTRAIT ;

INDTS = positif(INDCOLS + INDCTXS) * INDTRAIT ;

INDTD = positif(IND_COLD + IND_CTXD) * INDTRAIT ;

INDE1 = positif(INDRSE1 + INDRSE1X) * INDTRAIT ;
INDE2 = positif(INDRSE2 + INDRSE2X) * INDTRAIT ;
INDE3 = positif(INDRSE3 + INDRSE3X) * INDTRAIT ;
INDE4 = positif(INDRSE4 + INDRSE4X) * INDTRAIT ;
INDE5 = positif(INDRSE5 + INDRSE5X) * INDTRAIT ;

regle 117440:
application : batch, iliad;
ZIG_NETAP =  positif (BCSG  + BRDS + BPRS + BCVNSAL + BGAINSAL + BCSAL + BCDIS + BGLOA + BRSE1 + BRSE2 + BRSE3 + BRSE4 + BRSE5)
             * (1 - positif(CS_DEG))
             * LIG2 ;
regle 117450:
application : batch, iliad;
ZIG_TOTDEG = positif (CRDEG) * positif(INDCTX) ;

ZIG_TITREP = ZIG_NETAP + ZIG_TOTDEG ;

ZIGANNUL = positif(INDCTX) * positif(ANNUL2042) ;

regle 117490:
application : batch, iliad ;

ZIG_INF8 = positif (CS_DEG) * positif (SEUIL_8 - CS_DEG) * LIG2 ;

regle 117660:
application : batch, iliad;
ZIG_REMPLACE  = positif((1 - positif(20 - V_NOTRAIT)) 
               * positif(V_ANREV - V_0AX)
               * positif(V_ANREV - V_0AZ)
               * positif(V_ANREV - V_0AY) + positif(V_NOTRAIT - 20))
               * LIG2 ;
regle 117710:
application : batch, iliad;
ZIG_DEGINF61 = positif(V_CSANT+V_RDANT+V_PSANT+V_GAINSALANT+0)  
               * positif(CRDEG+0)
               * positif(SEUIL_61-TOTCRA-CSNET-RDNET-PRSNET-CSALNET-CDISNET+0)
               * (1 - null(CSTOT+0))
               * LIG2 ;
regle 117820:
application : batch , iliad ;

ZIG_CSGDDO = positif(V_IDANT - DCSGD) * positif(IDCSG) * LIG2 ;

ZIG_CSGDRS = positif(V_CSANT + V_RDANT + V_PSANT + V_IDANT) * positif(DCSGD - V_IDANT) * positif(IDCSG)
              * LIG2 ;

ZIG_CSGDCOR = positif(ZIG_CSGDDO + ZIG_CSGDRS) * LIG2 ;
regle 117822:
application : batch , iliad ;

ZIGLODD = positif(V_GLOANT - IDGLO) * positif(IDGLO) * LIG2 ;

ZIGLORS = positif(V_GLOANT) * positif(IDGLO - V_GLOANT) * positif(IDGLO) * LIG2 ;

ZIGLOCOR = positif(ZIGLODD + ZIGLORS) * LIG2 ;

ZIGRSEDD = positif(V_RSE1ANT + V_RSE2ANT + V_RSE3ANT + V_RSE4ANT + V_RSE5ANT - IDRSE) * positif(IDRSE) * LIG2 ;

ZIGRSERS = positif(V_RSE1ANT + V_RSE2ANT + V_RSE3ANT + V_RSE4ANT + V_RSE5ANT) 
	    * positif(IDRSE - (V_RSE1ANT + V_RSE2ANT + V_RSE3ANT + V_RSE4ANT + V_RSE5ANT)) * positif(IDRSE) * LIG2 ;

ZIGRSECOR = positif(ZIGRSEDD + ZIGRSERS) * LIG2 ;

regle 117850:
application : batch, iliad;
ZIG_PRIM = positif(NAPCR) * LIG2 ;
regle 117130:
application : batch, iliad;

CS_BPCOS = RDNCP ;
RD_BPCOS = CS_BPCOS ;
PS_BPCOS = CS_BPCOS ;

ZIG_BPCOS = positif(CS_BPCOS + RD_BPCOS + PS_BPCOS) * (1 - V_CNR) * LIG1 * LIG2 ;

regle 117801:
application : batch , iliad ;

ANCSDED2 = (V_ANCSDED * (1 - null(933 - V_ROLCSG)) + (V_ANCSDED + 1) * null(933 - V_ROLCSG)) * positif(V_ROLCSG + 0)
           + V_ANCSDED * (1 - positif(V_ROLCSG + 0)) ;

ZIG_CSGDPRIM = (1 - positif(V_CSANT + V_RDANT + V_PSANT + V_IDANT)) * positif(IDCSG) * LIG2 ;

ZIG_CSGD99 = ZIG_CSGDPRIM ;

ZIGIDGLO = positif(IDGLO) * LIG2 ;

ZIGIDRSE = positif(IDRSE) * LIG2 ;

regle 113530:
application : batch, iliad ;
LIG_SURSIS = positif(PVSURSI + PVSURSIWF + SURIMP + PVIMPOS + PVSURSIWG) * LIG1 * LIG2 ;
regle 113531:
application : batch, iliad;
LIG_CORRECT = positif_ou_nul(IBM23) * INDREV1A8 * LIG1 * LIG2 ;
regle 113532:
application : batch, iliad;
LIG_R8ZT = positif(V_8ZT) * LIG1 * LIG2 ;
regle 113533:
application : batch , iliad ;
                 
LIGTXMOYPOS = present(RMOND) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG1 * LIG2 ;

LIGTXMOYNEG = positif(DMOND) * (1 - positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55))) * LIG1 * LIG2 ;

LIGTXPOSYT = present(RMOND) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG1 * LIG2 ;

LIGTXNEGYT = positif(DMOND) * positif((CMAJ + 0) dans (3,4,5,6,8,11,31,55)) * LIG1 * LIG2 ;

regle 114000:
application : batch , iliad ;
                 
LIGAMEETREV = positif(INDREV1A8) * LIG1 * LIG2 ;
regle 114100:
application : batch , iliad ;
LIG_SAL = positif_ou_nul(TSHALLOV + TSHALLOC + TSHALLOP) * positif_ou_nul(ALLOV + ALLOC + ALLOP) * LIG0  * LIG2 ;

LIG_REVASS = positif_ou_nul(ALLOV + ALLOC + ALLOP) * positif_ou_nul(TSHALLOV + TSHALLOC + TSHALLOP) * LIG0  * LIG2 ;

LIG_SALASS = positif(TSBNV + TSBNC + TSBNP + F10AV + F10AC + F10AP 
		     + null(ALLOV + ALLOC + ALLOP) * null(TSHALLOV + TSHALLOC + TSHALLOP)) 
	       * LIG0 * LIG2 ;

LIG_GATASA = positif_ou_nul(BPCOSAV + BPCOSAC + GLDGRATV + GLDGRATC) * LIG0 * LIG2 ;

LIGF10V = positif(F10AV + F10BV) * LIG0 * LIG2 ;

LIGF10C = positif(F10AC + F10BC) * LIG0 * LIG2 ;

LIGF10P = positif(F10AP + F10BP) * LIG0 * LIG2 ;
regle 114300:
application : iliad,batch;
                 
LIGMIBNPNEG = positif((MIBNPRV+MIBNPRC+MIBNPRP+MIB_NETNPCT) * (-1)) * LIG2 ;

LIGMIBNPPOS = positif(MIBNPRV+MIBNPRC+MIBNPRP+MIB_NETNPCT) * (1 - positif(LIG_BICNPF)) * LIG2 ;

LIG_MIBP = positif(somme(i=V,C,P:MIBVENi) + somme(i=V,C,P:MIBPRESi) + abs(MIB_NETCT) + 0) * (1 - null(4 - V_REGCO)) ;
regle 114400:
application : iliad,batch;
                 
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
		     )) * LIG2 ;
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
		     )) * LIG2 ;
regle 114500:
application : batch , iliad;
LIGRCMABT = positif(present(RCMABD) + present(RCMTNC)
                    + present(RCMHAD) + present(RCMHAB) + present(RCMAV) + present(REGPRIV) 
		    + present(RCMFR) + present(DEFRCM) + present(DEFRCM2) + present(DEFRCM3)
		    + present(DEFRCM4) + present(DEFRCM5) + present(DEFRCM6))
             * (1 - positif(IPVLOC)) * LIG1 * LIG2 * positif(INDREV1A8IR) ;

LIG2RCMABT = positif(present(REVACT) + present(REVPEA) + present(PROVIE) + present(DISQUO) + present(RESTUC) + present(INTERE)) 
		* (1 - positif(IPVLOC)) * LIG1 * LIG2 * positif(INDREV1A8IR) ;
regle 114909:
application : batch, iliad;

LIGTXMOYIMP = positif(TXMOYIMP) * (1 - positif(V_CNR))
	       * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO) 
                              + positif(present(NRINET) + present(NRBASE) + present(IMPRET) + present(BASRET))))
               * IND_REV * LIG2 * positif(20 - V_NOTRAIT) * (1 - LIGPS) ;

LIGTXMOYIMPC = positif(TXMOYIMP) * (1 - positif(V_CNR))
	        * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO) 
                               + positif(present(NRINET) + present(NRBASE) + present(IMPRET) + present(BASRET))))
                * IND_REV * LIG2 * positif(V_NOTRAIT - 20) * (1 - LIGPS) ;

LIGTXMOYPS = positif(TXMOYIMP) * (1 - positif(V_CNR))
	       * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO) 
                              + positif(present(NRINET) + present(NRBASE) + present(IMPRET) + present(BASRET))))
               * IND_REV * LIG2 * positif(20 - V_NOTRAIT) * LIGPS ;
regle 114600:
application : iliad, batch;
LIGACHTOUR = positif(INVLOCNEUF) * LIG1 ;

LIGTRATOUR = positif(INVLOCT1 + INVLOCT2 + INVLOCT1AV + INVLOCT2AV + INVLOCXX + INVLOCXZ) * LIG1 ;

LIGREPTOUR = positif(REPINVLOCINV + RINVLOCINV + REPINVTOU + INVLOCXN) * LIG1 ;

LIGLOCHOTR = positif(INVLOCHOTR1 + INVLOCHOTR + INVLOGHOT) * LIG1 ;

LIGLOGRES = positif(INVLOCRES) * LIG1 ;

LIGLOGDOM = positif(DLOGDOM) * LIG1 * LIG2 ;

LIGLOGSOC = positif(DLOGSOC) * LIG1 * LIG2 ;

LIGDOMSOC1 = positif(DDOMSOC1) * LIG1 * LIG2 ;

LIGLOCENT = positif(DLOCENT) * LIG1 * LIG2 ;

LIGCOLENT = positif(DCOLENT) * LIG1 * LIG2 ;

LIGREPHA  = positif(REPINVLOCREA + RINVLOCREA + INVLOGREHA + INVLOCXV) * LIG1 * LIG2 ;

regle 114700:
application : iliad, batch ;
LIGCICA = positif(BAILOC98) * LIG1 * LIG2 ;
LIGCIGARD = positif(DGARD) * LIG1 * LIG2 ;
LIGPRETUD = positif(PRETUD+PRETUDANT) * LIG1 * LIG2 ;
LIGSALDOM = present(CREAIDE) * LIG1 * LIG2 ;
LIGHABPRIN = positif(present(PREHABT) + present(PREHABT1) + present(PREHABT2) 
	    + present(PREHABTN) + present(PREHABTN1) + present(PREHABTN2) + present(PREHABTVT)) 
		      * LIG1 * LIG2 ;
LIGDEVDUR = positif(DDEVDUR) * LIG1 * LIG2 ;
LIGDDUBAIL = positif(DEPENV) * LIG1 * LIG2 ;

LIGREDAGRI = positif(DDIFAGRI) * LIG1 * LIG2 ;
LIGFORET = positif(DFORET) * LIG1 * LIG2 ;
LIGCOTFOR = positif(DCOTFOR) * LIG1 * LIG2 ; 

LIGFOREST = positif(REPBON + REPFOREST + REPFOREST2 + REPEST) * LIG1 * LIG2 * (1 - V_CNR) ;
LIGREPBON = positif(REPBON) * LIG1 * LIG2 * (1 - V_CNR) ;
LIGREPFOR = positif(REPFOREST) * LIG1 * LIG2 * (1 - V_CNR) ;
LIGREPFOR2 = positif(REPFOREST2) * LIG1 * LIG2 * (1 - V_CNR) ;
LIGREPEST = positif(REPEST) * LIG1 * LIG2 * (1 - V_CNR) ;
LIGNFOREST = positif(REPSIN + REPFORSIN + REPFORSIN2 + REPNIS) * LIG1 * LIG2 ;
LIGREPSIN = positif(REPSIN) * LIG1 * LIG2 ;
LIGSINFOR = positif(REPFORSIN) * LIG1 * LIG2 ;
LIGSINFOR2 = positif(REPFORSIN2) * LIG1 * LIG2 ;
LIGREPNIS = positif(REPNIS) * LIG1 * LIG2 ;

LIGFIPC = positif(DFIPC) * LIG1 * LIG2 ;
LIGFIPDOM = positif(DFIPDOM) * LIG1 * LIG2 ;
LIGCINE = positif(DCINE) * LIG1 * LIG2 ;
LIGCITEC = positif(DTEC) * LIG1 * LIG2 ;
LIGRIRENOV = positif(DRIRENOV) * LIG1 * LIG2 ;
LIGREPAR = positif(NUPROPT) * LIG1 * LIG2 ;
LIGREPREPAR = positif(REPNUREPART) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 * (1 - V_CNR) ;
LIGREPAR12 = positif(REPAR12) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 * (1 - V_CNR) ;
LIGREPARN = positif(REPAR) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 * (1 - V_CNR) ;
LIGREPAR1 = positif(REPAR1) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 * (1 - V_CNR) ;
LIGREPAR2 = positif(REPAR2) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 * (1 - V_CNR) ;
LIGRESTIMO = (present(RIMOPPAUANT) + present(RIMOSAUVANT) + present(RESTIMOPPAU) + present(RESTIMOSAUV) + present(RIMOPPAURE) + present(RIMOSAUVRF)) 
	      * LIG1 * LIG2 ;
LIGRSA = positif(PPERSATOT) * positif(PPETOT) * LIG1 * LIG2 ;

LIGRLOCIDFG = positif(LOCMEUBID + LOCMEUBIF + LOCMEUBIG) * positif(RLOCIDFG1 + RLOCIDFG2 + RLOCIDFG3 + RLOCIDFG4 + RLOCIDFG5 + RLOCIDFG6 + RLOCIDFG7 + RLOCIDFG8)
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGREPLOCIE = positif(LOCMEUBIE) * positif(REPLOCIE1 + REPLOCIE2 + REPLOCIE3 + REPLOCIE4 + REPLOCIE5 + REPLOCIE6 + REPLOCIE7 + REPLOCIE8)
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGNEUV = positif(LOCRESINEUV + INVNPROF1 + INVNPROF2) * positif(RESINEUV1 + RESINEUV2 + RESINEUV3 + RESINEUV4 + RESINEUV5 + RESINEUV6 + RESINEUV7 + RESINEUV8) 
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGRNEUV = positif(MEUBLENP) * positif(RRESINEUV1 + RRESINEUV2 + RRESINEUV3 + RRESINEUV4 + RRESINEUV5 + RRESINEUV6 + RRESINEUV7 + RRESINEUV8) 
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGVIEU = positif(RESIVIEU) * positif(RESIVIEU1 + RESIVIEU2 + RESIVIEU3 + RESIVIEU4 + RESIVIEU5 + RESIVIEU6 + RESIVIEU7 + RESIVIEU8) 
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGVIAN = positif(RESIVIANT) * positif(RESIVIAN1 + RESIVIAN2 + RESIVIAN3 + RESIVIAN4 + RESIVIAN5 + RESIVIAN6 + RESIVIAN7 + RESIVIAN8) 
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGMEUB = positif(VIEUMEUB) * positif(RESIMEUB1 + RESIMEUB2 + RESIMEUB3 + RESIMEUB4 + RESIMEUB5 + RESIMEUB6 + RESIMEUB7 + RESIMEUB8)
	     * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGREPLOCNT = positif(REPLOCNT) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGRESIREP = positif(REPLOCIZ + REPRESINEUV) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPLOCIZ = positif(REPLOCIZ) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPLOCIJ = positif(REPRESINEUV) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGREPMEU = positif(REPINVRED + REPLOCIH + REPLOCN1) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPINV = positif(REPINVRED) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPLOCIH = positif(REPLOCIH) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPLOC1 = positif(REPLOCN1) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGREPNEUV = positif(MEUBLERED + REPREDREP + REPLOCIX + REPLOCN2) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPRED = positif(MEUBLERED) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPRESI = positif(REPREDREP) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPLOCIX = positif(REPLOCIX) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGREPLOC2 = positif(REPLOCN2) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

regle 114750:
application : iliad, batch ;
LIGCREAT = positif(DCREAT + DCREATHANDI) * LIG1 * LIG2 ;
LIGCREFAM = positif(CREFAM) * LIG1 * LIG2 ;
LIGCREAPP = positif(CREAPP) * LIG1 * LIG2 ;
LIGCREBIO = positif(CREAGRIBIO) * LIG1 * LIG2 ;
LIGPRESINT = positif(PRESINTER) * LIG1 * LIG2 ;
LIGCREPROSP = positif(CREPROSP) * LIG1 * LIG2 ;
LIGCREFORM = positif(CREFORMCHENT) * LIG1 * LIG2 ;
LIGINTER = positif(CREINTERESSE) * LIG1 * LIG2 ;
LIGMETART = positif(CREARTS) * LIG1 * LIG2 ;
LIGCONGA = positif(CRECONGAGRI) * LIG1 * LIG2 ;
LIGRESTAU = positif(CRERESTAU) * LIG1 * LIG2 ;
LIGTABAC = positif(CIDEBITTABAC) * LIG1 * LIG2 ;
LIGLOYIMP = positif(LOYIMP) * LIG1 * LIG2 ;

LIGREDMEUB = positif(DREDMEUB) * LIG1 * LIG2 ;
LIGREDREP = positif(DREDREP) * LIG1 * LIG2 ;
LIGILMIX = positif(DILMIX) * LIG1 * LIG2 ;
LIGINVRED = positif(DINVRED) * LIG1 * LIG2 ;
LIGILMIH = positif(DILMIH) * LIG1 * LIG2 ;
LIGILMIZ = positif(DILMIZ) * LIG1 * LIG2 ;
LIGMEUBLE = positif(DMEUBLE) * LIG1 * LIG2 ;
LIGPROREP = positif(DPROREP) * LIG1 * LIG2 ;
LIGREPNPRO = positif(DREPNPRO) * LIG1 * LIG2 ;
LIGMEUREP = positif(DREPMEU) * LIG1 * LIG2 ;
LIGILMIC = positif(DILMIC) * LIG1 * LIG2 ;
LIGILMIB = positif(DILMIB) * LIG1 * LIG2 ;
LIGILMIA = positif(DILMIA) * LIG1 * LIG2 ;

LIGRESIMEUB = positif(DRESIMEUB) * LIG1 * LIG2 ;
LIGRESIVIEU = positif(DRESIVIEU) * LIG1 * LIG2 ;
LIGRESINEUV = positif(DRESINEUV) * LIG1 * LIG2 ;
LIGLOCIDEFG = positif(DLOCIDEFG) * LIG1 * LIG2 ;

LIGVERSLIB = positif(AUTOVERSLIB) * LIG1 * LIG2 ;

regle 114800:
application : iliad, batch ;
pour i=V,C,P:
PPESAISITPi = positif(PPEACi* positif(abs(PPERPROi)));

pour i=V,C,P:
PPESAISINBJi = positif(PPENJi* positif(abs(PPERPROi)));

INDPPEV = positif(   PPETPV*PPESALVTOT
                   + PPENHV*PPESALVTOT
                   + positif(
                              present ( BPCOSAV  )
                            + present ( GLDGRATV )
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
                            + present ( GLDGRATV ) 
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

TYPEPPE  =  (1-null(2-V_REGCO)) * (1-null(4-V_REGCO)) * LIG0 * LIG2 ;

LIGPPEVCP = (positif(INDPPEV) * positif(INDPPEC) * positif(INDPPEP)) * TYPEPPE ;

LIGPPEV = (positif(INDPPEV) * null(INDPPEC) * null(INDPPEP)) * TYPEPPE ;
LIGPPEVC = (positif(INDPPEV) * positif(INDPPEC) * null(INDPPEP)) * TYPEPPE ;
LIGPPEVP = (positif(INDPPEV) * null(INDPPEC) * positif(INDPPEP)) * TYPEPPE ;

LIGPPEC = (null(INDPPEV) * positif(INDPPEC) * null(INDPPEP)) * TYPEPPE ;
LIGPPECP = (null(INDPPEV) * positif(INDPPEC) * positif(INDPPEP)) * TYPEPPE ;

LIGPPEP = (null(INDPPEV) * null(INDPPEC) * positif(INDPPEP)) * TYPEPPE ;

INDLIGPPE = positif(LIGPPEVCP + LIGPPEV + LIGPPEVC + LIGPPEVP + LIGPPEC + LIGPPECP + LIGPPEP)
	     * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

LIGPASPPE = INDLIGPPE * null(PPETOT) ;

regle 114850:
application : iliad, batch;
LIGTAXASSUR = positif(present(CESSASSV) + present(CESSASSC)) * LIG1 ;
LIGTAXASSURV = present(CESSASSV) * LIG1 ;
LIGTAXASSURC = present(CESSASSC) * LIG1 ;

LIGIPCAP = positif(present(PCAPTAXV) + present(PCAPTAXC)) * LIG1 ;
LIGIPCAPV = present(PCAPTAXV) * LIG1 ;
LIGIPCAPC = present(PCAPTAXC) * LIG1 ;

LIGITAXLOY = present(LOYELEV) * LIG1 ;

LIGIHAUT = positif(CHRAVANT) * (1 - positif(TEFFHRC)) * LIG1 ;

LIGHRTEFF = positif(CHRTEFF) * positif(TEFFHRC) * LIG1 ;

regle 1149000:
application : iliad, batch;
LIGPIPPE = positif (PPETOT) * LIG0;
regle 1149001:
application : iliad, batch;
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
application : iliad, batch;
TPLEINSALV = positif(PPETPV  * PPESALVTOT + positif(PPENHV - 1820)
                    + PPESALVTOT * INDLIGPPE * (1 - positif(LIGPPEHV))
                    + positif(PPEPRIMEVT) * positif(PPETOT) 
                     * positif(PPESALV) * (1 - positif(LIGPPEHV)) 
                    + positif(PPESALV) * (1 - positif(LIGPPEHV)))
                    * INDPPEV
                    * positif(INDLIGPPE) * LIG0 * LIG2 ;

TPLEINSALC = positif(  PPETPC*PPESALCTOT
                    + PPESALCTOT * INDLIGPPE * (1 - positif(LIGPPEHC))
                     + positif(PPENHC - 1820)
                    + positif(PPEPRIMECT) * positif(PPETOT) 
                     * positif(PPESALC) * (1 - positif(LIGPPEHC)) 
                     +positif(PPESALC) * (1 - positif(LIGPPEHC)))
                    * INDPPEC
                    * positif(INDLIGPPE) * LIG0 * LIG2 ;

TPLEINSALP = positif((PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4) * PPESALPTOT
              + positif(PPENHP1 - 1820) + positif(PPENHP2 - 1820)
              + positif(PPENHP3 - 1820) + positif(PPENHP4 - 1820) 
                    + PPESALPTOT * INDLIGPPE * (1 - positif(LIGPPEHP))
                    + positif(PPEPRIMEPT) * positif(PPETOT) 
                     * positif(PPESALPTOT) * (1 - positif(LIGPPEHP)) 
                    +positif(PPESALPTOT) * (1 - positif(LIGPPEHP)))
              * INDPPEP
              * positif(INDLIGPPE) * LIG0 * LIG2 ;

TPLEINNSALV = positif(positif(PPEACV + positif(PPENJV - 360)
               + positif(positif(1-null(PPE_AVRPRO1V+0))
                * positif(positif(PPETOT) + positif(PPEREVSALV))
                      * positif(abs(PPERPROV)))
               * (1 - positif(LIGPPEJV))) * positif(INDLIGPPE)
               + positif(PPESAISITPV) * positif(PPEACV))
               * INDPPEV
               * LIG0 * LIG2 ;

TPLEINNSALC = positif(positif(PPEACC + positif(PPENJC - 360) 
               + positif(positif(1-null(PPE_AVRPRO1C+0))
                * positif(positif(PPETOT) + positif(PPEREVSALC))
                      * positif(abs(PPERPROC)))
               * (1 - positif(LIGPPEJC)))* positif(INDLIGPPE)
               + positif(PPESAISITPC) * positif(PPEACC))
               * INDPPEC
               * LIG0 * LIG2 ; 

TPLEINNSALP =positif(positif(PPEACP + positif(PPENJP - 360) 
              + positif(positif(1 - null(PPE_AVRPRO1P+0))
               * positif(positif(PPETOT) + positif(PPEREVSALP))
                      * positif(abs(PPERPROP)))
              * (1 - positif(LIGPPEJP)))* positif(INDLIGPPE)
              + positif(PPESAISITPP) * positif(PPEACP))
              * INDPPEP
              * LIG0 * LIG2 ;
regle 114902:
application : iliad, batch;
LIGPPENSV = positif(positif(positif(1 - null(PPE_AVRPRO1V+0)) 
              * positif(positif(PPETOT) + positif(PPEREVSALV))
                     * positif(INDLIGPPE))
                    + positif(PPESAISITPV + PPESAISINBJV))
                   * INDPPEV
                   * LIG0 * LIG2 ;

LIGPPENSC = positif(positif(positif(1 - null(PPE_AVRPRO1C+0))
              * positif(positif(PPETOT) + positif(PPEREVSALC))
                   * positif(INDLIGPPE))
                    + positif(PPESAISITPC + PPESAISINBJC))
                   * INDPPEC
                   * LIG0 * LIG2 ;

LIGPPENSP = positif(positif(positif(1-null(PPE_AVRPRO1P+0)) 
              * positif(positif(PPETOT) + positif(PPEREVSALP))
                   * positif(INDLIGPPE))
                    + positif(PPESAISITPP + PPESAISINBJP))
                   * INDPPEP
                   * LIG0 * LIG2 ;
regle 114901:
application : iliad,batch;
LIGPPEHV = positif_ou_nul(1820 - PPENHV) * present(PPENHV) 
                        * INDPPEV
                        * positif(INDLIGPPE) * LIG0 * LIG2 ;
LIGPPEHC = positif_ou_nul(1820 - PPENHC) * present(PPENHC) 
                        * INDPPEC
                        * positif(INDLIGPPE) * LIG0 * LIG2 ;
LIGPPEHP = positif(
              positif_ou_nul(1820 - PPENHP1) * present(PPENHP1)  
            + positif_ou_nul(1820 - PPENHP2) * present(PPENHP2)
            + positif_ou_nul(1820 - PPENHP3) * present(PPENHP3)
            + positif_ou_nul(1820 - PPENHP4)  * present(PPENHP4)
                   )
            * INDPPEP
            * positif(INDLIGPPE) * LIG0 * LIG2 ;

LIGPPEJV = positif_ou_nul(360 - PPENJV) * positif(INDLIGPPE) * LIG0 * LIG2  
           * present(PPENJV)  
           * positif(PPENJV) 
           + positif(PPESAISITPV) * positif(PPEACV) ;
LIGPPEJC = positif_ou_nul(360 - PPENJC) * positif(INDLIGPPE) * LIG0 * LIG2 
           * positif(PPENJC)   
           * present(PPENJC)
           + positif(PPESAISITPC) * positif(PPEACC) ;
LIGPPEJP = positif_ou_nul(360 - PPENJP) * positif(INDLIGPPE) * LIG0 * LIG2  
           * positif(PPENJP)  
           * present(PPENJP) 
           + positif(PPESAISITPP) * positif(PPEACP) ;
regle 115100:
application : iliad , batch;
LIGCOMP01 = positif(BPRESCOMP01) * LIG1 * ((V_REGCO+0) dans (1,3,5,6)) * LIG2 ;
regle 115200:
application : iliad, batch;
LIGDEFBA = positif(DEFBA1 + DEFBA2 + DEFBA3 + DEFBA4 + DEFBA5 + DEFBA6) 
	       * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF = positif(BNCDF1 + BNCDF2 + BNCDF3 + BNCDF4 + BNCDF5 + BNCDF6) 
	       * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDEFBA1 = positif(DEFBA1) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDEFBA2 = positif(DEFBA2) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDEFBA3 = positif(DEFBA3) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDEFBA4 = positif(DEFBA4) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDEFBA5 = positif(DEFBA5) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDEFBA6 = positif(DEFBA6) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDFRCM = positif(DFRCMN+DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5) * LIG1 * LIG2 
	    * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDFRCMN = positif(DFRCMN) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDFRCM1 = positif(DFRCM1) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDFRCM2 = positif(DFRCM2) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDFRCM3 = positif(DFRCM3) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDFRCM4 = positif(DFRCM4) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDFRCM5 = positif(DFRCM5) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGDRCVM = positif(DPVRCM) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDRFRP = positif(DRFRP) * LIG1 * (1-null(4-V_REGCO)) * LIG2 ;
LIGDLMRN = positif(DLMRN6 + DLMRN5 + DLMRN4 + DLMRN3 + DLMRN2 + DLMRN1) 
	      * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDLMRN6 = positif(DLMRN6) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDLMRN5 = positif(DLMRN5) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDLMRN4 = positif(DLMRN4) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDLMRN3 = positif(DLMRN3) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDLMRN2 = positif(DLMRN2) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGDLMRN1 = positif(DLMRN1) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF6 = positif(BNCDF6) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF5 = positif(BNCDF5) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF4 = positif(BNCDF4) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF3 = positif(BNCDF3) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF2 = positif(BNCDF2) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGBNCDF1 = positif(BNCDF1) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGIRECR = positif(IRECR) * LIG1 * LIG2 ;

LIGMBDREPNPV = positif(MIBDREPNPV) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGMBDREPNPC = positif(MIBDREPNPC) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGMBDREPNPP = positif(MIBDREPNPP) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;

LIGMIBDREPV = positif(MIBDREPV) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGMIBDREPC = positif(MIBDREPC) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGMIBDREPP = positif(MIBDREPP) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;

LIGSPDREPNPV = positif(SPEDREPNPV) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGSPDREPNPC = positif(SPEDREPNPC) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGSPDREPNPP = positif(SPEDREPNPP) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;

LIGSPEDREPV = positif(SPEDREPV) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGSPEDREPC = positif(SPEDREPC) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGSPEDREPP = positif(SPEDREPP) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;

LIGELURAS = positif(ELURASV) * LIG1 * LIG2 ;
LIGELURASC = positif(ELURASC) * LIG1 * LIG2 ;
LIGREPPLU = positif(REPPLU) * LIG1 * LIG2 ;
LIGSURIMP = positif(SURIMP) * LIG1 * LIG2 ;
LIGPVIMPOS = positif(PVIMPOS) * LIG1 * LIG2 ;
LIGPVSURSI = positif(PVSURSI) * LIG1 * LIG2 ;
LIGPVSURSIF = positif(PVSURSIWF) * LIG1 * LIG2 ;
LIGPVSURSIG = positif(PVSURSIWG) * LIG1 * LIG2 ;
LIGSUR = positif(LIGREPPLU) * positif(LIGPVSURSI + LIGPVSURSIF + LIGSURIMP + LIGPVIMPOS + LIGPVSURSIG) ; 
LIGABDET = positif(GAINABDET) * LIG1 * LIG2 ;
LIGABDETP = positif(ABDETPLUS) * LIG1 * LIG2 ;
LIGABDETM = positif(ABDETMOINS) * LIG1 * LIG2 ;
LIGPVJEUNE = positif(PVJEUNENT) * LIG1 * LIG2 ;

LIGRCMSOC = positif(RCMSOC) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGLIBDIV = positif(RCMLIBDIV) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGRCMIMPAT = positif(RCMIMPAT) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGABIMPPV = positif(ABIMPPV) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGABIMPMV = positif(ABIMPMV) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGOPTCS = (positif(BPVOPTCSV) + positif(BPVOPTCSC))* LIG1 * LIG2 ;
LIGGSAL = positif(CGAINSAL) * LIG1 * LIG2 ;
LIGCVNSAL = positif(CVNSALC) * LIG1 * LIG2 ;
LIGCDIS = positif(GSALV + GSALC) * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;
LIGROBOR = positif(RFROBOR) * LIG1 * LIG2 ;
LIGPVPART = positif(PVPART) * LIG1 * LIG2 ;
LIGPVIMMO = positif(PVIMMO) * LIG1 * LIG2 ;
LIGPVTISOC = positif(PVTITRESOC) * LIG1 * LIG2 ;
LIGMOBNR = positif(PVMOBNR) * LIG1 * LIG2 ;

DEPCHO = (DEPCHOBAS + CRENRJ + CRENRJRNOUV + CRECHOCON2 + CRECHOBOI + CRECHOBAS) * positif(V_NOTRAIT - 10) ;
DEPMOB = (DEPMOBIL + RDGEQ + RDEQPAHA + RDTECH) * positif(V_NOTRAIT - 10) ;
DIFF7WY = positif(abs(DEPCHOBAS - VAR7WY_P) * null(5-V_IND_TRAIT) + DIFF7WY_A);
DIFF7WZ = positif(abs(DEPMOBIL - VAR7WZ_P) * null(5-V_IND_TRAIT) + DIFF7WZ_A);

LIGDEPCHO =         ((positif(DIFF7WY) * positif(DIFF7WZ))
                    +
                    (positif(DIFF7WY) * (1 - positif(DIFF7WZ)))
                    +
                    positif(DIFF7WZ) * (1 - positif(DIFF7WY)) *
                    ((positif(positif(DEPCHOBAS)+positif(CRENRJRNOUV)+positif(CRECHOCON2)
                    +positif(CRENRJ)+positif(CRECHOBOI)+positif(CRECHOBAS)) *
                    positif(positif(DEPMOBIL)+positif(RDGEQ)+positif(RDEQPAHA)+positif(RDTECH)))
                    +
                    (positif(positif(DEPCHOBAS)+positif(CRENRJRNOUV)+positif(CRECHOCON2)
                    +positif(CRENRJ)+positif(CRECHOBOI)+positif(CRECHOBAS)) *
                    (1 - positif(positif(DEPMOBIL)+positif(RDGEQ)+positif(RDEQPAHA)+positif(RDTECH))))))
                    * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;


LIGDEPMOB =        ((positif(DIFF7WY) * positif(DIFF7WZ))
                    +
                    (positif(DIFF7WZ) * (1 - positif(DIFF7WY)) )
                    +
                    positif(DIFF7WY) * (1 - positif(DIFF7WZ)) *
                    ((positif(positif(DEPCHOBAS)+positif(CRENRJRNOUV)+positif(CRECHOCON2)
                    +positif(CRENRJ)+positif(CRECHOBOI)+positif(CRECHOBAS)) *
                    positif(positif(DEPMOBIL)+positif(RDGEQ)+positif(RDEQPAHA)+positif(RDTECH)))
                    +
                    (1 - positif(positif(DEPCHOBAS)+positif(CRENRJRNOUV)+positif(CRECHOCON2)
                    +positif(CRENRJ)+positif(CRECHOBOI)+positif(CRECHOBAS))) *
                    (positif(positif(DEPMOBIL)+positif(RDGEQ)+positif(RDEQPAHA)+positif(RDTECH)))))
                    * LIG1 * LIG2 * ((V_REGCO+0) dans (1,3,5,6)) ;

LIGDEFPLOC = positif(DEFLOC1 + DEFLOC2 + DEFLOC3 + DEFLOC4 + DEFLOC5 + DEFLOC6 + DEFLOC7 + DEFLOC8 + DEFLOC9 + DEFLOC10) 
		 * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC1 = positif(DEFLOC1) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC2 = positif(DEFLOC2) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC3 = positif(DEFLOC3) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC4 = positif(DEFLOC4) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC5 = positif(DEFLOC5) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC6 = positif(DEFLOC6) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC7 = positif(DEFLOC7) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC8 = positif(DEFLOC8) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC9 = positif(DEFLOC9) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
LIGPLOC10 = positif(DEFLOC10) * LIG1 * (1 - null(4-V_REGCO)) * LIG2 ;
regle 115101:
application : batch , iliad;
LIGDCSGD = positif(DCSGD) * null(5 - V_IND_TRAIT) * INDCTX * LIG1 * LIG2 ;

regle 115102:
application :  batch , iliad;
LIGPVETR = positif(present(CIIMPPRO) + present(CIIMPPRO2)) * LIG1 * LIG2 ;

LIGCORSE = positif(present(CIINVCORSE) + present(IPREPCORSE) + present(CICORSENOW)) * LIG1 * LIG2 ;

LIGREPCORSE = positif(REPCORSE) * LIG1 * LIG2 ;

LIGREPRECH = positif(REPRECH) * LIG1 * LIG2 ;

LIGPME = positif(REPINVPME3 + REPINVPME2 + REPINVPME1 + REPINVPME) 
	   * LIG1 * LIG2 * (1 - positif(V_CNR)) 
           * (1 - null(2-V_REGCO)) * (1 - null(4-V_REGCO)) ;

LIGCICAP = present(PRELIBXT) * LIG1 * LIG2 ;

LIGREGCI = present(REGCI) * positif(CICHR) * LIG1 * LIG2 ;

LIGCULTURE = present(CIAQCUL) * LIG1 * LIG2 ;

LIGMECENAT = present(RDMECENAT) * LIG1 * LIG2 ;

regle 115103:
application : batch , iliad;
LIGIBAEX = positif(REVQTOT) * LIG1 * LIG2 
	     * (1 - INDTXMIN) * (1 - INDTXMOY) 
	     * (1 - null(2-V_REGCO) * (1 - LIG1522))
	     * (1 - null(4-V_REGCO)) ;

regle 115105:
application :  iliad, batch;
LIGANNUL2042 = LIG2 * LIG0 ;

regle 115107:
application : batch, iliad ;
LIGTRCT = positif(V_TRCT) ;

regle 115108:
application : batch, iliad ;

LIGVERSUP = positif(AUTOVERSSUP) ;

regle 115109:
application : iliad, batch;

INDRESTIT = positif(IREST + 0) ;

INDIMPOS = positif(null(1 - NATIMP) + 0) ;

regle 666998:
application :  iliad, batch;

AGREPAPER = PALIV + PALIC + PALIP + PENSALV + PENSALC + PENSALP ;

AGREPARET = RPALE + RPALP ; 

AGREPPE = PPETOT ;

AGREDTARDIF = positif(RETIR + RETTAXA + RETPCAP + RETLOY + RETHAUTREV + RETCS + RETRD + RETPS + RETGAIN
		      + RETCSAL + RETCVN + RETCDIS + RETGLOA + RETRSE1 + RETRSE2 + RETRSE3 + RETRSE4 + RETRSE5
		      + (null(V_IND_TRAIT - 4) * null(CMAJ - 7)) + FLAG_RETARD + 0) ;

AGRECI = IRETS + CRDIE2 + ICREREVET + CICAP + CICHR + CIDONENTR + IAVF2 + I2DH + CICULTUR + CIGE + CIDEVDUR
	  + CIDEPENV + CITEC + CICA + CIGARD + CISYND + CIPRETUD + CIADCRE + CIHABPRIN + CREFAM + CREAPP
	  + CREAGRIBIO + CREPROSP + CRESINTER + CREFORMCHENT + CREINTERESSE + CREARTS + CICONGAGRI + CRERESTAU
	  + CIDEBITTABAC + CILOYIMP + AUTOVERSLIB + CICORSEAVIS ;

regle 666999:
application :  iliad, batch;

VTEST01 = positif(DDEVDUR + 0);

VTEST02 = positif(DCREAT + DCREATHANDI + 0) ;

VTEST03 = positif(BGEDECL + 0) ;

VTEST04 = positif(LOYIMP + 0) ;

VTEST05 = positif(present(BIPV) + present(BIPC) + present(BIPP) 
		  + present(DEPLOCV) + present(DEPLOCC) + present(DEPLOCP) + 0)
         + 2 * positif(present(BINV) + present(BINC) + present(BINP)
		       + present(DENPLOCV) + present(DENPLOCC) + present(DENPLOCP) 
		       + TOTDEFLOCNP + DEFNP + 0)
	 + 4 * positif(MIBRV + MIBRC + MIBRP + MIBPVV + MIBPVC + MIBPVP + BICPMVCTV+ BICPMVCTC+ BICPMVCTP 
		       + MIBNPRV + MIBNPRC + MIBNPRP + MIBNPPVV + MIBNPPVC + MIBNPPVP + MIBNPDCT 
		       + MLOCDECV + MLOCDECC + MLOCDECP + 0) ;

VTEST06 = positif(present(BNCV) + present(BNCC) + present(BNCP) + 0) 
         + 2 * positif(present(NOCEPV) + present(NOCEPC) + present(NOCEPP) + DABNCNP + 0)
	 + 4 * positif(BNCPROV + BNCPROC + BNCPROP + BNCPROPVV + BNCPROPVC + BNCPROPVP + BNCPMVCTV 
		       + BNCNPV + BNCNPC + BNCNPP + BNCNPPVV + BNCNPPVC + BNCNPPVP + BNCNPDCT + 0) ;

VTEST07 = positif(PERP_COTV + RACCOTV + PERP_COTC + RACCOTC + PERP_COTP + RACCOTP + PERPIMPATRIE + PERPMUTU + 0) ;

VTEST08 = positif(DREPA + RDFREP + RDFDONETR + 0) + 2 * positif(DDONS + RDFDOU + RDFDAUTRE + 0) ;

VTEST09 = positif(FCPI + 0) ;

VTEST10 = positif(FFIP + 0) + 2 * positif(FIPCORSE + 0) + 4 * positif(FIPDOMCOM + 0) ;

VTEST11 = positif(REGCI + CIIMPPRO + CIIMPPRO2 + IPPNCS + 0) ;

VTEST12 = positif(BPVRCM + DPVRCM + BPV18V + BPCOPTV + BPV40V + BPVKRI + PEA + PVIMPOS + BPVOPTCSV + BPVOPTCSC + GAINSALAV + GAINSALAC + GSALV + GSALC + 0) ;

VTEST13 = positif(DLOGDOM + 0) + 2 * positif(DDOMSOC1 + DLOGSOC + 0) + 4 * positif(DLOCENT + DCOLENT + 0) ;

VTEST14 = positif(COTFORET + DFOREST + 0) ;

VTEST15 = positif(DRESINEUV + DRESIVIEU + DRESIMEUB + DMEUBLE + DREPMEU + DREPNPRO + DPROREP + DREDMEUB + DINVRED + DREDREP + 0) ;

VTEST16 = positif(DTOURNEUF + DTOURTRA + DTOURES + DTOURREP + DTOUHOTR + DTOUREPA + 0) ;

VTEST17 = positif(DCEL + DCELNBGL + DCELCOM + DCELNQ + DCELRREDLA + DCELRREDLB + DCELRREDLC + DCELREPHS + DCELREPHR + DCELREPHU + DCELREPHT
		  + DCELREPHZ + DCELREPHX + DCELREPHW + DCELREPHV + DCELHM + DCELHL + DCELHNO + DCELHJK + 0) ;

VTEST18 = positif(NUPROPT + 0) ;

VTEST19 = positif(PATNAT + PATNAT1 + 0) ;

VTEST20 = positif(PREHAB + 0) ; 

VTEST21 = positif(DRESTIMO + 0) + 2 * positif(RIRENOV + 0) ;

VTEST22 = positif(PCAPTAXV + PCAPTAXC + 0) ;

VTEST23 = positif(CREAIDE + DAIDE + PREMAIDE + INAIDE + 0) ;

VTEST24 = positif(DCINE + 0) ;

regle isf 99902:
application : iliad, batch;
NBLIGNESISF = positif(LIGISFBASE) * 3 
	    + positif(LIGISFDEC) * 3
	    + positif(LIGISFBRUT) * 6 
	    + positif(LIGISFRED) * 2
	    + positif(LIGISFREDPEN8) * 2
	    + positif(LIGISFDON) * 2
	    + positif(LIGISFRAN) 
	    + positif(LIGISFCEE)
	    + positif(LIGISFINV) * 2 
	    + positif(LIGISFPMED)
	    + positif(LIGISFPMEI)
	    + positif(LIGISFIP)
	    + positif(LIGISFCPI)
	    + positif(LIGISFIMPU) * 3
	    + positif(LIGISFPLAF) * 5
	    + positif(LIGISFE) * 3
	    + positif(LIGISFNOPEN) * 1 
	    + positif(LIGISFCOR) * 1
	    + positif(LIGISFRET) * 2 
	    + positif(LIGISF9249) 
	    + positif(LIGNMAJISF1) * 2 
            + positif(LIGISFANT) * 2 
	    + positif(LIGISFNET) * 3
	    + positif(LIGISF9269) * 3 
	    + positif(LIGISFANNUL) * 3 
	    + positif(LIGISFDEG) * 2 
	    + positif(LIGISFDEGR) * 2 
	    + positif(LIGISFZERO) * 3 
	    + positif(LIGISFNMR) * 4 
	    + positif(LIGISFNMRIS) * 3
	    + positif(LIGISF0DEG) * 2 
	    + positif(LIGISFNMRDEG) * 3
	    + positif(LIGISFNMRDEG) * 3 
	    + positif(LIGISFINF8) * 3 
	    + positif(LIGISFNEW) * 2 + 0 ;

LIGNBPAGESISF = positif( NBLIGNESISF - 41 + 0 ) ;

regle isf 99901:
application : iliad, batch;

LIGISF = (1 - positif(ISF_LIMINF + ISF_LIMSUP)) * present(ISFBASE) * positif(DISFBASE) ;

LIG_AVISISF = (1 - positif(ISF_LIMINF + ISF_LIMSUP)) * present(ISFBASE);

INDIS14 = si (  (V_NOTRAIT+0 = 14)
	     ou (V_NOTRAIT+0 = 16)
	     ou (V_NOTRAIT+0 = 26)
	     ou (V_NOTRAIT+0 = 36)
             ou (V_NOTRAIT+0 = 46)
             ou (V_NOTRAIT+0 = 56)
             ou (V_NOTRAIT+0 = 66)
             )
        alors (1)
        sinon (0)
        finsi;

INDIS26 = si (  (V_NOTRAIT+0 = 26)
	     ou (V_NOTRAIT+0 = 36)
             ou (V_NOTRAIT+0 = 46)
             ou (V_NOTRAIT+0 = 56)
             ou (V_NOTRAIT+0 = 66)
             )
        alors (1)
        sinon (0)
        finsi;

INDCTX23 = si (  (V_NOTRAIT+0 = 23)
                 ou (V_NOTRAIT+0 = 33)
		 ou (V_NOTRAIT+0 = 43)
		 ou (V_NOTRAIT+0 = 53)
		 ou (V_NOTRAIT+0 = 63)
             )
	  alors (1)
	  sinon (0)
	  finsi;

IND9HI0 = INDCTX23 * null( 5-V_IND_TRAIT ) * present(ISFBASE);

LIGISFBASE =  LIGISF * (1 - positif(ANNUL2042)) ;

LIGISFDEC = positif(ISF1) * positif(ISFDEC) * LIGISF * (1 - positif(ANNUL2042)) ;

LIGISFBRUT = positif(ISFBRUT) * (1 - positif(ANNUL2042)) * LIGISF * (1-null(5-V_IND_TRAIT))  
	      * positif(ISFDONF + ISFDONEURO + ISFPMEDI + ISFPMEIN + ISFFIP + ISFFCPI)

	    + positif(ISFBRUT) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT)  
	      * positif(present(ISFDONF) + present(ISFDONEURO)
	                + present(ISFPMEDI) + present(ISFPMEIN) + present(ISFFIP) + present(ISFFCPI));

LIGISFRAN = positif(ISFDONF) * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF +
            present(ISFDONF) * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFCEE = positif(ISFDONEURO) * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF +
            present(ISFDONEURO) * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFDON = positif(LIGISFRAN + LIGISFCEE) * LIGISF ;

LIGISFPMED = positif(ISFPMEDI) * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF +
             present(ISFPMEDI) * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFPMEI = positif(ISFPMEIN) * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF +
             present(ISFPMEIN) * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) * LIGISF ;

LIGISFIP = positif(ISFFIP) * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF +
           present(ISFFIP) * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFCPI = positif(ISFFCPI) * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF +
            present(ISFFCPI) * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFINV = positif(LIGISFPMED + LIGISFPMEI + LIGISFIP + LIGISFCPI) * LIGISF ;

LIGISFRED = positif(LIGISFINV + LIGISFDON) * LIGISF 
            * (1 - positif(null ((CODE_2042 + CMAJ_ISF)- 8))) ;

LIGISFREDPEN8 = positif(LIGISFINV + LIGISFDON) * LIGISF 
               * positif(null ((CODE_2042 + CMAJ_ISF)- 8)) ;

LIGISFPLAF = positif( ISFPLAF ) * (1-null(5-V_IND_TRAIT))
	     * LIGISF * (1 - positif(ANNUL2042))
	     + present( ISFPLAF )  * positif(DISFBASE) * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFE = positif(DISFBASE) * positif(ISFETRANG) 
	  * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT)) * LIGISF 
          + positif(DISFBASE) * present(ISFETRANG) 
	  * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT) ;

LIGISFIMPU = positif(DISFBASE) * positif(ISFETRANG+ISFPLAF)
            * (1 - positif (ISFDONF + ISFDONEURO + ISFPMEDI + ISFPMEIN + ISFFIP + ISFFCPI)) 
            * LIGISF * (1 - positif(ANNUL2042)) * (1-null(5-V_IND_TRAIT))
	    + positif(DISFBASE) * positif( present(ISFETRANG) + present(ISFPLAF))
            * (1 - positif (ISFDONF + ISFDONEURO + ISFPMEDI + ISFPMEIN + ISFFIP + ISFFCPI)) 
	    * LIGISF * (1 - positif(ANNUL2042)) * null(5-V_IND_TRAIT)
	    * (1-positif(LIGISFRED + LIGISFREDPEN8));

LIGISFCOR =   present(ISF4BIS)*positif(DISFBASE) * positif(PISF)
               * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF4BIS))) 
	       * (1 - positif(ANNUL2042)) * LIGISF 
	       * (1-positif(V_NOTRAIT-20))
	       + positif(V_NOTRAIT-20) * LIGISF * (1 - positif(ANNUL2042));
	     
LIGISFNOPEN = present(ISF5)*positif(DISFBASE)* (1 - positif(PISF))
		 * (1 - positif(LIGISFCOR))
	         * LIGISF * (1 - positif(ANNUL2042)) ;

LIGISFRET = positif( RETISF) * (1 - positif(ANNUL2042)) * LIGISF 
	    * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF5)));

LIGNMAJISF1 = positif( NMAJISF1) * (1 - positif(ANNUL2042)) * LIGISF 
	      * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF5)));

LIGISF9249 = positif(LIGNMAJISF1) * (1 - positif(LIGISFRET)) ;

LIGISFNET = (positif(PISF)*positif(DISFBASE) * (1-null(5-V_IND_TRAIT))
               * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF5)))
	       * (1 - positif(ANNUL2042)) * LIGISF 
	     + (null(5-V_IND_TRAIT)) * positif(LIGISFRET + LIGNMAJISF1)
	       * positif(ISFNAP) * (1 - positif( SEUIL_12 - ISFNAP)))
	    * (1 - positif(INDCTX23)) ;

LIGISFZERO = null(ISF5) * (1 - positif(ANNUL2042)) * positif(20-V_NOTRAIT) * LIGISF ;


LIGISFNMR = positif( SEUIL_12 - ISF5) * (1 - null(ISF5)) * (1 - positif(INDCTX23))
	    * LIGISF * (1 - positif(ANNUL2042)) ;


LIGISFANT =  positif(V_ANTISF) * positif(V_NOTRAIT-20) ; 

LIGISFDEGR = (null(2- (positif(SEUIL_8 - ISFDEGR) + positif_ou_nul(ISF5-SEUIL_12))) 
              + null(V_ANTISF))
	      * INDCTX23 * null(5-V_IND_TRAIT) * (1 - positif(ANNUL2042)) ;

LIGISFDEG = (1 - positif(LIGISFDEGR)) * IND9HI0 * positif(ISFDEG) ; 

LIGISFNMRDEG = (1 - positif(LIGISFDEGR)) * (1 - null(ISF5))
               * positif(SEUIL_12 - ISF4BIS) * positif(DISFBASE) 
	       * INDCTX23 * null(5-V_IND_TRAIT) * (1 - positif(ANNUL2042)) ; 

LIGISF9269 = (1 - positif(LIGISFRET + LIGNMAJISF1)) * (1 - positif( SEUIL_12 - ISFNAP)) * INDIS26 ;

LIGISFNMRIS = positif(SEUIL_12 - ISFNAP) 
	     * INDIS26 * null(5 - V_IND_TRAIT) * (1 - positif(ANNUL2042)) ;

LIGISF0DEG = IND9HI0 * null(ISF4BIS) * (1 - positif(ANNUL2042)) ;

LIGISFINF8 = IND9HI0 * positif(LIGISFDEGR) * (1 - positif(ANNUL2042)) ;


LIGISFNEW = present(ISFBASE) * (1 - positif(20-V_NOTRAIT)) * null(5 - V_IND_TRAIT) * (1 - positif(ANNUL2042)) ;

LIGISFANNUL = present(ISFBASE) * positif(ANNUL2042) ;

