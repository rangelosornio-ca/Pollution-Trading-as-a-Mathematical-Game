$title Pollution Trading as a Mathematical Game

Sets
   i     'Point Sources'                  /F1*F29/
   j     'Treatment Technologies'         /A*C/
   l(i)  'Leader'                         /F1*F29/;

Alias (i,k);
Alias (i,n);

Parameters

   VD(i) 'dicharge volume L/year'
         / F1     63688.3025e6
           F2     2072.2875e6
           F3     6355.0150e6
           F4     2072.2875e6
           F5     2763.05e6
           F6     3094.616e6
           F7     1657.83e6
           F8     37301.175e6
           F9     6216.8625e6
           F10    1381.525e6
           F11    1381.525e6
           F12    1381.525e6
           F13    2763.05e6
           F14    5201.4416e6
           F15    24867.45e6
           F16    9946.98e6
           F17    80957.365e6
           F18    31775.075e6
           F19    1591.5168e6
           F20    500.1121e6
           F21    149204.7e6
           F22    6465.537e6
           F23    38807.0373e6
           F24    2653.9095e6
           F25    751.5496e6
           F26    690.7625e6
           F27    4.1446e6
           F28    1721.3802e6
           F29    74.6024e6 /

   C0(i) 'discharge concentration Kg/L'
         / F1    4.65e-12
           F2    3.7e-12
           F3    4.3e-12
           F4    3.4e-12
           F5    3.88e-12
           F6    3.7e-12
           F7    3.9e-12
           F8    4.83e-12
           F9    4e-12
           F10   3.1e-12
           F11   3.06e-12
           F12   3.22e-12
           F13   3.31e-12
           F14   4.8e-12
           F15   4.33e-12
           F16   5.1e-12
           F17   4.87e-12
           F18   4.52e-12
           F19   5.05e-12
           F20   4.14e-12
           F21   4.58e-12
           F22   5.2e-12
           F23   4.41e-12
           F24   3.9e-12
           F25   4.5e-12
           F26   3.95e-12
           F27   3.72e-12
           F28   4.1e-12
           F29   3.4e-12 /

   prc(j) 'capacidad de reduccion de mercurio Kg/L'
          / A    3e-12
            B    2e-12
            C    1e-12 /

   TAC(j) 'costo por volumen de agua tratada $/L'
          / A    396.301e-6
            B    264.2008e-6
            C    158.5205e-6 /

   CTI_sc(i) 'Costo de Tecnología en el modelo sin créditos $/year'
         /F1        25239750.71
          F2        547500.0153
          F3        1679000.047
          F4        547500.0153
          F5        730000.0204
          F6        817600.0229
          F7        438000.0123
          F8        14782500.41
          F9        1642500.046
          F10        219000.0338
          F11        219000.0338
          F12        219000.0338
          F13        730000.0204
          F14        2061337.558
          F15        9855000.276
          F16        3942000.11
          F17        32083500.9
          F18        12592500.35
          F19        630720.0177
          F20        132130.0037
          F21        59130001.66
          F22        2562300.072
          F23        15379275.43
          F24        701165.0196
          F25        297840.0083
          F26        182500.0051
          F27        1095.000031
          F28        454790.0127
          F29        19710.00055/;

Scalar r         'trading ratio'                                         /1.1/
       MC        'upper limit for pollutant trading'                     /0.05/
       TMDL      'total maximum daily discharge limit '                  /1.1209e3/
       PC        'transaction cost per pollutant credit exchanged'       /1.5e3/
       LC        'pollutant concentration limit for all point sources'   /2.3e-9/
       Myp       'upper limit for binary variable yp'                    /5/
       Mys       'upper limit for binary variable yp'                    /5/
       MB        'upper limit for binary variable b'                     /5/
       M         'upper limit for equilibrium constraints'               /6e5/;

Parameter

   MD0(i) 'initial pollutant discharge'
   LM(i)  'maximum allowable mass discharge';

   MD0(i) = VD(i)*C0(i);
   LM(i) = VD(i)*LC;

