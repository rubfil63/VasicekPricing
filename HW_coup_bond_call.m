function f=HW_coup_bond_call(Coup,N,t1,dt,K,r0,sigma,kappa,T,time,discount)
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
    down=0;
    f_d=HW_Coupon(Coup,N,kappa,sigma,down,T,t,time,discount)-K;
    while(f_d<0)
        down=down-1;
        f_d=HW_Coupon(Coup,N,kappa,sigma,down,T,t,time,discount)-K;
    end
    up=1;
    f_u=HW_Coupon(Coup,N,kappa,sigma,up,T,t,time,discount)-K;
    while(f_u>0)
        up=up+1;
        f_u=HW_Coupon(Coup,N,kappa,sigma,up,T,t,time,discount)-K;
    end
    tol=10^-8;
    tmp=0.5*up+0.5*down;
    f_tmp=HW_Coupon(Coup,N,kappa,sigma,tmp,T,t,time,discount)-K;
    while(up-down>tol)
        if(f_u*f_d<0)
            down=tmp;
            f_d=f_tmp;
            tmp=0.5*up+0.5*down;
            f_tmp=HW_Coupon(Coup,N,kappa,sigma,tmp,T,t,time,discount)-K;
        else
            up=tmp;
            f_u=f_tmp;
            tmp=0.5*up+0.5*down;
            f_tmp=HW_Coupon(Coup,N,kappa,sigma,tmp,T,t,time,discount)-K;
        end
    end
    rstar=tmp;
    x =0;
    for i=1:N-1
        S=t1+(i-1)*dt;
        a=hwa(sigma,kappa,T,S,time,discount);
        b=hwb(kappa,T,S);
        MatDisc=HW_Coupon(Coup,N,kappa,sigma,r0,T,S,time,discount);
        strike=Cal(i)*a*exp(-b*rstar);
        sigavg=hwsigavg(sigma,kappa,T,S);
        x=x+Coup*Vasicek_Discount_Bond_Call(P(i*dt,time,discount),strike,MatDisc,sigavg,T);
    end
    S=t1+(N-1)*dt;%Maturity of bond
    a=hwa(sigma,kappa,T,S,time,discount);
    b=hwb(kappa,T,S);
    MatDisc=HW_Coupon(Coup,N,kappa,sigma,r0,T,S,time,discount);
    strike=Cal(N)*a*exp(-b*rstar);
    f=x+(1+Coup)*Vasicek_Discount_Bond_Call(P(t,time,discount),strike,MatDisc,sigavg,T);
end
