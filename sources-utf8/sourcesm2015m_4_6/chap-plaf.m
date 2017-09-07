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
regle 8200:
application : iliad , batch  ;
LIMIT12 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (4/100))) 
		     * (1 - positif(VARRMOND))
	        + max(0, 
		      arr( max(0, 
				VARRMOND 
				 + TONEQUOM1
			      )* (4/100))
		      ) 
		      * positif(VARRMOND);
LIMIT11 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (6/100))) 
		     * (1 - positif(VARRMOND))
	        + max(0, 
		      arr( max(0, 
			        VARRMOND
				  + TONEQUOM1
			      ) * (6/100))
		      ) 
		      * positif(VARRMOND);
LIMIT10 = 20000 + max(0, arr( max(0, RI1 + TONEQUO1) * (8/100))) 
		     * (1 - positif(VARRMOND))
	        + max(0, 
		      arr( max(0,
				VARRMOND
				  + TONEQUOM1
			      ) * (8/100))
		     ) 
		     * positif(VARRMOND);
LIMIT9 = 25000 + max(0, arr( max(0, RI1 + TONEQUO1) * (10/100))) 
		    * (1 - positif(VARRMOND))
               + max(0, 
		     arr( max(0,
			       VARRMOND
				 + TONEQUOM1
			     ) * (10/100))
		    ) 
		    * positif(VARRMOND);
		     
regle 8201:
application : iliad , batch  ;
NAPSANSPENA = NAPTIR - (PIR+PTAXA+PPCAP+PHAUTREV+PTAXLOY) * positif(abs(NAPTIR)) ; 
AVFISCO = V_NAPTEO * (1 - 2 * V_NEGTEO) - NAPSANSPENA ;
sortie(V_CALCUL_NAPS);

regle 8202:
application : iliad , batch  ;
AVFISCOPTER = AVPLAF9 + AVPLAF10 + AVPLAF11 + AVPLAF12 + AVPLAF13 ;
regle 82463:
application : iliad , batch  ;

A13RSOC = max(0, arr( RSOC4+RSOC9 + RSOC42+RSOC46 + RSOC34+RSOC38 + RSOC5+RSOC10 
                      - ( RSOC4+RSOC9 + RSOC42+RSOC46 + RSOC34+RSOC38 )*(TX65/100)
                      - ( RSOC5+RSOC10 )*(TX70/100)
                    )
             ) * (1 - V_CNR) ;

regle 82462:
application : iliad , batch  ;


A12RSOC = max(0, arr(RSOC3+RSOC8 + RSOC41+RSOC45 + RSOC26+RSOC30 + 
                     RSOC33+RSOC37
                  - ( RSOC3+RSOC8 + RSOC41+RSOC45 + RSOC26+RSOC30 +
                      RSOC33+RSOC37 )*(TX65/100))
             ) * (1 - V_CNR) ; 

regle 82461:
application : iliad , batch  ;

A11RSOC = max(0, arr( RSOC2+RSOC7 + RSOC40+RSOC44 + RSOC19+RSOC22 + 
                      RSOC25+RSOC29 + RSOC32+RSOC36
                      - (RSOC2+RSOC7 + RSOC40+RSOC44 +  RSOC19+RSOC22 +
                         RSOC25+RSOC29 + RSOC32+RSOC36)*(TX65/100))

             ) * (1 - V_CNR);

regle 8246:
application :  iliad , batch  ;

A10RSOC = max(0, arr( RSOC1+RSOC6 + RSOC39+RSOC43 + RSOC14+RSOC16 + 
                      RSOC18+RSOC21 + RSOC24+RSOC28 + RSOC31+RSOC35
                      - ( RSOC1+RSOC6 + RSOC39+RSOC43 + RSOC14+RSOC16 +
                          RSOC18+RSOC21 + RSOC24+RSOC28 + RSOC31+RSOC35)*(TX65/100)) 

             ) * (1 - V_CNR);

