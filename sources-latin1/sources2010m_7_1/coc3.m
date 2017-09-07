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
verif 3003:
application : pro , oceans , iliad  , batch;
si
   (
      V_0AM + 0 = 1  et  V_0AE + V_0AG + V_0AL + V_0AN + V_0AW + V_0AU +0> 0 
   )
alors erreur A01001;
verif 3004:
application : pro , oceans , iliad  , batch;
si
   (
       V_0AC + 0 = 1  et  V_0AF + V_0AS + V_0AU + 0 > 0  
   )
alors erreur A01004;
verif 3005:
application : pro , oceans , iliad  , batch;
si
   (
       V_0AD + 0 = 1  et  V_0AF + V_0AS + V_0AU + 0 > 0  
   )
alors erreur A01005;
verif 3006:
application : pro , oceans , iliad  , batch;
si
   (
      V_0AV + 0 = 1  et  ( (BOOL_0AZ != 1 et V_0AF  > 0) ou V_0AS > 0 ou V_0AU > 0)
   )
alors erreur A01003;
verif 3007:
application : pro , oceans , iliad  , batch;
si
   (
     (V_0AM + 0 = 1) et V_0BT+0 = 1
   )
alors erreur A01009;
verif 3009:
application : pro, oceans, iliad, batch;
si (
   ( V_0AP+V_0AF+V_0AS+V_0AE+V_0AW+V_0AL+V_0AN+V_0AG+V_0AU+V_0BT+0) > 0
   et
   positif(V_0AM + V_0AO + V_0AC + V_0AD + V_0AV + 0) != 1
   )
alors erreur A01011;
verif 3010:
application : pro, oceans, iliad, batch;
si ( 
	V_0AC = 1 et V_0AG =1
   )
alors erreur A01006;
verif 3011:
application : pro, oceans, iliad, batch;
si ( 
	V_0AD = 1 et V_0AG =1
   )
alors erreur A01007;
verif 3012:
application : pro, oceans, iliad, batch;
si ( 
	( V_0AV = 1 et V_INDG = 1 et V_0AG =1 )
	ou
	( present(V_0AZ)=1 et V_0AV=1 et BOOL_0AZ!=1 et V_INDG=1 et V_0AG=1 )
   )
alors erreur A01008;
verif 3513:
application : pro , oceans , iliad  , batch;
si
   (
       V_0AO + 0 = 1  et  V_0AE + V_0AG + V_0AL + V_0AN + V_0AW + 0 > 0  
   )
alors erreur A01002;
verif 3514:
application : pro , oceans , iliad  , batch;
si
   (
     (V_0AO + 0 = 1) et V_0BT+0 = 1
   )
alors erreur A01010;
verif 3013:
application : pro , oceans, iliad, batch;
si ( 
    (V_IND_TRAIT+0 = 4)
    et
    (
    V_0DA < (V_ANREV - 120) ou V_0DA > V_ANREV ou V_0DB < (V_ANREV - 120) ou V_0DB > V_ANREV
    )
   ) alors erreur A013;
verif  3014:
application : pro , oceans , iliad  , batch;
si
   (
    (V_IND_TRAIT = 5)
    et
    (
      ( positif(V_0DB) = 1 et ( V_0DB < (V_ANREV - 120) ou V_0DB > V_ANREV ) )
    ou
      ( V_0DA < (V_ANREV - 120) ou V_0DA > V_ANREV ) 
    )
   )
alors erreur A013;
verif 3020:
application : iliad , batch;
si
   (
	V_ZDC = 1 et somme(i=X,Y,Z: positif(V_0Ai)) > 1
   )
alors erreur A01701;
verif 3021:
application : iliad , batch ;
si
  (
    V_ZDC = 4
	et 
    (  
       positif(V_0AZ+0) = 0 
    ou 
       (V_0AM + V_0AO + 0 = 0)
    )
   )
alors erreur A01702;
verif 3022:
application : iliad , batch;
si
   (
    V_ZDC = 3
	et 
    ( 
      positif(V_0AY+0) = 0 
    ou 
      (V_0AM + V_0AO + 0 = 0)
    )
   )
