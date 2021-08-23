function y = theta(t,time,discount,delta,kappa,stigma)
         fleft = F(t-delta,time,discount,delta);
         fright= F(t+delta,time,discount,delta);
         fforward = F(t,time,discount,delta);
         
         y = (fright-fleft)/(2*delta)+kappa*fforward + stigma*stigma*(1-exp(-2*kappa*t))/(2*kappa);
         
end