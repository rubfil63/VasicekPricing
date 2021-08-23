function y = F(t,time,discount,delta)

    PMleft = P(t-delta,time, discount);
    PMright = P(t+delta,time,discount);
    logPMleft = log(PMleft);
    logPMright = log(PMright);
    
    y = -(logPMright-logPMleft)/(2*delta);

end