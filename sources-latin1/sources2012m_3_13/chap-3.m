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
                                                                         #####
  ####   #    #    ##    #####      #     #####  #####   ######         #     #
 #    #  #    #   #  #   #    #     #       #    #    #  #                    #
 #       ######  #    #  #    #     #       #    #    #  #####           #####
 #       #    #  ######  #####      #       #    #####   #                    #
 #    #  #    #  #    #  #          #       #    #   #   #              #     #
  ####   #    #  #    #  #          #       #    #    #  ###### #######  #####
 #
 #
 #
 #
 #
 #
 #
 #                       CALCUL DE L'IMPOT NET
 #
 #
 #
 #
 #
 #
regle 301:
application : bareme , iliad , batch  ;

IRN = min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) * positif( IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61) ;


regle 3010:
application : bareme , iliad , batch  ;

IAR = min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) ;

regle 302:
application : iliad , batch  ;
CREREVET =  min(arr(BPTP3 * TX16/100),arr(CIIMPPRO * TX_CREREVET/100 ))
	  + min(arr(BPTP24 * TX24/100),arr(CIIMPPRO2 * TX24/100 ));

CIIMPPROTOT = CIIMPPRO + CIIMPPRO2 ;
regle 3025:
application : iliad , batch  ;

ICREREVET = max(0,min(IAD11 + ITP - CIRCMAVFT - IRETS - min(IAD11 , CRCFA), min(ITP,CREREVET)));

regle 3026:
application : iliad , batch , bareme ;

INE = (CIRCMAVFT + IRETS + min(max(0,IAD11-CIRCMAVFT-IRETS) , CRCFA) + ICREREVET + CICULTUR + CIGPA + CIDONENTR + CICORSE + CIRECH)
            * (1-positif(RE168+TAX1649));

IAN = max( 0, (IRB - AVFISCOPTER + ((- CIRCMAVFT
				     - IRETS
                                     - min(max(0,IAD11-CIRCMAVFT-IRETS) , CRCFA) 
                                     - ICREREVET
                                     - CICULTUR
                                     - CIGPA
                                     - CIDONENTR
                                     - CICORSE
				     - CIRECH )
                                   * (1 - positif(RE168 + TAX1649)))
                  + min(TAXASSUR+0 , max(0,INE-IRB+AVFISCOPTER)) 
                  + min(IPCAPTAXTOT+0 , max(0,INE-IRB+AVFISCOPTER - min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))))
                  + min(TAXLOY+0 ,max(0,INE-IRB+AVFISCOPTER - min(IPCAPTAXTOT+0 , max(0,INE-IRB+AVFISCOPTER - min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))))
										  - min(TAXASSUR+0 , max(0,INE-IRB+AVFISCOPTER))))
	      )
         )
 ;

regle 3021:
application : iliad , batch  ;
IRE = si ( positif(RE168+TAX1649+0) = 0) 
      alors
       (si    ( V_REGCO = 2 )
        alors ( EPAV + CRICH 
             + CICA + CIGE  + IPELUS + CREFAM + CREAPP + CISYND
	     + CIDEVDUR + CIPRETUD + CILOYIMP + CIGARD
	     + CREAGRIBIO + CREPROSP + CREFORMCHENT + CREARTS + CICONGAGRI 
	     + CRERESTAU + CIHABPRIN + CIADCRE + CIDEBITTABAC + CREINTERESSE
	     + AUTOVERSLIB + CITEC + CIDEPENV + CICORSENOW + CRESINTER
	      )

        sinon ( EPAV + CRICH
             + CICA +  CIGE  + IPELUS + CREFAM + CREAPP + PPETOT - PPERSA+ CISYND
	     + DIREPARGNE + CIDEVDUR + CIPRETUD + CILOYIMP + CIGARD
	     + CREAGRIBIO + CREPROSP + CREFORMCHENT + CREARTS + CICONGAGRI 
	     + CRERESTAU + CIHABPRIN + CIADCRE + CIDEBITTABAC + CREINTERESSE 
	     + AUTOVERSLIB + CITEC + CIDEPENV+ CICORSENOW + CRESINTER
	      )
	     
        finsi)
       finsi;
IRE2 = IRE + (BCIGA * (1 - positif(RE168+TAX1649))); 
regle 3022:
application : iliad , batch  ;

CRICH =  IPRECH * (1 - positif(RE168+TAX1649));
regle 30221:
application : iliad , batch  ;
CIRCMAVFT = max(0,min(IRB + TAXASSUR + IPCAPTAXTOT +TAXLOY - AVFISCOPTER , RCMAVFT * (1 - null(2 - V_REGCO))));
regle 30222:
application : iliad , batch  ;
CIDIREPARGNE = DIREPARGNE * (1 - positif(RE168 + TAX1649)) * (1 - null(2 - V_REGCO));
regle 30226:
application : batch, iliad;
CICA =  arr(BAILOC98 * TX_BAIL / 100) * (1 - positif(RE168 + TAX1649)) ;
regle 3023:
application : iliad , batch  ;
CRCFA = (arr(IPQ1 * REGCI / (RB01 + TONEQUO + CHTOT + RDCSG + ABMAR + ABVIE)) * (1 - positif(RE168+TAX1649)));
regle 30231:
application : iliad , batch  ;
IRETS = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT , (IPSOUR * (1 - positif(RE168+TAX1649))))) ;
regle 3023101:
application : iliad , batch  ;
CRDIE = max(0,min(IRB-REI-AVFISCOPTER-CIRCMAVFT-IRETS,(min(IAD11-CIRCMAVFT-IRETS,CRCFA) * (1 - positif(RE168+TAX1649)))));
CRDIE2 = -CRDIE+0;
regle 3023102:
application : iliad , batch  ;
BCIAQCUL = arr(CIAQCUL * TX_CIAQCUL / 100);
CICULTUR = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-REI-IRETS-CRDIE-ICREREVET,min(IAD11+ITP+TAXASSUR+TAXLOY +IPCAPTAXTOT+CHRAPRES,BCIAQCUL)));
regle 3023103:
application : iliad , batch  ;
BCIGA = CRIGA;
CIGPA = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-CRDIE-ICREREVET-CICULTUR,BCIGA));
regle 3023104:
application : iliad , batch  ;
BCIDONENTR = RDMECENAT * (1-V_CNR) ;
CIDONENTR = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-REI-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA,BCIDONENTR));
regle 3023105:
application : iliad , batch  ;
CICORSE = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IPPRICORSE-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR,CIINVCORSE+IPREPCORSE));
CICORSEAVIS = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY-AVFISCOPTER-CIRCMAVFT-IPPRICORSE-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR,CIINVCORSE+IPREPCORSE))+CICORSENOW;
TOTCORSE = CIINVCORSE + IPREPCORSE + CICORSENOW;
REPCORSE = abs(CIINVCORSE+IPREPCORSE-CICORSE) ;
regle 3023106:
application : iliad , batch  ;
CIRECH = max(0,min(IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR-CICORSE,IPCHER));
REPRECH = abs(IPCHER - CIRECH) ;
IRECR = abs(min(0 ,IRB+TAXASSUR+IPCAPTAXTOT+TAXLOY -AVFISCOPTER-CIRCMAVFT-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR-CICORSE));
regle 3023107:
application : iliad , batch  ;
CICONGAGRI = CRECONGAGRI * (1-V_CNR) ;
regle 30231071:
application : iliad , batch  ;
BCICAP = min(IPCAPTAXTOT,arr((PRELIBXT - arr(PRELIBXT * TX10/100))*T_PCAPTAX/100));
BCICAPAVIS = max(0,(PRELIBXT - arr(PRELIBXT * TX10/100)));
CICAP = max(0,min(IRB + TAXASSUR + IPCAPTAXTOT +TAXLOY +CHRAPRES - AVFISCOPTER ,min(IPCAPTAXTOT,BCICAP)));
regle 30231072:
application : iliad , batch  ;
BCICHR = arr(CHRAPRES * (REGCI+0) / (REVKIREHR - TEFFHRC));
CICHR = max(0,min(IRB + TAXASSUR + IPCAPTAXTOT +TAXLOY +CHRAPRES - AVFISCOPTER-CICAP ,min(CHRAPRES,BCICHR)));
regle 407015:
application : iliad , batch  ;
BCOS = somme(i=V,C: max(0 , min(COSBi+0,arr(TX_BASECOTSYN/100*
                                   (TSBi*IND_10i
                                   - BPCOSAi + EXPRi ))))) +
                                   min(COSBP+0,arr(TX_BASECOTSYN/100*
                                   (somme(i=1..4:TSBi *IND_10i + EXPRi))))  ;
CISYND = arr (TX_REDCOTSYN/100 * BCOS) * (1 - V_CNR);
DSYND = RDSYVO + RDSYCJ + RDSYPP ;
ASYND = BCOS * (1-V_CNR)  ;
regle 3023108:
application : iliad , batch  ;

IAVF = IRE - EPAV + CICORSE + CICULTUR + CIGPA + CIRCMAVFT ;


