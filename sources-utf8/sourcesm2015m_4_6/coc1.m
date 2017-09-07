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
verif 10011:
application : batch , iliad ;


si
   APPLI_COLBERT + APPLI_ILIAD = 1
   et
   V_IND_TRAIT > 0
   et
   CHNFAC > 9
 
alors erreur A00101 ;
verif 10012:
application : batch , iliad ;

si
   APPLI_COLBERT + APPLI_ILIAD = 1
   et
   V_IND_TRAIT > 0
   et
   NBACT > 9

alors erreur A00102 ;
verif 10013:
application : batch , iliad ;

si
   APPLI_COLBERT + APPLI_ILIAD = 1
   et
   V_IND_TRAIT > 0
   et
   (
    RDENS > 9
    ou
    RDENL > 9
    ou
    RDENU > 9
    ou
    RDENSQAR > 9
    ou
    RDENLQAR > 9
    ou
    RDENUQAR > 9
   )

alors erreur A00103 ;
verif 10014:
application : batch , iliad ;

si
   APPLI_COLBERT + APPLI_ILIAD = 1
   et
   V_IND_TRAIT > 0
   et
   ASCAPA > 9

alors erreur A00104 ;
verif 10015:
application : batch , iliad ;

si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   ((RBG > 99999999)
    ou
    (BCSG > 99999999)
    ou
    (BRDS > 99999999)
    ou
    (BPRS > 99999999)
    ou
    (GSALV > 99999999)
    ou
    (GSALC > 99999999)
    ou
    (CVNSALAV > 99999999))

alors erreur A00105 ;
verif 10016:
application : iliad , batch ;


si
   V_IND_TRAIT > 0
   et
   LOYIMP > 99999

alors erreur A00106 ;
verif isf 10017:
application : batch , iliad ;

si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   ((ISFDONEURO > 99999999)
    ou
    (ISFDONF > 99999999)
    ou
    (ISFETRANG > 99999999)
    ou
    (ISFFCPI > 99999999)
    ou
    (ISFFIP > 99999999)
    ou
    (ISFPMEDI > 99999999)
    ou
    (ISFPMEIN > 99999999)
    ou
    (ISFBASE > 99999999)
    ou
    (ISFVBPAT > 99999999))

alors erreur A00107 ;
verif 10004:
application : batch ;


si
   V_IND_TRAIT > 0
   et
   positif(V_0AB + 0) = 1
   et
   (positif(V_0AX + 0) = 0
    ou
    positif(V_0AM + V_0AO + 0) = 1)

alors erreur A004 ;
verif 10005:
application : batch ;


si
   V_IND_TRAIT > 0
   et
   positif(V_0AX + 0) = 1
   et
   positif(V_0AC + V_0AD + V_0AV + 0) = 1
   et
   positif(V_0AB + 0) = 0

alors erreur A005 ;
verif 10101:
application : iliad , batch ;

si
   V_0AM + 0 = 1
   et
   V_0AG + V_0AN + V_0AW + V_0AL + 0 > 0

alors erreur A01001 ;
verif 10102:
application : iliad , batch ;
si
   V_0AO + 0 = 1
   et
   V_0AG + V_0AL + V_0AN + V_0AW + V_0AU + 0 > 0

alors erreur A01002 ;
verif 10103:
application : iliad , batch ;

si
   V_0AV + 0 = 1
   et
   BOOL_0AZ != 1
   et
   V_0AF + V_0AS + V_0AU + 0 > 0

alors erreur A01003 ;
verif 10104:
application : iliad , batch ;

si
   V_0AC + 0 = 1
   et
   V_0AF + V_0AS + V_0AU + 0 > 0

alors erreur A01004 ;
verif 10105:
application : iliad , batch ;

si
   V_0AD + 0 = 1
   et
   V_0AF + V_0AS + V_0AU + 0 > 0

alors erreur A01005 ;
verif 10106:
application : iliad , batch ;

si
   V_0AC = 1
   et
   V_0AG = 1

alors erreur A01006 ;
verif 10107:
application : iliad , batch ;

si
   V_0AD = 1
   et
   V_0AG = 1

alors erreur A01007 ;
verif 10108:
application : iliad , batch ;