regle 82473:
application : iliad , batch  ;


A13RENT = ( RENT14 + RENT19 + RENT15 + RENT20 +
            RLOC142 + RLOC148 + RLOC106 + RLOC112   
           + max (0 , RENT09+RENT29 + RENT04+RENT24 +
                      RENT10+RENT30 + RENT05+RENT25 +
                      RLOC136+RLOC160 + RLOC130+RLOC154 +
                      RLOC100+RLOC124 + RLOC94+RLOC120
                    - ( arr((RENT09+RENT29)*(5263/10000)) + arr((RENT04+RENT24)*(625/1000)) +
                        arr((RENT10+RENT30)*(56/100)) + arr((RENT05+RENT25)*(66/100)) +
                        arr((RLOC136+RLOC160)*(5263/10000))+ arr((RLOC130+RLOC154)*(625/1000)) +
                        arr((RLOC100+RLOC124)*(5263/10000)) + arr((RLOC94+RLOC120)*(625/1000))
                      )
                  )
             ) * (1 - V_CNR);

regle 82472:
application : iliad , batch  ;


A12RENT = ( RENT13 + RENT18 + RLOC141 + RLOC147 + RLOC105 + RLOC111 + RLOC67 + RLOC74
           + max (0 , RENT08+RENT28 + RENT03+RENT23
                    + RLOC135+RLOC159 + RLOC129+RLOC153
                    + RLOC60+RLOC88 + RLOC53+RLOC81 + RLOC99+RLOC123 + RLOC93+RLOC119
                    - (arr((RENT08+RENT28)*(5263/10000)) + arr((RENT03+RENT23)*(625/1000)) +
                       arr((RLOC135+RLOC159)*(5263/10000)) + arr((RLOC129+RLOC153)*(625/1000)) +
                       arr((RLOC60+RLOC88)*(5263/10000)) + arr((RLOC53+RLOC81)*(625/1000)) +
                       arr((RLOC99+RLOC123)*(5263/10000)) + arr((RLOC93+RLOC119)*(625/1000))
                      )
                 )
            ) * (1 - V_CNR);

regle 82471:
application : iliad , batch  ;

A11RENT = ( RENT12+RENT17  
            +RLOC138+RLOC140+RLOC144+RLOC146+RLOC102+RLOC108+RLOC104+RLOC110+RLOC34
            +RLOC63+RLOC70+RLOC66+RLOC73  
           + max (0 ,RENT07+RENT27 + RENT02+RENT22
                    + RLOC134+RLOC158 + RLOC128+RLOC152 + RLOC132+RLOC156 + RLOC126+RLOC150
                    +RLOC29+RLOC44 + RLOC24+RLOC39 + RLOC56+RLOC84 + RLOC49+RLOC77
                    + RLOC59+RLOC87 + RLOC52+RLOC80
                    + RLOC96+RLOC116 + RLOC90+RLOC114 + RLOC98+RLOC122 + RLOC92+RLOC118

                   - ( arr((RENT07+RENT27)*(5263/10000)) + arr((RENT02+RENT22)*(625/1000)) + 
                       arr((RLOC134+RLOC158)*(5263/10000))+arr((RLOC128+RLOC152)*(625/1000))+
                       arr((RLOC132+RLOC156)*(5263/10000))+ arr((RLOC126+RLOC150)*(625/1000))+
                       arr((RLOC29+RLOC44)*(5263/10000)) + arr((RLOC24+RLOC39)*(625/1000)) +
                       arr((RLOC56+RLOC84)*(5263/10000)) + arr((RLOC49+RLOC77)*(625/1000)) +
                       arr((RLOC59+RLOC87)*(5263/10000)) + arr((RLOC52+RLOC80)*(625/1000)) +
                       arr((RLOC96+RLOC116)*(5263/10000))+ arr((RLOC90+RLOC114)*(625/1000))+
                       arr((RLOC98+RLOC122)*(5263/10000))+ arr((RLOC92+RLOC118)*(625/1000))
                     )
                 )
            ) * (1 - V_CNR);