DIAVF2 = (BCIGA + IPRECH + IPCHER + IPELUS + RCMAVFT + DIREPARGNE) * (1 - positif(RE168+TAX1649)) + CIRCMAVFT * positif(RE168+TAX1649);


IAVF2 = (CIDIREPARGNE + IPRECH + CIRECH + IPELUS + CIRCMAVFT + CIGPA + 0) * (1-positif(RE168+TAX1649))
+ CIRCMAVFT * positif(RE168+TAX1649);

IAVFGP = IAVF2 + CREFAM + CREAPP;
regle 3023109:
application : iliad , batch  ;
I2DH = EPAV;
regle 30231011:
application : iliad , batch  ;
BTANTGECUM = (V_BTGECUM * (1 - present(DEPMOBIL)) + DEPMOBIL);
P2GE = max( (   PLAF_GE2 * (1 + BOOL_0AM)
             + PLAF_GE2_PACQAR * (V_0CH + V_0DP)
             + PLAF_GE2_PAC * (V_0CR + V_0CF + V_0DJ + V_0DN)  
              ) - BTANTGECUM
             , 0
             ) ;
BGEDECL = RDTECH + RDEQPAHA + RDGEQ ;
BGEPAHA = min(RDEQPAHA , P2GE) * (1 - V_CNR);
BGEAUTRE = min(RDGEQ,max(P2GE - BGEPAHA,0)) * (1 - V_CNR) ;
P2GEWL = max(0,P2GE + PLAF_GE2 * (1 + BOOL_0AM) -  BGEPAHA - BGEAUTRE);

BGTECH = min(RDTECH , P2GEWL) * (1 - V_CNR) ;
TOTBGE = BGTECH + BGEPAHA + BGEAUTRE ;
RGEPAHA =  (BGEPAHA * TX25 / 100 ) * (1 - V_CNR) ;
RGEAUTRE = (BGEAUTRE * TX15 / 100 ) * (1 - V_CNR) ;
RGTECH = (BGTECH * TX30 / 100 ) * (1 - V_CNR) ;
CIGE = arr (RGTECH + RGEPAHA + RGEAUTRE) * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;
GECUM = min(P2GE,BGEPAHA + BGEAUTRE + BGTECH) ;
GECUMWL = max(0,BGTECH + BGEPAHA + BGEAUTRE - GECUM) ;
DAIDC = CREAIDE ;
AAIDC = BADCRE * (1-V_CNR) ;
CIADCRE = arr (BADCRE * TX_AIDOMI /100) * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;
regle 30231012:
application : iliad , batch  ;
DLOYIMP = LOYIMP ;
ALOYIMP = DLOYIMP;
CILOYIMP = arr(ALOYIMP*TX_LOYIMP/100) * (1 - positif(RE168 + TAX1649)) ;
regle 30231014:
application : iliad , batch  ;
RDEDUBAILSJWK = positif(MATISOSJ)*positif(CRECHOBOI)*(1-positif(CRECHOCON2))*positif(positif(CRECHOBAS)*positif(TRAVITWT)
							    +positif(CRECHOBAS)
							    +positif(PARVITWS)*positif(TRAVITWT)
							    +positif(PARVITWS));
RDEDUBAILSKWK = positif(VOLISO)*positif(CRECHOBOI)*positif(VOLISOWV)*(1-positif(CRECHOCON2));
RDEDUBAILSLWK = positif(PORENT)*positif(CRECHOBOI)*positif(PORTEWX)*(1-positif(CRECHOCON2));

DDEVDUR = CRENRJ + CINRJ + CINRJBAIL + CIBOIBAIL + CIDEP15 + MATISOSI + MATISOSJ + VOLISO + PORENT + ELESOL
	         + CHAUBOISN + CHAUBOISO + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + EAUPLUV 
		 + DIAGPERF + RESCHAL + DEPENVTY + DEPENVTX + DEPENVTW + DEPENVTV + DEPENVTU + DEPENVTT ;

PDEVDUR = max( (   PLAF_DEVDUR * (1 + BOOL_0AM)
                  + PLAF_GE2_PACQAR * (V_0CH+V_0DP)
	          + PLAF_GE2_PAC * (V_0CR+V_0CF+V_0DJ+V_0DN) 
		 ) - (V_BTDEVDUR*(1-present(DEPCHOBAS))+DEPCHOBAS) , 0 );
ADEVDUR = max (0 , min (PDEVDUR , CRENRJ + CINRJ + CINRJBAIL + CIBOIBAIL + CIDEP15 + MATISOSI + MATISOSJ * (1 - positif(RDEDUBAILSJWK))
				   + VOLISO * (1 - positif(RDEDUBAILSKWK)) + PORENT * (1 - positif(RDEDUBAILSLWK)) + ELESOL
				   + CHAUBOISN + CHAUBOISO + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + EAUPLUV + DIAGPERF
				   + RESCHAL + DEPENVTY + DEPENVTX + DEPENVTW + DEPENVTV + DEPENVTU + DEPENVTT)) 
	   * (1 - V_CNR) * ((V_REGCO+0) dans (1,3,5,6)) ;

RDEVDURTY = min (ADEVDUR , DEPENVTY) ;
RDEVDURTX = min (max(0 , ADEVDUR-RDEVDURTY) , DEPENVTX) ;
RDEVDURTW = min (max(0 , ADEVDUR-RDEVDURTY-RDEVDURTX) , DEPENVTW) ;
RDEVDURTV = min (max(0 , ADEVDUR-RDEVDURTY-RDEVDURTX-RDEVDURTW) , DEPENVTV) ;
RDEVDURTU = min (max(0 , ADEVDUR-RDEVDURTY-RDEVDURTX-RDEVDURTW-RDEVDURTV) , DEPENVTU) ;
RDEVDURTT = min (max(0 , ADEVDUR-RDEVDURTY-RDEVDURTX-RDEVDURTW-RDEVDURTV-RDEVDURTU) , DEPENVTT) ;
RDEDUBAILSSWH = present(CHAUFSOL)*min(ADEVDUR,CHAUFSOL)* positif(CRECHOCON2) ;

RDEDUBAILSTWH = present(ENERGIEST)*min(ENERGIEST,max(0,ADEVDUR - RDEDUBAILSSWH))* positif(CRECHOCON2) ;

RDEDUBAILSNWH = present(CHAUBOISN)*min(CHAUBOISN,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH))* positif(CRECHOCON2) ;

RDEDUBAILSQWH = present(POMPESQ)*min(POMPESQ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH))* positif(CRECHOCON2) ;

RDEDUBAILSRWH = present(POMPESR)*min(POMPESR,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH))* positif(CRECHOCON2) ;

RDEDUBAILSS   = present(CHAUFSOL)*min(CHAUFSOL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH)) * (1-positif(CRECHOCON2))
				     * (1-positif(RDEDUBAILSSWH));

RDEDUBAILST   = present(ENERGIEST)*min(ENERGIEST,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS))* (1-positif(CRECHOCON2))
				     * (1-positif(RDEDUBAILSTWH));

RDEDUBAILSV   = present(DIAGPERF)*min(DIAGPERF,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST)) ;

RDEDUBAILSEWH = present(CINRJBAIL)*min(CINRJBAIL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV))* positif(CRECHOCON2) ;

RDEDUBAILSN   = present(CHAUBOISN)*min(CHAUBOISN,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH))* (1-positif(CRECHOCON2)) 
				     * (1-positif(RDEDUBAILSNWH));

RDEDUBAILSQ   = present(POMPESQ)*min(POMPESQ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN))* (1-positif(CRECHOCON2)) 
				     * (1-positif(RDEDUBAILSQWH));

RDEDUBAILSR   = present(POMPESR)*min(POMPESR,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ))* (1-positif(CRECHOCON2)) 
				     * (1-positif(RDEDUBAILSRWH));

RDEDUBAILSGWH = present(CINRJ)*min(CINRJ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR)) 
					     *positif(CRECHOCON2)*
					     positif(positif(TRAMURWC)*positif(ISOMURWA)
					            +positif(ISOMURWA)
					            +positif(TRAMURWC)*positif(ISOMURWB));

RDEDUBAILSHWH = present(CIDEP15)*min(CIDEP15,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH)) 
					     *positif(CRECHOCON2)
					     *positif(positif(TRATOIVG)*positif(ISOTOIVE)
						    +positif(ISOTOIVE)
						    +positif(TRATOIVG)*positif(ISOTOIVF));

RDEDUBAILSOWH = present(CHAUBOISO)*min(CHAUBOISO,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH)) * positif(CRECHOCON2);

RDEDUBAILSPWH = present(POMPESP)*min(POMPESP,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH)) * positif(CRECHOCON2);

RDEDUBAILSDWH = present(CIBOIBAIL)*min(CIBOIBAIL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
					     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH)) * positif(CRECHOCON2);