si
   V_0AV = 1
   et
   V_INDG = 1
   et
   V_0AG = 1
   ou
   (present(V_0AZ) = 1 et V_0AV = 1 et BOOL_0AZ != 1 et V_INDG = 1 et V_0AG = 1)

alors erreur A01008 ;
verif 10109:
application : iliad , batch ;

si
   V_0AM + 0 = 1
   et
   V_0BT + 0 = 1

alors erreur A01009 ;
verif 101010:
application : iliad , batch ;

si
   V_0AO + 0 = 1
   et
   V_0BT+0 = 1

alors erreur A01010 ;
verif 101011:
application : iliad , batch ;

si
   V_0AP + V_0AF + V_0AS + V_0AW + V_0AL + V_0AN + V_0AG + V_0BT + 0 > 0
   et
   positif(V_0AM + V_0AO + V_0AC + V_0AD + V_0AV + 0) != 1

alors erreur A01011 ;
verif 1011:
application : iliad , batch ;


si
   V_IND_TRAIT > 0
   et
   V_0DN + V_0DP + 0 = 1

alors erreur A011 ;
verif 10121:
application : iliad , batch ;


si
   V_0CF + 0 < V_0CG

alors erreur A01201 ;
verif 10122:
application : iliad , batch ;


si
   V_0CI + 0 > V_0CH +0

alors erreur A01202 ;
verif 1013:
application : iliad , batch ;

si
   (V_IND_TRAIT = 4
    et
    (V_0DA < (V_ANREV - 125) ou V_0DA > V_ANREV ou V_0DB < (V_ANREV - 125) ou V_0DB > V_ANREV))
   ou
   (V_IND_TRAIT = 5
    et
    ((positif(V_0DB) = 1 et ( V_0DB < (V_ANREV - 125) ou V_0DB > V_ANREV ) )
     ou
     (V_0DA < (V_ANREV - 125) ou V_0DA > V_ANREV)))

alors erreur A013 ;
verif 1015:
application : iliad , batch ;


si
   NBPT > 20

alors erreur A015 ;
verif 10171:
application : iliad , batch;


si
   APPLI_COLBERT + APPLI_OCEANS = 0
   et
   V_ZDC = 1
   et
   somme(i=X,Y,Z: positif(V_0Ai)) > 1

alors erreur A01701 ;
verif 10172:
application : iliad , batch ;


si
   APPLI_COLBERT + APPLI_OCEANS = 0
   et
   V_ZDC = 4
   et
   (positif(V_0AZ + 0) = 0
    ou
    V_0AM + V_0AO + (V_0AC + V_0AD + V_0AV) * V_0AB + 0 = 0)

alors erreur A01702 ;
verif 10173:
application : iliad , batch ;

si
   APPLI_COLBERT + APPLI_OCEANS = 0
   et
   V_ZDC = 1
   et
   positif(V_0AX) = 1
   et
   V_0AM + V_0AO + 0 = 0

alors erreur A01703 ;
verif 10174:
application : iliad , batch ;

si
   APPLI_COLBERT + APPLI_OCEANS = 0
   et
   V_ZDC = 1
   et
   positif(V_0AY) = 1
   et
   V_0AD + 0 = 0

alors erreur A01704 ;
verif 10175:
application : batch, iliad;


si
   APPLI_COLBERT + APPLI_OCEANS = 0
   et
   V_ZDC = 1
   et
   positif(V_0AZ) = 1
   et
   V_0AV + V_0AM + 0 = 0

alors erreur A01705 ;
verif 1018:
application : batch ;


si
   APPLI_COLBERT = 0
   et
   null(10 - V_NOTRAIT) = 1
   et
   V_ZDC + 0 = 0
   et
   positif(V_0AZ) = 1
   et
   V_0AV + V_0AM + V_0AO + 0 = 0

alors erreur A018 ;
verif 1019:
application : iliad , batch ;


si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   (V_0CF > 19 ou V_0CG > 19 ou V_0CH > 19 ou V_0CI > 19 ou V_0CR > 19 ou V_0DJ > 19 ou V_0DN > 19 ou V_0DP > 19)

alors erreur A019 ;
verif 1021:
application : batch , iliad ;