regle 8247:
application : iliad , batch  ;

A10RENT = ( RENT11 + RENT16 + RLOC62 + RLOC65 + RLOC101 + RLOC103 + RLOC137 + RLOC139 
             +RLOC13+RLOC31+RLOC33+RLOC69+RLOC72+RLOC107+RLOC109+RLOC143+RLOC145
           + max (0 , RENT06+RENT26 + RENT01+RENT21
                    + RLOC11+RLOC17 + RLOC09+RLOC15 + RLOC26+RLOC41 + RLOC21+RLOC36 + RLOC28+RLOC43 
                    + RLOC55+RLOC83 + RLOC48+RLOC76 + RLOC58+RLOC86 + RLOC51+RLOC79 + RLOC23+RLOC38
                    + RLOC95+RLOC115 + RLOC89+RLOC113 + RLOC97+RLOC121 + RLOC91+RLOC117
                    + RLOC131+RLOC155  + RLOC125+RLOC149 + RLOC133+RLOC157 + RLOC127+RLOC151

                    - (arr((RENT06+RENT26)*(5263/10000)) + arr((RENT01+RENT21)*(625/1000)) +
                       arr((RLOC11+RLOC17)*(50/100)) + arr((RLOC09+RLOC15)*(60/100)) +
                       arr((RLOC26+RLOC41)*(50/100)) + arr((RLOC21+RLOC36)*(60/100)) +
                       arr((RLOC55+RLOC83)*(50/100)) + arr((RLOC48+RLOC76)*(60/100)) +
                       arr((RLOC28+RLOC43)*(5263/10000)) + arr((RLOC23+RLOC38)*(625/1000)) +
                       arr((RLOC58+RLOC86)*(5263/10000)) + arr((RLOC51+RLOC79)*(625/1000)) +
                       arr((RLOC95+RLOC115)*(5263/10000)) + arr((RLOC89+RLOC113)*(625/1000)) +
                       arr((RLOC97+RLOC121)*(5263/10000)) + arr((RLOC91+RLOC117)*(625/1000)) +
                       arr((RLOC131+RLOC155)*(5263/10000)) + arr((RLOC125+RLOC149)*(625/1000)) +
                       arr((RLOC133+RLOC157)*(5263/10000)) + arr((RLOC127+RLOC151)*(625/1000))
                      )
                 )
            ) * (1 - V_CNR);

regle 82492:
application : iliad , batch  ;

PLAFRED_FORTRA = max( 0, PLAF_FOREST1 * (1 + BOOL_0AM) - ACOTFOR_R);

BASE7UWI = max(0, min (REPSINFOR+REPFOR + REPSINFOR1+REPFOR1 + REPSINFOR2+REPFOR2+REPSINFOR3+REPSINFOR4 , PLAFRED_FORTRA)
			   - (REPSINFOR+REPFOR + REPSINFOR1+REPFOR1 + REPSINFOR2 + REPSINFOR3)) * (1 - V_CNR) ;


BASE7UN = (min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM))) * (1 - V_CNR) ;

regle 82493:
application : iliad , batch  ;
A13RFOR_1 =  max(0,
                   min( arr((BASE7UWI + BASE7UN)* TX18/100) ,
	                    IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RFORET_1
                           -RFIPDOM_1-RFIPC_1-RPRESSE_1-RCINE_1-RRESTIMO_1-RSOCREPR_1
                           -RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1
                           -RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                           -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1
                           -A9RFOR_1-A10RFOR_1-A11RFOR_1-A12RFOR_1
                       )
                 ) ;


A13RFOR_2 = max( A13RFOR_P + A13RFORP2 , A13RFOR1731) * (1-PREM8_11) * ART1731BIS ;

