function f=Vasicek_Discount_Bond_Call(Underlying,K,MatDisc,sigavg,T)
    F=Underlying/MatDisc;
    x = (log((MatDisc*F)/(Underlying*K))+ 0.5 * sigavg * sigavg * T) / (sigavg * sqrt(T));
    y = x - sigavg * sqrt(T);
    %disp(x)
    %disp(K)
    %disp((MatDisc))
    %disp((MatDisc*F))
    f = MatDisc*F * normcdf(x) - Underlying*K* normcdf(y);
end