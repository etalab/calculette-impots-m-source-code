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
regle 901000:
application : iliad ;

CONST0 = 0;
CONST1 = 1;
CONST2 = 2;
CONST3 = 3;
CONST4 = 4;
CONST10 = 10;
CONST20 = 20;
CONST40 = 40;

regle 901010:
application : batch , iliad ;


LIG0 = (1 - positif(RE168 + TAX1649)) * IND_REV ;

LIG01 = (1 - (positif(REVFONC) * (1 - IND_REV8FV))) * (1 - positif(RE168 + TAX1649)) * (1 - positif(ANNUL2042)) * IND_REV ;

LIG1 = (1 - positif(RE168 + TAX1649)) ;

LIG2 = (1 - positif(ANNUL2042)) ;

LIG3 = positif(positif(CMAJ + 0) 
	+ positif_ou_nul(MAJTX1 - 40) + positif_ou_nul(MAJTX4 - 40)
        + positif_ou_nul(MAJTXPCAP1 - 40) + positif_ou_nul(MAJTXPCAP4 - 40)
        + positif_ou_nul(MAJTXLOY1 - 40) + positif_ou_nul(MAJTXLOY4 - 40)
        + positif_ou_nul(MAJTXCHR1 - 40) + positif_ou_nul(MAJTXCHR4 - 40)
	+ positif_ou_nul(MAJTXC1 - 40) + positif_ou_nul(MAJTXC4 - 40) 
        + positif_ou_nul(MAJTXCVN1 - 40) + positif_ou_nul(MAJTXCVN4 - 40)
	+ positif_ou_nul(MAJTXCDIS1 - 40) + positif_ou_nul(MAJTXCDIS4 - 40)
        + positif_ou_nul(MAJTXGLO1 - 40) + positif_ou_nul(MAJTXGLO4 - 40)
        + positif_ou_nul(MAJTXRSE11 - 40) + positif_ou_nul(MAJTXRSE14 - 40)
        + positif_ou_nul(MAJTXRSE51 - 40) + positif_ou_nul(MAJTXRSE54 - 40)
	+ positif_ou_nul(MAJTXRSE21 - 40) + positif_ou_nul(MAJTXRSE24 - 40)
        + positif_ou_nul(MAJTXRSE31 - 40) + positif_ou_nul(MAJTXRSE34 - 40)
        + positif_ou_nul(MAJTXRSE41 - 40) + positif_ou_nul(MAJTXRSE44 - 40)
        + positif_ou_nul(MAJTXRSE61 - 40) + positif_ou_nul(MAJTXRSE64 - 40)
        + positif_ou_nul(MAJTXTAXA4 - 40)) ;

CNRLIG12 = (1 - V_CNR) * LIG1 * LIG2 ;

CNRLIG1 = (1 - V_CNR) * LIG1 ;

regle 901020:
application : batch , iliad ;


LIG0010 = (INDV * INDC * INDP) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG0020 = (INDV * (1 - INDC) * (1 - INDP)) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG0030 = (INDC * (1 - INDV) * (1 - INDP)) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG0040 = (INDP * (1 - INDV) * (1 - INDC)) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG0050 = (INDV * INDC * (1 - INDP)) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG0060 = (INDV * INDP * (1 - INDC)) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG0070 = (INDC * INDP * (1 - INDV)) * (1 - ART1731BIS) * LIG0 * LIG2 ;

LIG10YT = (INDV * INDC * INDP) * ART1731BIS * LIG0 * LIG2 ;

LIG20YT = (INDV * (1 - INDC) * (1 - INDP)) * ART1731BIS * LIG0 * LIG2 ;

LIG30YT = (INDC * (1 - INDV) * (1 - INDP)) * ART1731BIS * LIG0 * LIG2 ;

LIG40YT = (INDP * (1 - INDV) * (1 - INDC)) * ART1731BIS * LIG0 * LIG2 ;

LIG50YT = (INDV * INDC * (1 - INDP)) * ART1731BIS * LIG0 * LIG2 ;

LIG60YT = (INDV * INDP * (1 - INDC)) * ART1731BIS * LIG0 * LIG2 ;

LIG70YT = (INDC * INDP * (1 - INDV)) * ART1731BIS * LIG0 * LIG2 ;

regle 901030:
application : batch , iliad ;


LIG10V = positif_ou_nul(TSBNV + PRBV + BPCOSAV + GLDGRATV + positif(F10AV * null(TSBNV + PRBV + BPCOSAV + GLDGRATV))) ;
LIG10C = positif_ou_nul(TSBNC + PRBC + BPCOSAC + GLDGRATC + positif(F10AC * null(TSBNC + PRBC + BPCOSAC + GLDGRATC))) ;
LIG10P = positif_ou_nul(somme(i=1..4:TSBNi + PRBi) + positif(F10AP * null(somme(i=1..4:TSBNi + PRBi)))) ;
LIG10 = positif(LIG10V + LIG10C + LIG10P) ;

regle 901040:
application : batch , iliad ;

LIG1100 = positif(T2RV) ;

LIG899 = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIGPV3VG + LIGPV3WB + LIGPV3VE 
		  + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * (1 - positif(LIG0010 + LIG0020 + LIG0030 + LIG0040 + LIG0050 + LIG0060 + LIG0070)) 
		 * (1 - ART1731BIS) ; 

LIG900 = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIGPV3VG + LIGPV3WB + LIGPV3VE 
		  + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * positif(LIG0010 + LIG0020 + LIG0030 + LIG0040 + LIG0050 + LIG0060 + LIG0070) 
		 * (1 - ART1731BIS) ; 

LIG899YT = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIGPV3VG + LIGPV3WB + LIGPV3VE 
		   + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * (1 - positif(LIG10YT + LIG20YT + LIG30YT + LIG40YT + LIG50YT + LIG60YT + LIG70YT)) 
		 * ART1731BIS ; 

LIG900YT = positif(RVTOT + LIG1100 + LIG910 + BRCMQ + RCMFR + REPRCM + LIGRCMABT + LIG2RCMABT + LIGPV3VG + LIGPV3WB + LIGPV3VE 
		   + RCMLIB + LIG29 + LIG30 + RFQ + 2REVF + 3REVF + LIG1130 + VLHAB + DFANT + ESFP + RE168 + TAX1649 + R1649 + PREREV)
		 * positif(LIG10YT + LIG20YT + LIG30YT + LIG40YT + LIG50YT + LIG60YT + LIG70YT) 
		 * ART1731BIS ; 

regle 901050:
application : batch , iliad ;

LIG4401 =  positif(V_FORVA) * (1 - positif_ou_nul(BAFV)) * LIG0 ;

LIG4402 =  positif(V_FORCA) * (1 - positif_ou_nul(BAFC)) * LIG0 ;

LIG4403 =  positif(V_FORPA) * (1 - positif_ou_nul(BAFP)) * LIG0 ;

regle 901060:
application : iliad , batch ;

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
	* (1 - positif(ANNUL2042)) * LIG1 ;

regle 901070:
application : batch , iliad ;

4BAQLV = positif(4BACREV + 4BAHREV) ;
4BAQLC = positif(4BACREC + 4BAHREC) ;
4BAQLP = positif(4BACREP + 4BAHREP) ;

regle 901080:
application : iliad , batch ;

LIG134V = positif(present(BAFV) + present(BAHREV) + present(BAHDEV) + present(BACREV) + present(BACDEV)+ present(BAFPVV)+present(BAFORESTV)) ;
LIG134C = positif(present(BAFC) + present(BAHREC) + present(BAHDEC) + present(BACREC) + present(BACDEC)+ present(BAFPVC)+present(BAFORESTC)) ;
LIG134P = positif(present(BAFP) + present(BAHREP) + present(BAHDEP) + present(BACREP) + present(BACDEP)+ present(BAFPVP)+present(BAFORESTP)) ;
LIG134 = positif(LIG134V + LIG134C + LIG134P+present(DAGRI6)+present(DAGRI5)+present(DAGRI4)+present(DAGRI3)+present(DAGRI2)+present(DAGRI1)) 
		* (1 - positif(abs(DEFIBA))) * (1 - positif(ANNUL2042)) * LIG1 ;

LIGDBAIP = positif_ou_nul(DBAIP) * positif(DAGRI1 + DAGRI2 + DAGRI3 + DAGRI4 + DAGRI5 + DAGRI6) 
			  * positif(abs(abs(BAHQTOT)+abs(BAQTOT)-(DAGRI6+DAGRI5+DAGRI4+DAGRI3+DAGRI2+DAGRI1))) * LIG1 ;

regle 901090:
application : iliad , batch ;

LIG136 = positif(BAQTOTAVIS) * (1 - positif(ANNUL2042)) * LIG1 ;

LIG138 = positif(BATMARGTOT) * (1 - positif(ANNUL2042)) * LIG1 ;

regle 901100:
application : iliad, batch ;

pour i = V,C,P:
LIG_BICPi =        (
  present ( BICNOi )                          
 + present (BICDNi )                          
 + present (BIHNOi )                          
 + present (BIHDNi )                          
                  ) * (1 - positif(ANNUL2042)) * LIG0 ;

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

LIGMIBMV = positif(BICPMVCTV + BICPMVCTC + BICPMVCTP) * LIG0 ;

LIGBNCPV = positif(BNCPROPVV + BNCPROPVC + BNCPROPVP) * LIG0 ;

LIGBNCMV = positif(BNCPMVCTV + BNCPMVCTC + BNCPMVCTP) * LIG0 ;

LIGSPENETPF = positif(BNCPROV + BNCPROC + BNCPROP + BNCPROPVV + BNCPROPVC + BNCPROPVP + BNCPMVCTV + BNCPMVCTC + BNCPMVCTP) * LIG0 ;

LIGPLOC = positif(LOCPROCGAV + LOCPROCGAC + LOCPROCGAP + LOCDEFPROCGAV + LOCDEFPROCGAC + LOCDEFPROCGAP 
		+ LOCPROV + LOCPROC + LOCPROP + LOCDEFPROV +LOCDEFPROC + LOCDEFPROP)
		   * LIG0 ;

LIGNPLOC = positif(LOCNPCGAV + LOCNPCGAC + LOCNPCGAPAC + LOCDEFNPCGAV + LOCDEFNPCGAC + LOCDEFNPCGAPAC
		   + LOCNPV + LOCNPC + LOCNPPAC + LOCDEFNPV + LOCDEFNPC + LOCDEFNPPAC
		   + LOCGITCV + LOCGITCC + LOCGITCP + LOCGITHCV + LOCGITHCC + LOCGITHCP)
		   * LIG0 ;

LIGNPLOCF = positif(LOCNPCGAV + LOCNPCGAC + LOCNPCGAPAC + LOCDEFNPCGAV + LOCDEFNPCGAC + LOCDEFNPCGAPAC
		   + LOCNPV + LOCNPC + LOCNPPAC + LOCDEFNPV + LOCDEFNPC + LOCDEFNPPAC
                   + LNPRODEF10 + LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 + LNPRODEF5
                   + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 + LNPRODEF1
		   + LOCGITCV + LOCGITCC + LOCGITCP + LOCGITHCV + LOCGITHCC + LOCGITHCP)
		   * LIG0 ;

LIGDEFNPLOC = positif(TOTDEFLOCNP) ;

LIGDFLOCNPF = positif(DEFLOCNPF) ;

LIGLOCNSEUL = positif(LIGNPLOC + LIGDEFNPLOC + LIGNPLOCF) ;

LIGLOCSEUL = 1 - positif(LIGNPLOC + LIGDEFNPLOC + LIGNPLOCF) ;

regle 901110:
application : iliad , batch ;

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

regle 901120:
application : iliad , batch ;

LIG_BNCNF = positif (present(BNCV) + present(BNCC) + present(BNCP)) ;

LIGNOCEP = (present(NOCEPV) + present(NOCEPC) + present(NOCEPP)) * LIG0 * LIG2 ;

LIGNOCEPIMP = (present(NOCEPIMPV) + present(NOCEPIMPC) + present(NOCEPIMPP)) * LIG0 * LIG2 ;

LIGDAB = positif(present(DABNCNP6) + present(DABNCNP5) + present(DABNCNP4)
		 + present(DABNCNP3) + present(DABNCNP2) + present(DABNCNP1)) 
		* LIG0 * LIG2 ;

LIGDIDAB = positif_ou_nul(DIDABNCNP) * positif(LIGDAB) * LIG0 * LIG2 ;


LIGDEFBNCNPF = positif(DEFBNCNPF) ;
LIGDEFBANIF  = positif (DEFBANIF) ;
LIGDEFBICNPF = positif (DEFBICNPF) ;
LIGDEFRFNONI = positif (DEFRFNONI) ;

LIGBNCIF = ( positif (LIGNOCEP) * (1 - positif(LIG3250) + null(BNCIF)) 
             + (null(BNCIF) * positif(LIGBNCDF)) 
	     + null(BNCIF) * (1 - positif_ou_nul(NOCEPIMP+SPENETNPF-DABNCNP6 -DABNCNP5 -DABNCNP4 -DABNCNP3 -DABNCNP2 -DABNCNP1))
             + positif (LIGDEFBNCNPF)
             + positif(
   present (DABNCNP6)
 + present (DABNCNP5)
 + present (DABNCNP4)
 + present (DABNCNP3)
 + present (DABNCNP2)
 + present (DABNCNP1)
 + present (BNCAADV)
 + present (DNOCEPC)
 + present (DNOCEPP)
 + present (BNCAADC)
 + present (BNCAADP)
 + present (DNOCEP)
 + present (BNCNPV)
 + present (BNCNPC)
 + present (BNCNPP)
 + present (BNCNPPVV)
 + present (BNCNPPVC)
 + present (BNCNPPVP)
 + present (BNCAABV)
 + present (ANOCEP)
 + present (BNCAABC)
 + present (ANOVEP)
 + present (BNCAABP)
 + present (ANOPEP)
                        )
           )
	     * (1 - positif(LIGSPENPNEG + LIGSPENPPOS)) * LIG0 * LIG2 ;

regle 901130:
application : batch , iliad ;

LIG910 = positif(present(RCMABD) + present(RCMTNC) + present(RCMAV) + present(RCMHAD) 
	         + present(RCMHAB) + present(REGPRIV) + (1-present(BRCMQ)) *(present(RCMFR))
                ) * LIG0 * LIG2 ;

regle 901140: 
application : iliad , batch ;

LIG1130 = positif(present(REPSOF)) * LIG0 * LIG2 ;

regle 901150:
application : iliad , batch ;

LIG1950 = INDREV1A8 *  positif_ou_nul(REVKIRE) 
                    * (1 - positif_ou_nul(IND_TDR)) 
                    * (1 - positif(ANNUL2042 + 0)) ;

regle 901160:
application : batch , iliad ;

LIG29 = positif(present(RFORDI) + present(RFDHIS) + present(RFDANT) +
                present(RFDORD)) 
                * (1 - positif(LIG30)) * LIG1 * LIG2 * IND_REV ;

regle 901170:
application : iliad , batch ;

LIG30 = positif(RFMIC) * LIG1 * LIG2 ;
LIGREVRF = positif(present(FONCI) + present(REAMOR)) * LIG1 * LIG2 ;

regle 901180:
application : batch , iliad ;

LIG49 =  INDREV1A8 * positif_ou_nul(DRBG) * LIG2 ;

regle 901190:
application : iliad , batch ;

LIG52 = positif(present(CHENF1) + present(CHENF2) + present(CHENF3) + present(CHENF4) 
                 + present(NCHENF1) + present(NCHENF2) + present(NCHENF3) + present(NCHENF4)) 
	     * LIG1 * LIG2 ;

regle 901200:
application : iliad , batch ;

LIG58 = (present(PAAV) + present(PAAP)) * positif(LIG52) * LIG1 * LIG2 ;

regle 901210:
application : iliad , batch ;

LIG585 = (present(PAAP) + present(PAAV)) * (1 - positif(LIG58)) * LIG1 * LIG2 ;
LIG65 = positif(LIG52 + LIG58 + LIG585 
                + present(CHRFAC) + present(CHNFAC) + present(CHRDED)
		+ present(DPERPV) + present(DPERPC) + present(DPERPP)
                + LIGREPAR)  
       * LIG1 * LIG2 ;

regle 901220:
application : iliad , batch ;

LIGDPREC = present(CHRFAC) * (1 - positif(ANNUL2042)) * LIG1 ;

LIGDFACC = (positif(20-V_NOTRAIT+0) * positif(DFACC)
           + (1 - positif(20-V_NOTRAIT+0)) * present(DFACC)) * (1 - positif(ANNUL2042)) * LIG1 ;

regle 901230:
application : batch , iliad ;

LIG1390 = positif(positif(ABMAR) + (1 - positif(RI1)) * positif(V_0DN)) * LIG1 * LIG2 ;

regle 901240:
application : batch , iliad ;

LIG68 = INDREV1A8 * (1 - positif(abs(RNIDF))) * LIG2 ;

regle 901250:
application : iliad , batch ;

LIGTTPVQ = positif(
                   positif(CARTSV) + positif(CARTSC) + positif(CARTSP1) + positif(CARTSP2)+ positif(CARTSP3)+ positif(CARTSP4)
                   + positif(REMPLAV) + positif(REMPLAC) + positif(REMPLAP1) + positif(REMPLAP2)+ positif(REMPLAP3)+ positif(REMPLAP4)
                   + positif(PEBFV) + positif(PEBFC) + positif(PEBF1) + positif(PEBF2)+ positif(PEBF3)+ positif(PEBF4)
                   + positif(CARPEV) + positif(CARPEC) + positif(CARPEP1) + positif(CARPEP2)+ positif(CARPEP3)+ positif(CARPEP4)
                   + positif(CODRAZ) + positif(CODRBZ) + positif(CODRCZ) + positif(CODRDZ) + positif(CODREZ) + positif(CODRFZ) 
                   + positif(PENSALV) + positif(PENSALC) + positif(PENSALP1) + positif(PENSALP2)+ positif(PENSALP3)+ positif(PENSALP4)
                   + positif(RENTAX) + positif(RENTAX5) + positif(RENTAX6) + positif(RENTAX7)
                   + positif(REVACT) + positif(REVPEA) + positif(PROVIE) + positif(DISQUO) + positif(RESTUC) + positif(INTERE)
                   + positif(FONCI) + positif(REAMOR)
                   + positif(4BACREV) + positif(4BACREC)+positif(4BACREP)+positif(4BAHREV)+positif(4BAHREC)+positif(4BAHREP)
                   + positif(GLD1V) + positif(GLD1C) + positif(GLD2V) + positif(GLD2C) + positif(GLD3V) + positif(GLD3C)
                   + positif(CODDAJ) + positif(CODEAJ) + positif(CODDBJ)+ positif(CODEBJ)   
                   + positif(CODRVG)
                  ) * LIG1 * LIG2 ;

regle 901260:
application : batch , iliad ;

LIG1430 = positif(BPTP3) * LIG0 * LIG2 ;

LIG1431 = positif(BPTP18) * LIG0 * LIG2 ;

LIG1432 = positif(BPTP19) * LIG0 * LIG2 ;

regle 901270:
application : batch , iliad ;

LIG815 = V_EAD * positif(BPTPD) * LIG0 * LIG2 ;
LIG816 = V_EAG * positif(BPTPG) * LIG0 * LIG2 ;
LIGTXF225 = positif(PEA+0) * LIG0 * LIG2 ;
LIGTXF24 = positif(BPTP24) * LIG0 * LIG2 ;
LIGTXF30 = positif_ou_nul(BPCOPTV + BPVSK) * LIG0  * LIG2 ;
LIGTXF40 = positif(BPV40V + 0) * LIG0 * LIG2 ;

regle 901280:
application : batch , iliad ;

LIGCESDOM = positif(BPTPDIV) * positif(PVTAXSB) * positif(V_EAD + 0) * LIG0 * LIG2 ;

LIGCESDOMG = positif(BPTPDIV) * positif(PVTAXSB) * positif(V_EAG + 0) * LIG0 * LIG2 ;

regle 901290:
application : batch , iliad ;
 
