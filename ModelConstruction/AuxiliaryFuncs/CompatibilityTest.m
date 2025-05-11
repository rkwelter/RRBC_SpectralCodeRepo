function indexCond = CompatibilityTest(n,np,npp)
%COMPATIBILITYTEST tests whether wave numbers p,q are compatible with a
%wave number m

waveCond1 = 0; waveCond2 = 0; waveCond3 = 0; phaseCond1 = 0; phaseCond2 = 0;

if(n(1)== np(1)+npp(1) || np(1)== n(1)+npp(1) || npp(1)== np(1)+n(1))
    waveCond1 = 1;
end

if(n(2)== np(2)+npp(2) || np(2)== n(2)+npp(2) || npp(2)== np(2)+n(2))
    waveCond2 = 1;
end

if(n(3)== np(3)+npp(3) || np(3)== n(3)+npp(3) || npp(3)== np(3)+n(3))
    waveCond3 = 1;
end

if( (n(4)== 0 && np(4)==0 && npp(4) == 0) || (n(4)== 0 && np(4)==1 && npp(4) == 1) || (n(4)== 1 && np(4)==0 && npp(4) == 1)  || (n(4)== 1 && np(4)==1 && npp(4) == 0))
    phaseCond1 = 1;
end

if( (n(5)== 0 && np(5)==0 && npp(5) == 0) || (n(5)== 0 && np(5)==1 && npp(5) == 1) || (n(5)== 1 && np(5)==0 && npp(5) == 1)  || (n(5)== 1 && np(5)==1 && npp(5) == 0))
    phaseCond2 = 1;
end

indexCond = min([waveCond1,waveCond2,waveCond3,phaseCond1,phaseCond2]);

end