RDEDUBAILSJWH = present(MATISOSJ)*min(MATISOSJ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH))
					     *
					     positif(positif(CRECHOCON2)*positif(CRECHOBOI)*positif(CRENRJRNOUV)*positif(TRAVITWT)
						    +positif(CRECHOCON2)*positif(CRENRJRNOUV)*positif(TRAVITWT)
						    +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(CRENRJRNOUV)
						    +positif(CRECHOCON2)*positif(CRENRJRNOUV)
					            +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(CRECHOBAS)*positif(TRAVITWT)
					            +positif(CRECHOCON2)*positif(CRECHOBAS)*positif(TRAVITWT)
					            +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(CRECHOBAS)
					            +positif(CRECHOCON2)*positif(CRECHOBAS)
					            +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(PARVITWS)*positif(TRAVITWT)
					            +positif(CRECHOCON2)*positif(PARVITWS)*positif(TRAVITWT))
				     * (1-positif(RDEDUBAILSJWK));

RDEDUBAILSE   = present(CINRJBAIL)*min(CINRJBAIL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH)) * (1-positif(CRECHOCON2))
				     * (1-positif(RDEDUBAILSEWH));

RDEDUBAILSF   = present(CRENRJ)*min(CRENRJ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE)) ;

RDEDUBAILSG   = present(CINRJ)*min(CINRJ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF))
					     *positif(positif(TRAMURWC)*positif(ISOMURWA)
									 +positif(ISOMURWA)
									 +positif(CRECHOCON2)*positif(ISOMURWB)
									 +positif(TRAMURWC)*positif(ISOMURWB)
									 +positif(ISOMURWB))
				     * (1-positif(RDEDUBAILSGWH));

RDEDUBAILSH   = present(CIDEP15)*min(CIDEP15,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG)) 
					     *positif(positif(TRATOIVG)*positif(ISOTOIVE)
								      +positif(ISOTOIVE)
								      +positif(CRECHOCON2)*positif(ISOTOIVF)
								      +positif(TRATOIVG)*positif(ISOTOIVF)
								      +positif(ISOTOIVF))
				     * (1-positif(RDEDUBAILSHWH));

RDEDUBAILSI   = present(MATISOSI)*min(MATISOSI,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
         				     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH)) ;

RDEDUBAILSO   = present(CHAUBOISO)*min(CHAUBOISO,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI)) * (1-positif(CRECHOCON2))
				     * (1-positif(RDEDUBAILSOWH));

RDEDUBAILSP   = present(POMPESP)*min(POMPESP,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO)) * (1-positif(CRECHOCON2))
				     * (1-positif(RDEDUBAILSPWH));

RDEDUBAILSU   = present(EAUPLUV)*min(EAUPLUV,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP)) ;

RDEDUBAILSW   = present(RESCHAL)*min(RESCHAL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP-RDEDUBAILSU)) ;

RDEDUBAILSM   = present(ELESOL)*min(ELESOL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP-RDEDUBAILSU
					     - RDEDUBAILSW)) ;

RDEDUBAILSD   = present(CIBOIBAIL)*min(CIBOIBAIL,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP-RDEDUBAILSU
					     - RDEDUBAILSW-RDEDUBAILSM)) * (1-positif(CRECHOCON2))
				     * (1-positif(RDEDUBAILSDWH));

RDEDUBAILSJ   = present(MATISOSJ)*min(MATISOSJ,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP-RDEDUBAILSU
					     - RDEDUBAILSW-RDEDUBAILSM-RDEDUBAILSD))
					     *positif(
					      (1-positif(CRECHOCON2))*positif(CRECHOBOI)*positif(CRENRJRNOUV)*positif(TRAVITWT)
					     +(1-positif(CRECHOCON2))*positif(CRENRJRNOUV)*positif(TRAVITWT)
					     +(1-positif(CRECHOCON2))*positif(CRECHOBOI)*positif(CRENRJRNOUV)
					     +(1-positif(CRECHOCON2))*positif(CRENRJRNOUV)
					     +(1-positif(CRECHOCON2))*positif(CRECHOBAS)*positif(TRAVITWT)
					     +(1-positif(CRECHOCON2))*positif(CRECHOBAS)
					     +(1-positif(CRECHOCON2))*positif(PARVITWS)*positif(TRAVITWT)
					     +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(PARVITWS)
					     +positif(CRECHOCON2)*positif(PARVITWS)
					     +(1-positif(CRECHOCON2))*positif(PARVITWS))
				     * (1-positif(RDEDUBAILSJWH)) * (1-positif(RDEDUBAILSJWK));
RDEDUBAILSK   = present(VOLISO)*min(VOLISO,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP-RDEDUBAILSU
					     - RDEDUBAILSW-RDEDUBAILSM-RDEDUBAILSD-RDEDUBAILSJ))
					     *positif(positif(CRECHOCON2)*positif(CRECHOBOI)*positif(VOLISOWU)
								     +positif(CRECHOCON2)*positif(VOLISOWU)
								     +positif(CRECHOBOI)*positif(VOLISOWU)
								     +positif(VOLISOWU)
								     +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(VOLISOWV)
								     +positif(CRECHOCON2)*positif(VOLISOWV)
								     +positif(VOLISOWV))
				     * (1-positif(RDEDUBAILSKWK));

RDEDUBAILSL   = present(PORENT)*min(PORENT,max(0,ADEVDUR - RDEDUBAILSSWH-RDEDUBAILSTWH-RDEDUBAILSNWH-RDEDUBAILSQWH-RDEDUBAILSRWH-RDEDUBAILSS
		                 	     - RDEDUBAILST-RDEDUBAILSV-RDEDUBAILSEWH-RDEDUBAILSN-RDEDUBAILSQ-RDEDUBAILSR-RDEDUBAILSGWH
					     - RDEDUBAILSHWH-RDEDUBAILSOWH-RDEDUBAILSPWH-RDEDUBAILSDWH-RDEDUBAILSJWH-RDEDUBAILSE
					     - RDEDUBAILSF-RDEDUBAILSG-RDEDUBAILSH-RDEDUBAILSI-RDEDUBAILSO-RDEDUBAILSP-RDEDUBAILSU
					     - RDEDUBAILSW-RDEDUBAILSM-RDEDUBAILSD-RDEDUBAILSJ-RDEDUBAILSK))
					     *positif(positif(CRECHOCON2)*positif(CRECHOBOI)*positif(PORTEWW)
								     +positif(CRECHOCON2)*positif(PORTEWW)
								     +positif(CRECHOBOI)*positif(PORTEWW)
								     +positif(PORTEWW)
					                             +positif(CRECHOCON2)*positif(CRECHOBOI)*positif(PORTEWX)
								     +positif(CRECHOCON2)*positif(PORTEWX)
								     +positif(PORTEWX))
				     * (1-positif(RDEDUBAILSLWK));
CIDEVDUR = arr(RDEDUBAILSSWH * TX40/100
                 +RDEDUBAILSTWH * TX40/100
                 +RDEDUBAILSNWH * TX34/100
                 +RDEDUBAILSQWH * TX34/100
                 +RDEDUBAILSRWH * TX34/100
                 +RDEDUBAILSS   * TX32/100
                 +RDEDUBAILST   * TX32/100
                 +RDEDUBAILSV   * TX32/100
                 +RDEDUBAILSEWH * TX26/100
                 +RDEDUBAILSN   * TX26/100
                 +RDEDUBAILSQ   * TX26/100
                 +RDEDUBAILSR   * TX26/100
                 +RDEDUBAILSGWH * TX23/100
                 +RDEDUBAILSHWH * TX23/100
                 +RDEDUBAILSOWH * TX23/100
                 +RDEDUBAILSPWH * TX23/100
                 +RDEDUBAILSDWH * TX18/100
                 +RDEDUBAILSJWH * TX18/100
                 +RDEDUBAILSE   * TX17/100
                 +RDEDUBAILSF   * TX15/100
                 +RDEDUBAILSG   * TX15/100
                 +RDEDUBAILSH   * TX15/100
                 +RDEDUBAILSI   * TX15/100
                 +RDEDUBAILSO   * TX15/100
                 +RDEDUBAILSP   * TX15/100
                 +RDEDUBAILSU   * TX15/100
                 +RDEDUBAILSW   * TX15/100
                 +RDEDUBAILSM   * TX11/100
                 +RDEDUBAILSD   * TX10/100
                 +RDEDUBAILSJ   * TX10/100
                 +RDEDUBAILSK   * TX10/100
                 +RDEDUBAILSL   * TX10/100
                 +RDEVDURTY     * TX32/100
		 +RDEVDURTX     * TX26/100 
		 +RDEVDURTW     * TX17/100  
		 +RDEVDURTV     * TX15/100
		 +RDEVDURTU     * TX11/100
		 +RDEVDURTT     * TX10/100 
		)  * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;