LIG81 = positif(present(RDDOUP) + present(DONAUTRE) + present(REPDON03) + present(REPDON04) 
                + present(REPDON05) + present(REPDON06) + present(REPDON07) + present(COD7UH)
                + positif(EXCEDANTA))
        * LIG1 * LIG2 ;

LIGCRDIE = positif(REGCI) * LIG1 * LIG2 ;

regle 901300:
application : iliad , batch ;

LIG1500 = positif((positif(IPMOND) * positif(present(IPTEFP)+positif(VARIPTEFP)*present(DEFZU))) + positif(INDTEFF) * positif(TEFFREVTOT)) 
	      * (1 - positif(DEFRIMOND)) * CNRLIG12 ;

LIG1510 = positif((positif(IPMOND) * present(IPTEFN)) + positif(INDTEFF) * (1 - positif(TEFFREVTOT))) 
	      * (1 - positif(DEFRIMOND)) * CNRLIG12 ;

LIG1500YT = positif((positif(IPMOND) * positif(present(IPTEFP)+positif(VARIPTEFP)*present(DEFZU))) + positif(INDTEFF) * positif(TEFFREVTOT)) 
	     * positif(positif(max(0,IPTEFP+DEFZU-IPTEFN))+positif(max(0,RMOND+DEFZU-DMOND))) * positif(DEFRIMOND) * CNRLIG12 ;

LIG1510YT =  positif(null(max(0,RMOND+DEFZU-DMOND))+null(max(0,IPTEFP+DEFZU-IPTEFN))) * positif(DEFRIMOND) * CNRLIG12 ;

regle 901310:
application : iliad , batch ;

LIG1522 = (1 - present(IND_TDR)) * (1 - INDTXMIN) * (1 - INDTXMOY) * V_CNR * LIG2 ;

regle 901320:
application : batch , iliad ;

LIG1523 = (1 - present(IND_TDR)) * LIG2 ;

regle 901330:
application : iliad , batch ;

LIG75 = (1 - INDTXMIN) * (1 - INDTXMOY) * (1 - (LIG1500+ LIG1500YT)) * (1 - (LIG1510+ LIG1510YT)) * INDREV1A8 * LIG2 ;

LIG1545 = (1 - present(IND_TDR)) * INDTXMIN * positif(IND_REV) * LIG2 ;

LIG1760 = (1 - present(IND_TDR)) * INDTXMOY * LIG2 ;

LIG1546 = positif(PRODOM + PROGUY) * (1 - positif(V_EAD + V_EAG)) * LIG2 ;

LIG1550 = (1 - present(IND_TDR)) * INDTXMOY * LIG2 ;

LIG74 = (1 - present(IND_TDR)) * (1 - INDTXMIN) * positif(LIG1500 + LIG1510 + LIG1500YT + LIG1510YT) * LIG2 ;

LIGBAMARG = positif(BATMARGTOT) * (1 - present(IND_TDR)) * LIG138 * LIG2 ;

regle 901340:
application : batch , iliad ;

LIG80 = positif(present(RDREP) + present(DONETRAN)) * LIG1 * LIG2 ;

regle 901350:
application : iliad , batch ;

LIGRSOCREPR = positif(present(RSOCREPRISE)) * LIG1 * LIG2 ;

regle 901360:
application : batch , iliad ;

LIG1740 = positif(RECOMP) * LIG2 ;

regle 901370:
application : batch , iliad ;

LIG1780 = positif(RDCOM + NBACT) * LIG1 * LIG2 ;

regle 901380:
application : batch , iliad ;

LIG98B = positif(LIG80 + LIGFIPC + LIGFIPDOM + present(DAIDE)
                 + LIGDUFLOT + LIGPINEL + LIG7CY + LIG7DY
                 + LIGREDAGRI + LIGFORET + LIGRESTIMO  
	         + LIGCINE + LIGPRESSE + LIGRSOCREPR + LIGCOTFOR 
	         + present(PRESCOMP2000) + present(RDPRESREPORT) + present(FCPI) 
		 + present(DSOUFIP) + LIGRIRENOV + present(DFOREST) 
		 + present(DHEBE) + present(DSURV)
	         + LIGLOGDOM + LIGREPTOUR + LIGLOCHOTR
	         + LIGREPHA + LIGCREAT + LIG1780 + LIG2040 + LIG81 + LIGCRDIE
                 + LIGLOGSOC + LIGDOMSOC1 
                 + somme (i=A,B,E,M,N,G,C,D,S,T,H,F,Z,X,I,J : LIGCELLi) + LIGCELMG + LIGCELMH
                 + somme (i=L,M,S,R,U,T,Z,X,W,V,F,D,H,G,A : LIGCELHi)
                 + somme (i=U,X,S,W,L,V,J : LIGCELGi )
                 + somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : LIGCELYi)
		 + LIGCELHNO + LIGCELHJK + LIGCELNQ + LIGCELCOM + LIGCELNBGL
		 + LIGCEL + LIGCELJP + LIGCELJBGL + LIGCELJOQR + LIGCEL2012
                 + LIGCELFD + LIGCELFABC
                 + LIGILMPA + LIGILMPB + LIGILMPC + LIGILMPD + LIGILMPE
                 + LIGILMPF + LIGILMPG + LIGILMPH + LIGILMPI + LIGILMPJ
                 + LIGILMOA + LIGILMOB + LIGILMOC + LIGILMOD + LIGILMOE
                 + LIGILMOJ + LIGILMOI + LIGILMOH + LIGILMOG + LIGILMOF
		 + LIGREDMEUB + LIGREDREP + LIGILMIX + LIGILMIY + LIGINVRED
                 + LIGILMIH  + LIGILMJC + LIGILMIZ + LIGILMJI + LIGILMJS
                 + LIGMEUBLE + LIGPROREP + LIGREPNPRO + LIGMEUREP + LIGILMIC
                 + LIGILMIB + LIGILMIA + LIGILMJY + LIGILMJX + LIGILMJW
                 + LIGILMJV + LIGRESIMEUB + LIGRESINEUV + LIGRESIVIEU + LIGLOCIDEFG
		 + LIGCODJTJU + LIGCODOU + LIGCODOV 
		 + present(DNOUV) + LIGLOCENT + LIGCOLENT + LIGRIDOMPRO
		 + LIGPATNAT1 + LIGPATNAT2 + LIGPATNAT3+LIGPATNAT4) 
           * LIG1 * LIG2 ;

LIGRED = LIG98B * (1 - positif(RIDEFRI)) * LIG1 * LIG2 ;

LIGREDYT = LIG98B * positif(RIDEFRI) * LIG1 * LIG2 ;

regle 901390:
application : batch , iliad ;

LIG1820 = positif(ABADO + ABAGU + RECOMP) * LIG2 ;

regle 901400:
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

regle 901410:
application : iliad , batch ;

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

regle 901420:
application : batch , iliad ;

LIG109 = positif(IPSOUR + REGCI + LIGPVETR + LIGCULTURE + LIGMECENAT 
		  + LIGCORSE + LIG2305 + LIGEMPLOI + LIGCI2CK + LIGCICAP + LIGCI8XV + LIGCIGLO + LIGREGCI
		  + LIGBPLIB + LIGCIHJA + LIGCIGE + LIGDEVDUR 
                  + LIGCICA + LIGCIGARD + LIG82
		  + LIGPRETUD + LIGSALDOM + LIGCIFORET + LIGHABPRIN
		  + LIGCREFAM + LIGCREAPP + LIGCREBIO  + LIGPRESINT + LIGCREPROSP + LIGINTER
		  + LIGRESTAU + LIGCONGA + LIGMETART 
		  + LIGCREFORM + LIGLOYIMP 
		  + LIGVERSLIB + LIGCITEC 
		   ) 
               * LIG1 * LIG2 ;

LIGCRED1 = positif(LIGPVETR + LIGCICAP + LIGREGCI + LIGCI8XV + LIGCIGLO + 0) 
	    * (1 - positif(IPSOUR + LIGCULTURE + LIGMECENAT + LIGCORSE + LIG2305 + LIGEMPLOI + LIGCI2CK + LIGBPLIB + LIGCIHJA + LIGCIGE + LIGDEVDUR 
		           + LIGCICA + LIGCIGARD + LIG82 + LIGPRETUD + LIGSALDOM + LIGCIFORET + LIGHABPRIN + LIGCREFAM + LIGCREAPP 
		           + LIGCREBIO + LIGPRESINT + LIGCREPROSP + LIGINTER + LIGRESTAU + LIGCONGA + LIGMETART
		           + LIGCREFORM + LIGLOYIMP + LIGVERSLIB + LIGCITEC + 0))
	    ;

LIGCRED2 = (1 - positif(LIGPVETR + LIGCICAP + LIGREGCI + LIGCI8XV + LIGCIGLO + 0)) 
	    * positif(IPSOUR + LIGCULTURE + LIGMECENAT + LIGCORSE + LIG2305 + LIGEMPLOI + LIGCI2CK + LIGBPLIB + LIGCIHJA + LIGCIGE + LIGDEVDUR 
		      + LIGCICA + LIGCIGARD + LIG82 + LIGPRETUD + LIGSALDOM + LIGCIFORET + LIGHABPRIN + LIGCREFAM + LIGCREAPP 
		      + LIGCREBIO + LIGPRESINT + LIGCREPROSP + LIGINTER + LIGRESTAU + LIGCONGA + LIGMETART
		      + LIGCREFORM + LIGLOYIMP + LIGVERSLIB + LIGCITEC + 0)
	    ;

LIGCRED3 = positif(LIGPVETR + LIGCICAP + LIGREGCI + LIGCI8XV + LIGCIGLO + 0) 
	    * positif(IPSOUR + LIGCULTURE + LIGMECENAT + LIGCORSE + LIG2305 + LIGEMPLOI + LIGCI2CK + LIGBPLIB + LIGCIHJA + LIGCIGE + LIGDEVDUR
		      + LIGCICA + LIGCIGARD + LIG82 + LIGPRETUD + LIGSALDOM + LIGCIFORET + LIGHABPRIN + LIGCREFAM + LIGCREAPP 
		      + LIGCREBIO + LIGPRESINT + LIGCREPROSP + LIGINTER + LIGRESTAU + LIGCONGA + LIGMETART
		      + LIGCREFORM + LIGLOYIMP + LIGVERSLIB + LIGCITEC + 0)
           ;

regle 901430:
application : batch , iliad ;

LIGPVETR = positif(present(CIIMPPRO) + present(CIIMPPRO2)) * LIG1 * LIG2 ;
LIGCICAP = present(PRELIBXT) * LIG1 * LIG2 ;
LIGREGCI = positif(present(REGCI) + present(COD8XY)) * positif(CICHR) * LIG1 * LIG2 ;
LIGCI8XV = present(COD8XV) * LIG1 * LIG2 ;
LIGCIGLO = positif(present(COD8XF) + present(COD8XG) + present(COD8XH)) * LIG1 * LIG2 ;

LIGCULTURE = present(CIAQCUL) * LIG1 * LIG2 ;
LIGMECENAT = present(RDMECENAT) * LIG1 * LIG2 ;
LIGCORSE = positif(present(CIINVCORSE) + present(IPREPCORSE) + present(CICORSENOW)) * LIG1 * LIG2 ;
LIG2305 = positif(DIAVF2) * LIG1 * LIG2 ;
LIGEMPLOI = positif(COD8UW + COD8TL) * LIG1 * LIG2 ;
LIGCI2CK = positif(COD2CK) * LIG1 * LIG2 ;
LIGBPLIB = present(RCMLIB) * LIG0 * LIG2 ;
LIGCIHJA = positif(CODHJA) * LIG1 * LIG2 ;
LIGCIGE = positif(RDTECH + RDEQPAHA) * LIG1 * LIG2 ;
LIGDEVDUR = positif(DDEVDUR) * LIG1 * LIG2 ;
LIGCICA = positif(BAILOC98) * LIG1 * LIG2 ;
LIGCIGARD = positif(DGARD) * LIG1 * LIG2 ;
LIG82 = positif(present(RDSYVO) + present(RDSYCJ) + present(RDSYPP) ) * LIG1 * LIG2 ;
LIGPRETUD = positif(PRETUD+PRETUDANT) * LIG1 * LIG2 ;
LIGSALDOM = present(CREAIDE) * LIG1 * LIG2 ;
LIGCIFORET = positif(BDCIFORET) * LIG1 * LIG2 ;
LIGHABPRIN = positif(present(PREHABT) + present(PREHABT1) + present(PREHABT2) + present(PREHABTN) 
                     + present(PREHABTN1) + present(PREHABTN2) + present(PREHABTVT)
                    ) * LIG1 * LIG2 ;
LIGCREFAM = positif(CREFAM) * LIG1 * LIG2 ;
LIGCREAPP = positif(CREAPP) * LIG1 * LIG2 ;
LIGCREBIO = positif(CREAGRIBIO) * LIG1 * LIG2 ;
LIGPRESINT = positif(PRESINTER) * LIG1 * LIG2 ;
LIGCREPROSP = positif(CREPROSP) * LIG1 * LIG2 ;
LIGINTER = positif(CREINTERESSE) * LIG1 * LIG2 ;
LIGRESTAU = positif(CRERESTAU) * LIG1 * LIG2 ;
LIGCONGA = positif(CRECONGAGRI) * LIG1 * LIG2 ;
LIGMETART = positif(CREARTS) * LIG1 * LIG2 ;
LIGCREFORM = positif(CREFORMCHENT) * LIG1 * LIG2 ;
LIGLOYIMP = positif(LOYIMP) * LIG1 * LIG2 ;
LIGVERSLIB = positif(AUTOVERSLIB) * LIG1 * LIG2 ;
LIGCITEC = positif(DTEC) * LIG1 * LIG2 ;

LIGCREAT = positif(DCREAT + DCREATHANDI) * LIG1 * LIG2 ;

regle 901440:
application : batch , iliad ;

LIGNRBASE = positif(present(NRINET) + present(NRBASE)) * LIG1 * LIG2 ;
LIGBASRET = positif(present(IMPRET) + present(BASRET)) * LIG1 * LIG2 ;

regle 901450:
application : iliad , batch ;

LIGAVFISC = positif(AVFISCOPTER) * LIG1 * LIG2 ; 

regle 901460:
application : batch , iliad ;

LIG2040 = positif(DNBE + RNBE + RRETU) * LIG1 * LIG2 ;

regle 901470:
application : iliad , batch ;

LIGRDCSG = positif(positif(V_BTCSGDED) + present(DCSG) + present(RCMSOC)) * LIG1 * LIG2 ;

regle 901480:
application : batch , iliad ;

LIGTAXANET = positif((present(CESSASSV) + present(CESSASSC)) * INDREV1A8IR + TAXANTAFF) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;

LIGPCAPNET = positif((present(PCAPTAXV) + present(PCAPTAXC)) * INDREV1A8IR + PCAPANTAFF) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;

LIGLOYNET = (present(LOYELEV) * INDREV1A8IR + TAXLOYANTAFF) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;

LIGHAUTNET = positif(BHAUTREV * INDREV1A8IR + HAUTREVANTAF) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;

LIG_IRNET = positif(LIGTAXANET + LIGPCAPNET + LIGLOYNET + LIGHAUTNET) * (1 - positif(ANNUL2042 + 0)) ;

LIGIRNET = positif(IRNET * LIG_IRNET + LIGTAXANET + LIGPCAPNET + LIGLOYNET + LIGHAUTNET) * (1 - positif(ANNUL2042 + 0)) ;

regle 901490:
application : batch , iliad ;

LIGANNUL = positif(ANNUL2042) ;

regle 901500:
application : batch , iliad ;

LIG2053 = positif(V_NOTRAIT - 20) * positif(IDEGR) * positif(IREST - SEUIL_8) * TYPE2 ;

regle 901510:
application : batch , iliad ;


LIG2051 = (1 - positif(20 - V_NOTRAIT)) 

          * positif (RECUMBIS) ;

LIGBLOC = positif(V_NOTRAIT - 20) ;

LIGSUP = positif(null(V_NOTRAIT - 26) + null(V_NOTRAIT - 36) + null(V_NOTRAIT - 46) + null(V_NOTRAIT - 56) + null(V_NOTRAIT - 66)) ;

LIGDEG = positif_ou_nul(TOTIRPSANT) * positif(SEUIL_8 - RECUM) 
         * positif(null(V_NOTRAIT - 23) + null(V_NOTRAIT - 33) + null(V_NOTRAIT - 43) + null(V_NOTRAIT - 53) + null(V_NOTRAIT - 63)) ;

LIGRES = (1 - positif(TOTIRPSANT + 0)) * positif_ou_nul(RECUM - SEUIL_8)
         * positif(null(V_NOTRAIT - 23) + null(V_NOTRAIT - 33) + null(V_NOTRAIT - 43) + null(V_NOTRAIT - 53) + null(V_NOTRAIT - 63)) ;

LIGDEGRES = positif(TOTIRPSANT + 0) * positif_ou_nul(RECUM - SEUIL_8) 
            * positif(null(V_NOTRAIT - 23) + null(V_NOTRAIT - 33) + null(V_NOTRAIT - 43) + null(V_NOTRAIT - 53) + null(V_NOTRAIT - 63)) ;

LIGNEMP = positif((1 - null(NAPTEMP)) + null(NAPTEMP) * null(NAPTIR) * null(NAPCRP)) ;

LIGEMP = 1 - LIGNEMP ;

LIG2052 = (1 - positif(V_ANTREIR + 0)) * (1 - APPLI_OCEANS);

LIGTAXANT = (
	     APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_TAXANT + LIGTAXANET * positif(TAXANET))
            ) * (1 - positif(LIG2051)) * TYPE2 * (1 - APPLI_OCEANS);

LIGPCAPANT = (
	      APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_PCAPANT + LIGPCAPNET * positif(PCAPNET))
             ) * (1 - positif(LIG2051)) * TYPE2 * (1 - APPLI_OCEANS);
LIGLOYANT = (
	      APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_TAXLOYANT + LIGLOYNET * positif(TAXLOYNET))
             ) * (1 - positif(LIG2051)) * TYPE2 * (1 - APPLI_OCEANS);

LIGHAUTANT = (
	      APPLI_ILIAD * (1 - positif(20 - V_NOTRAIT)) * positif(V_CHRANT + LIGHAUTNET * positif(HAUTREVNET))
             ) * (1 - positif(LIG2051)) * TYPE2 * (1 - APPLI_OCEANS);

LIGANTREIR = positif(V_ANTREIR + 0) * (1 - positif(V_ANTCR)) * (1 - APPLI_OCEANS);

LIGNANTREIR = positif(V_ANTREIR + 0) * positif(V_ANTCR + 0) * (1 - APPLI_OCEANS);

LIGNONREC = positif(V_NONMERANT + 0) * (1 - APPLI_OCEANS);

LIGNONREST = positif(V_NONRESTANT + 0) * (1 - APPLI_OCEANS);

LIGIINET = LIGSUP * (positif(NAPT + 0) + null(IINETCALC)) ;

LIGIINETC = LIGSUP * null(NAPT) * positif(IINETCALC + 0) ;

LIGIDEGR = positif(LIGDEG + LIGDEGRES) * (positif_ou_nul(IDEGR - SEUIL_8) + null(IDEGR)) ;

LIGIDEGRC = positif(LIGDEG + LIGDEGRES) * positif(SEUIL_8 - IDEGR) * positif(IDEGR + 0) ;

LIGIREST = positif(LIGRES + LIGDEGRES) * (positif_ou_nul(IREST - SEUIL_8) + null(IREST)) ;

LIGIRESTC = positif(LIGRES + LIGDEGRES) * positif(SEUIL_8 - IREST) * positif(IREST + 0) ;

LIGNMRR = LIGIINETC * positif(V_ANTRE - V_NONRESTANT + 0) ;

LIGNMRS = LIGIINETC * (1 - positif(V_ANTRE - V_NONRESTANT)) ;

LIGRESINF = positif(LIGIDEGRC + LIGIRESTC) ;

regle 901520:
application : batch , iliad ;


LIG2080 = positif(NATIMP - 71) * LIG2 ;

regle 901530:
application : batch , iliad ;


LIGTAXADEG = positif(NATIMP - 71) * positif(TAXADEG) * LIG2 ;