alors erreur A01703;
verif 3023:
application : iliad , batch;
si
   (
    V_ZDC = 2
    et
    (positif(V_0AX+0) = 0 ou (V_0AC + V_0AD + V_0AV + 0 = 0))
   )
alors erreur A01704;
verif 3024:
application : iliad , batch ;
si
   (
    V_ZDC = 1 
	et 
    (positif(V_0AX) = 1 et (V_0AM + V_0AO + 0 = 0))
   )
alors erreur A01705;
verif 3025:
application : iliad , batch;
si
   (
    V_ZDC = 1 
	et 
    (positif(V_0AY) = 1 et (V_0AC + V_0AV + V_0AD + 0 = 0))
   )
alors erreur A01706;
verif 3026:
application : batch, iliad;
si
   (
    V_ZDC = 1 
	et 
    (positif(V_0AZ) = 1 et (V_0AV + V_0AM + 0 = 0)) 
   )
alors erreur A01707;
verif 3031:
application : batch ;
si
   (
    null(10 - V_NOTRAIT) = 1
        et
    V_ZDC + 0 = 0 
	et 
    ((positif (V_0AX) = 1 et V_0AM + 0 = 0 et V_0AO + 0 = 0)
        ou
    (positif(V_0AZ) = 1 et V_0AV + 0 = 0)
        ou
    (positif(V_0AY) = 1 et V_0AD + 0 = 0 et V_0AC + 0 = 0 et V_0AV + 0 = 0))
   )
alors erreur A018;
verif 3041:
application : pro , iliad  , oceans ;
si
   (
    V_0AC = 1 et V_0AZ + 0 > 0 
   )
alors erreur AS0101;
verif 3042:
application : pro , iliad  , oceans ;
si
   (
    V_0AM = 1 et V_0AY + 0 > 0 et V_0AZ + 0 > 0 
   )
alors erreur AS0102;
verif 3044:
application : pro , iliad  , oceans ;
si
   (
     V_0AD = 1 et V_0AZ + 0 > 0
   )
alors erreur AS0103;
verif 3045:
application : pro ;
si
  positif(V_IND_TRAIT + 0) = 1 
  et
  (V_NOTRAIT + 0 < 14)
  et
  present(V_ANTIR) = 0
  et
  positif(V_0DA + 0) = 0

alors erreur AS11;
verif 3100:
application : pro , oceans , iliad  , batch;
si
   (
     (  V_0CF + 0 < V_0CG )
   )
alors erreur A01201;
verif 3101:
application : pro , oceans , iliad  , batch;
si
   (
     (  V_0CI + 0 > V_0CH +0 ) 
   )
alors erreur A01202;
verif 3110:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CF != somme (i = 0..7: positif(V_0Fi+0))
   )
alors erreur IM1101;
verif 3111:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CG != somme (i = 0, 1, 2, 3: positif(V_0Gi+0))
   )
alors erreur IM1102;
verif 3112:
application : iliad ;
si
   (
     present(V_CALCULIR) = 0 
	et 
     V_0CR != somme (i = 0, 1, 2, 3: positif(V_0Ri+0))
   )
alors erreur IM1105;
verif 3113:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0DJ != somme (i = 0, 1, 2, 3: positif(V_0Ji+0))
   )
alors erreur IM1106;
verif 3114:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0DN != somme (i = 0, 1, 2, 3: positif(V_0Ni+0))
   )
alors erreur IM1107;
verif 3118:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CH != somme (i = 0,1,2,3,4,5: positif(V_0Hi+0))
   )
alors erreur IM1103;
verif 3116:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0CI != somme (i = 0, 1, 2, 3: positif(V_0Ii+0))
   )
alors erreur IM1104;
verif 3117:
application : iliad ;
si
   (
    present(V_CALCULIR) = 0 
	et 
    V_0DP !=  positif(V_0P0+0)
   )
alors erreur IM1108;
verif 3200:
application : bareme ;
si (
   ( V_9VV < 2 et (V_0AM + V_0AO + 0 = 1) )
   )