DEVDURCUM = ADEVDUR + (V_BTDEVDUR*(1-present(DEPCHOBAS))+DEPCHOBAS);
regle 302310141:
application : iliad , batch  ;
CIDEPENV = DEPENV * (1 - V_CNR);
regle 30231015:
application : iliad , batch  ;
DTEC = RISKTEC;
ATEC = positif(DTEC) * DTEC;
CITEC = arr (ATEC * TX30/100);
regle 30231016:
application : iliad , batch  ;
DPRETUD = PRETUD + PRETUDANT ;
APRETUD = max(min(PRETUD,LIM_PRETUD) + min(PRETUDANT,LIM_PRETUD*CASEPRETUD),0) * (1-V_CNR) ;

CIPRETUD = arr(APRETUD*TX_PRETUD/100) * (1 - positif(RE168 + TAX1649)) * (1-V_CNR) ;
regle 30231017:
application : iliad , batch  ;

EM7 = somme (i=0..7: min (1 , max(0 , V_0Fi + AG_LIMFG - V_ANREV)))
      + (1 - positif(somme(i=0..7:V_0Fi) + 0)) * V_0CF ;

EM7QAR = somme (i=0..5: min (1 , max(0 , V_0Hi + AG_LIMFG - V_ANREV)))
         + somme (j=0..3: min (1 , max(0 , V_0Pj + AG_LIMFG - V_ANREV)))
         + (1 - positif(somme(i=0..5: V_0Hi) + somme(j=0..3: V_0Pj) + 0)) * (V_0CH + V_0DP) ;

BRFG = min(RDGARD1,PLAF_REDGARD) + min(RDGARD2,PLAF_REDGARD)
       + min(RDGARD3,PLAF_REDGARD) + min(RDGARD4,PLAF_REDGARD)
       + min(RDGARD1QAR,PLAF_REDGARDQAR) + min(RDGARD2QAR,PLAF_REDGARDQAR)
       + min(RDGARD3QAR,PLAF_REDGARDQAR) + min(RDGARD4QAR,PLAF_REDGARDQAR)
       ;
RFG = arr ( (BRFG) * TX_REDGARD /100 ) * (1 -V_CNR);
DGARD = somme(i=1..4:RDGARDi)+somme(i=1..4:RDGARDiQAR);
AGARD = (BRFG) * (1-V_CNR) ;
CIGARD = RFG * (1 - positif(RE168 + TAX1649)) ;
regle 30231018:
application : iliad , batch  ;

PREHAB = PREHABT + PREHABTN + PREHABTN1 + PREHABT1 + PREHABT2 + PREHABTN2 + PREHABTVT ;

BCIHP = max(( PLAFHABPRIN * (1 + BOOL_0AM) * (1+positif(V_0AP+V_0AF+V_0CG+V_0CI+V_0CR))
	         + (PLAFHABPRINENF/2) * (V_0CH + V_0DP)
         	 + PLAFHABPRINENF * (V_0CR + V_0CF + V_0DJ + V_0DN)
	          ) 
	     ,0);

BCIHABPRIN1 = min(BCIHP , PREHABT) * (1 - V_CNR) ;
BCIHABPRIN2 = min(max(0,BCIHP-BCIHABPRIN1),PREHABT1) * (1 - V_CNR);
BCIHABPRIN3 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2),PREHABTN) * (1 - V_CNR);
BCIHABPRIN4 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3),PREHABTN1) * (1 - V_CNR);
BCIHABPRIN5 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4),PREHABT2) * (1 - V_CNR);
BCIHABPRIN6 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4-BCIHABPRIN5),PREHABTN2) * (1 - V_CNR);
BCIHABPRIN7 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4-BCIHABPRIN5-BCIHABPRIN6),PREHABTVT) * (1 - V_CNR);

BCIHABPRIN = BCIHABPRIN1 + BCIHABPRIN2 + BCIHABPRIN3 + BCIHABPRIN4 + BCIHABPRIN5 + BCIHABPRIN6 + BCIHABPRIN7 ;

CIHABPRIN = arr((BCIHABPRIN1 * TX40/100)
		+ (BCIHABPRIN2 * TX40/100)
		+ (BCIHABPRIN3 * TX30/100)
                + (BCIHABPRIN4 * TX25/100)
                + (BCIHABPRIN5 * TX20/100)
		+ (BCIHABPRIN6 * TX15/100)
		+ (BCIHABPRIN7 * TX10/100))
		* (1 - positif(RE168 + TAX1649)) * (1 - V_CNR);
regle 302311:
application : iliad , batch ;
CICSG = min( CSGC , arr( IPPNCS * T_CSG/100 ));
CIRDS = min( RDSC , arr( (IPPNCS+REVCSXA+REVCSXB+REVCSXC+REVCSXD+REVCSXE) * T_RDS/100 ));
CIPRS = min( PRSC , arr( IPPNCS * T_PREL_SOC/100 ));
CIRSE1 = min( RSE1 , arr( REVCSXA * TX075/100 ));
CIRSE2 = min( RSE2 , arr( REVCSXC * TX066/100 ));
CIRSE3 = min( RSE3 , arr( REVCSXD * TX062/100 ));
CIRSE4 = min( RSE4 , arr( REVCSXE * TX038/100 ));
CIRSE5 = min( RSE5 , arr( REVCSXB * TX075/100 ));
CIRSETOT = CIRSE1 + CIRSE2 + CIRSE3 + CIRSE4 + CIRSE5;


regle 30400:
application : iliad , batch  ;
PPE_DATE_DEB = positif(V_0AV+0) * positif(V_0AZ+0) * (V_0AZ+0)
              + positif(DATRETETR+0) * (DATRETETR+0) * null(V_0AZ+0) ;

PPE_DATE_FIN = positif(BOOL_0AM) * positif(V_0AZ+0) * (V_0AZ+0)
              + positif(DATDEPETR+0) * (DATDEPETR+0) * null(V_0AZ+0) ;
regle 30500:
application : iliad , batch  ;
PPE_DEBJJMMMM =  PPE_DATE_DEB + (01010000+V_ANREV) * null(PPE_DATE_DEB+0);
PPE_DEBJJMM = arr( (PPE_DEBJJMMMM - V_ANREV)/10000);
PPE_DEBJJ =  inf(PPE_DEBJJMM/100);
PPE_DEBMM =  PPE_DEBJJMM -  (PPE_DEBJJ*100);
PPE_DEBRANG= PPE_DEBJJ 
             + (PPE_DEBMM - 1 ) * 30;
regle 30501:
application : iliad , batch  ;
PPE_FINJJMMMM =  PPE_DATE_FIN + (30120000+V_ANREV) * null(PPE_DATE_FIN+0);
PPE_FINJJMM = arr( (PPE_FINJJMMMM - V_ANREV)/10000);
PPE_FINJJ =  inf(PPE_FINJJMM/100);
PPE_FINMM =  PPE_FINJJMM -  (PPE_FINJJ*100);
PPE_FINRANG= PPE_FINJJ 
             + (PPE_FINMM - 1 ) * 30
             - 1 * positif (PPE_DATE_FIN);
