function f=hwa(sigma,kappa,S,T,time,discount)
    tau=T-S;
    B = 1/kappa * (1- exp(-kappa*(tau)));
    f = P(T,time,discount)/P(S,time,discount) * exp(B*F(S,time,discount,0.001) - (sigma^2/(4*kappa))*(1-exp(-2*kappa*S))*B^2);
end
