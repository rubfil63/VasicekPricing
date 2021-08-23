%Get data from zero_curve & Option

zero_curve = readtable('ZeroCurve.xlsx');
market_data = readtable('CallOption.xlsx');
zero_curve  = table2array(zero_curve);
zero_curve(:,2) = (-1)*zero_curve(:,2);
market_data = table2array(market_data);
num = min(size(market_data));

%Store market price (i,7)
%K,N,t1,T,dt,Coup  from 1:6

market_value = zeros(num,1);
for i = 1:num
    
    this_option = market_data(i,7);
    market_value(i) = this_option;
    
end

%Optimization
optimiz = @(param)opt(param(1),param(2),param(3),market_data(:,1:6),market_value,zero_curve(:,1),zero_curve(:,2));
param0 = [0.1,0.15,0.02];
[param2,fval2] = fminunc(optimiz,param0);
kappa_optim2 = param2(1);
sigma_optim2 = param2(2);
r0_optim2 = param2(3);

model_value_optim = zeros(num,1);
for i = 1:num
    %model_value_optim(i) = HW_coup_bond_call(market_data(i,6),market_data(i,2),market_data(i,3),market_data(i,5),market_data(i,1),r0_optim,sigma_optim,kappa_optim,market_data(i,4),zero_curve(:,1),zero_curve(:,2));
    model_value_optim(i) = HW_coup_bond_call(market_data(i,6),market_data(i,2),market_data(i,3),market_data(i,5),market_data(i,1),r0_optim2,sigma_optim2,kappa_optim2,market_data(i,4),zero_curve(:,1),zero_curve(:,2));
    fprintf('%5.4f & %5.4f \n',model_value_optim(i),market_data(i,7))
end