Variable
   sigma         'complementarity deviation'
   PRTC(i)       'pollutant reduction achieved'
   CPT(i)        'otal cost of trading pollutant credits'
   b(i,j)        'treatment technology selection'
   yp(i)         'relaxed binary variable for credits purchased'
   ys(i)         'relaxed binary variable for credits sold'
   CT(i)         'total cost'
   FMD(i)        'final pollutant discharge'

   sumCTI(i)     'total cost of treatment technology investment'

   lambdaI(i,j)   'Dual variable'
   lambdaII(i,j)  'Dual variable'
   lambdaIII(i)   'Dual variable'
   lambdaIV(i)    'Dual variable'
   lambdaV(i)     'Dual variable'
   lambdaVI(i)    'Dual variable'
   lambdaVII(i)   'Dual variable'

   Z              'objective function';

Positive Variable
   CTI(i,j)      'cost of implementing technology'
   Cpurch(i)     'total amount of credits purchased'
   Csold(i)      'total amount of credits sold'
   CC(i,k)       'credits purchased from point source i to point source k'
   rp(i,j)       'pollutant removed through the implementation of technology'
   MPD(i)        'mass of pollutant discharged after the pollutant treatment technology has been implemented'
   muI(i)        'Dual variable'
   muII(i)       'Dual variable'
   muIII(i)      'Dual variable'
   muIV(i)       'Dual variable'
   muV(i)        'Dual variable'
   muVI(i)       'Dual variable'
;

SOS1 Variable
   sigmaCTIp(i,j)  'positive deviation related to variable CTI'
   sigmaCTIn(i,j)  'desviación negativa asociada a la variable CTI'
   sigmarpp(i,j)   'positive deviation related to variable rp'
   sigmarpn(i,j)   'negative deviation related to variable rp'
   sigmabp(i,j)    'positive deviation related to variable b'
   sigmabn(i,j)    'negative deviation related to variable b'
   sigmaCPTp(i)    'positive deviation related to variable CPT'
   sigmaCPTn(i)    'negative deviation related to variable CPT'
   sigmaMPDp(i)    'positive deviation related to variable MPD'
   sigmaMPDn(i)    'negative deviation related to variable MPD'
   sigmaCpurchp(i) 'positive deviation related to variable Cpurch'
   sigmaCpurchn(i) 'negative deviation related to variable Cpurch'
   sigmaCsoldp(i)  'positive deviation related to variable Csold'
   sigmaCsoldn(i)  'negative deviation related to variable Csold'
   sigmaPRTCp(i)   'positive deviation related to variable PRTC'
   sigmaPRTCn(i)   'negative deviation related to variable PRTC'
   sigmaCCp(i,k)   'positive deviation related to variable CC'
   sigmaCCn(i,k)   'negative deviation related to variable CC'
   sigmaypp(i)     'positive deviation related to variable yp'
   sigmaypn(i)     'negative deviation related to variable yp'
   sigmaysp(i)     'positive deviation related to variable ys'
   sigmaysn(i)     'negative deviation related to variable ys'
   sigmamuIp(i)    'positive deviation related to variable muI'
   sigmamuIn(i)    'negative deviation related to variable muI'
   sigmamuIIp(i)   'positive deviation related to variable muII'
   sigmamuIIn(i)   'negative deviation related to variable muII'
   sigmamuIIIp(i)  'positive deviation related to variable muIII'
   sigmamuIIIn(i)  'negative deviation related to variable muIII'
   sigmamuIVp(i)   'positive deviation related to variable muIV'
   sigmamuIVn(i)   'negative deviation related to variable muIV'
   sigmamuVp(i)    'positive deviation related to variable muV'
   sigmamuVn(i)    'negative deviation related to variable muV'
   sigmamuVIp(i)   'positive deviation related to variable muVI'
   sigmamuVIn(i)   'negative deviation related to variable muVI'
;

Binary Variable
   yyp(i)        'binary variable for relaxed binary variable of credits purchased'
   yys(i)        'binary variable for relaxed binary variable of credits sold'
   yb(i,j)       'binary variable for relaxed binary variable of treatment technology'
   BCTI(i,j)     'binary variable related to CTI'
   BCPT(i)       'binary variable related to CPT'
   Brp(i,j)      'binary variable related to rp'
   Bb(i,j)       'binary variable related to b'
   BMPD(i)       'binary variable related to MPD'
   BCpurch(i)    'binary variable related to Cpurch'
   BCsold(i)     'binary variable related to Csold'
   BPRTC(i)      'binary variable related to PRTC'
   BCC(i,k)      'binary variable related to CC'
   Byp(i)        'binary variable related to yp'
   Bys(i)        'binary variable related to ys'
   BmuI(i)       'binary variable related to muI'
   BmuII(i)      'binary variable related to muII'
   BmuIII(i)     'binary variable related to muIII'
   BmuIV(i)      'binary variable related to muIV'
   BmuV(i)       'binary variable related to muV'
   BmuVI         'binary variable related to muVI';