A13RFOR = (A13RFOR_1 * (1 - ART1731BIS)
           + min( A13RFOR_1 , A13RFOR_2 ) * ART1731BIS 
          ) * (1 - V_CNR) ;

regle 824910:
application : iliad , batch  ;

BASE7UWH = max(0, min (REPSINFOR + REPFOR1+REPSINFOR1 + REPFOR + REPSINFOR2 + REPSINFOR3 , PLAFRED_FORTRA)
			   - (REPSINFOR + REPSINFOR1 + REPFOR + REPSINFOR2)) * (1 - V_CNR) ;

BA12RFOR  = arr(BASE7UWH * TX18 / 100 ) ;

A12RFOR_1 = max(0,
	       min( BA12RFOR ,IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RFORET_1
                           -RFIPDOM_1-RFIPC_1-RPRESSE_1-RCINE_1-RRESTIMO_1-RSOCREPR_1
                           -RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1
                           -RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                           -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1
                           -A9RFOR_1-A10RFOR_1-A11RFOR_1
                  )
                ) ;

A12RFOR_2 = max( A12RFOR_P + A12RFORP2 , A12RFOR1731) * (1-PREM8_11) * ART1731BIS ;

A12RFOR = (A12RFOR_1 * (1 - ART1731BIS)
           + min( A12RFOR_1 , A12RFOR_2 ) * ART1731BIS 
          ) * (1 - V_CNR) ;

regle 82491:
application : iliad , batch  ;

BASE7UVG = max(0, min (REPFOR + REPSINFOR + REPSINFOR1 + REPSINFOR2 , PLAFRED_FORTRA)
			   - (REPSINFOR + REPSINFOR1)) * (1 - V_CNR) ;

BA11RFOR  = arr(BASE7UVG * TX22 / 100 ) ;

A11RFOR_1 = max(0,
	       min( BA11RFOR ,IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RFORET_1
                           -RFIPDOM_1-RFIPC_1-RPRESSE_1-RCINE_1-RRESTIMO_1-RSOCREPR_1
                           -RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1
                           -RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                           -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1
                           -A9RFOR_1-A10RFOR_1
                  )
             ) ;

A11RFOR_2 = max( A11RFOR_P + A11RFORP2 , A11RFOR1731) * (1-PREM8_11) * ART1731BIS ;

A11RFOR = (A11RFOR_1 * (1 - ART1731BIS)
           + min( A11RFOR_1 , A11RFOR_2 ) * ART1731BIS 
          ) * (1 - V_CNR) ;

regle 8249:
application : iliad , batch  ;
BASE7UTF = max(0, min ( REPSINFOR + REPSINFOR1, PLAFRED_FORTRA) - REPSINFOR)
            * (1 - V_CNR) ;

BA10RFOR  = arr(BASE7UTF * TX25 / 100 ) ;

A10RFOR_1 = max(0,
	       min( BA10RFOR ,IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RFORET_1
                           -RFIPDOM_1-RFIPC_1-RPRESSE_1-RCINE_1-RRESTIMO_1-RSOCREPR_1
                           -RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1
                           -RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                           -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1
                           -A9RFOR_1 )
             ) ;

A10RFOR_2 = max( A10RFOR_P + A10RFORP2 , A10RFOR1731) * (1-PREM8_11) * ART1731BIS ;

A10RFOR = (A10RFOR_1 * (1 - ART1731BIS)
           + min( A10RFOR_1 , A10RFOR_2 ) * ART1731BIS 
          ) * (1 - V_CNR) ;

regle 82500:
application : iliad , batch  ;

BA9RFOR  = arr( min ( REPSINFOR , PLAFRED_FORTRA) * TX25 / 100 ) * (1 - V_CNR) ;
A9RFOR_1 = max(0,
	       min( BA9RFOR ,IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RFORET_1
                           -RFIPDOM_1-RFIPC_1-RPRESSE_1-RCINE_1-RRESTIMO_1-RSOCREPR_1
                           -RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1
                           -RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                           -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1
                  )
             ) ;