regle 30503:
application : iliad , batch  ;
PPE_DEBUT = PPE_DEBRANG ;
PPE_FIN   = PPE_FINRANG ;
PPENBJ = max(1, arr(min(PPENBJAN , PPE_FIN - PPE_DEBUT + 1))) ;
regle 30508:
application : iliad , batch  ;
PPETX1 = PPE_TX1 ;
PPETX2 = PPE_TX2 ;
PPETX3 = PPE_TX3 ;
regle 30510:
application : iliad , batch  ;
PPE_BOOL_ACT_COND = positif(


   positif ( TSHALLOV ) 
 + positif ( TSHALLOC ) 
 + positif ( TSHALLO1 ) 
 + positif ( TSHALLO2 ) 
 + positif ( TSHALLO3 ) 
 + positif ( TSHALLO4 ) 
 + positif ( GLD1V ) 
 + positif ( GLD2V ) 
 + positif ( GLD3V ) 
 + positif ( GLD1C ) 
 + positif ( GLD2C ) 
 + positif ( GLD3C ) 
 + positif ( BPCOSAV ) 
 + positif ( BPCOSAC ) 
 + positif ( TSASSUV ) 
 + positif ( TSASSUC ) 
 + positif( CARTSV ) * positif( CARTSNBAV )
 + positif( CARTSC ) * positif( CARTSNBAC )
 + positif( CARTSP1 ) * positif( CARTSNBAP1 )
 + positif( CARTSP2 ) * positif( CARTSNBAP2 )
 + positif( CARTSP3 ) * positif( CARTSNBAP3 )
 + positif( CARTSP4 ) * positif( CARTSNBAP4 )
 + positif( TSELUPPEV )
 + positif( TSELUPPEC )
 + positif( HEURESUPV )
 + positif( HEURESUPC )
 + positif( HEURESUPP1 )
 + positif( HEURESUPP2 )
 + positif( HEURESUPP3 )
 + positif( HEURESUPP4 )
 + positif ( FEXV ) 
 + positif ( BAFV ) 
 + positif ( BAFPVV ) 
 + positif ( BAEXV ) 
 + positif ( BACREV ) + positif ( 4BACREV )
 + positif ( BACDEV ) 
 + positif ( BAHEXV ) 
 + positif ( BAHREV ) + positif ( 4BAHREV )
 + positif ( BAHDEV ) 
 + positif ( MIBEXV ) 
 + positif ( MIBVENV ) 
 + positif ( MIBPRESV ) 
 + positif ( MIBPVV ) 
 + positif ( BICEXV ) 
 + positif ( BICNOV ) 
 + positif ( BICDNV ) 
 + positif ( BIHEXV ) 
 + positif ( BIHNOV ) 
 + positif ( BIHDNV ) 
 + positif ( FEXC ) 
 + positif ( BAFC ) 
 + positif ( BAFPVC ) 
 + positif ( BAEXC ) 
 + positif ( BACREC ) + positif ( 4BACREC )
 + positif ( BACDEC ) 
 + positif ( BAHEXC ) 
 + positif ( BAHREC ) + positif ( 4BAHREC )
 + positif ( BAHDEC ) 
 + positif ( MIBEXC ) 
 + positif ( MIBVENC ) 
 + positif ( MIBPRESC ) 
 + positif ( MIBPVC ) 
 + positif ( BICEXC ) 
 + positif ( BICNOC ) 
 + positif ( BICDNC ) 
 + positif ( BIHEXC ) 
 + positif ( BIHNOC ) 
 + positif ( BIHDNC ) 
 + positif ( FEXP ) 
 + positif ( BAFP ) 
 + positif ( BAFPVP ) 
 + positif ( BAEXP ) 
 + positif ( BACREP ) + positif ( 4BACREP )
 + positif ( BACDEP ) 
 + positif ( BAHEXP ) 
 + positif ( BAHREP ) + positif ( 4BAHREP )
 + positif ( BAHDEP ) 
 + positif ( MIBEXP ) 
 + positif ( MIBVENP ) 
 + positif ( MIBPRESP ) 
 + positif ( BICEXP ) 
 + positif ( MIBPVP ) 
 + positif ( BICNOP ) 
 + positif ( BICDNP ) 
 + positif ( BIHEXP ) 
 + positif ( BIHNOP ) 
 + positif ( BIHDNP ) 
 + positif ( BNCPROEXV ) 
 + positif ( BNCPROV ) 
 + positif ( BNCPROPVV ) 
 + positif ( BNCEXV ) 
 + positif ( BNCREV ) 
 + positif ( BNCDEV ) 
 + positif ( BNHEXV ) 
 + positif ( BNHREV ) 
 + positif ( BNHDEV ) 
 + positif ( BNCCRV ) 
 + positif ( BNCPROEXC ) 
 + positif ( BNCPROC ) 
 + positif ( BNCPROPVC ) 
 + positif ( BNCEXC ) 
 + positif ( BNCREC ) 
 + positif ( BNCDEC ) 
 + positif ( BNHEXC ) 
 + positif ( BNHREC ) 
 + positif ( BNHDEC ) 
 + positif ( BNCCRC ) 
 + positif ( BNCPROEXP ) 
 + positif ( BNCPROP ) 
 + positif ( BNCPROPVP ) 
 + positif ( BNCEXP ) 
 + positif ( BNCREP ) 
 + positif ( BNCDEP ) 
 + positif ( BNHEXP ) 
 + positif ( BNHREP ) 
 + positif ( BNHDEP )
 + positif ( BNCCRP ) 
 + positif ( BIPERPV )
 + positif ( BIPERPC )
 + positif ( BIPERPP )
 + positif ( BAFORESTV )
 + positif ( BAFORESTC )
 + positif ( BAFORESTP )
 + positif ( AUTOBICVV ) + positif ( AUTOBICPV ) + positif ( AUTOBNCV ) 
 + positif ( AUTOBICVC ) + positif ( AUTOBICPC ) + positif ( AUTOBNCC )
 + positif ( AUTOBICVP ) + positif ( AUTOBICPP ) + positif ( AUTOBNCP )
 + positif ( LOCPROCGAV ) + positif ( LOCPROV ) + positif ( LOCDEFPROCGAV )
 + positif ( LOCDEFPROV ) + positif ( LOCPROCGAC ) + positif ( LOCPROC )
 + positif ( LOCDEFPROCGAC ) + positif ( LOCDEFPROC ) + positif ( LOCPROCGAP ) 
 + positif ( LOCPROP ) + positif ( LOCDEFPROCGAP ) + positif ( LOCDEFPROP )
 + positif ( XHONOAAV ) + positif ( XHONOAAC ) + positif ( XHONOAAP )
 + positif ( XHONOV ) + positif ( XHONOC ) + positif ( XHONOP )
 + positif ( GLDGRATV ) + positif ( GLDGRATC )
 + positif ( SALINTV ) + positif ( SALINTC )
);
regle 30520:
application : iliad , batch  ;
PPE_BOOL_SIFC 	= (1 - BOOL_0AM)*(1 - positif (V_0AV)*positif(V_0AZ)) ;


PPE_BOOL_SIFM	= BOOL_0AM  + positif (V_0AV)*positif(V_0AZ) ;

PPESEUILKIR   = PPE_BOOL_SIFC * PPELIMC  
                + PPE_BOOL_SIFM * PPELIMM
                + (NBPT - 1 - PPE_BOOL_SIFM - NBQAR) * 2 * PPELIMPAC
                + NBQAR * PPELIMPAC * 2 ;


PPE_KIRE =  REVKIRE * PPENBJAN / PPENBJ;

PPE_BOOL_KIR_COND =   (1 - null (IND_TDR)) * positif_ou_nul ( PPESEUILKIR - PPE_KIRE);

regle 30525:
application : iliad , batch  ;
pour i=V,C:
PPE_BOOL_NADAi = positif (TSHALLOi+HEURESUPi+0 ) * null ( PPETPi+0  ) * null (PPENHi+0);
pour i=1,2,3,4:
PPE_BOOL_NADAi = positif (TSHALLOi+HEURESUPPi+0 ) * null ( PPETPPi+0 ) * null (PPENHPi+0);

PPE_BOOL_NADAU = positif(TSHALLO1 + TSHALLO2 + TSHALLO3 + TSHALLO4 
			  + HEURESUPP1 + HEURESUPP2 + HEURESUPP3 + HEURESUPP4 + 0)
                 * null ( PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4     +0)
                 * null ( PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4     +0);  

PPE_BOOL_NADAN=0;

regle 30530:
application : iliad , batch  ;
pour i=V,C:
PPE_SALAVDEFi =
   TSHALLOi
 + HEURESUPi
 +  BPCOSAi  
 + GLD1i  
 + GLD2i  
 + GLD3i  
 + TSASSUi  
 + TSELUPPEi
 + CARTSi * positif(CARTSNBAi)
 + GLDGRATi + SALINTi
  ;
pour i =1..4:
PPE_SALAVDEFi= TSHALLOi + HEURESUPPi + CARTSPi * positif(CARTSNBAPi) ;

regle 30540:
application : iliad , batch  ;
pour i = V,C,P:
PPE_RPRO1i =   
(
   FEXi  
 + BAFi  
 + BAEXi  
 + BACREi + 4BACREi
 - BACDEi  
 + BAHEXi  
 + BAHREi + 4BAHREi 
 - BAHDEi  
 + BICEXi  
 + BICNOi  
 - BICDNi  
 + BIHEXi  
 + BIHNOi  
 - BIHDNi  
 + BNCEXi  
 + BNCREi  
 - BNCDEi  
 + BNHEXi  
 + BNHREi  
 - BNHDEi  
 + MIBEXi  
 + BNCPROEXi  
 + TMIB_NETVi  
 + TMIB_NETPi
 + TSPENETPi  
 + BAFPVi  
 + MIBPVi  
 + BNCPROPVi  
 + BAFORESTi
 + LOCPROi + LOCPROCGAi - LOCDEFPROCGAi - LOCDEFPROi
 + XHONOAAi + XHONOi

) ;

pour i = V,C,P:
PPE_AVRPRO1i = 
(
   FEXi  
 + BAFi  
 + BAEXi  
 + BACREi + 4BACREi 
 - BACDEi  
 + BAHEXi  
 + BAHREi + 4BAHREi 
 - BAHDEi  
 + BICEXi  
 + BICNOi  
 - BICDNi  
 + BIHEXi   
 + BIHNOi  
 - BIHDNi  
 + BNCEXi  
 + BNCREi  
 - BNCDEi  
 + BNHEXi  
 + BNHREi  
 - BNHDEi  
 + MIBEXi  
 + BNCPROEXi  
 + MIBVENi  
 + MIBPRESi
 + BNCPROi  
 + BAFPVi  
 + MIBPVi  
 + BNCPROPVi  
 + BAFORESTi
 + AUTOBICVi + AUTOBICPi + AUTOBNCi 
 + LOCPROi + LOCPROCGAi + LOCDEFPROCGAi + LOCDEFPROi
 + XHONOAAi + XHONOi
) ;