Equation
   fobj          'objective function'
   desv          'sum of deviations'
   e1(i,j)       'pollutant removed through implementation of technology'
   e2(i,j)       'implementation cost of technology'
   e3(i)         'amount of pollutant discharged after technology implementation'
   e4(i)         'pollutant reduction achieved through the purchase and sale of credits'
   e5(i)         'cost of pollutant trading'
   e6(i)         'credits purchased'
   e7(i)         'credits sold'
   e8(i)         'total cost constraint'
   e9(i)         'total credits purchased'
   e10(i)        'total credits sold'
   e11(i)        'logical constraint to avoid simultaneous buying and selling of credits'
   e12(i)        'credits purchased limit'
   e13(i)        'credits sold limit'
   e14(i)        'Logical constraint to avoid simultaneous buying and selling of credits:'
   e15(i,j)      'relaxation of binary variable b'
   e16(i,j)      'relaxation of binary variable b'
   e17(i,j)      'relaxation of binary variable b'
   e18(i,j)      'relaxation of binary variable b'
   e19(i)        'relaxation of binary variable yp'
   e20(i)        'relaxation of binary variable yp'
   e21(i)        'relaxation of binary variable yp'
   e22(i)        'relaxation of binary variable yp'
   e23(i)        'relaxation of binary variable ys'
   e24(i)        'relaxation of binary variable ys'
   e25(i)        'relaxation of binary variable ys'
   e26(i)        'relaxation of binary variable ys'
   e27(i,j)      'reformulation related to variable CTI'
   e28(i,j)      'reformulation related to variable CTI'
   e29(i,j)      'reformulation related to variable CTI'
   e30(i)        'reformulation related to variable CPT'
   e31(i)        'reformulation related to variable CPT'
   e32(i)        'reformulation related to variable CPT'
   e33(i,j)      'reformulation related to variable rp'
   e34(i,j)      'reformulation related to variable rp'
   e35(i,j)      'reformulation related to variable rp'
   e36(i,j)      'reformulation related to variable b'
   e37(i,j)      'reformulation related to variable b'
   e38(i,j)      'reformulation related to variable b'
   e39(i)        'reformulation related to variable MPD'
   e40(i)        'reformulation related to variable MPD'
   e41(i)        'reformulation related to variable MPD'
   e42(i)        'reformulation related to variable Cpurch'
   e43(i)        'reformulation related to variable Cpurch'
   e44(i)        'reformulation related to variable Cpurch'
   e45(i)        'reformulation related to variable Csold'
   e46(i)        'reformulation related to variable Csold'
   e47(i)        'reformulation related to variable Csold'
   e48(i)        'reformulation related to variable PRTC'
   e49(i)        'reformulation related to variable PRTC'
   e50(i)        'reformulation related to variable PRTC'
   e51(i)        'reformulation related to variable CC'
   e52(i,k)      'reformulation related to variable CC'
   e53(i,k)      'reformulation related to variable CC'
   e54(k)        'reformulation related to variable CC'
   e55(i,k)      'reformulation related to variable CC'
   e56(i,k)      'reformulation related to variable CC'
   e57(i)        'reformulation related to variable yp'
   e58(i)        'reformulation related to variable yp'
   e59(i)        'reformulation related to variable yp'
   e60(i)        'reformulation related to variable ys'
   e61(i)        'reformulation related to variable ys'
   e62(i)        'reformulation related to variable ys'
   e63(i)        'reformulation related to variable muI'
   e64(i)        'reformulation related to variable muI'
   e65(i)        'reformulation related to variable muI'
   e66(i)        'reformulation related to variable muII'
   e67(i)        'reformulation related to variable muII'
   e68(i)        'reformulation related to variable muII'
   e69(i)        'reformulation related to variable muIII'
   e70(i)        'reformulation related to variable muIII'
   e71(i)        'reformulation related to variable muIII'
   e72(i)        'reformulation related to variable muIV'
   e73(i)        'reformulation related to variable muIV'
   e74(i)        'reformulation related to variable muIV'
   e75(i)        'reformulation related to variable muV'
   e76(i)        'reformulation related to variable muV'
   e77(i)        'reformulation related to variable muV'
   e78(i)        'reformulation related to variable muVI'
   e79(i)        'reformulation related to variable muVI'
   e80(i)        'reformulation related to variable muVI'
   e81(i)        'sum of technology costs'
   e82(i)        'total costs of point source i'
   e83(i)        'final pollutant discharge'