A9RFOR_2 = max( A9RFOR_P + A9RFORP2 , A9RFOR1731) * (1-PREM8_11) * ART1731BIS ;

A9RFOR = (A9RFOR_1 * (1 - ART1731BIS)
           + min( A9RFOR_1 , A9RFOR_2 ) * ART1731BIS 
          ) * (1 - V_CNR) ;

regle 8252:
application : iliad , batch  ;
A10TOURSOC = RTOURREP*positif(REPINVTOU)
             + RTOUHOTR*positif(INVLOGHOT) * (1-V_CNR)
             + RTOUREPA*positif(INVLOGREHA);


regle 8250:
application : iliad , batch  ;

A13REELA =  RCOTFOR
         + RFIPDOM + RAIDE
	 + RFIPC  + RPRESSE
         + RINNO + RSOUFIP + RRIRENOV 
         + RDUFLOEKL +  RDUFLOGIH  +  RDUFREPFI + RDUFREPFK
         + RPIQAB + RPIQEF  + RPIREPAI + RPIREPBI
         + A13RFOR 
           + arr(RSNCU + RSNCF + RSNCN + RSNCC + RSNCR + RSNCV
           + RPLAFREPME4 + RPENTDY ) 
           + CIDEVDUR + CIGARD + CIADCRE 
	   + CIHABPRIN + CILOYIMP 
           + CIFORET
	 + RCODJT + RILMPE + RILMOA + RILMPJ + RILMOF                                 
         + RCODOU + RCODOV
         + RPATNAT ; 

A13REELB = RCINE 
           + RPIREPCI + RPIREPDI +  RPIQCD + RPIQGH
           + RLOG32 + RLOG39 + RLOG46                                 
           + A13RSOC                                       
           + A13RENT ;

regle 8254:
application : iliad , batch  ;


AUBAINE13A = max(0, min(V_A13REELA, V_DIFTEOREEL)) ;
AUBAINE13B = max(0, min(V_A13REELB, V_DIFTEOREEL - AUBAINE13A)) ;

regle 8255:
application : iliad , batch  ;

A12REEL = A12RFOR 
          + A12RRESTIMO

         + RLOG25 + RLOG31 + RLOG38 + RLOG45

         + RTOURREP * positif(COD7UY) + RTOUREPA * positif(COD7UZ)

          + arr( RSNCM + RSNCQ )

         + RCELRREDMG + RCELRREDMH + RCELRREDLJ
         + RCELREPGV + RCELREPGJ
         + RCELREPYJ + RCELREPYB + RCELREPYQ + RCELREPYM
         + RCELJOQR + RCEL2012 + RCELFD + RCELFABC 

         + RCODIF + RCODIG + RCODID
         + RILMJV + RILMJS + RCODJU
         + RILMPD + RILMOB + RILMPI + RILMOG

        + RPATNAT3

        + A12RSOC   

        + A12RENT ;

regle 8256:
application : iliad , batch  ;

AUBAINE12 = max( 0, min( V_A12REEL , V_DIFTEOREEL - AUBAINE13A - AUBAINE13B ))   ;

regle 8260:
application : iliad , batch  ;
A11REEL = RLOG16 + RLOG21 + RLOG24 + RLOG28 + RLOG30 +
          RLOG35 + RLOG37 + RLOG42 + RLOG44 

        + A11RSOC

        + arr( RSNCL ) 

        + RCELRREDLF + RCELRREDLZ + RCELRREDLX + RCELRREDLI
        + RCELREPHG + RCELREPHA + RCELREPGW + RCELREPGL 
        + RCELREPYK + RCELREPYD + RCELREPYR + RCELREPYN
        + RCELCOM + RCEL + RCELJP + RCELJBGL

        + RCODIE + RCODIN + RCODIV + RCODIJ
        + RILMIZ + RILMIA + RILMJI + RILMJW 
        + RILMPC + RILMOC + RILMPH + RILMOH

         + RTOURREP*positif(INVLOCXN) + RTOUREPA*positif(INVLOCXV)

        + RPATNAT2  

        + A11RENT

        + A11RFOR ;