pour i=V,C,P:
SOMMEAVRPROi = present(FEXi) + present(BAFi) + present(BAEXi) 
	      + present(BACREi) + present(4BACREi) + present(BACDEi) + present(BAHEXi) 
	      + present(BAHREi) + present(4BAHREi) + present(BAHDEi) + present(BICEXi) + present(BICNOi) 
	      + present(BICDNi) + present(BIHEXi) + present(BIHNOi) 
	      + present(BIHDNi) + present(BNCEXi) + present(BNCREi) 
              + present(BNCDEi) + present(BNHEXi) + present(BNHREi) + present(BNHDEi) + present(MIBEXi) 
              + present(BNCPROEXi) + present(MIBVENi) + present(MIBPRESi) + present(BNCPROi) 
	      + present(BAFPVi) + present(MIBPVi) + present(BNCPROPVi) + present(BAFORESTi)
	      + present(AUTOBICVi) + present(AUTOBICPi) + present(AUTOBNCi) + present(LOCPROi) + present(LOCPROCGAi)
	      + present(LOCDEFPROCGAi) + present(LOCDEFPROi) + present(XHONOAAi) + present(XHONOi)
;

pour i=V,C,P:
PPE_RPROi = positif(PPE_RPRO1i) * arr((1+ PPETXRPRO/100) * PPE_RPRO1i )
           +(1-positif(PPE_RPRO1i)) * arr(PPE_RPRO1i * (1- PPETXRPRO/100));
regle 30550:
application : iliad , batch  ;


PPE_BOOL_SEULPAC = null(V_0CF + V_0CR + V_0DJ + V_0DN + V_0CH + V_0DP -1);

PPE_SALAVDEFU = (somme(i=1,2,3,4: PPE_SALAVDEFi))* PPE_BOOL_SEULPAC;
PPE_KIKEKU = 1 * positif(PPE_SALAVDEF1 )
           + 2 * positif(PPE_SALAVDEF2 )
           + 3 * positif(PPE_SALAVDEF3 )
           + 4 * positif(PPE_SALAVDEF4 );


pour i=V,C:
PPESALi = PPE_SALAVDEFi + PPE_RPROi*(1 - positif(PPE_RPROi)) ;
 
PPESALU = (PPE_SALAVDEFU + PPE_RPROP*(1 - positif(PPE_RPROP)))
          * PPE_BOOL_SEULPAC;


pour i = 1..4:
PPESALi =  PPE_SALAVDEFi * (1 - PPE_BOOL_SEULPAC) ;

regle 30560:
application : iliad , batch  ;

pour i=V,C:
PPE_RTAi = max(0,PPESALi +  PPE_RPROi * positif(PPE_RPROi));


pour i =1..4:
PPE_RTAi = PPESALi;

PPE_RTAU = max(0,PPESALU + PPE_RPROP * positif(PPE_RPROP)) * PPE_BOOL_SEULPAC;
PPE_RTAN = max(0, PPE_RPROP ) * (1 - PPE_BOOL_SEULPAC);
regle 30570:
application : iliad , batch  ;
pour i=V,C:
PPE_BOOL_TPi = positif
             (
                 positif ( PPETPi+0) * positif(PPE_SALAVDEFi+0)
               + null (PPENHi+0) * null(PPETPi+0)* positif(PPE_SALAVDEFi)
               + positif ( 360 / PPENBJ * ( PPENHi*positif(PPE_SALAVDEFi+0) /1820 
                                            + PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) /360 ) - 1 )
               + positif_ou_nul (PPENHi*positif(PPE_SALAVDEFi+0) - 1820 )
               + positif_ou_nul (PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) - 360 )
               + positif(PPEACi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi)))+0)  
               + (1 - positif(PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi)))))
				    *(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi)))
             ) ;

PPE_BOOL_TPU = positif
             (
               (  positif ( PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4) * positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4)
               + null (PPENHP1+PPENHP2+PPENHP3+PPENHP4+0)
                 * null(PPETPP1+PPETPP2+PPETPP3+PPETPP4+0)
                 * positif(PPE_SALAVDEF1+PPE_SALAVDEF2
                          +PPE_SALAVDEF3+PPE_SALAVDEF4)  
               + positif( ( 360 / PPENBJ * ((PPENHP1+PPENHP2+PPENHP3+PPENHP4)*positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4))/1820 + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) /360 ) - 1 )
               + positif_ou_nul (((PPENHP1+PPENHP2+PPENHP3+PPENHP4)*positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4))-1820)
               + positif_ou_nul ( PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) - 360 )
               + positif(PPEACP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))))  
               + (1 - positif(PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))))
			  *(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))) 
          * PPE_BOOL_SEULPAC
              );


pour i =1,2,3,4:
PPE_BOOL_TPi = positif  
             (   positif ( PPETPPi) * positif(PPE_SALAVDEFi+0)
              + null (PPENHPi+0) * null(PPETPPi+0)* positif(PPE_SALAVDEFi)  
              + positif_ou_nul ( 360 / PPENBJ * PPENHPi*positif(PPE_SALAVDEFi+0) - 1820 )
             );

PPE_BOOL_TPN= positif 
             (
                positif_ou_nul ( 360 / PPENBJ * PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) - 360 )
              + positif(PPEACP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))))  
              + (1 - positif(PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))))
		   *(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))
             ) ;

regle 30580:
application : iliad , batch  ;


pour i =V,C:
PPE_COEFFi =  PPE_BOOL_TPi * 360/  PPENBJ
             +  ( 1 -  PPE_BOOL_TPi)  / (PPENHi*positif(PPE_SALAVDEFi+0) /1820 + PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) /360);

PPE_COEFFU =       PPE_BOOL_TPU * 360/  PPENBJ
       	     +  ( 1 -  PPE_BOOL_TPU)  / 
               ((PPENHP1+PPENHP2+PPENHP3+PPENHP4)/1820 + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) /360)
          * PPE_BOOL_SEULPAC;


pour i =1..4:
PPE_COEFFi =       PPE_BOOL_TPi * 360/  PPENBJ
       	     +  ( 1 -  PPE_BOOL_TPi)  / (PPENHPi*positif(PPE_SALAVDEFi+0) /1820 );


PPE_COEFFN =       PPE_BOOL_TPN * 360/  PPENBJ
     	     +  ( 1 -  PPE_BOOL_TPN)  / (PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) /360);


 
pour i= V,C,1,2,3,4,U,N:
PPE_RCONTPi = arr (  PPE_RTAi * PPE_COEFFi ) ;


regle 30590:
application : iliad , batch  ;

pour i=V,C,U,N,1,2,3,4:
PPE_BOOL_MINi = positif_ou_nul (PPE_RTAi- PPELIMRPB) * (1 - PPE_BOOL_NADAi);

regle 30600:
application : iliad , batch  ;

INDMONO =  BOOL_0AM 
            * (
                   positif_ou_nul(PPE_RTAV  - PPELIMRPB)
                 * positif(PPELIMRPB - PPE_RTAC)
               +
                   positif_ou_nul(PPE_RTAC - PPELIMRPB )
                   *positif(PPELIMRPB - PPE_RTAV)
               );

regle 30605:
application : iliad , batch  ;
PPE_HAUTE = PPELIMRPH * (1 - BOOL_0AM)
          + PPELIMRPH * BOOL_0AM * null(INDMONO)
                      * positif_ou_nul(PPE_RCONTPV - PPELIMRPB)
                      * positif_ou_nul(PPE_RCONTPC - PPELIMRPB)
          + PPELIMRPH2 * INDMONO;

regle 30610:
application : iliad , batch  ;

pour i=V,C:
PPE_BOOL_MAXi = positif_ou_nul(PPE_HAUTE - PPE_RCONTPi);

pour i=U,N,1,2,3,4:
PPE_BOOL_MAXi = positif_ou_nul(PPELIMRPH - PPE_RCONTPi);

regle 30615:
application : iliad , batch  ;

pour i = V,C,U,N,1,2,3,4:
PPE_FORMULEi =  PPE_BOOL_KIR_COND
               *PPE_BOOL_ACT_COND
               *PPE_BOOL_MINi
               *PPE_BOOL_MAXi
               *arr(positif_ou_nul(PPELIMSMIC - PPE_RCONTPi)
                     * arr(PPE_RCONTPi * PPETX1/100)/PPE_COEFFi
                    +
                        positif(PPE_RCONTPi - PPELIMSMIC)
                      * positif_ou_nul(PPELIMRPH - PPE_RCONTPi )
                      * arr(arr((PPELIMRPH  - PPE_RCONTPi ) * PPETX2 /100)/PPE_COEFFi)
                    +
                      positif(PPE_RCONTPi - PPELIMRPHI)
                      * positif_ou_nul(PPE_HAUTE - PPE_RCONTPi )
                      * arr(arr((PPELIMRPH2 - PPE_RCONTPi ) * PPETX3 /100)/PPE_COEFFi)
                   );


regle 30620:
application : iliad , batch  ;


pour i =V,C:

PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
               * (   null(PPENBJ - 360) * PPE_COEFFi
                  +
                    (1 - null(PPENBJ - 360)) 
                          * (    PPENBJ * 1820/360 
                                      /
                                (PPENHi*positif(PPE_SALAVDEFi+0) + PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) * 1820/360)
                            )
                 );

pour i =U,N:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
               * (   null(PPENBJ - 360) * PPE_COEFFi
                  +
                    (1 - null(PPENBJ - 360)) 
                       * ( PPENBJ * 1820/360
                                        /
                          ((PPENHP1+PPENHP2+PPENHP3+PPENHP4) + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) * 1820/360))
                 );
pour i =1,2,3,4:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
               * (  null(PPENBJ - 360) * PPE_COEFFi
                  + (1 - null(PPENBJ - 360)) 
                          * (    PPENBJ * 1820/360 
                                      /
                                (PPENHPi*positif(PPE_SALAVDEFi+0) + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) * 1820/360)
                            )
                 );

pour i =V,C,U,1,2,3,4,N:
PPENARPRIMEi =   PPE_FORMULEi * ( 1 + PPETXMAJ2)
               * positif_ou_nul(PPE_COEFFCONDi - 2)
               * (1 - PPE_BOOL_TPi)

              +  (arr(PPE_FORMULEi * PPETXMAJ1) + arr(PPE_FORMULEi * (PPE_COEFFi * PPETXMAJ2 )))
               * positif (2 - PPE_COEFFCONDi)
               * positif (PPE_COEFFCONDi  -1 )
               * (1 - PPE_BOOL_TPi)

              + PPE_FORMULEi  * positif(PPE_BOOL_TPi + positif_ou_nul (1 - PPE_COEFFCONDi))  ; 


regle 30625:
application : iliad , batch  ;
pour i =V,C,U,1,2,3,4,N:
PPEPRIMEi =arr( PPENARPRIMEi) ;

PPEPRIMEPAC = PPEPRIMEU + PPEPRIME1 + PPEPRIME2 + PPEPRIME3 + PPEPRIME4 + PPEPRIMEN ;


PPEPRIMETTEV = PPE_BOOL_KIR_COND *  PPE_BOOL_ACT_COND 
               *(
                    ( PPE_PRIMETTE
                      * BOOL_0AM
                      * INDMONO
                      *  positif_ou_nul (PPE_RTAV - PPELIMRPB)
                      *  positif_ou_nul(PPELIMRPHI - PPE_RCONTPV)
                      *  (1 - positif(PPE_BOOL_NADAV))
                     )
                   ) 
               * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
               * ( 1 -  V_CNR);
                     
PPEPRIMETTEC =  PPE_BOOL_KIR_COND *  PPE_BOOL_ACT_COND 
                *(
                     ( PPE_PRIMETTE
                      * BOOL_0AM
                      * INDMONO
                      *  positif_ou_nul(PPELIMRPHI - PPE_RCONTPC)
                      *  positif_ou_nul (PPE_RTAC - PPELIMRPB)
                      *  (1 - positif(PPE_BOOL_NADAC))
                      )
                    )
               * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
               * ( 1 -  V_CNR);
PPEPRIMETTE = PPEPRIMETTEV + PPEPRIMETTEC ;




regle 30800:
application : iliad , batch  ;

BOOLENF = positif(V_0CF + V_0CH + V_0DJ + V_0CR + 0) ;

PPE_NB_PAC= V_0CF + V_0CR + V_0DJ + V_0DN  ;
PPE_NB_PAC_QAR =  V_0CH + V_0DP ;
TOTPAC = PPE_NB_PAC + PPE_NB_PAC_QAR;



PPE_NBNONELI = ( 
                        somme(i=1,2,3,4,U,N: positif(PPEPRIMEi))
                      + somme(i=1,2,3,4,U,N: positif_ou_nul(PPE_RTAi - PPELIMRPB) 
                                           * positif(PPE_RCONTPi - PPELIMRPH)
                              )
                  );
  



PPE_NBELIGI = PPE_NB_PAC + PPE_NB_PAC_QAR - PPE_NBNONELI;


PPE_BOOL_BT = V_0BT * positif(2 - V_0AV - BOOLENF) ;

PPE_BOOL_MAJO = (1 - PPE_BOOL_BT)
               * positif (  positif_ou_nul (PPELIMRPH - PPE_RCONTPV)
                           *positif_ou_nul (PPE_RTAV - PPELIMRPB)
                           *(1 - positif(PPE_BOOL_NADAV))
                          +
                            positif_ou_nul (PPELIMRPH - PPE_RCONTPC)
                           *positif_ou_nul (PPE_RTAC - PPELIMRPB)
                           *(1 - positif(PPE_BOOL_NADAC))
                          )
                        ;
PPE_NBMAJO =    positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI)
                 *PPE_NBELIGI
               + (1 - positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI))
               *  PPE_NB_PAC ;
PPE_NBMAJOQAR =    positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI)
                 * 0
               + (1 - positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI))
                 * ( PPE_NBELIGI - PPE_NB_PAC ) ;




PPE_MAJO =   PPE_BOOL_MAJO 
           * positif( PPE_NBELIGI )
           * ( PPE_NBMAJO * PPEMONMAJO
             + PPE_NBMAJOQAR * PPEMONMAJO / 2
             );

regle 30810:
application : iliad , batch  ;


PPE_BOOL_MONO =  (1 - PPE_BOOL_MAJO )
                *  (1 - PPE_BOOL_MAJOBT)
                * positif( PPE_NB_PAC + PPE_NB_PAC_QAR - PPE_NBNONELI)
                * INDMONO
                *( ( positif( PPE_BOOL_BT + BOOL_0AM )
                    *  positif_ou_nul (PPE_RTAV - PPELIMRPB)
                    *  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPV)
                    *  (1 - positif(PPE_BOOL_NADAV))
                   )
                 + (  positif(  BOOL_0AM )
                    *  positif_ou_nul (PPE_RTAC - PPELIMRPB)
                    *  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPC)
                    *  (1 - positif(PPE_BOOL_NADAC))
                  )
                 );
PPE_MONO = PPE_BOOL_MONO * ( 1 + PPE_BOOL_BT)
          *( positif( PPE_NBMAJO) * PPEMONMAJO 
            + 
             null( PPE_NBMAJO)*positif(PPE_NBMAJOQAR) * PPEMONMAJO / 2
           )
           ;


regle 30820:
application : iliad , batch  ;


PPE_BOOL_MAJOBT = positif (  positif_ou_nul (PPELIMRPH - PPE_RCONTPV)
                            *positif_ou_nul (PPE_RTAV - PPELIMRPB)
                            *(1 - positif(PPE_BOOL_NADAV))
                          )
                * PPE_BOOL_BT;

PPE_MABT =   PPE_BOOL_MAJOBT
           * positif( PPE_NBMAJO)
           * (( PPE_NBMAJO + 1) * PPEMONMAJO
             + PPE_NBMAJOQAR * PPEMONMAJO / 2
             )
         +   PPE_BOOL_MAJOBT
           * null( PPE_NBMAJO + 0)*positif(PPE_NBMAJOQAR)
           * (  positif(PPE_NBMAJOQAR-1) *  PPE_NBMAJOQAR * PPEMONMAJO / 2
                + PPEMONMAJO 
             )
          +  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPV)
           * positif_ou_nul (PPE_RTAV - PPELIMRPB)
           * (1 - PPE_BOOL_MAJOBT)
           * (1 - positif(PPE_BOOL_NADAV))
           * PPE_BOOL_BT
           * ( positif( PPE_NB_PAC) * 2 * PPEMONMAJO
             + positif( PPE_NB_PAC_QAR ) * null ( PPE_NB_PAC + 0 ) * PPEMONMAJO
             )
            ;

                 
regle 30830:
application : iliad , batch  ;
PPEMAJORETTE =   PPE_BOOL_KIR_COND
               * PPE_BOOL_ACT_COND
               * arr ( PPE_MONO + PPE_MAJO + PPE_MABT )
               * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
               * ( 1 -  V_CNR);

regle 30900:
application : iliad , batch  ;