;
* Objective function

   fobj..        Z =E= sum((l(i),j),CTI(i,j)) + sum((l(i)),CPT(i)) + sigma;

   desv..        sigma =E= sum((i,j)$[not l(i)],sigmaCTIp(i,j)+sigmaCTIn(i,j)+sigmarpp(i,j)+sigmarpn(i,j)+sigmabp(i,j)+sigmabn(i,j))+sum((i,k)$[not l(i) and not l(k)],sigmaCCp(i,k)+sigmaCCn(i,k))
                           +sum(i$[not l(i)],sigmaCPTp(i)+sigmaCPTn(i)+sigmaMPDp(i)+sigmaMPDn(i)+sigmaCpurchp(i)+sigmaCpurchn(i)+sigmaCsoldp(i)+sigmaCsoldn(i)+sigmaPRTCp(i)+sigmaPRTCn(i)+sigmaypp(i)+sigmaypn(i))
                           +sum(i$[not l(i)],sigmaysp(i)+sigmaysn(i)+sigmamuIp(i)+sigmamuIn(i)+sigmamuIIp(i)+sigmamuIIn(i)+sigmamuIIIp(i)+sigmamuIIIn(i)+sigmamuIVp(i)+sigmamuIVn(i)+sigmamuVp(i)+sigmamuVn(i)+sigmamuVIp(i)+sigmamuVIn(i));

* Main constraints

   e1(i,j)..     rp(i,j) =E= prc(j)*VD(i)*b(i,j);
   e2(i,j)..     CTI(i,j) =E= TAC(j)*VD(i)*b(i,j);
   e3(i)..       MPD(i) =E= MD0(i)-sum(j,rp(i,j));
   e4(i)..       PRTC(i) =E= 1/r*Cpurch(i)-Csold(i);
   e5(i)..       CPT(i) =E= PC*(Cpurch(i)-Csold(i));
   e6(i)..       LM(i) =G= MPD(i)-PRTC(i);
   e7(i)..       Cpurch(i)+Csold(i) =L= MC;

   e8(i)..       sum(j,CTI(i,j)) + CPT(i) =L= CTI_sc(i);

* Purchase and sell constraints

   e9(i)..      Cpurch(i) =E= sum(k,CC(i,k));
   e10(i)..      Csold(i) =E= sum(k,CC(k,i));
   e11(i)..      CC(i,i) =E= 0;
   e12(i)..      Cpurch(i) =L= MC*yp(i);
   e13(i)..      Csold(i) =L= MC*ys(i);
   e14(i)..      yp(i)+ys(i) =L= 1;

* Relaxation of binary variables

   e15(i,j)..    b(i,j) =G= 1-MB*(1-yb(i,j));
   e16(i,j)..    b(i,j) =L= 1;
   e17(i,j)..    b(i,j) =L= MB*yb(i,j);
   e18(i,j)..    b(i,j) =G= 0;

   e19(i)..      yp(i) =G= 1-Myp*(1-yyp(i));
   e20(i)..      yp(i) =L= 1;
   e21(i)..      yp(i) =L= Myp*yyp(i);
   e22(i)..      yp(i) =G= 0;

   e23(i)..      ys(i) =G= 1-Mys*(1-yys(i));
   e24(i)..      ys(i) =L= 1;
   e25(i)..      ys(i) =L= Mys*yys(i);
   e26(i)..      ys(i) =G= 0;

