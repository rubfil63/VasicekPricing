function f=hwb(kappa,S,T)
    tau=T-S;
    f=(1-exp(-kappa*tau))/kappa;
end