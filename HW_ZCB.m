%zero coupon bond
function y = HW_ZCB(kappa,r0,T,time,sigma,discount)

    B = 1/kappa * (1- exp(-kappa*(T)));
    A = P(T,time,discount)/P(0,time,discount) * exp(B*F(0,time,discount,0.001) - (sigma^2/(4*kappa))*(1-exp(-2*kappa*0))*B^2);
    r = r0;
    y = A * exp(-B*r);
    
end
