function f=hwsigavg(sigma,kappa,T,u)
    f=(sigma*(exp(-kappa*T)-exp(-kappa*u))/kappa)*sqrt((exp(2*kappa*T)-1)/(2*kappa*T));
end