* Complementarity constraints

   e27(i,j)$[not l(i)]..    1+lambdaII(i,j) + muVI(i) =G= 0;
   e28(i,j)$[not l(i)]..    1+lambdaII(i,j) + muVI(i) =L= M*(BCTI(i,j)+sigmaCTIp(i,j)-sigmaCTIn(i,j));
   e29(i,j)$[not l(i)]..    CTI(i,j) =L= M*(1-BCTI(i,j)+sigmaCTIp(i,j)-sigmaCTIn(i,j));

   e30(i)$[not l(i)]..      1+lambdaV(i) + muVI(i) =G= 0;
   e31(i)$[not l(i)]..      1+lambdaV(i) + muVI(i) =L= M*(BCPT(i)+sigmaCPTp(i)-sigmaCPTn(i));
   e32(i)$[not l(i)]..      CPT(i) =L= M*(1-BCPT(i)+sigmaCPTp(i)-sigmaCPTn(i));

   e33(i,j)$[not l(i)]..    lambdaI(i,j)+lambdaIII(i) =G= 0;
   e34(i,j)$[not l(i)]..    lambdaI(i,j)+lambdaIII(i) =L= M*(Brp(i,j)+sigmarpp(i,j)-sigmarpn(i,j));
   e35(i,j)$[not l(i)]..    rp(i,j) =L= M*(1-Brp(i,j)+sigmarpp(i,j)-sigmarpn(i,j));

   e36(i,j)$[not l(i)]..    -prc(j)*VD(i)*lambdaI(i,j)-TAC(j)*VD(i)*lambdaII(i,j) =G= 0;
   e37(i,j)$[not l(i)]..    -prc(j)*VD(i)*lambdaI(i,j)-TAC(j)*VD(i)*lambdaII(i,j) =L= M*(Bb(i,j)+sigmabp(i,j)-sigmabn(i,j));
   e38(i,j)$[not l(i)]..    b(i,j) =L= M*(1-Bb(i,j)+sigmabp(i,j)-sigmabn(i,j));

   e39(i)$[not l(i)]..      lambdaIII(i)+muI(i) =G= 0;
   e40(i)$[not l(i)]..      lambdaIII(i)+muI(i) =L= M*(BMPD(i)+sigmaMPDp(i)-sigmaMPDn(i));
   e41(i)$[not l(i)]..      MPD(i) =L= M*(1-BMPD(i)+sigmaMPDp(i)-sigmaMPDn(i));

   e42(i)$[not l(i)]..      -lambdaIV(i)/r-PC*lambdaV(i)+lambdaVI(i)+muII(i)+muIII(i) =G= 0;
   e43(i)$[not l(i)]..      -lambdaIV(i)/r-PC*lambdaV(i)+lambdaVI(i)+muII(i)+muIII(i) =L= M*(BCpurch(i)+sigmaCpurchp(i)-sigmaCpurchn(i));
   e44(i)$[not l(i)]..      Cpurch(i) =L= M*(1-BCpurch(i)+sigmaCpurchp(i)-sigmaCpurchn(i));

   e45(i)$[not l(i)]..      lambdaIV(i)+PC*lambdaV(i)+lambdaVII(i)+muII(i)+muIV(i) =G= 0;
   e46(i)$[not l(i)]..      lambdaIV(i)+PC*lambdaV(i)+lambdaVII(i)+muII(i)+muIV(i) =L= M*(BCsold(i)+sigmaCsoldp(i)-sigmaCsoldn(i));
   e47(i)$[not l(i)]..      Csold(i) =L= M*(1-BCsold(i)+sigmaCsoldp(i)-sigmaCsoldn(i));

   e48(i)$[not l(i)]..      lambdaIV(i)-muI(i) =G= 0;
   e49(i)$[not l(i)]..      lambdaIV(i)-muI(i) =L= M*(BPRTC(i)+sigmaPRTCp(i)-sigmaPRTCn(i));
   e50(i)$[not l(i)]..      PRTC(i) =L= M*(1-BPRTC(i)+sigmaPRTCp(i)-sigmaPRTCn(i));

   e51(i)$[not l(i)]..                   -lambdaVI(i) =G= 0;
   e52(i,k)$[not l(i) and not l(k)]..     -lambdaVI(i) =L= M*(BCC(i,k)+sigmaCCp(i,k)-sigmaCCn(i,k));
   e53(i,k)$[not l(i) and not l(k)]..    CC(i,k) =L= M*(1-BCC(i,k)+sigmaCCp(i,k)-sigmaCCn(i,k));

   e54(k)$[not l(k)]..                   -lambdaVII(k) =G= 0;
   e55(k,i)$[not l(i) and not l(k)]..    -lambdaVII(k) =L= M*(BCC(k,i)+sigmaCCp(k,i)-sigmaCCn(k,i));
   e56(k,i)$[not l(i) and not l(k)]..    CC(k,i) =L= M*(1-BCC(k,i)+sigmaCCp(k,i)-sigmaCCn(k,i));

   e57(i)$[not l(i)]..      -MC*muIII(i) + muV(i) =G= 0;
   e58(i)$[not l(i)]..      -MC*muIII(i) + muV(i) =L= M*(Byp(i)+sigmaypp(i)-sigmaypn(i));
   e59(i)$[not l(i)]..      yp(i) =L= M*(1-Byp(i)+sigmaypp(i)-sigmaypn(i));

   e60(i)$[not l(i)]..      -MC*muIV(i) + muV(i) =G= 0;
   e61(i)$[not l(i)]..      -MC*muIV(i) + muV(i) =L= M*(Bys(i)+sigmaysp(i)-sigmaysn(i));
   e62(i)$[not l(i)]..      ys(i) =L= M*(1-Bys(i)+sigmaysp(i)-sigmaysn(i));

   e63(i)$[not l(i)]..      PRTC(i)+LM(i)-MPD(i) =G= 0;
   e64(i)$[not l(i)]..      PRTC(i)+LM(i)-MPD(i) =L= M*(BmuI(i)+sigmamuIp(i)-sigmamuIn(i));
   e65(i)$[not l(i)]..      muI(i) =L= M*(1-BmuI(i)+sigmamuIp(i)-sigmamuIn(i));

   e66(i)$[not l(i)]..      -Cpurch(i)-Csold(i)+MC =G= 0;
   e67(i)$[not l(i)]..      -Cpurch(i)-Csold(i)+MC =L= M*(BmuII(i)+sigmamuIIp(i)-sigmamuIIn(i));
   e68(i)$[not l(i)]..      muII(i) =L= M*(1-BmuII(i)+sigmamuIIp(i)-sigmamuIIn(i));

   e69(i)$[not l(i)]..      - Cpurch(i) + MC*yp(i) =G= 0;
   e70(i)$[not l(i)]..      - Cpurch(i) + MC*yp(i) =L= M*(BmuIII(i)+sigmamuIIIp(i)-sigmamuIIIn(i));
   e71(i)$[not l(i)]..      muIII(i) =L= M*(1-BmuIII(i)+sigmamuIIIp(i)-sigmamuIIIn(i));

   e72(i)$[not l(i)]..      - Csold(i) + MC*ys(i) =G= 0;
   e73(i)$[not l(i)]..      - Csold(i) + MC*ys(i) =L= M*(BmuIV(i)+sigmamuIVp(i)-sigmamuIVn(i));
   e74(i)$[not l(i)]..      muIV(i) =L= M*(1-BmuIV(i)+sigmamuIVp(i)-sigmamuIVn(i));

   e75(i)$[not l(i)]..      -yp(i) - ys(i) + 1 =G= 0;
   e76(i)$[not l(i)]..      -yp(i) - ys(i) + 1 =L= M*(BmuV(i)+sigmamuVp(i)-sigmamuVn(i));
   e77(i)$[not l(i)]..      muV(i) =L= M*(1-BmuV(i)+sigmamuVp(i)-sigmamuVn(i));

   e78(i)$[not l(i)]..      -sum(j,CTI(i,j)) - CPT(i) + CTI_sc(i) =G= 0;
   e79(i)$[not l(i)]..      -sum(j,CTI(i,j)) - CPT(i) + CTI_sc(i) =L= M*(BmuVI(i)+sigmamuVIp(i)-sigmamuVIn(i));
   e80(i)$[not l(i)]..      muVI(i) =L= M*(1-BmuVI(i)+sigmamuVIp(i)-sigmamuVIn(i));

* Additional contraints

   e81(i)..      sumCTI(i) =E= sum(j,CTI(i,j));
   e82(i)..      CT(i) =E= sum(j,CTI(i,j)) + CPT(i);
   e83(i)..       FMD(i) =E= MPD(i)-PRTC(i);

Model leadermodel /all/;

Option MIP=CPLEX;

*Sin líder
l(n) =no;
Solve leadermodel using MIP minimizing Z;

*Líder N
l(n) =no;
$onEnd
Loop (n)$(ord(n) <= card(n)) do
l(n) =yes;
Solve leadermodel using MIP minimizing Z;
l(n) =no;
Endloop;