PPETOT = positif ( somme(i=V,C,U,1,2,3,4,N:PPENARPRIMEi)
                   +PPEPRIMETTE
                   +PPEMAJORETTE +0

 
                   +somme(i=V,C,U,1,2,3,4,N :( 1 - positif(PPELIMRPH - PPE_RCONTPi - 10))
                     *  PPE_BOOL_KIR_COND
                     *  PPE_BOOL_ACT_COND
                     *  PPE_BOOL_MINi
                     *  PPE_BOOL_MAXi)
                   +somme(i=V,C,U,1,2,3,4,N :( 1 - positif(PPELIMRPH2 - PPE_RCONTPi - 10))
                     *  PPE_BOOL_KIR_COND
                     *  PPE_BOOL_ACT_COND
                     *  PPE_BOOL_MINi
                     *  PPE_BOOL_MAXi)

           )
        
           * max(0,arr( (somme(i=V,C,U,1,2,3,4,N :PPEPRIMEi)
                                +PPEPRIMETTE
                                +PPEMAJORETTE
                        ) 
                      )
                 )
           * positif_ou_nul(arr( (somme(i=V,C,U,1,2,3,4,N :PPEPRIMEi)
                                +PPEPRIMETTE
                                +PPEMAJORETTE
				- PPELIMTOT                  )) 
                           )
       * (1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
       * (1 - positif(RE168 + TAX1649)) 
       * (1 -  V_CNR);

regle 30910:
application : iliad,batch ;
PPENATREST = positif(IRE) * positif(IREST) * 
           (
            (1 - null(2 - V_REGCO))  *
            (
             ( null(IRE - PPETOT + PPERSA) * 1                                              * 1
             + (1 - positif(PPETOT-PPERSA))                                                 * 2 
             + null(IRE) * (1 - positif(PPETOT-PPERSA))                                     * 3 
	     + positif(PPETOT-PPERSA) * positif(IRE-PPETOT+PPERSA)                          * 4
             )
	    )
           + 2 * null(2 - V_REGCO) 
           )
            ;

PPERESTA = positif(PPENATREST) * max(0,min(IREST , PPETOT-PPERSA)) ;

PPENATIMPA = positif(PPETOT-PPERSA) * (positif(IINET - PPETOT + PPERSA - ICREREVET) + positif( PPETOT - PPERSA - PPERESTA));

PPEIMPA = positif(PPENATIMPA) * positif_ou_nul(PPERESTA) * (PPETOT - PPERSA - PPERESTA) ;

PPENATREST2 = (positif(IREST - V_ANTRE + V_ANTIR) + positif(V_ANTRE - IINET)) * positif(IRE) *
             (
              (1 - null(2 - V_REGCO))  *
               (
                ( null(IRE - PPETOT + PPERSA) * 1                                              * 1
                + (1 - positif(PPETOT-PPERSA))                                                 * 2 
                + null(IRE) * (1 - positif(PPETOT-PPERSA))                                     * 3 
	        + positif(PPETOT-PPERSA) * positif(IRE-PPETOT+PPERSA)                          * 4
                )
	       )
              + 2 * null(2 - V_REGCO) 
             )
            ;

PPEREST2A = positif(IRE) * positif(IRESTITIR) * max(0,min(PPETOT-PPERSA , IRESTITIR)) ; 

PPEIMP2A = positif_ou_nul(PPEREST2A) * (PPETOT - PPERSA - PPEREST2A) ;



regle 30912:
application : iliad , batch  ;

pour i=V,C,1,2,3,4,N,U:
PPETEMPSi = arr(1 / PPE_COEFFi * 100) ;




pour i=V,C,1,2,3,4,N,U:
PPECOEFFi= arr(PPE_COEFFCONDi * 100 );
regle 989:
application : iliad, batch ;

CRESINTER = PRESINTER ;

regle 990:
application : iliad, batch ;

REST = positif(IRE) * positif(IRESTITIR) ;

LIBREST = positif(REST) * max(0,min(AUTOVERSLIB , IRESTITIR-(PPETOT-PPERSA))) ;

LIBIMP = positif_ou_nul(LIBREST) * (AUTOVERSLIB - LIBREST) ;

LOIREST = positif(REST) * max(0,min(CILOYIMP , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB)) ;

LOIIMP = positif_ou_nul(LOIREST) * (CILOYIMP - LOIREST) ;

TABREST = positif(REST) * max(0,min(CIDEBITTABAC , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP)) ;

TABIMP = positif_ou_nul(TABREST) * (CIDEBITTABAC - TABREST) ;

TAUREST = positif(REST) * max(0,min(CRERESTAU , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC)) ;

TAUIMP = positif_ou_nul(TAUREST) * (CRERESTAU - TAUREST) ;

AGRREST = positif(REST) * max(0,min(CICONGAGRI , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU)) ;

AGRIMP = positif_ou_nul(AGRREST) * (CICONGAGRI - AGRREST) ;

ARTREST = positif(REST) * max(0,min(CREARTS , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI)) ;

ARTIMP = positif_ou_nul(ARTREST) * (CREARTS - ARTREST) ;

INTREST = positif(REST) * max(0,min(CREINTERESSE , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS)) ;

INTIMP = positif_ou_nul(INTREST) * (CREINTERESSE - INTREST) ;

FORREST = positif(REST) * max(0,min(CREFORMCHENT , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE)) ;

FORIMP = positif_ou_nul(FORREST) * (CREFORMCHENT - FORREST) ;

PSIREST = positif(REST) * max(0,min(CRESINTER , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						-CREFORMCHENT)) ; 

PSIIMP = positif_ou_nul(PSIREST) * (CRESINTER - PSIREST) ;

PROREST = positif(REST) * max(0,min(CREPROSP , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CRESINTER)) ;

PROIMP = positif_ou_nul(PROREST) * (CREPROSP - PROREST) ;

BIOREST = positif(REST) * max(0,min(CREAGRIBIO , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CRESINTER-CREPROSP)) ;

BIOIMP = positif_ou_nul(BIOREST) * (CREAGRIBIO - BIOREST) ;

APPREST = positif(REST) * max(0,min(CREAPP , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO)) ;

APPIMP = positif_ou_nul(APPREST) * (CREAPP - APPREST) ;

FAMREST = positif(REST) * max(0,min(CREFAM , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP)) ;

FAMIMP = positif_ou_nul(FAMREST) * (CREFAM - FAMREST) ;

HABREST = positif(REST) * max(0,min(CIHABPRIN , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						-CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM)) ;

HABIMP = positif_ou_nul(HABREST) * (CIHABPRIN - HABREST) ;

SALREST = positif(REST) * max(0,min(CIADCRE , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
                                              -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN)) ;

SALIMP = positif_ou_nul(SALREST) * (CIADCRE - SALREST) ;

PREREST = positif(REST) * max(0,min(CIPRETUD , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE)) ;

PREIMP = positif_ou_nul(PREREST) * (CIPRETUD - PREREST) ;

SYNREST = positif(REST) * max(0,min(CISYND , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD)) ;

SYNIMP = positif_ou_nul(SYNREST) * (CISYND - SYNREST) ;

GARREST = positif(REST) * max(0,min(CIGARD , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND)) ;

GARIMP = positif_ou_nul(GARREST) * (CIGARD - GARREST) ;

BAIREST = positif(REST) * max(0,min(CICA , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD)) ;
 
BAIIMP = positif_ou_nul(BAIREST) * (CICA - BAIREST) ;

ELUREST = positif(REST) * max(0,min(IPELUS , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					     -CICA)) ;
 
ELUIMP = positif_ou_nul(ELUREST) * (IPELUS - ELUREST) ;

TECREST = positif(REST) * max(0,min(CITEC , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					    -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					    -CICA-IPELUS)) ;

TECIMP = positif_ou_nul(TECREST) * (CITEC - TECREST) ;

DELREST = positif(REST) * max(0,min(CIDEPENV , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					       -CICA-IPELUS-CITEC)) ;

DELIMP = positif_ou_nul(DELREST) * (CIDEPENV - DELREST) ;

DEPREST = positif(REST) * max(0,min(CIDEVDUR , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					       -CICA-IPELUS-CITEC-CIDEPENV)) ;

DEPIMP = positif_ou_nul(DEPREST) * (CIDEVDUR - DEPREST) ;

AIDREST = positif(REST) * max(0,min(CIGE , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					   -CICA-IPELUS-CITEC-CIDEPENV-CIDEVDUR)) ;

AIDIMP = positif_ou_nul(AIDREST) * (CIGE - AIDREST) ;

ASSREST = positif(REST) * max(0,min(I2DH , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					   -CICA-IPELUS-CITEC-CIDEPENV-CIDEVDUR-CIGE)) ;

ASSIMP = positif_ou_nul(ASSREST) * (I2DH - ASSREST) ;

EPAREST = positif(REST) * max(0,min(CIDIREPARGNE , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						   -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
						   -CICA-IPELUS-CITEC-CIDEPENV-CIDEVDUR-CIGE-I2DH)) ;

EPAIMP = positif_ou_nul(EPAREST) * (CIDIREPARGNE - EPAREST) ;

RECREST = positif(REST) * max(0,min(IPRECH , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					     -CICA-IPELUS-CITEC-CIDEPENV-CIDEVDUR-CIGE-I2DH-CIDIREPARGNE)) ;

RECIMP = positif_ou_nul(RECREST) * (IPRECH - RECREST) ;

CORREST = positif(REST) * max(0,min(CICORSENOW , IRESTITIR-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					         -CREFORMCHENT-CRESINTER-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CISYND-CIGARD
					         -CICA-IPELUS-CITEC-CIDEPENV-CIDEVDUR-CIGE-I2DH-CIDIREPARGNE-IPRECH)) ;

CORIMP = positif_ou_nul(CORREST) * (CICORSENOW - CORREST) ;