si
   APPLI_OCEANS = 0
   et
   ((positif(V_0CF + 0) != 1
     et
     (pour un i dans 0..7: positif(V_0Fi + 0) = 1))
    ou
    (positif(V_0CH + 0) != 1
     et
     (pour un i dans 0..5: positif(V_0Hi) = 1)))

alors erreur A021 ;
verif 1022:
application : batch, iliad ;


si
   APPLI_OCEANS + APPLI_COLBERT = 0
   et
   V_NOTRAIT = 10
   et
   (pour un i dans 0..5: V_BT0Fi = V_ANREV - 18)
   et
   (pour un i dans 0..5: V_0Ji = V_ANREV - 18)

alors erreur A022 ;
verif 10231:
application : batch , iliad ;


si
   APPLI_OCEANS = 0
   et
   V_NOTRAIT+0 < 20
   et
   V_IND_TRAIT + 0 = 4
   et
   (
    (present(V_0AX) = 1
     et
     (inf( ( V_0AX - V_ANREV ) / 1000000) > 31
      ou
      inf( ( V_0AX - V_ANREV ) / 1000000) = 0))
    ou
    (present(V_0AY) = 1
     et
     (inf( ( V_0AY - V_ANREV ) / 1000000) > 31
      ou
      inf( ( V_0AY - V_ANREV ) / 1000000) = 0))
    ou
    (present(V_0AZ) = 1
     et
     (inf( ( V_0AZ - V_ANREV ) / 1000000) > 31
      ou
      inf( ( V_0AZ - V_ANREV ) / 1000000) = 0))
   )

alors erreur A02301 ;
verif 10232:
application : batch , iliad ;


si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   V_IND_TRAIT + 0 = 4
   et
   (
    (present(V_0AX) = 1
     et
     (
     (    inf ( V_0AX / 10000) * 10000
        - inf ( V_0AX / 1000000)* 1000000
     )/10000 > 12
   ou
     (    inf ( V_0AX / 10000) * 10000
        - inf ( V_0AX / 1000000)* 1000000
     )/10000 =0
   )
)
ou
(  present(V_0AY) =1
 et
  (
     (    inf ( V_0AY / 10000) * 10000
        - inf ( V_0AY / 1000000)* 1000000
     )/10000 > 12
   ou
     (    inf ( V_0AY / 10000) * 10000
        - inf ( V_0AY / 1000000)* 1000000
     )/10000 =0
   )
)
ou
(  present(V_0AZ) =1
 et
  (
     (    inf ( V_0AZ / 10000) * 10000
        - inf ( V_0AZ / 1000000)* 1000000
     )/10000 > 12
   ou
     (    inf ( V_0AZ / 10000) * 10000
        - inf ( V_0AZ / 1000000)* 1000000
     )/10000 =0
   )
)
)

alors erreur A02302 ;
verif 10233:
application : batch , iliad ;


si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   V_IND_TRAIT + 0 = 4
   et
   (
    (present(V_0AX) = 1
     et
     (V_0AX - inf(V_0AX/ 10000) * 10000) != V_ANREV
     et
     (V_0AX - inf(V_0AX/ 10000) * 10000) != V_ANREV - 1)
    ou
    (present(V_0AY) = 1
     et
     (V_0AY - inf(V_0AY/ 10000) * 10000) != V_ANREV)
    ou
    (present(V_0AZ) = 1
     et
     (V_0AZ - inf(V_0AZ/ 10000) * 10000) != V_ANREV)
   )

alors erreur A02303 ;
verif 10242:
application : batch ;


si
   V_IND_TRAIT > 0
   et
   (
    (present(V_0AX) = 1
     et
     V_0AX + 0 < 1010000 + (V_ANREV - 1))
    ou
    (present(V_0AY) = 1
     et
     V_0AY + 0 < 1010000 + V_ANREV)
    ou
    (present(V_0AZ) = 1
     et
     V_0AZ + 0 < 1010000 + V_ANREV)
   )

alors erreur A02402 ;
verif 102421:
application : iliad ;


