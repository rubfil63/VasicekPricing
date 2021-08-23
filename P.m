function y = P(t,time,discount) 
 
y = exp(interp1(time,discount,t,'spline'));

end