alors erreur A063;
verif 3201:
application : bareme ;
si (
   ( V_9VV < 1.25 et ( (V_0AC = 1 ou V_0AD = 1) et V_9XX = 1 ))
   )
alors erreur A064;
verif 3202:
application : bareme ;
si (
   ( V_9VV < 2.25 et ( (BOOL_0AM = 1 ou V_0AV = 1) et V_9XX = 1 ))
   )
alors erreur A064;
verif 32021:
application : bareme ;
si (
    V_9VV = 1.25 et  V_0BT=1 et V_9XX=1 
   )
alors erreur A064;
verif 3203:
application : bareme ;
si (
    V_9VV < 2 et  (V_0AV +V_0AZ = 2)
   )
alors erreur A066;
verif 3210:
application : iliad , pro , batch;
si (
    (V_0AM + V_0AO + 0 = 1) et V_0AS = 1 et V_0AP+0 = 0 et V_0AF+0 = 0
	  et 
   V_ANREV - V_0DA < 75 et V_ANREV - V_0DB < 75
   )
alors erreur I011;
verif 3213:
application : iliad , batch;
si 
   positif(V_0AN+0) != 1 et
   (
   ((V_0AC + V_BT0AC +0 =2) et V_BTNBP+0 > (1 + 99 * APPLI_BATCH) et NBPT = 1)
    ou
   ((V_0AD + V_BT0AD +0 =2) et V_BTNBP+0 > (1 + 99 * APPLI_BATCH) et NBPT = 1)
    ou
   ((V_0AV + V_BT0AV +0 =2) et V_BTNBP+0 > (1 + 99 * APPLI_BATCH) et NBPT = 1)
   )
alors erreur I013;
verif 3221:
application : batch , iliad , pro;
si (
    (V_0AM + V_0AO + 0 = 0 )
	  et 
    V_0AZ + 0 = 0
          et
    V_0AP + 0 = 0
          et
    (V_0AE + 0 = 0 ou (V_0AE + 0 = 1 et (V_0DJ + 0 > 0 ou V_0DN + 0 > 0)))
          et
    V_0AW = 1
	  et 
    V_ANREV - V_0DA < 75
   )
alors erreur I012;
verif 3216:
application : batch , iliad , pro , oceans ;
si 
    V_IND_TRAIT > 0
    et
    V_REGCO != 2
    et
    V_REGCO != 4
    et
   (
    DEFRCM4 + 0 > V_BTDFRCM1 + PLAF_PRECONS * (1 - positif(V_BTDFRCM1))
    ou
    DEFRCM3 + 0 > V_BTDFRCM2 + PLAF_PRECONS * (1 - positif(V_BTDFRCM2))
    ou
    DEFRCM2 + 0 > V_BTDFRCM3 + PLAF_PRECONS * (1 - positif(V_BTDFRCM3))
    ou
    DEFRCM + 0 > V_BTDFRCM4 + PLAF_PRECONS * (1 - positif(V_BTDFRCM4)))

alors erreur I015;