si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   (
      ( V_IND_TRAIT+0 = 4 et (
       (  present(V_0AX) =1
           et
        ( V_0AX + 0 < (1010000 + (V_ANREV - 1)))
       )
           ou
       (  present(V_0AY) =1
           et
        ( V_0AY + 0 < (1010000 + V_ANREV))
       )
           ou
       (  present(V_0AZ) =1
           et
        ( V_0AZ + 0 < (1010000 + V_ANREV))
       ))
      )
       ou
       ( V_IND_TRAIT = 5 et (
        (  positif(V_0AX) =1
            et
         ( V_0AX + 0 < (1010000 + (V_ANREV - 1)))
        )
            ou
        (  positif(V_0AY) =1
            et
         ( V_0AY + 0 < (1010000 + V_ANREV))
        )
            ou
        (  positif(V_0AZ) =1
            et
         ( V_0AZ + 0 < (1010000 + V_ANREV))
        )
       ))
   )

alors erreur A02402 ;
verif 1030:
application : batch , iliad ;


si
   V_0CF + V_0CG + V_0CH + V_0CI + V_0CR + V_0DJ + V_0DN + V_0DP + 0 = 0
   et
   SOMMEA030 > 0

alors erreur A030 ;
verif 1031:
application : batch , iliad ;


si
   V_0AC + V_0AD + 0 > 0
   et
   SOMMEA031 > 0

alors erreur A031 ;
verif 1063:
application : bareme ;


si
   V_9VV < 2
   et
   V_0AM + V_0AO + 0 = 1

alors erreur A063 ;
verif 1064:
application : bareme ;


si
   (V_9VV < 1.25
    et
    (V_0AC = 1 ou V_0AD = 1)
    et
    V_9XX = 1)
   ou
   (V_9VV < 2.25
    et
    (BOOL_0AM = 1 ou V_0AV = 1)
    et
    V_9XX = 1)
   ou
   (V_9VV = 1.25
    et
    V_0BT = 1
    et
    V_9XX=1)

alors erreur A064 ;
verif 10651:
application : bareme ;


si
   ((V_9VV / 0.25) - arr(V_9VV / 0.25)) != 0

alors erreur A06501 ;
verif 10652:
application : bareme ;


si
   V_9VV < 1
   ou
   V_9VV > 99.75

alors erreur A06502 ;
verif 1066:
application : bareme ;


si
   V_9VV < 2
   et
   V_0AV + V_0AZ = 2

alors erreur A066 ;
verif 1077:
application : batch , iliad ;

si
   positif(COD8XK + 0) = 1
   et
   V_REGCO + 0 != 3

alors erreur A077 ;
verif 1078:
application : batch , iliad ;

si
   positif(COD8YK + 0) = 1
   et
   ((V_REGCO+0) dans (2,3))

alors erreur A078 ;
verif 1079:
application : batch , iliad ;

si
   positif_ou_nul(BRAS) = 1
   et
   V_CNR2 + 0 != 1

alors erreur A079 ;
verif 1080:
application : batch , iliad ;


si
   (V_NOTRAIT + 0 < 20
    et
    present(BRAS) = 1 et V_CNR + 0 != 1 et V_CNR2+0 = 1)
   ou
   (V_NOTRAIT >= 20
    et
    positif(BRAS) = 1 et V_CNR + 0 != 1 et V_CNR2+0 = 1)

alors erreur A080 ;
verif 1082:
application : batch , iliad ;


si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   VALREGCO non dans (1,2)

alors erreur A082 ;
verif 1083:
application : batch , iliad ;


si
   APPLI_OCEANS = 0
   et
   V_NOTRAIT+0 = 10
   et
   VALREGCO = 2 
   et
   V_CNR2 + 0 != 1

alors erreur A083 ;
verif 1085:
application : iliad , batch ;


si
   (V_NOTRAIT + 0 < 20
    et
    (NRBASE >= 0 ou NRINET >= 0)
    et
    V_REGCO != 3)
   ou
   (V_NOTRAIT + 0 > 20
    et
    (NRBASE > 0 ou NRINET > 0)
    et
    V_REGCO != 3)

alors erreur A085 ;
verif 1086:
application : iliad , batch ;


si
   positif(present(NRBASE) + present(NRINET)) = 1
   et
   present(NRBASE) + present(NRINET) < 2