LIGPCAPDEG = positif(NATIMP - 71) * positif(PCAPDEG) * LIG2 ;

LIGLOYDEG = positif(NATIMP - 71) * positif(TAXLOYDEG) * LIG2 ;

LIGHAUTDEG = positif(NATIMP - 71) * positif(HAUTREVDEG) * LIG2 ;

regle 901540:
application : iliad , batch ;

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


LIG2140 = si (
                ( ( (V_CNR + 0 = 0) et NATIMP = 1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		    ou ((V_CNR + 0 = 1) et (NATIMP = 1 ou  NATIMP = 0))
                    ou ((V_REGCO + 0 = 3) et ((NRINET > 0) et (NRINET < 12) et (CSTOTSSPENA < 61)))
                ) 
		et LIG2141 + 0 = 0
		)
          alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * positif(20 - V_NOTRAIT))
          finsi;

LIG21401 = si (( ((V_CNR+0=0) et NATIMP=1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		ou ((V_CNR+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
           alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * positif(20 - V_NOTRAIT))
           finsi ;

LIG21402 = si (( ((V_CNR+0=0) et NATIMP=1 et (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + NRINET - NAPTOTA + NAPCR >= SEUIL_12)) 
		ou ((V_CNR+0=1) et (NATIMP=1 ou  NATIMP=0)))
		et LIG2141 + 0 = 0
		)
           alors ((((1 - INDCTX) * INDREV1A8 * (1 - (positif(IRANT)*null(NAPT)) ) * LIG2)
                + null(IINET + NAPTOTA) * null(INDREV1A8)) * positif(IND_REV) * positif(V_NOTRAIT - 20))
           finsi ;


regle 901550:
application : batch , iliad ;

LIG2141 = null(IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES - IRANT) 
                  * positif(IRANT)
                  * (1 - positif(LIG2501))
		  * null(V_IND_TRAIT - 4)
		  * (1 - positif(NRINET + 0)) ;

regle 901560:
application : batch , iliad ;

LIGNETAREC = positif (IINET) * (1 - LIGPS) * positif(ANNUL2042) * TYPE2 ;

LIGNETARECS = positif (IINET) * LIGPS * positif(ANNUL2042) * TYPE2 ;

regle 901570:
application : iliad , batch ;

LIG2150 = (1 - INDCTX) 
	 * positif(IREST)
         * (1 - positif(LIG2140))
         * (1 - positif(IND_REST50))
	 * positif(20 - V_NOTRAIT)
         * LIG2 ;

regle 901580:
application : batch , iliad ;

LIG2161 =  INDCTX 
	  * positif(IREST) 
          * positif_ou_nul(IREST - SEUIL_8) 
	  * (1 - positif(IND_REST50)) ;

LIG2368 = INDCTX 
	 * positif(IREST)
         * positif ( positif(IND_REST50)
                     + positif(IDEGR) ) ;

regle 901590:
application : batch , iliad ;

LIG2171 = (1 - INDCTX) 
	 * positif(IREST)
	 * (1 - positif(LIG2140))
         * positif(IND_REST50)  
	 * positif(20 - V_NOTRAIT)
	 * LIG2 ;

regle 901600:
application : batch , iliad ;

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

regle 901610:
application : batch , iliad ;

LIGRESINF50 = positif(positif(IND_REST50) * positif(IREST) 
                      + positif(RECUM) * (1 - positif_ou_nul(RECUM - SEUIL_8)))  
	      * positif(SEUIL_8 - IRESTIT) * null(LIGRESINF) ;

regle 901620:
application : batch , iliad ;

LIG2200 = (positif(IDEGR) * positif_ou_nul(IDEGR - SEUIL_8) * (1 - LIGPS) * TYPE2) ;

LIG2200S = (positif(IDEGR) * positif_ou_nul(IDEGR - SEUIL_8) * LIGPS * TYPE2) ;

regle 901630:
application : batch , iliad ;

LIG2205 = positif(IDEGR) * (1 - positif_ou_nul(IDEGR - SEUIL_8)) * (1 - LIGPS) * LIG2 ;

LIG2205S = positif(IDEGR) * (1 - positif_ou_nul(IDEGR - SEUIL_8)) * LIGPS * LIG2 ;

regle 901640:
application : batch , iliad ;


IND_NIRED = si ((CODINI=3 ou CODINI=5 ou CODINI=13)
               et ((IAVIM +NAPCRPAVIM)- TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES) = 0 
                   et  V_CNR = 0)
          alors (1 - INDCTX) 
          finsi ;

regle 901650:
application : batch , iliad ;


IND_IRNMR = si (CODINI=8 et NATIMP=0 et V_CNR = 0)
          alors (1 - INDCTX)  
          finsi;

regle 901660:
application : batch , iliad ;

IND_IRINF80 = si ( ((CODINI+0=9 et NATIMP+0=0) ou (CODINI +0= 99))
                  et V_CNR=0 
                  et  (IRNET +TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES + NAPCR < SEUIL_12)
                  et  ((IAVIM+NAPCRPAVIM) >= SEUIL_61))
              alors ((1 - positif(INDCTX)) * (1 - positif(IREST))) 
              finsi;

regle 901670:
application : batch , iliad ;


LIGNIIR = null(IDRS3 - IDEC)
           * null(NRINET+0)
           * null(NATIMP)
           * null(TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES + NAPCRP)
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
           * (1 - positif(IRESTIT))
           * (1 - positif(IDEGR))
           * (1 - positif(LIGAUCUN))
           * (1 - positif(LIG2141))
           * (1 - positif(LIG2501))
           * (1 - positif(LIG8FV))
           * (1 - positif(LIGNIDB))
           * (1 - V_CNR)
           * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - positif(NRINET))
	   * positif(20 - V_NOTRAIT)
           * LIG2 ;

LIGNIIRDEG = null(IDRS3 - IDEC)
	       * null(IAMD2)
	       * (1 - positif(IRE))
               * null(TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES + NAPCRP)
               * (1 - V_CNR)
               * (1 - positif(LIG2501))
	       * (1 - positif(LIGTROP))
	       * (1 - positif(LIGTROPREST))
	       * (1 - positif(IMPRET - SEUIL_12))
	       * (1 - positif(NRINET - SEUIL_12))
	       * positif(1 + null(3 - INDIRPS))
	       * positif(V_NOTRAIT - 20)
               * LIG2 ;

regle 901680:
application : batch , iliad ;


LIGCBAIL = null(IDOM11 - DEC11)
            * (1 - positif(IAMD2))
	    * positif_ou_nul(TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES + (V_ANTREIR * positif(TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES)) + NAPCRP - SEUIL_61)
	    * positif_ou_nul(IINET - SEUIL_12)
	    * (1 - positif(LIGNIDB))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
	    * (1 - positif(NRINET))
            * (1 - V_CNR)
            * LIG2 ;

LIGNITSUP = positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES - SEUIL_61)
             * null(IDRS2-IDEC+IREP)
             * positif_ou_nul(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - SEUIL_12)
	     * (1 - positif(LIG0TSUP))
             * (1 - V_CNR)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * positif(V_NOTRAIT - 20)
	     * (1 - positif(INDCTX))
             * LIG2 ;
                       
LIGNITDEG = positif(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
             * positif_ou_nul(IRB2 - SEUIL_61)
             * positif_ou_nul(TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET - SEUIL_12)
             * null(INDNIRI) * (1 - positif(IAMD2))
             * positif(1 - V_CNR) * INDREV1A8
             * (1 - V_CNR)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(INDCTX)
             * LIG2 ;
                       
regle 901690:
application : batch , iliad ;

LIGNIDB = null(IDOM11 - DEC11)
           * positif(SEUIL_61 - TAXASSUR - IPCAPTAXTOT - TAXLOY - CHRAPRES - (V_ANTREIR * positif(TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES)))
           * positif(SEUIL_61 - NAPCRP)
	   * positif(TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES + NAPCRP)
           * null(IRNETBIS)
	   * (1 - positif(IRESTIT))
           * (1 - positif(IREP))
           * (1 - positif(IPROP))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(NRINET))
	   * (1 - positif(IMPRET))
           * (1 - V_CNR)
           * LIG2 ;  

LIGREVSUP = INDREV1A8
	     * positif(REVFONC)
             * (1 - V_CNR)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(V_NOTRAIT - 20)
	     * (1 - positif(INDCTX))
             * LIG2 ;  

LIGREVDEG = INDREV1A8
	     * positif(REVFONC)
             * (1 - V_CNR)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET))
	     * positif(INDCTX)
             * LIG2 ;  

regle 901700:
application : batch , iliad ;


LIG0TSUP = INDNIRI
            * null(IRNETBIS)
            * positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES - SEUIL_61)
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - V_CNR)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(V_NOTRAIT - 20)
	    * (1 - positif(INDCTX))
            * LIG2 ;

LIG0TDEG = INDNIRI
            * null(IRNETBIS)
            * positif_ou_nul(TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES - SEUIL_61)
            * (1 - positif(IREP))
            * (1 - positif(IPROP))
            * (1 - V_CNR)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(INDCTX)
            * LIG2 ;

regle 901710:
application : batch , iliad ;


LIGPSNIR = positif(IAVIM) 
           * positif(SEUIL_61 - IAVIM) 
           * positif(SEUIL_61 - (NAPTIR + V_ANTREIR))
           * positif_ou_nul(NAPCRP - SEUIL_61)
           * (positif(IINET) * positif(20 - V_NOTRAIT) + positif(V_NOTRAIT - 20)) 
           * (1 - V_CNR)
           * (1 - positif(LIGNIDB))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - positif(NRINET))
           * LIG2 ;

LIGIRNPS = positif((positif_ou_nul(IAVIM - SEUIL_61) * positif_ou_nul(NAPTIR - SEUIL_12)) * positif(IAMD2)
                   + positif(IRESTIT + 0))
           * positif(SEUIL_61 - NAPCRP)
           * positif(NAPCRP)
           * (1 - V_CNR)
           * (1 - positif(LIGNIDB))
	   * (1 - positif(LIGTROP))
	   * (1 - positif(LIGTROPREST))
	   * (1 - positif(IMPRET))
	   * (1 - positif(NRINET))
           * LIG2 ;


LIG400DEG = positif(IAVIM + NAPCRPAVIM)
  	     * positif (SEUIL_61 - (IAVIM + NAPCRPAVIM))
	     * null(ITRED)
	     * positif (IRNET)
	     * (1 - positif(IRNET + V_ANTREIR - SEUIL_61))
             * (1 - V_CNR)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * (1 - positif(IMPRET - SEUIL_12))
	     * (1 - positif(NRINET - SEUIL_12))
	     * positif(V_NOTRAIT - 20)
             * LIG2 ;

regle 901720:
application : batch , iliad ;



LIG61DEG = positif(ITRED)
	    * positif(IAVIM)  
            * positif(SEUIL_61 - IAVIM)
            * (1 - positif(INDNMR2))
            * (1 - V_CNR)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
            * positif(INDCTX)
            * LIG2 ;

regle 901730:
application : batch , iliad ;
	

LIGAUCUN = positif((positif(SEUIL_61 - IAVIM) * positif(IAVIM) * (1 - positif(NAPCRP))
                    + positif_ou_nul(IAVIM - SEUIL_61) * positif(NAPTIR) * positif(SEUIL_12 - NAPTIR) * (1 - positif(NAPCRP))
                    + positif(SEUIL_61 - NAPCRP) * positif(NAPCRP) * positif(SEUIL_61 - IAVIM)
                    + (positif_ou_nul(IAVIM - SEUIL_61) + positif_ou_nul(NAPCRP - SEUIL_61)) * positif(NAPCRP) * positif(SEUIL_12 - IRPSCUM))
	           * (1 - positif(IREST))
                   * (1 - LIGNIDB)
	           * (1 - positif(LIGTROP))
	           * (1 - positif(LIGTROPREST))
	           * (1 - positif(IMPRET))
	           * (1 - positif(NRINET))
                   * (1 - positif(IRANT))
                   * (1 - V_CNR)
	           * positif(20 - V_NOTRAIT) 
	           * LIG2
                  ) ;

regle 901740:
application : batch , iliad ;


LIG12ANT = positif (IRANT)
            * positif (SEUIL_12 - TOTNET )
	    * positif( TOTNET)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(V_CNR + (1 - V_CNR) * positif(NRINET-SEUIL_12)))
	    * (1 - positif(IMPRET - SEUIL_12)) 
	    * (1 - positif(NRINET - SEUIL_12))
	    * positif(20 - V_NOTRAIT)
            * LIG2 ; 

regle 901750:
application : batch , iliad ;

LIG12NMR = positif(IRPSCUM)
            * positif(SEUIL_12 - IRPSCUM)
	    * positif(V_NOTRAIT - 20)
            * (1 - V_CNR)
	    * (1 - positif(IMPRET - SEUIL_12)) 
	    * (1 - positif(NRINET - SEUIL_12)) ;

regle 901760:
application : batch , iliad ;


LIGNIIRAF = null(IAD11)
             * positif(IRESTIT)
             * (1 - positif(INDNIRI))
             * (1 - positif(IREP))
             * (1 - positif(IPROP))
             * (1 - positif_ou_nul(NAPTIR))
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
	     * positif(1 + null(3 - INDIRPS))
             * LIG2 ;

regle 901770:
application : batch , iliad ;


LIGNIDEG = null(IDRS3-IDEC)
	    * null(IAMD2)
	    * positif(SEUIL_61 - TAXASSUR)
	    * positif(SEUIL_61 - IPCAPTAXT)
	    * positif(SEUIL_61 - TAXLOY)
	    * positif(SEUIL_61 - CHRAPRES)
            * positif(SEUIL_12 - IRNET)
            * (1 - V_CNR)
	    * (1 - positif(LIGDEG61))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * positif(INDCTX)
            * LIG2 ;

regle 901780:
application : batch , iliad ;

LIGDEG61 = positif (IRNETBIS)
            * positif (SEUIL_61 - IAMD1) 
            * positif (SEUIL_61 - NRINET) 
	    * positif (IAMD2)
	    * (1 - positif(LIG61DEG))
            * (1 - V_CNR)
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
	    * (1 - positif(IMPRET))
            * positif (INDCTX)
            * LIG2 ;

regle 901790:
application : batch , iliad ;

LIGDEG12 = positif (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET)
            * positif (SEUIL_12 - IRNET - TAXANET - PCAPNET - TAXLOYNET - HAUTREVNET)
            * (1 - V_CNR)
            * (1 - positif(LIGNIDEG))
            * (1 - positif(LIGDEG61))
            * (1 - positif(LIG61DEG))
	    * (1 - positif(LIGTROP))
	    * (1 - positif(LIGTROPREST))
            * (1 - positif(IMPRET))
	    * positif(INDCTX)
            * LIG2 ;

regle 901800:
application : batch , iliad ;

LIGDIPLOI = positif(INDREV1A8)
             * positif(null(NATIMP - 1) + positif(NAPTEMP))
             * positif(REVFONC) * (1 - V_CNR)
	     * (1 - positif(LIGTROP))
	     * (1 - positif(LIGTROPREST))
             * LIG1 ;

regle 901810:
application : batch , iliad ;

LIGDIPLONI = positif(INDREV1A8)
              * positif(null(NATIMP) + positif(IREST) + (1 - positif(NAPTEMP)))
              * positif(REVFONC) * (1 - V_CNR)
	      * (1 - positif(LIGTROP))
	      * (1 - positif(LIGTROPREST))
	      * (1 - LIGDIPLOI)
              * LIG1 ;

regle 901820:
application : batch , iliad ;

LIG2355 = positif (
		   IND_NI * (1 - positif(V_ANTRE)) + INDNMR1 + INDNMR2
                   + positif(NAT1BIS) *  null(NAPT) * (positif (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET))
		   + positif(SEUIL_12 - (IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES - IRANT))
				 * positif_ou_nul(IAN + RPEN - IAVT + TAXASSUR + IPCAPTAXT + TAXLOY + CHRAPRES - IRANT) 
                  )
          * positif(INDREV1A8)
          * (1 - null(NATIMP - 1) + null(NATIMP - 1) * positif(IRANT))  
	  * (1 - LIGPS)
	  * LIG2 ;

regle 901830:
application : batch , iliad ;

LIG7CY = positif(COD7CY) * LIG1 * LIG2 ;
LIG7DY = positif(COD7DY) * LIG1 * LIG2 ;
LIGRVG = positif(CODRVG) * LIG1 * LIG2 ;

regle 901840:
application : batch , iliad ;

LIG2380 = si (NATIMP=0 ou NATIMP=21 ou NATIMP=70 ou NATIMP=91)
          alors (IND_SPR * positif_ou_nul(V_8ZT - RBG) * positif(V_8ZT)
                * (1 - present(BRAS)) * (1 - present(IPSOUR))
                * V_CNR * LIG2)
          finsi ;

regle 901850:
application : batch , iliad ;

LIG2383 = si ((IAVIM+NAPCRPAVIM)<=(IPSOUR * LIG1 ))
          alors ( positif(RBG - V_8ZT) * present(IPSOUR) 
                * V_CNR * LIG2)
          finsi ;

regle 901860:
application : iliad , batch ;

LIG2501 = (1 - positif(IND_REV)) * (1 - V_CNR) * LIG2 ;

LIG25012 = (1 - positif(IND_REV)) * V_CNR * LIG2 ;

LIG8FV = positif(REVFONC) * (1 - IND_REV8FV) ;

regle 901870:
application : batch , iliad ;

LIG2503 = (1 - positif(IND_REV))
          * (1 - positif_ou_nul(IND_TDR))
          * LIG2
          * (1 - V_CNR) ;

regle 901880:
application : batch , iliad ;

LIG3510 =  (positif(V_FORVA) * (1 - positif_ou_nul(BAFV))
           + positif(V_FORCA) * (1 - positif_ou_nul(BAFC))
           + positif(V_FORPA) * (1 - positif_ou_nul(BAFP)))
           * LIG1 ;

regle 901890:
application : batch , iliad ;

LIG3700 = positif(LIG4271 + LIG3710 + LIG3720 + LIG3730) * LIG1 * TYPE4 ;

regle 901900:
application : batch , iliad ;

LIG4271 = positif(positif(V_0AB) * LIG1) * (1 - positif(ANNUL2042 + 0)) ;

LIG3710 = positif(20 - V_NOTRAIT) * positif(BOOL_0AZ) * LIG1 ;

regle 901910:
application : batch , iliad ;

LIG3720 = (1 - positif(20 - V_NOTRAIT)) * (1 - positif(LIG3730)) * LIG1 * LIG2 ;

regle 901920:
application : batch , iliad ;

LIG3730 = (1 - positif(20 - V_NOTRAIT))
          * positif(BOOL_0AZ)
          * LIG1 ;

regle 901930:
application : batch , iliad ;

LIG3740 = positif(INDTXMIN) * LIG1 * positif(IND_REV) * (1 - positif(ANNUL2042)) ;

regle 901940:
application : batch , iliad ;

LIG3750 = present(V_ZDC) * null(abs(V_ZDC - 1)) * positif(IREST) * LIG1 ;

regle 901950:
application : iliad , batch ;


LIGPRR2 = positif(PRR2V + PRR2C + PRR2P + PRR2ZV + PRR2ZC + PRR2Z1 + PRR2Z2 + PRR2Z3 + PRR2Z4 + PENALIMV + PENALIMC + PENALIMP + 0) ;

regle 901960:
application : batch , iliad ;

LIG022 = somme(i=1..4:TSNN2iAFF) ;

regle 901970:
application : batch , iliad ;

LIG023 = somme(i=1..4:3TSNi) ;

regle 901980:
application : batch , iliad ;

LIG024 = somme(i=1..4:4TSNi) ;

regle 901990:
application : batch , iliad ;

LIG062V = CARPEV + CARPENBAV + PENSALV + PENSALNBV + CODRAZ;
LIG062C = CARPEC + CARPENBAC + PENSALC + PENSALNBC + CODRBZ;
LIG062P = somme(i=1..4: CARPEPi + CARPENBAPi) + somme(i=1..4: PENSALPi + PENSALNBPi) + CODRCZ + CODRDZ + CODREZ + CODRFZ ;

