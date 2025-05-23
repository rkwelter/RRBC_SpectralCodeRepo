function [dX] =linf_k1_1_k2_1_1(X,Pr,Ra,Ro)

dX = [ -Pr*(1)*X(1)-(0.063494)*X(4)*X(7)-(0.063494)*X(6)*X(9)-(0.036658)*X(6)*X(11)-(0.044897)*X(10)*X(5)-(-0.025921)*X(12)*X(5);
-Pr*(2)*X(2)+Pr*Ra*(0.70711)*X(13)+Pr*Ro*(-0.70711)*X(3)-(0.044897)*X(4)*X(10)-(-0.077764)*X(4)*X(12)-(-0.031747)*X(5)*X(7)-(0.044897)*X(6)*X(8)-(0.031747)*X(7)*X(5)-(0.044897)*X(8)*X(6)-(0.044897)*X(10)*X(4)-(0.025921)*X(12)*X(4);
-Pr*(2)*X(3)+Pr*Ro*(0.70711)*X(2)-(0.063494)*X(4)*X(9)-(0.036658)*X(4)*X(11)-(-0.044897)*X(5)*X(8)-(0.063494)*X(6)*X(7)-(0.044897)*X(8)*X(5);
-Pr*(1)*X(4)-(-0.063494)*X(1)*X(7)-(-0.063494)*X(3)*X(9)-(0.036658)*X(3)*X(11)-(-0.044897)*X(10)*X(2)-(-0.025921)*X(12)*X(2);
-Pr*(2)*X(5)+Pr*Ra*(-0.70711)*X(14)+Pr*Ro*(0.70711)*X(6)-(-0.044897)*X(1)*X(10)-(-0.077764)*X(1)*X(12)-(0.031747)*X(2)*X(7)-(-0.044897)*X(3)*X(8)-(-0.031747)*X(7)*X(2)-(-0.044897)*X(8)*X(3)-(-0.044897)*X(10)*X(1)-(0.025921)*X(12)*X(1);
-Pr*(2)*X(6)+Pr*Ro*(-0.70711)*X(5)-(-0.063494)*X(1)*X(9)-(0.036658)*X(1)*X(11)-(0.044897)*X(2)*X(8)-(-0.063494)*X(3)*X(7)-(-0.044897)*X(8)*X(2);
-Pr*(2)*X(7)-(0.063494)*X(1)*X(4)-(-0.031747)*X(2)*X(5)-(0.063494)*X(3)*X(6)-(-0.063494)*X(4)*X(1)-(0.031747)*X(5)*X(2)-(-0.063494)*X(6)*X(3);
-Pr*(2)*X(8)-(-0.044897)*X(2)*X(6)-(0.044897)*X(3)*X(5)-(0.044897)*X(5)*X(3)-(-0.044897)*X(6)*X(2);
-Pr*(3)*X(9)+Pr*Ro*(-0.57735)*X(12)-(0.063494)*X(1)*X(6)-(0.063494)*X(3)*X(4)-(-0.063494)*X(4)*X(3)-(-0.063494)*X(6)*X(1);
-Pr*(3)*X(10)+Pr*Ro*(-0.57735)*X(11)-(0.044897)*X(1)*X(5)-(-0.044897)*X(4)*X(2);
-Pr*(3)*X(11)+Pr*Ra*(-0.8165)*X(15)+Pr*Ro*(0.57735)*X(10)-(-0.036658)*X(1)*X(6)-(-0.036658)*X(3)*X(4)-(-0.036658)*X(4)*X(3)-(-0.036658)*X(6)*X(1);
-Pr*(3)*X(12)+Pr*Ra*(-0.8165)*X(16)+Pr*Ro*(0.57735)*X(9)-(0.077764)*X(1)*X(5)-(0.077764)*X(4)*X(2);
-(2)*X(13)+(0.70711)*X(2)-(-0.089794)*X(2)*X(18)-(0.089794)*X(4)*X(16)-(-0.063494)*X(7)*X(14);
-(2)*X(14)+(-0.70711)*X(5)-(-0.089794)*X(1)*X(16)-(0.089794)*X(5)*X(18)-(0.063494)*X(7)*X(13);
-(3)*X(15)+(-0.8165)*X(11)-(0.10368)*X(11)*X(18);
-(3)*X(16)+(-0.8165)*X(12)-(0.089794)*X(1)*X(14)-(-0.089794)*X(4)*X(13)-(0.10368)*X(12)*X(18);
-(1)*X(17);
-(4)*X(18)-(0.089794)*X(2)*X(13)-(-0.089794)*X(5)*X(14)-(-0.10368)*X(11)*X(15)-(-0.10368)*X(12)*X(16)];
end