verif 3301:
application : iliad,pro,batch ;
si
  ( 
 	V_0AV  = 1     
	et
       (
       (
        positif(XETRANC) + positif(TSELUPPEC) + positif(EXOCETC) + positif(FRNC)
	+ positif(TSHALLOC) + positif(ALLOC) 
	+ positif(HEURESUPC)
	+ positif(PRBC) + somme(i=2..4:positif(iPRBC)) + positif(PEBFC) 
	+ positif(CARTSC) + positif(REMPLAC) + positif(CARPEC) + positif(PENSALC)
	+ somme (i=1..3: positif (GLDiC)) + somme (i=A: positif(BiFC) + somme(j=A: positif(Bi1jC)))
	+ somme (i=H,C: 
       			somme(j= A,N: somme(k=R,D: positif(BjikEC))) + 
       			somme(j=N: positif(BIiDjC)) + positif(BIiNOC)  
          )
	+ positif(BICREC) + positif(BI2AC) + positif(BICDEC)
        + positif(TSASSUC)
	+ positif(PPETPC) + positif(PPENHC)
	+ positif(GSALC)

 + positif( FEXC ) 
 + positif( BAFC ) 
 + positif( BAFORESTC )
 + positif( BAFPVC ) 
 + positif( BAF1AC ) 
 + positif( BAEXC ) 
 + positif( BACREC ) 
 + positif( 4BACREC )
 + positif( BA1AC ) 
 + positif( BACDEC ) 
 + positif( BAHEXC ) 
 + positif( BAHREC ) 
 + positif( 4BAHREC )
 + positif( BAHDEC ) 
 + positif( BAPERPC ) 
 + positif( MIBEXC ) 
 + positif( MIBVENC ) 
 + positif( MIBPRESC ) 
 + positif( MIBPVC ) 
 + positif( MIB1AC ) 
 + positif( MIBDEC ) 
 + positif( BICEXC ) 
 + positif( BICNOC ) 
 + positif( BI1AC ) 
 + positif( BICDNC ) 
 + positif( BIHEXC ) 
 + positif( BIHNOC ) 
 + positif( BIHDNC ) 
 + positif( BIPERPC ) 
 + positif( MIBNPEXC ) 
 + positif( MIBNPVENC ) 
 + positif( MIBNPPRESC ) 
 + positif( MIBNPPVC ) 
 + positif( MIBNP1AC ) 
 + positif( MIBNPDEC ) 
 + positif( BICNPEXC ) 
 + positif( BICREC ) 
 + positif( BI2AC ) 
 + positif( BICDEC ) 
 + positif( BICNPHEXC ) 
 + positif( BICHREC ) 
 + positif( BICHDEC ) 
 + positif( BNCPROEXC ) 
 + positif( BNCPROC ) 
 + positif( BNCPROPVC ) 
 + positif( BNCPRO1AC ) 
 + positif( BNCPRODEC ) 
 + positif( BNCEXC ) 
 + positif( BNCREC ) 
 + positif( BN1AC ) 
 + positif( BNCDEC ) 
 + positif( BNHEXC ) 
 + positif( BNHREC ) 
 + positif( BNHDEC ) 
 + positif ( BNCCRC )
 + positif ( CESSASSC )
 + positif( BNCNPC ) 
 + positif( BNCNPPVC ) 
 + positif( BNCNP1AC ) 
 + positif( BNCNPDEC ) 
 + positif( ANOVEP )
 + positif( PVINCE )
 + positif( DNOCEPC )
 + positif( BNCCRFC )
 + positif( PVSOCC )
 + positif( PPEACC ) 
 + positif( PPENJC ) 
 + positif( RCSC ) 
 + positif( BNCAABC )
 + positif( BNCAADC )
 + positif( PERPC ) 
 + positif( PERP_COTC ) 
 + positif( RACCOTC ) 
 + positif( PLAF_PERPC ) 
 + positif ( PERPPLAFCC )
 + positif ( PERPPLAFNUC1 )
 + positif ( PERPPLAFNUC2 )
 + positif ( PERPPLAFNUC3 )
 + positif( ELURASC ) 
 + positif( BNCNPREXAAC ) + positif( BNCNPREXC )
 + positif( AUTOBICVC ) + positif( AUTOBICPC ) + positif( LOCPROCGAC ) + positif( LOCDEFPROCGAC )
 + positif( LOCPROC ) + positif( LOCDEFPROC ) 
 + positif( LOCNPCGAC ) + positif( LOCDEFNPCGAC ) + positif( LOCNPC ) + positif( LOCDEFNPC )
 + positif( AUTOBNCC ) + positif( XHONOAAC ) + positif( XHONOC )
 + positif( XSPENPC )
     )
	> 0 
     )
   )
alors erreur I010;
verif 3415:
application : pro , iliad , batch;
si
   (
       positif(V_0AO + 0) * positif(V_BT0AO + 0) = 1
       et
       V_BT0AX + 0 = V_ANREV - 1
       et
       V_0AY >= 1010000 + V_ANREV 
   )
alors erreur A003;