regle 8261:
application : iliad , batch  ;

AUBAINE11 = max( 0, min( V_A11REEL , V_DIFTEOREEL - AUBAINE13A-AUBAINE13B-AUBAINE12 ));
regle 8262:
application : iliad , batch  ;

A10REEL = RLOG11 + RLOG13 + RLOG15 + RLOG18 + RLOG20 + RLOG23 + RLOG26 + RLOG27 +
          RLOG29 + RLOG33 + RLOG34 + RLOG36 + RLOG40 + RLOG41 + RLOG43

         + A10RSOC  

         + A10RENT 

         + RCELRREDLC + RCELRREDLD + RCELRREDLS + RCELRREDLT + RCELRREDLH
         + RCELREPHW + RCELREPHV + RCELREPHD + RCELREPHH 
         + RCELREPGX + RCELREPGS  
         + RCELREPYL + RCELREPYF + RCELREPYS + RCELREPYO 
	 + RCELHJK + RCELNQ + RCELNBGL

         + RINVRED + RREPMEU + RCODIM + RCODIL
	 + RILMIH + RILMIB + RILMJC + RILMJX 
         + RILMPB + RILMPG + RILMOD + RILMOI

         + A10TOURSOC

	 + RPATNAT1

         + A10RFOR ;

regle 8263:
application : iliad , batch  ;
 
AUBAINE10 = max( 0, min( V_A10REEL , V_DIFTEOREEL - AUBAINE13A-AUBAINE13B-AUBAINE12-AUBAINE11 ));

regle 8280:
application : iliad , batch  ;

AUBAINE9 = max(0, V_DIFTEOREEL - AUBAINE13A - AUBAINE13B - AUBAINE12 - AUBAINE11 - AUBAINE10);
regle 8290:
application : iliad , batch  ;
AVPLAF13A = max(0, AUBAINE13A - LIM10000 ) * positif(V_DIFTEOREEL) ;

AVPLAF13B = max(0, min(AUBAINE13A , LIM10000) + AUBAINE13B - LIM18000 ) * positif(V_DIFTEOREEL) ;

AVPLAF13 = AVPLAF13A + AVPLAF13B;

AVPLAF12 = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 
                  - AVPLAF13 - LIMIT12) * positif(V_DIFTEOREEL);

AVPLAF11 = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 + AUBAINE11 
                  - AVPLAF13 - AVPLAF12 - LIMIT11) * positif(V_DIFTEOREEL);

AVPLAF10 = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 + AUBAINE11 + AUBAINE10 
                  - AVPLAF13 - AVPLAF12 - AVPLAF11 - LIMIT10) * positif(V_DIFTEOREEL);

AVPLAF9  = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 + AUBAINE11 + AUBAINE10 + AUBAINE9 
                  - AVPLAF13 - AVPLAF12 - AVPLAF11 - AVPLAF10 - LIMIT9) * positif(V_DIFTEOREEL);

regle 8321:
application : iliad , batch  ;
RFTEO = RFORDI + RFROBOR; 
regle 8331:
application : iliad , batch  ;

RFNTEO = (RFORDI + RFROBOR - min(
                                     min(RFDORD,RFDORD1731+0) * positif(ART1731BIS) + RFDORD * (1 - ART1731BIS)
                          
			           + min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS) ,
                              
                                    RFORDI + RFROBOR
                                ) 
                           - RFDHIS * (1 - ART1731BIS)      

         ) * present(RFROBOR) + RRFI * (1-present(RFROBOR));

regle 8341:
application : iliad , batch  ;
RRFTEO = RFNTEO;
 