regle 902000:
application : batch , iliad ;

LIG066 = somme(i=1..4:PEBFi);

regle 902010:
application : batch , iliad ;

LIG390 = GLD1V + GLD1C ;

regle 902020:
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

regle 902030:
application : batch , iliad ;


LIGRCMABT = positif(present(RCMABD) + present(RCMTNC)
                    + present(RCMHAD) + present(RCMHAB) + present(RCMAV) + present(REGPRIV)
                    + present(RCMFR) + present(DEFRCM) + present(DEFRCM2) + present(DEFRCM3)
                    + present(DEFRCM4) + present(DEFRCM5) + present(DEFRCM6))
             * LIG1 * LIG2 * positif(INDREV1A8IR) ;

LIG2RCMABT = positif(present(REVACT) + present(REVPEA) + present(PROVIE) + present(DISQUO) + present(RESTUC) + present(INTERE))
                * LIG1 * LIG2 * positif(INDREV1A8IR) ;

LIGPV3VG = positif(PVBAR3VG) * LIG1 * LIG2 * positif(INDREV1A8IR) ;

LIGPV3WB = positif(PVBAR3WB) * LIG1 * LIG2 * positif(INDREV1A8IR) ;

LIGPV3VE = positif(PVBAR3VE) * LIG1 * LIG2 * positif(INDREV1A8IR) ;

regle 902040:
application : batch , iliad ;


LIG_REPORT = positif(LIGRNIDF + LIGDFRCM + LIGDRFRP + LIGDEFBA
                     + LIGDLMRN + LIGDEFPLOC + LIGBNCDF + LIGDRCVM
                     + somme(i=V,C,P:LIGMIBDREPi + LIGMBDREPNPi + LIGSPEDREPi + LIGSPDREPNPi)
                     + LIGREPREPAR

	             + LIGRCELFABC + LIGRCELFD + LIGRCEL2012 + LIGRCELJBGL + LIGRCELJOQR + LIGRCELJP
                     + LIGRCEL + LIGRCELNBGL + LIGRCELCOM + LIGRCELNQ + LIGRCELHJK + LIGRCELHNO
	             + LIGRCELHLM + LIGRRCEL1 +  LIGRRCEL2 +  LIGRRCEL3 +  LIGRRCEL4

                     + LIGRCODOV + LIGRCODOU + LIGRCODJT + LIGRCODJU 
                     + LIGRLOCIDFG + LIGREPLOCIE + LIGNEUV + LIGRNEUV + LIGVIEU
                     + LIGVIAN + LIGMEUB
                     + LIGREPLOC15 + LIGREPLOC12 + LIGREPLOC11 + LIGREPLOC10 + LIGREPLOC9                      
	             + LIGRDUFLOTOT + LIGRPINELTOT
                     + LIGCOMP01

	             + LIGREPQKG + LIGREPQNH + LIGREPQUS + LIGREPQWB + LIGREPRXC + LIGREPXI
                     + LIGREPMMQE + LIGREPQV + LIGREPQO + LIGREPQP 
	             + LIGREPQR + LIGREPQF + LIGREPQG + LIGREPQI + LIGREPPAK + LIGREPPBL
	             + LIGREPPDO + LIGREPPEK + LIGREPPFL + LIGREPPHO + LIGREPPIZ  + LIGREPCC 
                     + LIGREPPJA + LIGREPCD + LIGREPPLB
	             + LIGREPPM + LIGREPPN + LIGREPPO + LIGREPPP + LIGREPPR + LIGREPPS
	             + LIGREPPT + LIGREPPU + LIGREPPW + LIGREPPX + LIGREPPY 
	             + LIGREPRG + LIGREPRI + LIGREPRM 
	             + LIGREPRR + LIGREPRUP + LIGREPRVQ + LIGREPRWR + LIGREPRYT + LIGREPNW 
                     + LIGREPSAA + LIGREPSAB + LIGREPSAC + LIGREPSAE + LIGREPSAF
                     + LIGREPSAG + LIGREPSAH + LIGREPSAJ + LIGREPSAM 
                     + LIGREPTBE + LIGREPSAU + LIGREPSAV + LIGREPSAW + LIGREPSAY
                     + LIGREPBX + LIGREPBY + LIGREPBZ + LIGREPCB + LIGREPENTD

                     + LIGREPCORSE + LIGPME + LIGRSN + LIGPLAFRSN + LIGREPDON
                     + LIGFOREST + LIGNFOREST + LIGRCIF + LIGRCIFAD + LIGRCIFSIN + LIGRCIFADSN
                     + LIGPATNATR + LIGREPRECH + LIGREPCICE
	             ) * LIG2 ;

regle 902050:
application : iliad , batch ;

LIGRNIDF = positif(abs(RNIDF)) * LIG1 * LIG2 ;
LIGRNIDF0 = positif(abs(RNIDF0)) * positif(positif(abs(RNIDF))+positif(FLAGRETARD08+FLAGDEFAUT11)) * LIG1 * LIG2 ;
LIGRNIDF1 = positif(abs(RNIDF1)) * positif(positif(abs(RNIDF))+positif(FLAGRETARD08+FLAGDEFAUT11)) * LIG1 * LIG2 ;
LIGRNIDF2 = positif(abs(RNIDF2)) * positif(positif(abs(RNIDF))+positif(FLAGRETARD08+FLAGDEFAUT11)) * LIG1 * LIG2 ;
LIGRNIDF3 = positif(abs(RNIDF3)) * positif(positif(abs(RNIDF))+positif(FLAGRETARD08+FLAGDEFAUT11)) * LIG1 * LIG2 ;
LIGRNIDF4 = positif(abs(RNIDF4)) * positif(positif(abs(RNIDF))+positif(FLAGRETARD08+FLAGDEFAUT11)) * LIG1 * LIG2 ;
LIGRNIDF5 = positif(abs(RNIDF5)) * positif(positif(abs(RNIDF))+positif(FLAGRETARD08+FLAGDEFAUT11)) * LIG1 * LIG2 ;

regle 902060:
application : iliad , batch ;

LIGDUFI = positif(DUFLOFI) * LIG1 * LIG2 ;
LIGDUFK = positif(DUFLOFK) * LIG1 * LIG2 ;
LIGDUFLOEKL = positif(DDUFLOEKL) * LIG1 * LIG2 ;
LIGDUFLOGIH = positif(DDUFLOGIH) * LIG1 * LIG2 ;
LIGPIAI = positif(PINELAI) * LIG1 * LIG2 ;
LIGPIBI = positif(PINELBI) * LIG1 * LIG2 ;
LIGPICI = positif(PINELCI) * LIG1 * LIG2 ;
LIGPIDI = positif(PINELDI) * LIG1 * LIG2 ;
LIGPIQGH = positif(DPIQGH) * LIG1 * LIG2 ;
LIGPIQEF = positif(DPIQEF) * LIG1 * LIG2 ;
LIGPIQCD = positif(DPIQCD) * LIG1 * LIG2 ;
LIGPIQAB = positif(DPIQAB) * LIG1 * LIG2 ;
LIGDUFLOT = LIGDUFI + LIGDUFK + LIGDUFLOGIH + LIGDUFLOEKL ; 

LIGPINEL = LIGPIAI + LIGPIBI + LIGPICI + LIGPIDI 
           + LIGPIQGH + LIGPIQEF + LIGPIQCD + LIGPIQAB ;

regle 902070:
application : iliad , batch ;

LIGRDUEKL = positif(RIVDUEKL) * LIG1 * LIG2 ;
LIGRPIQB = positif(RIVPIQB) * LIG1 * LIG2 ;
LIGRPIQD = positif(RIVPIQD) * LIG1 * LIG2 ;
LIGRPIQA = positif(RIVPIQA) * LIG1 * LIG2 ;
LIGRPIQC = positif(RIVPIQC) * LIG1 * LIG2 ;
LIGRPIQH = positif(RIVPIQH) * LIG1 * LIG2 ;
LIGRPIQF = positif(RIVPIQF) * LIG1 * LIG2 ;
LIGRPIQG = positif(RIVPIQG) * LIG1 * LIG2 ;
LIGRPIQE = positif(RIVPIQE) * LIG1 * LIG2 ;
LIGRDUGIH = positif(RIVDUGIH) * LIG1 * LIG2 ;
LIGRDUFLOTOT = LIGRDUEKL + LIGRDUGIH ;
LIGRPINELTOT = LIGRPIQA + LIGRPIQB + LIGRPIQC + LIGRPIQD +
               LIGRPIQE + LIGRPIQF + LIGRPIQG + LIGRPIQH ;

regle 902080:
application : iliad , batch ;

LIGCELLA = positif(DCELRREDLA) * LIG1 * LIG2 ;

LIGCELLB = positif(DCELRREDLB) * LIG1 * LIG2 ;

LIGCELLE = positif(DCELRREDLE) * LIG1 * LIG2 ;

LIGCELLM = positif(DCELRREDLM) * LIG1 * LIG2 ;

LIGCELLN = positif(DCELRREDLN) * LIG1 * LIG2 ;

LIGCELLG = positif(DCELRREDLG) * LIG1 * LIG2 ;

LIGCELLC = positif(DCELRREDLC) * LIG1 * LIG2 ;

LIGCELLD = positif(DCELRREDLD) * LIG1 * LIG2 ;

LIGCELLS = positif(DCELRREDLS) * LIG1 * LIG2 ;

LIGCELLT = positif(DCELRREDLT) * LIG1 * LIG2 ;

LIGCELLH = positif(DCELRREDLH) * LIG1 * LIG2 ;

LIGCELLF = positif(DCELRREDLF) * LIG1 * LIG2 ;

LIGCELLZ = positif(DCELRREDLZ) * LIG1 * LIG2 ;

LIGCELLX = positif(DCELRREDLX) * LIG1 * LIG2 ;

LIGCELLI = positif(DCELRREDLI) * LIG1 * LIG2 ;

LIGCELMG = positif(DCELRREDMG) * LIG1 * LIG2 ;

LIGCELMH = positif(DCELRREDMH) * LIG1 * LIG2 ;

LIGCELLJ = positif(DCELRREDLJ) * LIG1 * LIG2 ;

LIGCELHS = positif(DCELREPHS) * LIG1 * LIG2 ;

LIGCELHR = positif(DCELREPHR) * LIG1 * LIG2 ;

LIGCELHU = positif(DCELREPHU) * LIG1 * LIG2 ;

LIGCELHT = positif(DCELREPHT) * LIG1 * LIG2 ;

LIGCELHZ = positif(DCELREPHZ) * LIG1 * LIG2 ;

LIGCELHX = positif(DCELREPHX) * LIG1 * LIG2 ;

LIGCELHW = positif(DCELREPHW) * LIG1 * LIG2 ;

LIGCELHV = positif(DCELREPHV) * LIG1 * LIG2 ;

LIGCELHF = positif(DCELREPHF) * LIG1 * LIG2 ;


LIGCELHD = positif(DCELREPHD) * LIG1 * LIG2 ;

LIGCELHH = positif(DCELREPHH) * LIG1 * LIG2 ;

LIGCELHG = positif(DCELREPHG) * LIG1 * LIG2 ;


LIGCELHA = positif(DCELREPHA) * LIG1 * LIG2 ;

LIGCELGU = positif(DCELREPGU) * LIG1 * LIG2 ;

LIGCELGX = positif(DCELREPGX) * LIG1 * LIG2 ;

LIGCELGS = positif(DCELREPGS) * LIG1 * LIG2 ;

LIGCELGW = positif(DCELREPGW) * LIG1 * LIG2 ;

LIGCELGL = positif(DCELREPGL) * LIG1 * LIG2 ;

LIGCELGV = positif(DCELREPGV) * LIG1 * LIG2 ;

LIGCELGJ = positif(DCELREPGJ) * LIG1 * LIG2 ;

LIGCELYH = positif(DCELREPYH) * LIG1 * LIG2 ;

LIGCELYL = positif(DCELREPYL) * LIG1 * LIG2 ;


LIGCELYF = positif(DCELREPYF) * LIG1 * LIG2 ;

LIGCELYK = positif(DCELREPYK) * LIG1 * LIG2 ;

LIGCELYD = positif(DCELREPYD) * LIG1 * LIG2 ;

LIGCELYJ = positif(DCELREPYJ) * LIG1 * LIG2 ;

LIGCELYB = positif(DCELREPYB) * LIG1 * LIG2 ;

LIGCELYM = positif(DCELREPYM) * LIG1 * LIG2 ;

LIGCELYN = positif(DCELREPYN) * LIG1 * LIG2 ;

LIGCELYO = positif(DCELREPYO) * LIG1 * LIG2 ;

LIGCELYP = positif(DCELREPYP) * LIG1 * LIG2 ;

LIGCELYQ = positif(DCELREPYQ) * LIG1 * LIG2 ;

LIGCELYR = positif(DCELREPYR) * LIG1 * LIG2 ;

LIGCELYS = positif(DCELREPYS) * LIG1 * LIG2 ;

LIGCELHM = positif(DCELHM) * LIG1 * LIG2 ;

LIGCELHL = positif(DCELHL) * LIG1 * LIG2 ;

LIGCELHNO = positif(DCELHNO) * LIG1 * LIG2 ;

LIGCELHJK = positif(DCELHJK) * LIG1 * LIG2 ;

LIGCELNQ = positif(DCELNQ) * LIG1 * LIG2 ; 

LIGCELNBGL = positif(DCELNBGL) * LIG1 * LIG2 ; 

LIGCELCOM = positif(DCELCOM) * LIG1 * LIG2 ; 

LIGCEL = positif(DCEL) * LIG1 * LIG2 ; 

LIGCELJP = positif(DCELJP) * LIG1 * LIG2 ; 

LIGCELJBGL = positif(DCELJBGL) * LIG1 * LIG2 ; 

LIGCELJOQR = positif(DCELJOQR) * LIG1 * LIG2 ; 

LIGCEL2012 = positif(DCEL2012) * LIG1 * LIG2 ; 

LIGCELFD = positif(DCELFD) * LIG1 * LIG2 ;

LIGCELFABC = positif(DCELFABC) * LIG1 * LIG2 ;

regle 902090:
application : iliad , batch ;


LIGRCEL =  positif(RIVCEL1) * CNRLIG12 ;

LIGRCELNBGL =  positif(RIVCELNBGL1) * CNRLIG12 ;

LIGRCELCOM =  positif(RIVCELCOM1) * CNRLIG12 ;

LIGRCELNQ =  positif(RIVCELNQ1) * CNRLIG12 ;

LIGRCELHJK =  positif(RIVCELHJK1) * CNRLIG12 ;

LIGRCELHNO =  positif(RIVCELHNO1) * CNRLIG12 ;

LIGRCELHLM =  positif(RIVCELHLM1) * CNRLIG12 ;

LIGRCELJP =  positif(RIVCELJP1) * CNRLIG12 ;

LIGRCELJOQR =  positif(RIVCELJOQR1) * CNRLIG12 ;

LIGRCELJBGL =  positif(RIVCELJBGL1) * CNRLIG12 ;

LIGRCEL2012 = positif(RIV2012CEL1) * CNRLIG12 ;

LIGRCELFABC =  positif(RIVCELFABC1) * CNRLIG12 ;

LIGRCELFD =  positif(RIVCELFD1) * CNRLIG12 ;


LIGRRCEL1 = positif(RRCELLJ + RRCELMG + RRCELMH + RRCEL2012) * CNRLIG12 ;
LIGRRCEL11 = positif(RRCELMG) * CNRLIG12 ;
LIGRRCEL12 = positif(RRCELMH) * CNRLIG12 ;
LIGRRCEL13 = positif(RRCELLJ) * CNRLIG12 ;
LIGRRCEL14 = positif(RRCEL2012) * CNRLIG12 ;

LIGRRCEL2 = positif(RRCEL2011 + RRCELLF + RRCELLZ + RRCELLX + RRCELLI ) * CNRLIG12 ;
LIGRRCEL21 = positif(RRCELLF) * CNRLIG12 ;
LIGRRCEL22 = positif(RRCELLZ) * CNRLIG12 ;
LIGRRCEL23 = positif(RRCELLX) * CNRLIG12 ;
LIGRRCEL24 = positif(RRCELLI) * CNRLIG12 ;
LIGRRCEL25 = positif(RRCEL2011) * CNRLIG12 ;

LIGRRCEL3 = positif(RRCEL2010 + RRCELLC + RRCELLD + RRCELLS + RRCELLT + RRCELLH) * CNRLIG12 ;
LIGRRCEL31 = positif(RRCELLC) * CNRLIG12 ;
LIGRRCEL32 = positif(RRCELLD) * CNRLIG12 ;
LIGRRCEL33 = positif(RRCELLS) * CNRLIG12 ;
LIGRRCEL34 = positif(RRCELLT) * CNRLIG12 ;
LIGRRCEL35 = positif(RRCELLH) * CNRLIG12 ;
LIGRRCEL36 = positif(RRCEL2010) * CNRLIG12 ;

LIGRRCEL4 = positif(RRCEL2009 + RRCELLA + RRCELLB + RRCELLE + RRCELLM + RRCELLN + RRCELLG) * CNRLIG12 ;
LIGRRCEL41 = positif(RRCELLA) * CNRLIG12 ;
LIGRRCEL42 = positif(RRCELLB) * CNRLIG12 ;
LIGRRCEL43 = positif(RRCELLE) * CNRLIG12 ;
LIGRRCEL44 = positif(RRCELLM) * CNRLIG12 ;
LIGRRCEL45 = positif(RRCELLN) * CNRLIG12 ;
LIGRRCEL46 = positif(RRCELLG) * CNRLIG12 ;
LIGRRCEL47 = positif(RRCEL2009) * CNRLIG12 ;

regle 902100:
application : iliad , batch ;


LIGPATNAT1 = LIG1 * LIG2 * (positif(PATNAT1) + null(PATNAT1) * positif(V_NOTRAIT - 20)) ;
LIGPATNAT2 = LIG1 * LIG2 * (positif(PATNAT2) + null(PATNAT2) * positif(V_NOTRAIT - 20)) ;
LIGPATNAT3 = LIG1 * LIG2 * (positif(PATNAT3) + null(PATNAT3) * positif(V_NOTRAIT - 20)) ;
LIGPATNAT4 = LIG1 * LIG2 * (positif(PATNAT4) + null(PATNAT4) * positif(V_NOTRAIT - 20)) ;

LIGPATNATR = positif(REPNATR + REPNATR1 + REPNATR2 + REPNATR3) * LIG1 ; 
LIGNATR1 = positif(REPNATR1) * LIG1 ; 
LIGNATR2 = positif(REPNATR2) * LIG1 ; 
LIGNATR3 = positif(REPNATR3) * LIG1 ; 
LIGNATR = positif(REPNATR) * LIG1 ; 

regle 902110:
application : iliad , batch ;


LIGREPQK = positif(REPQK) * CNRLIG1 ;
LIGREPQX = positif(REPQX) * CNRLIG1 ;
LIGREPRD = positif(REPRD) * CNRLIG1 ;
LIGREPXE = positif(REPXE) * CNRLIG1 ;
LIGREPXK = positif(REPXK) * CNRLIG1 ;
LIGREPQKG = positif(REPQK + REPQX + REPRD + REPXE + REPXK) * CNRLIG1 ;

LIGREPQN = positif(REPQN) * CNRLIG1 ;
LIGREPQJ = positif(REPQJ) * CNRLIG1 ;
LIGREPQNH = positif(REPQJ + REPQN) * CNRLIG1 ;

LIGREPQU = positif(REPQU) * CNRLIG1 ;
LIGREPQS = positif(REPQS) * CNRLIG1 ;
LIGREPRA = positif(REPRA) * CNRLIG1 ;
LIGREPXA = positif(REPXA) * CNRLIG1 ;
LIGREPXF = positif(REPXF) * CNRLIG1 ;
LIGREPQUS = positif(REPQS + REPQU + REPRA + REPXA + REPXF) * CNRLIG1 ;

