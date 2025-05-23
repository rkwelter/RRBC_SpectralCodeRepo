function [dX] =HKC_k1_1_k2_1_2(X,Pr,Ra,Ro)

dX = [ -Pr*(2)*X(1)+Pr*Ra*(-0.70711)*X(12)+Pr*Ro*(0.70711)*X(2)-(0.019048)*X(3)*X(6)-(-0.020078)*X(3)*X(9)-(-0.060235)*X(3)*X(11)-(-0.019048)*X(6)*X(3)-(-0.060235)*X(9)*X(3)-(-0.020078)*X(11)*X(3);
-Pr*(2)*X(2)+Pr*Ro*(-0.70711)*X(1)-(0.060235)*X(3)*X(7)-(0.028395)*X(3)*X(8)-(0.085186)*X(3)*X(10)-(0.060235)*X(6)*X(4)-(0.063494)*X(9)*X(4)-(0.063494)*X(11)*X(4);
-Pr*(5)*X(3)+Pr*Ra*(-0.44721)*X(13)+Pr*Ro*(-0.89443)*X(4)-(-0.076192)*X(1)*X(6)-(-0.040157)*X(1)*X(9)-(0.12047)*X(1)*X(11)-(0.019048)*X(6)*X(1)-(0.060235)*X(9)*X(1)-(0.020078)*X(11)*X(1);
-Pr*(5)*X(4)+Pr*Ro*(0.89443)*X(3)-(-0.09524)*X(1)*X(7)-(-0.044897)*X(1)*X(8)-(0.13469)*X(1)*X(10)-(-0.060235)*X(6)*X(2)-(-0.063494)*X(9)*X(2)-(-0.063494)*X(11)*X(2);
-Pr*(1)*X(5);
-Pr*(5)*X(6)+Pr*Ra*(-0.89443)*X(14)+Pr*Ro*(-0.44721)*X(7)-(0.076192)*X(1)*X(3)-(-0.019048)*X(3)*X(1);
-Pr*(5)*X(7)+Pr*Ro*(0.44721)*X(6)-(0.09524)*X(1)*X(4)-(-0.060235)*X(3)*X(2);
-Pr*(1)*X(8)+Pr*Ro*(1)*X(9)-(0.044897)*X(1)*X(4)-(-0.028395)*X(3)*X(2);
-Pr*(1)*X(9)+Pr*Ro*(-1)*X(8)-(0.040157)*X(1)*X(3)-(0.020078)*X(3)*X(1);
-Pr*(9)*X(10)+Pr*Ro*(1)*X(11)-(-0.13469)*X(1)*X(4)-(-0.085186)*X(3)*X(2);
-Pr*(9)*X(11)+Pr*Ro*(-1)*X(10)-(-0.12047)*X(1)*X(3)-(0.060235)*X(3)*X(1);
-(2)*X(12)+(-0.70711)*X(1)-(0.089794)*X(1)*X(15)-(0.060235)*X(3)*X(14)-(0.060235)*X(6)*X(13)-(-0.063494)*X(9)*X(13)-(0.063494)*X(11)*X(13);
-(5)*X(13)+(-0.44721)*X(3)-(-0.09524)*X(1)*X(14)-(0.11358)*X(3)*X(16)-(-0.060235)*X(6)*X(12)-(0.063494)*X(9)*X(12)-(-0.063494)*X(11)*X(12);
-(5)*X(14)+(-0.89443)*X(6)-(0.09524)*X(1)*X(13)-(-0.060235)*X(3)*X(12)-(0.11358)*X(6)*X(15);
-(4)*X(15)-(-0.089794)*X(1)*X(12)-(-0.11358)*X(6)*X(14);
-(16)*X(16)-(-0.11358)*X(3)*X(13)];
end