alors erreur A086 ;
verif 1087:
application : iliad , batch ;


si
   (V_NOTRAIT + 0 < 20
    et
    V_CNR + 0 = 1
    et
    IND_TDR >= 0)
   ou
   (V_NOTRAIT + 0 > 20
    et
    V_CNR + 0 = 1
    et
    IND_TDR > 0)

alors erreur A087 ;
verif 1088:
application : iliad , batch ;


si
   (IPTEFP + IPTEFN
    + SALEXTV + SALEXTC + SALEXT1 + SALEXT2 + SALEXT3 + SALEXT4
    + COD1AH + COD1BH + COD1CH + COD1DH + COD1EH + COD1FH
    + PRODOM + PROGUY
    + CODDAJ + CODDBJ + CODEAJ + CODEBJ + 0) > 0
   et
   V_CNR + 0 = 1

alors erreur A088 ;
verif 1089:
application : iliad ,  batch ;


si
   ((APPLI_OCEANS = 1 et V_8ZT > 0)
    ou
    (APPLI_BATCH = 1 et V_8ZT >= 0))
   et
   V_CNR + 0 != 1

alors erreur A089 ;
verif 10891:
application : iliad ;


si
   APPLI_OCEANS = 0
   et
   (( V_8ZT >= 0 et V_CNR+0 != 1 et V_NOTRAIT + 0 < 20)
    ou
    ( V_8ZT > 0 et V_CNR+0 != 1 et V_NOTRAIT >= 20))

alors erreur A089 ;
verif 1090:
application : iliad , batch ;


si
    V_IND_TRAIT + 0 > 0
    et
    V_8ZT > ( somme(i=V,C,1..4: TPRi)
              + somme (i=1..3: GLNiV)
              + somme (i=1..3: GLNiC)
              + RVTOT + T2RV
              + 2 )

alors erreur A090 ;
verif 1091:
application : iliad , batch ;


si
   (V_NOTRAIT + 0 < 20
    et
    (present(RMOND) = 1 ou present(DMOND) = 1)
    et V_CNR + 0 != 1)
   ou
   (V_NOTRAIT >= 20
    et
    (positif(RMOND) = 1 ou positif(DMOND) = 1)
    et V_CNR + 0 != 1)

alors erreur A091 ;
verif 1092:
application : iliad , batch;


si
   (V_NOTRAIT + 0 < 20
    et
    ((positif(IPTXMO) = 1 et present(DMOND) != 1 et present(RMOND) != 1)
     ou
     ((present(RMOND) = 1 ou present(DMOND) = 1) et positif(IPTXMO+0) != 1)))
   ou
   (V_NOTRAIT >= 20
    et
    ((positif(IPTXMO) = 1 et positif(DMOND) != 1 et positif(RMOND) != 1)
     ou
     ((positif(RMOND) = 1 ou positif(DMOND) = 1) et positif(IPTXMO+0) != 1)))

alors erreur A092 ;
verif 1093:
application : iliad , batch ;


si
   (V_NOTRAIT + 0 < 20
    et
    present(RMOND) = 1
    et
    present(DMOND) = 1)
   ou
   (V_NOTRAIT >= 20
    et
    positif(RMOND) = 1
    et
    positif(DMOND) = 1)

alors erreur A093 ;
verif 1096:
application : batch , iliad ;

si
   V_REGCO dans (2,3)
   et
   ((V_IND_TRAIT = 4 et BASRET >= 0 et IMPRET >= 0)
    ou
    (V_IND_TRAIT = 5 et BASRET > 0 et IMPRET > 0))

alors erreur A096 ;
verif 1097:
application : batch , iliad ;


si
   present(PERPIMPATRIE) = 1
   et
   V_CNR = 1

alors erreur A097 ;
verif 10981:
application : batch , iliad ;

si
   positif(PVMOBNR + 0) = 1
   et
   V_CNR != 1

alors erreur A09801 ;
verif 10982:
application : batch , iliad ;

si
   positif(COD3VE + 0) = 1
   et
   V_CNR != 1
 
alors erreur A09802 ;
verif 10983:
application : batch , iliad ;

si
   positif(COD3UV + 0) = 1
   et
   V_CNR != 1
 
alors erreur A09803 ;