LIGREPQW = positif(REPQW) * CNRLIG1 ;
LIGREPRB = positif(REPRB) * CNRLIG1 ;
LIGREPXB = positif(REPXB) * CNRLIG1 ;
LIGREPXG = positif(REPXG) * CNRLIG1 ;
LIGREPQWB = positif(REPQW + REPRB + REPXB + REPXG) * CNRLIG1 ;

LIGREPRC = positif(REPRC) * CNRLIG1 ;
LIGREPXC = positif(REPXC) * CNRLIG1 ;
LIGREPXH = positif(REPXH) * CNRLIG1 ;
LIGREPRXC = positif(REPRC + REPXC + REPXH) * CNRLIG1 ;

LIGREPXI = positif(REPXI) * CNRLIG1 ;

LIGREPQE = positif(REPQE) * CNRLIG1 ;
LIGREPRJ = positif(REPRJ) * CNRLIG1 ;
LIGREPMMQE = positif(REPRJ + REPQE) * CNRLIG1 ;

LIGREPQV = positif(REPQV) * CNRLIG1 ;

LIGREPQO = positif(REPQO) * CNRLIG1 ;

LIGREPQP = positif(REPQP) * CNRLIG1 ;

LIGREPQR = positif(REPQR) * CNRLIG1 ;

LIGREPQF = positif(REPQF) * CNRLIG1 ;

LIGREPQG = positif(REPQG) * CNRLIG1 ;

LIGREPQI = positif(REPQI) * CNRLIG1 ;

LIGREPPA = positif(REPPA) * CNRLIG1 ;
LIGREPRK = positif(REPRK) * CNRLIG1 ;
LIGREPPAK = positif(REPPA + REPRK) * CNRLIG1 ;

LIGREPPB = positif(REPPB) * CNRLIG1 ;
LIGREPRL = positif(REPRL) * CNRLIG1 ;
LIGREPPBL = positif(REPPB + REPRL) * CNRLIG1 ;

LIGREPPD = positif(REPPD) * CNRLIG1 ;
LIGREPRO = positif(REPRO) * CNRLIG1 ;
LIGREPPDO = positif(REPPD + REPRO) * CNRLIG1 ;

LIGREPPE = positif(REPPE) * CNRLIG1 ;
LIGREPRP = positif(REPRP) * CNRLIG1 ;
LIGREPSK = positif(REPSK) * CNRLIG1 ;
LIGREPAK = positif(REPAK) * CNRLIG1 ;
LIGREPBI = positif(REPBI) * CNRLIG1 ;
LIGREPPEK = positif(REPPE + REPRP + REPSK + REPAK + REPBI) * CNRLIG1 ;

LIGREPPF = positif(REPPF) * CNRLIG1 ;
LIGREPRQ = positif(REPRQ) * CNRLIG1 ;
LIGREPSL = positif(REPSL) * CNRLIG1 ;
LIGREPAL = positif(REPAL) * CNRLIG1 ;
LIGREPBJ = positif(REPBJ) * CNRLIG1 ;
LIGREPPFL = positif(REPPF + REPRQ + REPSL + REPAL + REPBJ) * CNRLIG1 ;

LIGREPPH = positif(REPPH) * CNRLIG1 ;
LIGREPRT = positif(REPRT) * CNRLIG1 ;
LIGREPSO = positif(REPSO) * CNRLIG1 ;
LIGREPAO = positif(REPAO) * CNRLIG1 ;
LIGREPBM = positif(REPBM) * CNRLIG1 ;
LIGREPPHO = positif(REPPH + REPRT + REPSO + REPAO + REPBM) * CNRLIG1 ;

LIGREPPI = positif(REPPI) * CNRLIG1 ;
LIGREPNU = positif(REPNU) * CNRLIG1 ;
LIGREPSZ = positif(REPSZ) * CNRLIG1 ;
LIGREPBA = positif(REPBA) * CNRLIG1 ;
LIGREPPIZ = positif(REPPI + REPNU + REPSZ + REPBA) * CNRLIG1 ;

LIGREPCC = positif(REPCC) * CNRLIG1 ;

LIGREPPJ = positif(REPPJ) * CNRLIG1 ;
LIGREPNV = positif(REPNV) * CNRLIG1 ;
LIGREPTA = positif(REPTA) * CNRLIG1 ;
LIGREPBB = positif(REPBB) * CNRLIG1 ;
LIGREPPJA = positif(REPPJ + REPNV + REPTA + REPBB) * CNRLIG1 ;

LIGREPCD = positif(REPCD) * CNRLIG1 ;

LIGREPPL = positif(REPPL) * CNRLIG1 ;
LIGREPNY = positif(REPNY) * CNRLIG1 ;
LIGREPTD = positif(REPTD) * CNRLIG1 ;
LIGREPBG = positif(REPBG) * CNRLIG1 ;
LIGREPCG = positif(REPCG) * CNRLIG1 ;
LIGREPPLB = positif(REPPL + REPNY + REPTD + REPBG + REPCG) * CNRLIG1 ;

LIGREPPM = positif(REPPM) * CNRLIG1 ;

LIGREPPN = positif(REPPN) * CNRLIG1 ;

LIGREPPO = positif(REPPO) * CNRLIG1 ;

LIGREPPP = positif(REPPP) * CNRLIG1 ;

LIGREPPR = positif(REPPR) * CNRLIG1 ;

LIGREPPS = positif(REPPS) * CNRLIG1 ;

LIGREPPT = positif(REPPT) * CNRLIG1 ;

LIGREPPU = positif(REPPU) * CNRLIG1 ;

LIGREPPW = positif(REPPW) * CNRLIG1 ;

LIGREPPX = positif(REPPX) * CNRLIG1 ;

LIGREPPY = positif(REPPY) * CNRLIG1 ;

LIGREPRG = positif(REPRG) * CNRLIG1 ;

LIGREPRI = positif(REPRI) * CNRLIG1 ;

LIGREPRM = positif(REPRM) * CNRLIG1 ;

LIGREPRR = positif(REPRR) * CNRLIG1 ;

LIGREPRU = positif(REPRU) * CNRLIG1 ;
LIGREPSP = positif(REPSP) * CNRLIG1 ;
LIGREPAP = positif(REPAP) * CNRLIG1 ;
LIGREPBN = positif(REPBN) * CNRLIG1 ;
LIGREPRUP = positif(REPRU + REPSP + REPAP + REPBN) * CNRLIG1 ;

LIGREPRV = positif(REPRV) * CNRLIG1 ;
LIGREPSQ = positif(REPSQ) * CNRLIG1 ;
LIGREPAQ = positif(REPAQ) * CNRLIG1 ;
LIGREPBO = positif(REPBO) * CNRLIG1 ;
LIGREPRVQ = positif(REPRV + REPSQ + REPAQ + REPBO) * CNRLIG1 ;

LIGREPRW = positif(REPRW) * CNRLIG1 ;
LIGREPSR = positif(REPSR) * CNRLIG1 ;
LIGREPHAR = positif(REPHAR) * CNRLIG1 ;
LIGREPBP = positif(REPBP) * CNRLIG1 ;
LIGREPRWR = positif(REPRW + REPSR + REPHAR + REPBP) * CNRLIG1 ;

LIGREPRY = positif(REPRY) * CNRLIG1 ;
LIGREPST = positif(REPST) * CNRLIG1 ;
LIGREPAT = positif(REPAT) * CNRLIG1 ;
LIGREPBR = positif(REPBR) * CNRLIG1 ;
LIGREPRYT = positif(REPRY + REPST + REPAT + REPBR) * CNRLIG1 ;

LIGREPNW = positif(REPNW) * CNRLIG1 ;

LIGREPSA = positif(REPSA) * CNRLIG1 ;
LIGREPAA = positif(REPAA) * CNRLIG1 ;
LIGREPSAA = positif(REPSA + REPAA) * CNRLIG1 ;

LIGREPSB = positif(REPSB) * CNRLIG1 ;
LIGREPAB = positif(REPAB) * CNRLIG1 ;
LIGREPSAB = positif(REPSB + REPAB) * CNRLIG1 ;

LIGREPSC = positif(REPSC) * CNRLIG1 ;
LIGREPAC = positif(REPAC) * CNRLIG1 ;
LIGREPSAC = positif(REPSC + REPAC) * CNRLIG1 ;

LIGREPSE = positif(REPSE) * CNRLIG1 ;
LIGREPAE = positif(REPAE) * CNRLIG1 ;
LIGREPSAE = positif(REPSE + REPAE) * CNRLIG1 ;

LIGREPSF = positif(REPSF) * CNRLIG1 ;
LIGREPAF = positif(REPAF) * CNRLIG1 ;
LIGREPSAF = positif(REPSF + REPAF) * CNRLIG1 ;

LIGREPSG = positif(REPSG) * CNRLIG1 ;
LIGREPAG = positif(REPAG) * CNRLIG1 ;
LIGREPSAG = positif(REPSG + REPAG) * CNRLIG1 ;

LIGREPSH = positif(REPSH) * CNRLIG1 ;
LIGREPAH = positif(REPAH) * CNRLIG1 ;
LIGREPSAH = positif(REPSH + REPAH) * CNRLIG1 ;

LIGREPSJ = positif(REPSJ) * CNRLIG1 ;
LIGREPAJ = positif(REPAJ) * CNRLIG1 ;
LIGREPSAJ = positif(REPSJ + REPAJ) * CNRLIG1 ;

LIGREPSM = positif(REPSM) * CNRLIG1 ;
LIGREPAM = positif(REPAM) * CNRLIG1 ;
LIGREPBK = positif(REPBK) * CNRLIG1 ;
LIGREPSAM = positif(REPSM + REPAM + REPBK) * CNRLIG1 ;

LIGREPTB = positif(REPTB) * CNRLIG1 ;
LIGREPBE = positif(REPBE) * CNRLIG1 ;
LIGREPCE = positif(REPCE) * CNRLIG1 ;
LIGREPTBE = positif(REPTB + REPBE + REPCE) * CNRLIG1 ;

LIGREPSU = positif(REPSU) * CNRLIG1 ;
LIGREPAU = positif(REPAU) * CNRLIG1 ;
LIGREPBS = positif(REPBS) * CNRLIG1 ;
LIGREPSAU = positif(REPSU + REPAU + REPBS) * CNRLIG1 ;

LIGREPSV = positif(REPSV) * CNRLIG1 ;
LIGREPAV = positif(REPAV) * CNRLIG1 ;
LIGREPBT = positif(REPBT) * CNRLIG1 ;
LIGREPSAV = positif(REPSV + REPAV + REPBT) * CNRLIG1 ;

LIGREPSW = positif(REPSW) * CNRLIG1 ;
LIGREPAW = positif(REPAW) * CNRLIG1 ;
LIGREPBU = positif(REPBU) * CNRLIG1 ;
LIGREPSAW = positif(REPSW + REPAW + REPBU) * CNRLIG1 ;

LIGREPSY = positif(REPSY) * CNRLIG1 ;
LIGREPAY = positif(REPAY) * CNRLIG1 ;
LIGREPBW = positif(REPBW) * CNRLIG1 ;
LIGREPSAY = positif(REPSY + REPAY + REPBW) * CNRLIG1 ;

LIGREPBX = positif(REPBX) * CNRLIG1 ;

LIGREPBY = positif(REPBY) * CNRLIG1 ;

LIGREPBZ = positif(REPBZ) * CNRLIG1 ;

LIGREPCB = positif(REPCB) * CNRLIG1 ;

LIGREPENTD = positif(REPENTD) * CNRLIG1 ;


LIGREPDON = positif(REPDONR + REPDONR1 + REPDONR2 + REPDONR3 + REPDONR4) * CNRLIG1 ;
LIGREPDONR1 = positif(REPDONR1) * CNRLIG1 ;
LIGREPDONR2 = positif(REPDONR2) * CNRLIG1 ;
LIGREPDONR3 = positif(REPDONR3) * CNRLIG1 ;
LIGREPDONR4 = positif(REPDONR4) * CNRLIG1 ;
LIGREPDONR = positif(REPDONR) * CNRLIG1 ;
LIGRIDOMPRO = positif(RIDOMPRO) * LIG1 ;

LIGPME1 = positif(REPINVPME1) * CNRLIG1 ;
LIGPME2 = positif(REPINVPME2) * CNRLIG1 ;
LIGPME3 = positif(REPINVPME3) * CNRLIG1 ;
LIGPMECU = positif(REPINVPMECU) * CNRLIG1 ;

LIGRSN = positif(RINVTPME12 + RINVTPME13 + RINVTPME14 + RINVTPME15) * CNRLIG1 ;
LIGRSN3 = positif(RINVTPME12) * CNRLIG1 ;
LIGRSN2 = positif(RINVTPME13) * CNRLIG1 ;
LIGRSN1 = positif(RINVTPME14) * CNRLIG1 ;
LIGRSN0 = positif(RINVTPME15) * CNRLIG1 ;

LIGPLAFRSN = positif(PLAFREPSN5 + PLAFREPSN4 + PLAFREPSN3) * CNRLIG1 ;
LIGPLAFRSN5 = positif(PLAFREPSN5) * CNRLIG1 ;
LIGPLAFRSN4 = positif(PLAFREPSN4) * CNRLIG1 ;
LIGPLAFRSN3 = positif(PLAFREPSN3) * CNRLIG1 ;

LIGFOREST = positif(REPFOREST2 + REPFOREST3 + REPEST) * CNRLIG12 ;
LIGREPFOR2 = positif(REPFOREST2) * CNRLIG12 ;
LIGREPFOR3 = positif(REPFOREST3) * CNRLIG12 ;
LIGREPEST = positif(REPEST) * CNRLIG12 ;

regle 902120:
application : batch , iliad ;

EXOVOUS = present ( TSASSUV ) 
          + positif ( XETRANV )
          + positif ( EXOCETV ) 
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

EXOCJT = present ( TSASSUC ) 
         + positif ( XETRANC )
         + positif ( EXOCETC ) 
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

EXOPAC = present ( FEXP ) 
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

regle 902130:
application : batch , iliad ;

LIGTITREXVCP = positif(EXOVOUS)
               * positif(EXOCJT)
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;

LIGTITREXV = positif(EXOVOUS)
             * (1 - positif(EXOCJT))
             * (1 - positif(EXOPAC))
	     * (1 - positif(LIG2501))
             * LIG1 * LIG2 ;

LIGTITREXC =  (1 - positif(EXOVOUS))
               * positif(EXOCJT)
               * (1 - positif(EXOPAC))
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;

LIGTITREXP =  (1 - positif(EXOVOUS))
               * (1 - positif(EXOCJT))
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;

LIGTITREXVC =  positif(EXOVOUS)
               * positif(EXOCJT)
               * (1 - positif(EXOPAC))
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;

LIGTITREXVP =  positif(EXOVOUS)
               * (1 - positif(EXOCJT))
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;

LIGTITREXCP =  (1 - positif(EXOVOUS))
               * positif(EXOCJT) 
               * positif(EXOPAC)
	       * (1 - positif(LIG2501))
               * LIG1 * LIG2 ;

regle 902140:
application : batch , iliad ;

EXOCET = EXOCETC + EXOCETV ;
LIGEXOCET = positif(EXOCET) * LIG1 * LIG2 ;

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
LIGXFORF =  positif(present(FEXV) + present(FEXC) + present(FEXP)) * LIG1 * LIG2 ;
LIGXBA =  positif(XBAV + XBAC + XBAP) * LIG1 * LIG2 ;

LIGBICAP = positif(ABICPDECV + ABICPDECC + ABICPDECP) * CNRLIG12 ;
LIGBNCAP = positif(ABNCPDECV + ABNCPDECC + ABNCPDECP) * CNRLIG12 ;
LIGHONO = positif(HONODECV + HONODECC + HONODECP) * CNRLIG12 ;

LIGBAPERP =  positif(BAPERPV + BAPERPC + BAPERPP + BANOCGAV + BANOCGAC + BANOCGAP) * LIG1 * LIG2 ;
LIGBIPERP =  positif(BIPERPV + BIPERPC + BIPERPP) * LIG1 * LIG2 ;
LIGBNCCREA =  positif(BNCCREAV + BNCCREAC + BNCCREAP) * LIG1 * LIG2 ;

regle 902150:
application : batch , iliad ;


LIGPERP = (1 - positif(PERPIMPATRIE+0))
                 * positif(PERPINDV + PERPINDC + PERPINDP
                        + PERPINDCV + PERPINDCC + PERPINDCP)
                 * positif(PERPINDAFFV+PERPINDAFFC+PERPINDAFFP)
                  * (1 - null(PERP_COTV + PERP_COTC + PERP_COTP + 0) * (1 - INDIMPOS))
                  * (1 - positif(PERP_COND1+PERP_COND2))
                  * (1 - positif(LIG8FV))
                  * (1 - positif(LIG2501))
                  * CNRLIG12 
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
                  * CNRLIG12
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
                  * CNRLIG12
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
                  * CNRLIG12
                  +0
                  ;

LIGPERPFAM = positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
              * positif(PERPINDC + PERPINDCC)* positif(PERPINDAFFC)
              * positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
              * CNRLIG12
              * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
              ;

LIGPERPV = positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
           * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
           * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
           * CNRLIG12
           * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
           ;

LIGPERPC = positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC)
          * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
          * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
          * CNRLIG12
          * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
          ;

LIGPERPP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
           * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
           * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
           * CNRLIG12
           * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
           ;

LIGPERPCP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
           * positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFV)
           * (1 - positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV))
           * CNRLIG12
           * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
           ;

LIGPERPVP = positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP)
           * positif(PERPINDV + PERPINDCV) * positif(PERPINDAFFV)
           * (1 - positif(PERPINDC + PERPINDCC) * positif(PERPINDAFFC))
           * CNRLIG12
           * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
           ;

LIGPERPMAR = positif(PERPINDV + PERPINDCV)  * positif(PERPINDAFFV)
             * positif(PERPINDC + PERPINDCC)  * positif(PERPINDAFFC)
             * (1 - positif(PERPINDP + PERPINDCP) * positif(PERPINDAFFP))
             * CNRLIG12
             * positif(LIGPERP + LIGPERPI + LIGPERPM + LIGPERPMI)
             ;

regle 902160:
application : batch , iliad ;


ZIG_TITRECRP = positif(BCSG + V_CSANT + COD8RU+COD8RV )
             * positif(BRDS + V_RDANT + COD8RU+COD8RV ) 
             * positif(BPRS + V_PSANT + COD8RU+COD8RV ) * (1 - positif(BCVNSAL + V_CVNANT))
                                       * (1 - (V_CNR * (1 - positif(ZIG_RF + max(0, NPLOCNETSF))))) * LIG2 ;

ZIGTITRECRPS = positif(BCSG + V_CSANT) * positif(BRDS + V_RDANT) * positif(BPRS + V_PSANT) * positif(BCVNSAL + V_CVNANT)
                                       * (1 - (V_CNR * (1 - positif(ZIG_RF + max(0, NPLOCNETSF))))) * LIG2 ;

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

regle 902170:
application : batch , iliad ;

ZIGTITRE = positif((positif(BCSG + V_CSANT + BRDS + V_RDANT + BPRS + V_PSANT) * (1 - (V_CNR * (1 - positif(ZIG_RF+max(0,NPLOCNETSF))))) 
		       + positif (BCVNSAL + V_CVNANT + BCDIS + V_CDISANT)+ positif(COD8RU+COD8RV)
                   ) * TYPE4
		  ) * (1 - positif(ANNUL2042)) ;

ZIGBASECS1 = positif(BCSG + V_CSANT) * positif(INDCTX) ;
ZIGBASERD1 = positif(BRDS + V_RDANT) * positif(INDCTX) ;
ZIGBASEPS1 = positif(BPRS + V_PSANT) * positif(INDCTX) ;
ZIGBASESAL1 = positif(BCVNSAL + V_CVNANT) * positif(INDCTX) ;

regle 902180:
application : batch , iliad ;

CS_RVT = RDRV ;
RD_RVT = CS_RVT;
PS_RVT = CS_RVT;
IND_ZIGRVT =  0;

ZIG_RVTO = positif (CS_RVT + RD_RVT + PS_RVT + IND_ZIGRVT)
                   * (1 - positif(ANNUL2042)) * null(3 - INDIRPS) * CNRLIG12 ;

