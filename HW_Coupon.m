%coupon bond
function y = HW_Coupon(Coup,N,kappa,sigma,r0,t,T,time,discount)
    x = 0;
    dt = T-t/N;
    
    for i = 1:N-1
        x = x + HW_ZCB(kappa,r0,t+i*dt,time,sigma,discount)*Coup;  
    
    end
    
   y = x + HW_ZCB(kappa,r0,T,time,sigma,discount);
   
end

