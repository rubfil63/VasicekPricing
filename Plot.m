zero_curve = readtable('ZeroCurve.xlsx');
market_data = readtable('CallOption.xlsx');
zero_curve  = table2array(zero_curve);
zero_curve(:,2) = (-1)*zero_curve(:,2);
market_data = table2array(market_data);

tm =zero_curve(:,1);
ds =zero_curve(:,2);

t_plot = 0:0.02:50;
discount_plot = (P(t_plot,tm,ds));
forward_plot = F(t_plot,tm,ds,0.0001);
theta_plot = theta(t_plot,tm,ds,0.0001,0.1195,0.1210);
hold on

a = plot(tm,ds,'o',t_plot,discount_plot,':.');
b = plot(tm,ds,'o',t_plot,forward_plot,':.');
c = plot(tm,ds,'o',t_plot,theta_plot,':.');
legend('market obs','zero-coupon discount', 'market obs', 'instantaneous forward','market obs','theta')

hold off