regle 902190:
application : batch , iliad ;

CS_RCM =  RDRCM ;
RD_RCM = CS_RCM ;
PS_RCM = CS_RCM ;

IND_ZIGRCM = positif(present(RCMABD) + present(RCMAV) + present(RCMHAD) + present(RCMHAB)  
                     + present(RCMTNC) + present(RCMAVFT) + present(REGPRIV)) 
	      * positif(V_NOTRAIT - 20) ;

ZIG_RCM = positif(CS_RCM + RD_RCM + PS_RCM + IND_ZIGRCM)
                   * (1 - positif(ANNUL2042)) * null(3 - INDIRPS) * CNRLIG12 ;

regle 902200:
application : batch , iliad ;

CS_REVCS = RDNP ;
RD_REVCS = CS_REVCS ;
PS_REVCS = CS_REVCS ;

IND_ZIGPROF = positif(V_NOTRAIT - 20) * positif( present(RCSV)
                     +present(RCSC)
                     +present(RCSP));
ZIG_PROF = positif(CS_REVCS+RD_REVCS+PS_REVCS+IND_ZIGPROF)
           * (1 - positif(ANNUL2042)) * LIG1 * null(3 - INDIRPS) ;


regle 902210:
application : batch , iliad ;


CS_RFG = RDRFPS ;
RD_RFG = CS_RFG ;
PS_RFG = CS_RFG ;

IND_ZIGRFG = positif(V_NOTRAIT - 20) * positif( present(RFORDI)
                     +present(RFDORD)
                     +present(RFDHIS)
                     +present(RFMIC) );

ZIG_RF = positif(CS_RFG + RD_RFG + PS_RFG + IND_ZIGRFG) * (1 - positif(ANNUL2042)) * LIG1 * LIG2 * null(3 - INDIRPS) ;

regle 902220:
application : batch , iliad ;


CS_RTF = RDPTP + RDNCP ;
RD_RTF = CS_RTF ;
PS_RTF = CS_RTF ;

IND_ZIGRTF=  positif(V_NOTRAIT - 20) * positif (present (PEA) + present( BPCOPTV ) + present( BPVRCM )) ;

ZIG_RTF = positif (CS_RTF + RD_RTF + PS_RTF + IND_ZIGRTF)
                   * (1 - positif(ANNUL2042)) * null(3 - INDIRPS) * CNRLIG12 ;

ZIGGAINLEV = positif(CVNSALC) * positif(CVNSALAV) * LIG1 * LIG2 ;

regle 902230:
application : batch , iliad ;


CS_REVETRANG = 0 ;
RD_REVETRANG = SALECS + SALECSG + ALLECS + INDECS + PENECS 
             + COD8SA + COD8SB + COD8SC + COD8SW + COD8SX ;
PS_REVETRANG = 0 ;


ZIG_REVETR = positif(SALECS + SALECSG + ALLECS + INDECS + PENECS 
                     + COD8SA +COD8SB + COD8SC + COD8SW + COD8SX )
                   * CNRLIG12 ;

regle 902240:
application : batch , iliad ;


CS_RVORIGND =   ESFP;
RD_RVORIGND =   ESFP;
PS_RVORIGND =   ESFP;

IND_ZIGREVORIGIND = present(ESFP) ;

ZIG_RVORIGND = positif (CS_RVORIGND + RD_RVORIGND + PS_RVORIGND
                         + IND_ZIGREVORIGIND)
                   * CNRLIG12 ;

regle 902250:
application : batch , iliad ;

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

ZIGR1649 = positif(R1649) * CNRLIG12 ;
ZIGPREREV = positif(PREREV) * CNRLIG12 ;

regle 902255:
application : batch , iliad ;

REVNONASSU = ( COD8RU + COD8RV ) * positif(COD8RU + COD8RV +0) ;
ZIGNONASSU = positif( COD8RU + COD8RV ) * LIG2 ;


regle 902260:
application : batch , iliad ;
 

LIGPS = positif(BCSG + BRDS + BPRS + BCVNSAL + BCDIS 
                + BGLOA + BRSE1 + BRSE2 + BRSE3 + BRSE4 + BRSE5 + BRSE6 + 0
                + positif(COD8RU+COD8RV)
               ) 
	 * (1 - positif(ANNUL2042)) ;

LIGPSP = 1 - (null(LIGPS) * null(V_ANTCR)) ;

NONLIGPS = positif(positif(1 - LIGPS) + positif(null(V_NOTRAIT - 23) + null(V_NOTRAIT - 33) + null(V_NOTRAIT - 43) + null(V_NOTRAIT - 53) + null(V_NOTRAIT - 63))) ;

INDIRPS =  (1 * (1 - LIGPS) * positif(3 - ANTINDIRPS))
	 + (3 * (1- positif((1 - LIGPS) * positif(3 - ANTINDIRPS)))) ;

regle 902270:
application : batch , iliad ;


CS_BASE = BCSG ;
RD_BASE = BRDS ;
PS_BASE = BPRS ;
ZIGBASECS = positif(BCSG + V_CSANT + COD8RU + COD8RV) ;
ZIGBASERD = positif(BRDS + V_RDANT + COD8RU + COD8RV) ;
ZIGBASEPS = positif(BPRS + V_PSANT + COD8RU + COD8RV) ;
ZIGBASECVN = positif(BCVNSAL + V_CVNANT) ;
ZIG_BASE = positif(BCSG + BRDS + BPRS + BCVNSAL + V_CSANT + V_RDANT + V_PSANT + V_CVNANT + COD8RU + COD8RV) * LIG2 ;
ZIGCDIS = positif(BCDIS + V_CDISANT) * LIG2 ;
ZIGGLOA = positif(BGLOA) * (1 - V_CNR) * LIG2 ;
ZIGGLOANR = positif(BGLOACNR) * LIG2 ;
ZIGGLOALL = positif(ZIGGLOA + ZIGGLOANR) * LIG2 ;
ZIGRSE1 = positif(BRSE1) * LIG2 ; 
ZIGRSE2 = positif(BRSE2) * LIG2 ;
ZIGRSE3 = positif(BRSE3) * LIG2 ;
ZIGRSE4 = positif(BRSE4) * LIG2 ;
ZIGRSE5 = positif(BRSE5) * LIG2 ;
ZIGRSE6 = positif(BRSE6) * LIG2 ;


ZIGRFRET = positif(COD8YK) * (1-positif(COD8XK)) * LIG2 ;
ZIGRFDEP = positif(COD8XK) * (1-positif(COD8YK)) * LIG2 ;

regle 902280:
application : batch , iliad ;

ZIG_TAUXCRP  = ZIG_TITRECRP ;
ZIG_TAUXCR   = ZIG_TITRECR ;
ZIG_TAUXCP   = ZIG_TITRECP ;
ZIG_TAUXRP   = ZIG_TITRERP ;
ZIG_TAUXR    = ZIG_TITRER ;
ZIGTAUX1 = ZIGTITRECRPS ;
ZIGTAUX3 = ZIGTITRECRS ;
ZIGTAUX4 = ZIG_TITRECR ;

regle 902290:
application : batch , iliad ;

ZIGMONTS = positif(BCVNSAL + V_CVNANT) ;
ZIGMONTCS = positif(BCSG + V_CSANT + COD8RU+COD8RV) ;
ZIGMONTRD = positif(BRDS + V_RDANT + COD8RU+COD8RV) ;
ZIGMONTPS = positif(BPRS + V_PSANT + COD8RU+COD8RV) ;
ZIG_MONTANT = positif (BCSG + BRDS + BPRS + BCVNSAL + V_CSANT + V_RDANT + V_PSANT + V_CVNANT + COD8RU+COD8RV) * (1 - positif(ANNUL2042)) ;

regle 902300:
application : batch , iliad ;


ZIG_INT =  positif (RETCS + RETRD + RETPS + RETCVN) * LIG2 ;

ZIGINT = positif(RETCDIS) * LIG2 ;

ZIGLOA = positif(RETGLOA) * LIG2 ;

ZIGINT1 = positif(RETRSE1) * LIG2 ;
ZIGINT2 = positif(RETRSE2) * LIG2 ;
ZIGINT3 = positif(RETRSE3) * LIG2 ;
ZIGINT4 = positif(RETRSE4) * LIG2 ;
ZIGINT5 = positif(RETRSE5) * LIG2 ;
ZIGINT6 = positif(RETRSE6) * LIG2 ;

ZIGINT22 = positif(RETCDIS22) ;
ZIGLOA22 = positif(RETGLOA22) ;

ZIGINT122 = positif(RETRSE122) * LIG2 ;
ZIGINT222 = positif(RETRSE222) * LIG2 ;
ZIGINT322 = positif(RETRSE322) * LIG2 ;
ZIGINT422 = positif(RETRSE422) * LIG2 ;
ZIGINT522 = positif(RETRSE522) * LIG2 ;
ZIGINT622 = positif(RETRSE622) * LIG2 ;

regle 902310:
application : batch , iliad ;

ZIG_PEN17281 = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJCVN1) * LIG2 ;

ZIG_PENATX4 = ZIG_PENAMONT * positif(NMAJC4 + NMAJR4 + NMAJP4 + NMAJCVN4) * LIG2 ;
ZIG_PENATAUX = ZIG_PENAMONT * positif(NMAJC1 + NMAJR1 + NMAJP1 + NMAJCVN1) * LIG2 ;

ZIGNONR30 = positif(ZIG_PENATX4) * positif(1 - positif(R1649 + PREREV)) * LIG2 ;
ZIGR30 = positif(ZIG_PENATX4) * positif(R1649 + PREREV) * LIG2 ;

ZIGPENACDIS = positif(PCDIS) * positif(NMAJCDIS1) * LIG2 ;

ZIGPENAGLO1 = positif(PGLOA) * positif(NMAJGLO1) * LIG2 ;

ZIGPENARSE1 = positif(PRSE1) * positif(NMAJRSE11) * LIG2 ;
ZIGPENARSE2 = positif(PRSE2) * positif(NMAJRSE21) * LIG2 ;
ZIGPENARSE3 = positif(PRSE3) * positif(NMAJRSE31) * LIG2 ;
ZIGPENARSE4 = positif(PRSE4) * positif(NMAJRSE41) * LIG2 ;
ZIGPENARSE5 = positif(PRSE5) * positif(NMAJRSE51) * LIG2 ;
ZIGPENARSE6 = positif(PRSE6) * positif(NMAJRSE61) * LIG2 ;

ZIGPENACDIS4 = positif(PCDIS) * positif(NMAJCDIS4) * LIG2 ;

ZIGPENAGLO4 = positif(PGLOA) * positif(NMAJGLO4) * LIG2 ;

ZIGPENARSE14 = positif(PRSE1) * positif(NMAJRSE14) * LIG2 ;
ZIGPENARSE24 = positif(PRSE2) * positif(NMAJRSE24) * LIG2 ;
ZIGPENARSE34 = positif(PRSE3) * positif(NMAJRSE34) * LIG2 ;
ZIGPENARSE44 = positif(PRSE4) * positif(NMAJRSE44) * LIG2 ;
ZIGPENARSE54 = positif(PRSE5) * positif(NMAJRSE54) * LIG2 ;
ZIGPENARSE64 = positif(PRSE6) * positif(NMAJRSE64) * LIG2 ;

regle 902320:
application : batch , iliad ;

ZIG_PENAMONT = positif(PCSG + PRDS + PPRS + PCVN) * LIG2 ;

regle 902330:
application : batch , iliad ;

ZIG_CRDETR = positif(CICSG + CIRDS + CIPRS + CICVN) * LIG2 ;

regle 902340 :
application : batch , iliad ;

ZIGCOD8YL = positif(COD8YL) * TYPE2;
CGLOAPROV = COD8YL * (1-V_CNR) ;
ZIGCOD8YT = positif(COD8YT) * TYPE2;
ZIGCDISPROV = positif(CDISPROV) * TYPE2 ;

ZIGREVXA = positif(REVCSXA) * TYPE2 ;

ZIGREVXB = positif(REVCSXB) * TYPE2 ;
ZIGREVXC = positif(REVCSXC + COD8XI) * TYPE2 ;

ZIGREVXD = positif(REVCSXD) * TYPE2 ;
ZIGREVXE = positif(REVCSXE + COD8XJ) * TYPE2 ;

ZIGPROVYD = positif(CSPROVYD) * TYPE2 ;

ZIGPROVYE = positif(CSPROVYE) * TYPE2 ;

ZIGPROVYF = positif(CSPROVYF + CSPROVYN) * TYPE2 ;
CSPROVRSE2 = CSPROVYF + CSPROVYN ;

ZIGPROVYG = positif(CSPROVYG) * TYPE2 ;

ZIGPROVYH = positif(CSPROVYH + CSPROVYP) * TYPE2 ;
CSPROVRSE4 = CSPROVYH + CSPROVYP ;

ZIGCIRSE6 = positif(REVCSXB+REVCSXC+COD8XI) * TYPE2 ;
regle 902350 :
application : batch , iliad ;

ZIG_CTRIANT = positif(V_ANTCR) * TYPE2 ;

ZIGCSANT = positif(V_CSANT) * TYPE2* (1 - APPLI_OCEANS) ;

ZIGRDANT = positif(V_RDANT) * TYPE2 * (1 - APPLI_OCEANS);

ZIGPSANT = positif(V_PSANT) * TYPE2 * (1 - APPLI_OCEANS);

ZIGCVNANT = positif(V_CVNANT) * TYPE2 * (1 - APPLI_OCEANS);

ZIGREGVANT = positif(V_REGVANT) * TYPE2 * (1 - APPLI_OCEANS);

ZIGCDISANT = positif(V_CDISANT) * TYPE2 * (1 - APPLI_OCEANS);

ZIGLOANT = positif(V_GLOANT) * TYPE2 * (1 - APPLI_OCEANS);

ZIGRSE1ANT = positif(V_RSE1ANT) * TYPE2 * (1 - APPLI_OCEANS);
ZIGRSE2ANT = positif(V_RSE2ANT) * TYPE2 * (1 - APPLI_OCEANS);
ZIGRSE3ANT = positif(V_RSE3ANT) * TYPE2 * (1 - APPLI_OCEANS);
ZIGRSE4ANT = positif(V_RSE4ANT) * TYPE2 * (1 - APPLI_OCEANS);
ZIGRSE5ANT = positif(V_RSE5ANT) * TYPE2 * (1 - APPLI_OCEANS);
ZIGRSE6ANT = positif(V_RSE6ANT) * TYPE2 * (1 - APPLI_OCEANS);

regle 902360:
application : batch , iliad ;


ZIG_CTRIPROV = positif(COD8YT + PRSPROV + CSGIM + CRDSIM) * LIG2 ;

ZIG_CONTRIBPROV_A = positif(PRSPROV_A + CSGIM_A + CRDSIM_A) * LIG2 ;

regle 902370:
application : batch , iliad ;


IND_COLC = positif(BCSG) * positif(PCSG + CICSG + CSGIM) * (1 - INDCTX) ;

IND_COLR = positif(BRDS) * positif(PRDS + CIRDS + CRDSIM) * (1 - INDCTX) ;

IND_COLP = positif(BPRS) * positif(PPRS + CIPRS + PRSPROV) * (1 - INDCTX) ;

INDCOLVN = positif(BCVNSAL) * positif(PCVN + CICVN + COD8YT) * (1 - INDCTX) ;

INDCOL = positif(IND_COLC + IND_COLR + IND_COLP + INDCOLVN) ;

IND_COLD = positif(BCDIS) * positif(PCDIS + CDISPROV) * (1 - INDCTX) ;

INDGLOA = positif(BGLOA) * positif(PGLOA+COD8YL) * (1 - INDCTX) ;

INDRSE1 = positif(BRSE1) * positif(PRSE1 + CIRSE1 + CSPROVYD) * (1 - INDCTX) ;
INDRSE2 = positif(BRSE2) * positif(PRSE2 + CIRSE2 + CSPROVYF + CSPROVYN) * (1 - INDCTX) ;
INDRSE3 = positif(BRSE3) * positif(PRSE3 + CIRSE3 + CSPROVYG) * (1 - INDCTX) ;
INDRSE4 = positif(BRSE4) * positif(PRSE4 + CIRSE4 + CSPROVYH + CSPROVYP) * (1 - INDCTX) ;
INDRSE5 = positif(BRSE5) * positif(PRSE5 + CIRSE5 + CSPROVYE) * (1 - INDCTX) ;

INDRSE6 = positif(BRSE6) * positif(PRSE6 + CIRSE6 ) * (1 - INDCTX) ;

IND_CTXC = positif(CS_DEG) * positif(BCSG) * positif(INDCTX) ;

IND_CTXR = positif(CS_DEG) * positif(BRDS) * positif(INDCTX) ;

IND_CTXP = positif(CS_DEG) * positif(BPRS) * positif(INDCTX) ;

IND_CTXD = positif(CS_DEG) * positif(BCDIS) * positif(INDCTX) ;

INDRSE1X = positif(CS_DEG) * positif(BRSE1) * positif(INDCTX) ;
INDRSE2X = positif(CS_DEG) * positif(BRSE2) * positif(INDCTX) ;
INDRSE3X = positif(CS_DEG) * positif(BRSE3) * positif(INDCTX) ;
INDRSE4X = positif(CS_DEG) * positif(BRSE4) * positif(INDCTX) ;
INDRSE5X = positif(CS_DEG) * positif(BRSE5) * positif(INDCTX) ;
INDRSE6X = positif(CS_DEG) * positif(BRSE6) * positif(INDCTX) ;

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
INDE6 = positif(INDRSE6 + INDRSE6X) * INDTRAIT ;

regle 902380:
application : batch , iliad ;

ZIG_NETAP =  positif (BCSG  + BRDS + BPRS + BCVNSAL + BCDIS 
                      + BGLOA + BRSE1 + BRSE2 + BRSE3 + BRSE4 
                      + BRSE5  + BRSE6 + COD8RU+COD8RV)
             * LIG2 ;

regle 902390:
application : batch , iliad ;

ZIG_TOTDEG = positif (CRDEG) * positif(INDCTX) ;

ZIG_TITREP = ZIG_NETAP + ZIG_TOTDEG ;

ZIGANNUL = positif(INDCTX) * positif(ANNUL2042) ;

regle 902400:
application : batch , iliad ;

ZIG_INF8 = positif (CS_DEG) * positif (SEUIL_8 - CS_DEG) * LIG2 ;

regle 902410:
application : batch , iliad ;

ZIG_REMPLACE  = positif((1 - positif(20 - V_NOTRAIT)) 
               * positif(V_ANREV - V_0AX)
               * positif(V_ANREV - V_0AZ)
               * positif(V_ANREV - V_0AY) + positif(V_NOTRAIT - 20))
               * LIG2 ;

regle 902420:
application : batch , iliad ;


ZIG_DEGINF61 = positif(V_CSANT+V_RDANT+V_PSANT+0)  
               * positif(CRDEG+0)
               * positif(SEUIL_61-TOTCRA-CSNET-RDNET-PRSNET-CDISNET+0)
               * (1 - null(CSTOT+0))
               * LIG2 ;

regle 902430:
application : batch , iliad ;


