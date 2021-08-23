% inputs:
% kappa,sigma,r0: HW model params
% f0: instantaneous forward rate at time 0
% market_value: option data
% Output: loss function value

function y = opt(kappa,sigma,r0,data,market_value,time,discount)
      
   n = min(size(market_value));
   model_value = zeros(n,1);
   
   for i = 1:n
       K = data(i,1);
       N = data(i,2);
       t1 = data(i,3);
       T = data(i,4);
       dt = data(i,5);
       Coup = data(i,6);
       model_value(i) = HW_coup_bond_call(Coup,N,t1,dt,K,r0,sigma,kappa,T,time,discount);
   end
   
   diff = (market_value - model_value)./market_value;
   sq_diff = diff.*diff;
   y=0;
   for j =1:n
       y = y+0.5 *(sq_diff(i));
   end
   
end
