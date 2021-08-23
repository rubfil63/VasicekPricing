function f=HW_coup_bond_call_new(Coup,N,t1,dt,K,r0,sigma,kappa,T,time,discount)
    %T-Maturity of option
    aT=hwa(sigma,kappa,T,0,time,discount);
    bT=hwb(kappa,T,0);
    t=N*dt;%maturity of bond
    Cal=zeros(1,N);
    for i=1:N
        S=T+t1+(i-1)*dt;
        a=hwa(sigma,kappa,T,S,time,discount);
        b=hwb(kappa,T,S);
        MatDisc=HW_Coupon(Coup,N,kappa,sigma,r0,T,t,time,discount);
        Cal(i)=exp(a-aT+(b-bT)*r0)*P(S-T,time,discount)/MatDisc;
    end
    x =0;   
    sigavg=hwsigavg(sigma,kappa,T,T+t);
    for i=1:N-1
        S=t1+(i-1)*dt;
        a=hwa(sigma,kappa,T,S,time,discount);
        b=hwb(kappa,T,S);
        MatDisc=HW_Coupon(Coup,N,kappa,sigma,r0,T,S,time,discount);
        strike=Cal(i)*a*exp(-b*r0)*K;
        m=Vasicek_Discount_Bond_Call(P(i*dt,time,discount),strike,MatDisc,sigavg,T);
        x=x+Coup*Vasicek_Discount_Bond_Call(P(i*dt,time,discount),strike,MatDisc,sigavg,T);
    end
    S=t1+(N-1)*dt;                                  %Maturity of bond
    a=hwa(sigma,kappa,T,S,time,discount);
    b=hwb(kappa,T,S);
    MatDisc=HW_Coupon(Coup,N,kappa,sigma,r0,T,S,time,discount);
    strike=Cal(N)*a*exp(-b*r0)*K;
    f=x+(1+Coup)*Vasicek_Discount_Bond_Call(P(t,time,discount),strike,MatDisc,sigavg,T);
end