ZIG_CSGDDO = positif(V_IDANT - DCSGD) * positif(IDCSG) * (1 - null(V_IDANT + DCSGD + 0)) * (1 - null(V_IDANT - DCSGD)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIG_CSGDRS = positif(DCSGD - V_IDANT) * positif(IDCSG) * (1 - null(V_IDANT + DCSGD + 0)) * (1 - null(V_IDANT - DCSGD)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIG_CSGDC = positif(ZIG_CSGDDO + ZIG_CSGDRS + null(V_IDANT - DCSGD)) * (1 - null(V_IDANT + DCSGD + 0)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIG_CSGDCOR = positif(ZIG_CSGDDO + ZIG_CSGDRS) * (1 - null(V_IDANT + DCSGD + 0)) * (1 - null(V_IDANT - DCSGD)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGCSGDCOR1 = ZIG_CSGDCOR * null(ANCSDED2 - (V_ANREV + 1)) ;
ZIGCSGDCOR2 = ZIG_CSGDCOR * null(ANCSDED2 - (V_ANREV + 2)) ;
ZIGCSGDCOR3 = ZIG_CSGDCOR * null(ANCSDED2 - (V_ANREV + 3)) ;
ZIGCSGDCOR4 = ZIG_CSGDCOR * null(ANCSDED2 - (V_ANREV + 4)) ;
ZIGCSGDCOR5 = ZIG_CSGDCOR * null(ANCSDED2 - (V_ANREV + 5)) ;
ZIGCSGDCOR6 = ZIG_CSGDCOR * null(ANCSDED2 - (V_ANREV + 6)) ;

regle 902440:
application : batch , iliad ;

ZIGLODD = positif(V_IDGLOANT - DGLOD) * positif(IDGLO) * (1 - null(V_IDGLOANT + DGLOD + 0)) * (1 - null(V_IDGLOANT - DGLOD)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGLORS = positif(DGLOD - V_IDGLOANT) * positif(IDGLO) * (1 - null(V_IDGLOANT + DGLOD + 0)) * (1 - null(V_IDGLOANT - DGLOD)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGLOCO = positif(ZIGLODD + ZIGLORS + null(V_IDGLOANT - DGLOD)) * (1 - null(V_IDGLOANT + DGLOD + 0)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGLOCOR = positif(ZIGLODD + ZIGLORS) * (1 - null(V_IDGLOANT + DGLOD + 0)) * (1 - null(V_IDGLOANT - DGLOD)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGLOCOR1 = ZIGLOCOR * null(ANCSDED2 - (V_ANREV + 1)) ;
ZIGLOCOR2 = ZIGLOCOR * null(ANCSDED2 - (V_ANREV + 2)) ;
ZIGLOCOR3 = ZIGLOCOR * null(ANCSDED2 - (V_ANREV + 3)) ;
ZIGLOCOR4 = ZIGLOCOR * null(ANCSDED2 - (V_ANREV + 4)) ;
ZIGLOCOR5 = ZIGLOCOR * null(ANCSDED2 - (V_ANREV + 5)) ;
ZIGLOCOR6 = ZIGLOCOR * null(ANCSDED2 - (V_ANREV + 6)) ;

ZIGRSEDD = positif(V_IDRSEANT - DRSED) * positif(IDRSE) * (1 - null(V_IDRSEANT + DRSED + 0)) 
	    * (1 - null(V_IDRSEANT - DRSED)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGRSERS = positif(DRSED - V_IDRSEANT) * positif(IDRSE) * (1 - null(V_IDRSEANT + DRSED + 0)) 
	    * (1 - null(V_IDRSEANT - DRSED)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGRSECO = positif(ZIGRSEDD + ZIGRSERS + null(V_IDRSEANT - DRSED)) * (1 - null(V_IDRSEANT + DRSED + 0)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGRSECOR = positif(ZIGRSEDD + ZIGRSERS) * (1 - null(V_IDRSEANT + DRSED + 0)) * (1 - null(V_IDRSEANT - DRSED)) * positif(V_NOTRAIT - 20) * LIG2 ;

ZIGRSECOR1 = ZIGRSECOR * null(ANCSDED2 - (V_ANREV + 1)) ;
ZIGRSECOR2 = ZIGRSECOR * null(ANCSDED2 - (V_ANREV + 2)) ;
ZIGRSECOR3 = ZIGRSECOR * null(ANCSDED2 - (V_ANREV + 3)) ;
ZIGRSECOR4 = ZIGRSECOR * null(ANCSDED2 - (V_ANREV + 4)) ;
ZIGRSECOR5 = ZIGRSECOR * null(ANCSDED2 - (V_ANREV + 5)) ;
ZIGRSECOR6 = ZIGRSECOR * null(ANCSDED2 - (V_ANREV + 6)) ;

regle 902450:
application : batch , iliad ;

                 
ZIG_PRIM = positif(NAPCR) * LIG2 ;

regle 902460:
application : batch , iliad ;


CS_BPCOS = RDNCP ;
RD_BPCOS = CS_BPCOS ;
PS_BPCOS = CS_BPCOS ;

ZIG_BPCOS = positif(CS_BPCOS + RD_BPCOS + PS_BPCOS) * CNRLIG12 ;

regle 902470:
application : batch , iliad ;


ANCSDED2 = (V_ANCSDED * (1 - null(933 - V_ROLCSG)) + (V_ANCSDED + 1) * null(933 - V_ROLCSG)) * positif(V_ROLCSG + 0)
           + V_ANCSDED * (1 - positif(V_ROLCSG + 0)) ;

ZIG_CSGDPRIM = (1 - positif(V_CSANT + V_RDANT + V_PSANT + V_IDANT)) * positif(IDCSG) * LIG2 ;

ZIG_CSGD99 = ZIG_CSGDPRIM * (1 - null(V_IDANT + DCSGD + 0)) * positif(DCSGD) * positif(20 - V_NOTRAIT) * LIG2 ;

ZIGDCSGD1 = ZIG_CSGD99 * null(ANCSDED2 - (V_ANREV + 1)) * LIG2 ;
ZIGDCSGD2 = ZIG_CSGD99 * null(ANCSDED2 - (V_ANREV + 2)) * LIG2 ;
ZIGDCSGD3 = ZIG_CSGD99 * null(ANCSDED2 - (V_ANREV + 3)) * LIG2 ;
ZIGDCSGD4 = ZIG_CSGD99 * null(ANCSDED2 - (V_ANREV + 4)) * LIG2 ;
ZIGDCSGD5 = ZIG_CSGD99 * null(ANCSDED2 - (V_ANREV + 5)) * LIG2 ;
ZIGDCSGD6 = ZIG_CSGD99 * null(ANCSDED2 - (V_ANREV + 6)) * LIG2 ;

ZIGIDGLO = positif(IDGLO) * (1 - null(V_IDGLOANT + DGLOD + 0))  * positif(20 - V_NOTRAIT) * LIG2 ;

ZIGIDGLO1 = ZIGIDGLO * null(ANCSDED2 - (V_ANREV + 1)) ;
ZIGIDGLO2 = ZIGIDGLO * null(ANCSDED2 - (V_ANREV + 2)) ;
ZIGIDGLO3 = ZIGIDGLO * null(ANCSDED2 - (V_ANREV + 3)) ;
ZIGIDGLO4 = ZIGIDGLO * null(ANCSDED2 - (V_ANREV + 4)) ;
ZIGIDGLO5 = ZIGIDGLO * null(ANCSDED2 - (V_ANREV + 5)) ;
ZIGIDGLO6 = ZIGIDGLO * null(ANCSDED2 - (V_ANREV + 6)) ;

ZIGIDRSE = positif(IDRSE) * (1 - null(V_IDRSEANT + DRSED + 0)) * positif(20 - V_NOTRAIT) * LIG2 ;

ZIGDRSED1 = ZIGIDRSE * null(ANCSDED2 - (V_ANREV + 1)) ;
ZIGDRSED2 = ZIGIDRSE * null(ANCSDED2 - (V_ANREV + 2)) ;
ZIGDRSED3 = ZIGIDRSE * null(ANCSDED2 - (V_ANREV + 3)) ;
ZIGDRSED4 = ZIGIDRSE * null(ANCSDED2 - (V_ANREV + 4)) ;
ZIGDRSED5 = ZIGIDRSE * null(ANCSDED2 - (V_ANREV + 5)) ;
ZIGDRSED6 = ZIGIDRSE * null(ANCSDED2 - (V_ANREV + 6)) ;

regle 902480:
application : batch , iliad ;

ZIGINFO = positif(ZIG_CSGD99 + ZIGIDGLO + ZIGIDRSE + ZIG_CSGDC + ZIGLOCO + ZIGRSECO) ;

regle 902490:
application : batch , iliad ;


LIGPVSURSI = positif(PVSURSI + CODRWA) * CNRLIG12 ;

LIGBPTPGJ = positif(BPTP19WGWJ) * CNRLIG12 ;

LIGIREXITI = positif(IREXITI) * (1 - positif(IREXITS)) * CNRLIG12 ;

LIGIREXI19 = positif(IREXITI19) * CNRLIG12 ;

LIGIREXITS = positif(IREXITS) * (1 - positif(IREXITI)) * CNRLIG12 ;

LIGIREXS19 = positif(IREXITS19) * CNRLIG12 ;

LIGIREXIT = positif(PVIMPOS + CODRWB) * positif(PVSURSI + CODRWA) * CNRLIG12 ;

LIGPV3WBI = positif(PVIMPOS + CODRWB) * CNRLIG12 ;

LIGEXITAX3 = positif(EXITTAX3) * CNRLIG12 ;

LIG_SURSIS = positif( LIGPVSURSI + LIGBPTPGJ + LIGIREXITI
                      + LIGIREXI19 + LIGIREXITS + LIGIREXS19 + LIGIREXIT + LIGEXITAX3
                      + LIGSURIMP ) * LIG1 * LIG2 ; 

LIGI017 = positif(PVSURSI + PVIMPOS + CODRWA + CODRWB) * V_IND_TRAIT ;

regle 902500:
application : batch , iliad ;


LIG_CORRECT = positif_ou_nul(IAMD2) * INDREV1A8 * LIG1 * LIG2 ;

regle 902510:
application : batch , iliad ;


LIG_R8ZT = positif(V_8ZT) * LIG1 * LIG2 ;

regle 902520:
application : batch , iliad ;

                 
LIGTXMOYPOS = positif(present(RMOND)+positif(VARRMOND)*present(DEFZU)) * (1 - positif(DEFRIMOND)) * LIG1 * LIG2 ;

LIGTXMOYNEG = positif(DMOND) * (1 - positif(DEFRIMOND)) * LIG1 * LIG2 ;

LIGTXPOSYT = positif(VARRMOND) * positif(IPTXMO) * positif(DEFRIMOND) * LIG1 * LIG2 ;

LIGTXNEGYT = (1-positif(LIGTXPOSYT)) * positif(VARDMOND) * positif(IPTXMO) * positif(DEFRIMOND) * LIG1 * LIG2 ;

regle 902530:
application : batch , iliad ;

                 
LIGAMEETREV = positif(INDREV1A8) * LIG1 * LIG2 ;

regle 902540:
application : iliad , batch ;

                 
LIGMIBNPNEG = positif((MIBNPRV+MIBNPRC+MIBNPRP+MIB_NETNPCT) * (-1)) * LIG2 ;

LIGMIBNPPOS = positif(MIBNPRV+MIBNPRC+MIBNPRP+MIB_NETNPCT) * (1 - positif(LIG_BICNPF)) * LIG2 ;

LIG_MIBP = positif(somme(i=V,C,P:MIBVENi) + somme(i=V,C,P:MIBPRESi) + abs(MIB_NETCT) + 0) ; 

regle 902550:
application : iliad , batch ;

                 
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
	    * positif_ou_nul(ANOCEP - (DNOCEP + DABNCNP6 +DABNCNP5 +DABNCNP4 +DABNCNP3 +DABNCNP2 +DABNCNP1)+0) 
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

regle 902560:
application : batch , iliad ;


LIGTXMOYPS = positif(TXMOYIMP) * (1 - positif(V_CNR))
	       * (1 - positif(V_CNR + positif(present(NRINET) + present(NRBASE) + present(IMPRET) + present(BASRET))))
               * IND_REV * LIG2 * positif(20 - V_NOTRAIT) ;

regle 902570:
application : iliad , batch ;



LIGREPTOUR = positif(RINVLOCINV + REPINVTOU + INVLOCXN + COD7UY) * LIG1 ;

LIGLOCHOTR = positif(INVLOGHOT) * LIG1 ;


LIGLOGDOM = positif(DLOGDOM) * LIG1 * LIG2 ;

LIGLOGSOC = positif(DLOGSOC) * LIG1 * LIG2 ;

LIGDOMSOC1 = positif(DDOMSOC1) * LIG1 * LIG2 ;

LIGLOCENT = positif(DLOCENT) * LIG1 * LIG2 ;

LIGCOLENT = positif(DCOLENT) * LIG1 * LIG2 ;

LIGREPHA  = positif(RINVLOCREA + INVLOGREHA + INVLOCXV + COD7UZ) * LIG1 * LIG2 ;

regle 902580:
application : iliad , batch ;

LIGREDAGRI = positif(DDIFAGRI) * LIG1 * LIG2 ;
LIGFORET = positif(DFORET) * LIG1 * LIG2 ;
LIGCOTFOR = positif(DCOTFOR) * LIG1 * LIG2 ; 

LIGRCIF = positif(REPCIF + REPCIFHSN1) * LIG1 * LIG2 ;
LIGREP7UX = positif(REPCIFHSN1) * LIG1 * LIG2 ;
LIGREP7UP = positif(REPCIF) * LIG1 * LIG2 ;

LIGRCIFAD = positif(REPCIFAD + REPCIFADHSN1) * LIG1 * LIG2 ;
LIGREP7VP = positif(REPCIFADHSN1) * LIG1 * LIG2 ;
LIGREP7UA = positif(REPCIFAD) * LIG1 * LIG2 ;

LIGRCIFSIN = positif(REPCIFSIN + REPCIFSN1) * LIG1 * LIG2 ;
LIGREP7TJ = positif(REPCIFSN1) * LIG1 * LIG2 ;
LIGREP7UT = positif(REPCIFSIN) * LIG1 * LIG2 ;

LIGRCIFADSN = positif(REPCIFADSIN + REPCIFADSSN1) * LIG1 * LIG2 ;
LIGREP7TK = positif(REPCIFADSSN1) * LIG1 * LIG2 ;
LIGREP7UB = positif(REPCIFADSIN) * LIG1 * LIG2 ;

LIGNFOREST = positif(REPSIN + REPFORSIN + REPFORSIN2 + REPFORSIN3 + REPNIS) * LIG1 * LIG2 ;
LIGREPSIN = positif(REPSIN) * LIG1 * LIG2 ;
LIGSINFOR = positif(REPFORSIN) * LIG1 * LIG2 ;
LIGSINFOR2 = positif(REPFORSIN2) * LIG1 * LIG2 ;
LIGSINFOR3 = positif(REPFORSIN3) * LIG1 * LIG2 ;
LIGREPNIS = positif(REPNIS) * LIG1 * LIG2 ;

LIGFIPC = positif(DFIPC) * LIG1 * LIG2 ;
LIGFIPDOM = positif(DFIPDOM) * LIG1 * LIG2 ;
LIGPRESSE = positif(DPRESSE) * LIG1 * LIG2 ;
LIGCINE = positif(DCINE) * LIG1 * LIG2 ;
LIGRIRENOV = positif(DRIRENOV) * LIG1 * LIG2 ;
LIGREPAR = positif(NUPROPT) * LIG1 * LIG2 ;
LIGREPREPAR = positif(REPNUREPART) * CNRLIG12 ;
LIGREPARN = positif(REPAR) * CNRLIG12 ;
LIGREPAR1 = positif(REPAR1) * CNRLIG12 ;
LIGREPAR2 = positif(REPAR2) * CNRLIG12 ;
LIGREPAR3 = positif(REPAR3) * CNRLIG12 ;
LIGREPAR4 = positif(REPAR4) * CNRLIG12 ;
LIGREPAR5 = positif(REPAR5) * CNRLIG12 ;
LIGREPAR6 = positif(REPAR6) * CNRLIG12 ;

LIGRESTIMO = (present(RIMOPPAUANT) + present(RIMOSAUVANT) + present(RESTIMOPPAU) + present(RESTIMOSAUV) + present(RIMOPPAURE) + present(RIMOSAUVRF)
              + present(COD7SY) + present(COD7SX)) * LIG1 * LIG2 ;


LIGRCODOU = positif(COD7OU + 0) * CNRLIG12 ;

LIGRCODOV = positif(COD7OV + 0) * CNRLIG12 ;

LIGRCODJT = positif(LOCMEUBJT + 0) * positif(RCODJT1 + RCODJT2 + RCODJT3 + RCODJT4 + RCODJT5 + RCODJT6 + RCODJT7 + RCODJT8) * CNRLIG12 ;

LIGRCODJU = positif(LOCMEUBJU + 0) * positif(RCODJU1 + RCODJU2 + RCODJU3 + RCODJU4 + RCODJU5 + RCODJU6 + RCODJU7 + RCODJU8) * CNRLIG12 ;

LIGRLOCIDFG = positif(LOCMEUBID + LOCMEUBIF + LOCMEUBIG) * positif(RLOCIDFG1 + RLOCIDFG2 + RLOCIDFG3 + RLOCIDFG4 + RLOCIDFG5 + RLOCIDFG6 + RLOCIDFG7 + RLOCIDFG8)
	     * CNRLIG12 ;

LIGREPLOCIE = positif(LOCMEUBIE) * positif(REPLOCIE1 + REPLOCIE2 + REPLOCIE3 + REPLOCIE4 + REPLOCIE5 + REPLOCIE6 + REPLOCIE7 + REPLOCIE8)
	     * CNRLIG12 ;

LIGNEUV = positif(LOCRESINEUV + INVNPROF1 + INVNPROF2) * positif(RESINEUV1 + RESINEUV2 + RESINEUV3 + RESINEUV4 + RESINEUV5 + RESINEUV6 + RESINEUV7 + RESINEUV8) 
	     * CNRLIG12 ;

LIGRNEUV = positif(MEUBLENP) * positif(RRESINEUV1 + RRESINEUV2 + RRESINEUV3 + RRESINEUV4 + RRESINEUV5 + RRESINEUV6 + RRESINEUV7 + RRESINEUV8) 
	     * CNRLIG12 ;

LIGVIEU = positif(RESIVIEU) * positif(RESIVIEU1 + RESIVIEU2 + RESIVIEU3 + RESIVIEU4 + RESIVIEU5 + RESIVIEU6 + RESIVIEU7 + RESIVIEU8) 
	     * CNRLIG12 ;

LIGVIAN = positif(RESIVIANT) * positif(RESIVIAN1 + RESIVIAN2 + RESIVIAN3 + RESIVIAN4 + RESIVIAN5 + RESIVIAN6 + RESIVIAN7 + RESIVIAN8) 
	     * CNRLIG12 ;

LIGMEUB = positif(VIEUMEUB) * positif(RESIMEUB1 + RESIMEUB2 + RESIMEUB3 + RESIMEUB4 + RESIMEUB5 + RESIMEUB6 + RESIMEUB7 + RESIMEUB8)
	     * CNRLIG12 ;

LIGREPLOC15 = positif(REPMEUPE + REPMEUPJ + REPMEU15) * CNRLIG12 ;
LIGREP7PE = positif(REPMEUPE) * CNRLIG12 ;
LIGREP7PJ = positif(REPMEUPJ) * CNRLIG12 ;
LIGREPMEU15 = positif(REPMEU15) * CNRLIG12 ;


LIGREPLOC12 = positif(REPMEUJS + REPMEUPD + REPMEUPI + REP12MEU15) 
              * CNRLIG12 ;
LIGREP7JS = positif(REPMEUJS) * CNRLIG12 ;
LIGREP7PD = positif(REPMEUPD) * CNRLIG12 ;
LIGREP7PI = positif(REPMEUPI) * CNRLIG12 ;
LIGREP12MEU = positif(REP12MEU15) * CNRLIG12 ;

LIGREPLOC11 = positif(REPMEUIZ + REPMEUJI + REPMEUPC + REPMEUPH + REP11MEU15)
              * CNRLIG12 ;
LIGREP7IZ = positif(REPMEUIZ) * CNRLIG12 ;
LIGREP7JI = positif(REPMEUJI) * CNRLIG12 ;
LIGREP7PC = positif(REPMEUPC) * CNRLIG12 ;
LIGREP7PH = positif(REPMEUPH) * CNRLIG12 ;
LIGREP11MEU = positif(REP11MEU15) * CNRLIG12 ;

LIGREPLOC10 = positif(REPMEUIT + REPMEUIH + REPMEUJC + REPMEUPB + REPMEUPG + REP10MEU15)
              * CNRLIG12 ;
LIGREP7IT = positif(REPMEUIT) * CNRLIG12 ;
LIGREP7IH = positif(REPMEUIH) * CNRLIG12 ;
LIGREP7JC = positif(REPMEUJC) * CNRLIG12 ;
LIGREP7PB = positif(REPMEUPB) * CNRLIG12 ;
LIGREP7PG = positif(REPMEUPG) * CNRLIG12 ;
LIGREP10MEU = positif(REP10MEU15) * CNRLIG12 ;


LIGREPLOC9 = positif(REPMEUIS+REPMEUIU+REPMEUIX+REPMEUIY+REPMEUPA+REPMEUPF+REP9MEU15)
             * CNRLIG12 ;
LIGREP7IS = positif(REPMEUIS) * CNRLIG12 ;
LIGREP7IU = positif(REPMEUIU) * CNRLIG12 ;
LIGREP7IX = positif(REPMEUIX) * CNRLIG12 ;
LIGREP7IY = positif(REPMEUIY) * CNRLIG12 ;
LIGREP7PA = positif(REPMEUPA) * CNRLIG12 ;
LIGREP7PF = positif(REPMEUPF) * CNRLIG12 ;
LIGREP9MEU = positif(REP9MEU15) * CNRLIG12 ;

regle 902590:
application : iliad , batch ;

LIGREDMEUB = positif(DREDMEUB) * LIG1 * LIG2 ;
LIGREDREP = positif(DREDREP) * LIG1 * LIG2 ;
LIGILMIX = positif(DILMIX) * LIG1 * LIG2 ;
LIGILMIY = positif(DILMIY) * LIG1 * LIG2 ;

LIGILMPA = positif(DILMPA) * LIG1 * LIG2 ;
LIGILMPB = positif(DILMPB) * LIG1 * LIG2 ;
LIGILMPC = positif(DILMPC) * LIG1 * LIG2 ;
LIGILMPD = positif(DILMPD) * LIG1 * LIG2 ;
LIGILMPE = positif(DILMPE) * LIG1 * LIG2 ;
LIGILMPF = positif(DILMPF) * LIG1 * LIG2 ;
LIGILMPG = positif(DILMPG) * LIG1 * LIG2 ;
LIGILMPH = positif(DILMPH) * LIG1 * LIG2 ;
LIGILMPI = positif(DILMPI) * LIG1 * LIG2 ;
LIGILMPJ = positif(DILMPJ) * LIG1 * LIG2 ;

LIGINVRED = positif(DINVRED) * LIG1 * LIG2 ;
LIGILMIH = positif(DILMIH) * LIG1 * LIG2 ;
LIGILMJC = positif(DILMJC) * LIG1 * LIG2 ;
LIGILMIZ = positif(DILMIZ) * LIG1 * LIG2 ;
LIGILMJI = positif(DILMJI) * LIG1 * LIG2 ;
LIGILMJS = positif(DILMJS) * LIG1 * LIG2 ;
LIGMEUBLE = positif(DMEUBLE) * LIG1 * LIG2 ;
LIGPROREP = positif(DPROREP) * LIG1 * LIG2 ;
LIGREPNPRO = positif(DREPNPRO) * LIG1 * LIG2 ;
LIGMEUREP = positif(DREPMEU) * LIG1 * LIG2 ;
LIGILMIC = positif(DILMIC) * LIG1 * LIG2 ;
LIGILMIB = positif(DILMIB) * LIG1 * LIG2 ;
LIGILMIA = positif(DILMIA) * LIG1 * LIG2 ;
LIGILMJY = positif(DILMJY) * LIG1 * LIG2 ;
LIGILMJX = positif(DILMJX) * LIG1 * LIG2 ;
LIGILMJW = positif(DILMJW) * LIG1 * LIG2 ;
LIGILMJV = positif(DILMJV) * LIG1 * LIG2 ;

LIGILMOE = positif(DILMOE) * LIG1 * LIG2 ;
LIGILMOD = positif(DILMOD) * LIG1 * LIG2 ;
LIGILMOC = positif(DILMOC) * LIG1 * LIG2 ;
LIGILMOB = positif(DILMOB) * LIG1 * LIG2 ;
LIGILMOA = positif(DILMOA) * LIG1 * LIG2 ;
LIGILMOJ = positif(DILMOJ) * LIG1 * LIG2 ;
LIGILMOI = positif(DILMOI) * LIG1 * LIG2 ;
LIGILMOH = positif(DILMOH) * LIG1 * LIG2 ;
LIGILMOG = positif(DILMOG) * LIG1 * LIG2 ;
LIGILMOF = positif(DILMOF) * LIG1 * LIG2 ;

LIGRESIMEUB = positif(DRESIMEUB) * LIG1 * LIG2 ;
LIGRESIVIEU = positif(DRESIVIEU) * LIG1 * LIG2 ;
LIGRESINEUV = positif(DRESINEUV) * LIG1 * LIG2 ;
LIGLOCIDEFG = positif(DLOCIDEFG) * LIG1 * LIG2 ;
LIGCODJTJU = positif(DCODJTJU) * LIG1 * LIG2 ;
LIGCODOU = positif(DCODOU) * LIG1 * LIG2 ;
LIGCODOV = positif(DCODOV) * LIG1 * LIG2 ;

regle 902600:
application : iliad , batch ;

LIGTAXASSUR = positif(present(CESSASSV) + present(CESSASSC)) * (1 - positif(ANNUL2042)) * LIG1 ;
LIGTAXASSURV = present(CESSASSV) * (1 - positif(ANNUL2042)) * LIG1 ;
LIGTAXASSURC = present(CESSASSC) * (1 - positif(ANNUL2042)) * LIG1 ;

LIGIPCAP = positif(present(PCAPTAXV) + present(PCAPTAXC)) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;
LIGIPCAPV = present(PCAPTAXV) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;
LIGIPCAPC = present(PCAPTAXC) * (1 - positif(ANNUL2042 + 0)) * LIG1 ;

LIGITAXLOY = present(LOYELEV) * (1 - positif(ANNUL2042)) * LIG1 ;

LIGIHAUT = positif(CHRAVANT) * (1 - positif(TEFFHRC + COD8YJ)) * (1 - positif(ANNUL2042)) * LIG1 ;

LIGHRTEFF = positif(CHRTEFF) * positif(TEFFHRC + COD8YJ) * (1 - positif(ANNUL2042)) * LIG1 ;

regle 902610:
application : iliad , batch ;

LIGCOMP01 = positif(BPRESCOMP01) * CNRLIG12 ;

regle 902620:
application : iliad , batch ;

LIGDEFBA = positif(DEFBA1 + DEFBA2 + DEFBA3 + DEFBA4 + DEFBA5 + DEFBA6) * LIG1 * LIG2 ;
LIGDEFBA1 = positif(DEFBA1) * LIG1 * LIG2 ;
LIGDEFBA2 = positif(DEFBA2) * LIG1 * LIG2 ;
LIGDEFBA3 = positif(DEFBA3) * LIG1 * LIG2 ;
LIGDEFBA4 = positif(DEFBA4) * LIG1 * LIG2 ;
LIGDEFBA5 = positif(DEFBA5) * LIG1 * LIG2 ;
LIGDEFBA6 = positif(DEFBA6) * LIG1 * LIG2 ;

LIGDFRCM = positif(DFRCMN+DFRCM1+DFRCM2+DFRCM3+DFRCM4+DFRCM5) * CNRLIG12 ;
LIGDFRCMN = positif(DFRCMN) * CNRLIG12 ;
LIGDFRCM1 = positif(DFRCM1) * CNRLIG12 ;
LIGDFRCM2 = positif(DFRCM2) * CNRLIG12 ;
LIGDFRCM3 = positif(DFRCM3) * CNRLIG12 ;
LIGDFRCM4 = positif(DFRCM4) * CNRLIG12 ;
LIGDFRCM5 = positif(DFRCM5) * CNRLIG12 ;

LIGDRCVM = positif(DPVRCM) * LIG1 * LIG2 ;
LIGDRFRP = positif(DRFRP) * LIG1 * LIG2 ;

LIGDLMRN = positif(DLMRN6 + DLMRN5 + DLMRN4 + DLMRN3 + DLMRN2 + DLMRN1) * LIG1 * LIG2 ;
LIGDLMRN6 = positif(DLMRN6) * LIG1 * LIG2 ;
LIGDLMRN5 = positif(DLMRN5) * LIG1 * LIG2 ;
LIGDLMRN4 = positif(DLMRN4) * LIG1 * LIG2 ;
LIGDLMRN3 = positif(DLMRN3) * LIG1 * LIG2 ;
LIGDLMRN2 = positif(DLMRN2) * LIG1 * LIG2 ;
LIGDLMRN1 = positif(DLMRN1) * LIG1 * LIG2 ;

LIGBNCDF = positif(BNCDF1 + BNCDF2 + BNCDF3 + BNCDF4 + BNCDF5 + BNCDF6) * LIG1 * LIG2 ;
LIGBNCDF6 = positif(BNCDF6) * LIG1 * LIG2 ;
LIGBNCDF5 = positif(BNCDF5) * LIG1 * LIG2 ;
LIGBNCDF4 = positif(BNCDF4) * LIG1 * LIG2 ;
LIGBNCDF3 = positif(BNCDF3) * LIG1 * LIG2 ;
LIGBNCDF2 = positif(BNCDF2) * LIG1 * LIG2 ;
LIGBNCDF1 = positif(BNCDF1) * LIG1 * LIG2 ;

LIGMBDREPNPV = positif(MIBDREPNPV) * LIG1 * LIG2 ;
LIGMBDREPNPC = positif(MIBDREPNPC) * LIG1 * LIG2 ;
LIGMBDREPNPP = positif(MIBDREPNPP) * LIG1 * LIG2 ;

LIGMIBDREPV = positif(MIBDREPV) * LIG1 * LIG2 ;
LIGMIBDREPC = positif(MIBDREPC) * LIG1 * LIG2 ;
LIGMIBDREPP = positif(MIBDREPP) * LIG1 * LIG2 ;

LIGSPDREPNPV = positif(SPEDREPNPV) * LIG1 * LIG2 ;
LIGSPDREPNPC = positif(SPEDREPNPC) * LIG1 * LIG2 ;
LIGSPDREPNPP = positif(SPEDREPNPP) * LIG1 * LIG2 ;

LIGSPEDREPV = positif(SPEDREPV) * LIG1 * LIG2 ;
LIGSPEDREPC = positif(SPEDREPC) * LIG1 * LIG2 ;
LIGSPEDREPP = positif(SPEDREPP) * LIG1 * LIG2 ;

regle 902630:
application : batch , iliad ;


LIG_MEMO = positif(LIGPRELIB + LIG_SURSIS + LIGREPPLU + LIGELURAS + LIGELURASC + LIGABDET + LIGABDETP + LIGABDETM
                     + LIGROBOR + LIGPVIMMO + LIGPVTISOC + LIGMOBNR 
                     + LIGDEPCHO + LIGDEPMOB + LIGCOD3SG + LIGCOD3SL + LIGCOD3SM + LIGCOD3SC)
             + positif(LIG3525 + LIGRCMSOC + LIGRCMIMPAT + LIGABIMPPV + LIGABIMPMV + LIGPV3SB) * CNRLIG12 ;

regle 902640:
application : batch , iliad ;

LIGPRELIB = positif(present(PPLIB) + present(RCMLIB)) * LIG0 * LIG2 ;

LIG3525 = positif(RTNC) * CNRLIG12 ;

LIGELURAS = positif(ELURASV) * LIG1 * LIG2 ;
LIGELURASC = positif(ELURASC) * LIG1 * LIG2 ;

LIGREPPLU = positif(REPPLU) * LIG1 * LIG2 ;
LIGSURIMP = positif(SURIMP) * LIG1 * LIG2 ;
LIGPVIMPOS = positif(PVIMPOS) * LIG1 * LIG2 ;

LIGABDET = positif(GAINABDET) * LIG1 * LIG2 ;
ABDEPRET = ABDETPLUS + COD3VB + COD3VO + COD3VP + COD3VY ;
LIGABDETP = positif(ABDEPRET) * LIG1 * LIG2 ;

LIGCOD3SG = positif(COD3SG) * LIG1 * LIG2 ;
LIGCOD3SL = positif(COD3SL) * LIG1 * LIG2 ;
LIGPV3SB = positif(PVBAR3SB) * LIG1 * LIG2 ;
LIGCOD3SC = positif(COD3SC) * LIG1 * LIG2 ;

LIGRCMSOC = positif(RCMSOC) * CNRLIG12 ;
LIGRCMIMPAT = positif(RCMIMPAT) * CNRLIG12 ;
LIGABIMPPV = positif(ABIMPPV) * CNRLIG12 ;
LIGABIMPMV = positif(ABIMPMV) * CNRLIG12 ;

LIGCVNSAL = positif(CVNSALC) * LIG1 * LIG2 ;
LIGCDIS = positif(GSALV + GSALC) * CNRLIG12 ;
LIGROBOR = positif(RFROBOR) * LIG1 * LIG2 ;
LIGPVIMMO = positif(PVIMMO) * LIG1 * LIG2 ;
LIGPVTISOC = positif(PVTITRESOC) * LIG1 * LIG2 ;
LIGMOBNR = positif(PVMOBNR) * LIG1 * LIG2 ;

DEPCHO = (CIBOIBAIL + COD7SA + CINRJBAIL + COD7SB + CRENRJ + COD7SC + TRAMURWC + COD7WB + CINRJ + COD7RG + TRATOIVG + COD7VH
          + CIDEP15 + COD7RH + MATISOSI + COD7RI + TRAVITWT + COD7WU + MATISOSJ + COD7RJ + VOLISO + COD7RK + PORENT + COD7RL + CHAUBOISN 
          + COD7RN + POMPESP + COD7RP + POMPESR + COD7RR + CHAUFSOL + COD7RS + POMPESQ + COD7RQ + ENERGIEST + COD7RT + DIAGPERF + COD7TV 
          + RESCHAL + COD7TW + COD7RV + COD7RW + COD7RZ) * positif(V_NOTRAIT - 10) ;

DEPMOB = (RDEQPAHA + RDTECH) * positif(V_NOTRAIT - 10) ;


LIGDEPCHO = DIFF7WY * positif(DEPCHO) * CNRLIG12 ;

LIGDEPMOB = positif(DIFF7WZ + DIFF7WD) * positif(DEPMOB) * CNRLIG12 ;

LIGDEFPLOC = positif(DEFLOC1 + DEFLOC2 + DEFLOC3 + DEFLOC4 + DEFLOC5 + DEFLOC6 + DEFLOC7 + DEFLOC8 + DEFLOC9 + DEFLOC10) * LIG1 * LIG2 ;
LIGPLOC1 = positif(DEFLOC1) * LIG1 * LIG2 ;
LIGPLOC2 = positif(DEFLOC2) * LIG1 * LIG2 ;
LIGPLOC3 = positif(DEFLOC3) * LIG1 * LIG2 ;
LIGPLOC4 = positif(DEFLOC4) * LIG1 * LIG2 ;
LIGPLOC5 = positif(DEFLOC5) * LIG1 * LIG2 ;
LIGPLOC6 = positif(DEFLOC6) * LIG1 * LIG2 ;
LIGPLOC7 = positif(DEFLOC7) * LIG1 * LIG2 ;
LIGPLOC8 = positif(DEFLOC8) * LIG1 * LIG2 ;
LIGPLOC9 = positif(DEFLOC9) * LIG1 * LIG2 ;
LIGPLOC10 = positif(DEFLOC10) * LIG1 * LIG2 ;

regle 902650:
application : batch , iliad ;


LIGDCSGD = positif(DCSGD) * null(5 - V_IND_TRAIT) * INDCTX * LIG1 * LIG2 ;

regle 902660:
application : batch , iliad ;


LIGREPCORSE = positif(REPCORSE) * LIG1 * LIG2 ;

LIGREPRECH = positif(REPRECH) * LIG1 * LIG2 ;

LIGREPCICE = positif(REPCICE) * LIG1 * LIG2 ; 

LIGPME = positif(REPINVPME3 + REPINVPME2 + REPINVPME1 + REPINVPMECU) 
	   * CNRLIG12 ;

regle 902670:
application : batch , iliad ;

LIGIBAEX = positif(REVQTOT) * LIG1 * LIG2 
	     * (1 - INDTXMIN) * (1 - INDTXMOY) 
	     * (1 - V_CNR * (1 - LIG1522)) ;

regle 902680:
application :  iliad , batch ;

LIGANNUL2042 = LIG2 * LIG0 ;

LIG121 = positif(DEFRITS) * LIGANNUL2042 ;
LIG931 = positif(DEFRIRCM)*positif(RCMFR) * LIGANNUL2042 ;
LIG936 = positif(DEFRIRCM)*positif(REPRCM) * LIGANNUL2042 ;
LIG1111 = positif(DFANTIMPU) * LIGANNUL2042 ;
LIG1112 = positif(DFANTIMPU) * positif(DEFRF4BC) * positif(RDRFPS) * LIGANNUL2042 ;
LIGDFANT = positif(DFANTIMPUQUO) * LIGANNUL2042 ;

regle 902690:
application : batch , iliad ;

LIGTRCT = positif(V_TRCT) ;
LIGISFTRCT = present(ISFBASE) * positif(V_TRCT) ;

regle 902700:
application : batch , iliad ;

LIGVERSUP = positif(AUTOVERSSUP) ;

regle 902710:
application : iliad , batch ;


INDRESTIT = positif(IREST + 0) ;

INDIMPOS = positif(null(1 - NATIMP) + 0) ;

regle isf 902720:
application : iliad , batch ;

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
	    + positif(LIGISF9749) 
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
	    + positif(LIGISFNEW) * 2 
            + positif(LIGISFTRCT) + 0 ;

LIGNBPAGESISF = positif( NBLIGNESISF - 41 + 0 ) ;

regle isf 902730:
application : iliad , batch ;


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
             * (1 - positif(null((CODE_2042 + CMAJ_ISF)- 8) + null(CMAJ_ISF - 34)) * (1 - COD9ZA))  ;

LIGISFREDPEN8 = positif(LIGISFINV + LIGISFDON) * LIGISF 
             * positif(null ((CODE_2042 + CMAJ_ISF)- 8) + null(CMAJ_ISF - 34))
             * (1 - COD9ZA) ;

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

LIGISF17281 = positif( NMAJISF1) * (1 - positif(ANNUL2042)) * LIGISF
               * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF5)))
               * (1 - positif(V_FLAGR34 + null(CMAJ_ISF - 34))) ;

LIGISF17285 = positif( NMAJISF1) * (1 - positif(ANNUL2042)) * LIGISF
               * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF5)))
               * positif(V_FLAGR34 + null(CMAJ_ISF - 34)) ;

LIGISF9749 = positif(LIGNMAJISF1) * (1 - positif(LIGISFRET)) ;

LIGISFNET = (positif(PISF)*positif(DISFBASE) * (1-null(5-V_IND_TRAIT))
               * (1 - positif( SEUIL_12 - ISF4BIS)*(1-null(ISF5)))
	       * (1 - positif(ANNUL2042)) * LIGISF 
	     + (null(5-V_IND_TRAIT)) * positif(LIGISFRET + LIGNMAJISF1)
	       * positif(ISFNAP) * (1 - positif( SEUIL_12 - ISFNAP)))
	    * (1 - positif(INDCTX23)) ;

LIGISFZERO = null(ISF5) * (1 - positif(ANNUL2042)) * positif(20-V_NOTRAIT) * LIGISF ;


LIGISFNMR = positif( SEUIL_12 - ISF5) * (1 - null(ISF5)) 
           * (1 - positif(INDCTX23)) * positif(20 - V_NOTRAIT) 
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
	     * INDIS26 * positif(V_NOTRAIT - 20) * (1 - positif(ANNUL2042)) ;

LIGISF0DEG = IND9HI0 * null(ISF4BIS) * (1 - positif(ANNUL2042)) ;

LIGISFINF8 = IND9HI0 * positif(LIGISFDEGR) * (1 - positif(ANNUL2042)) ;


LIGISFNEW = present(ISFBASE) * (1 - positif(20-V_NOTRAIT)) * null(5 - V_IND_TRAIT) * (1 - positif(ANNUL2042)) ;

LIGISFANNUL = present(ISFBASE) * positif(ANNUL2042) ;

