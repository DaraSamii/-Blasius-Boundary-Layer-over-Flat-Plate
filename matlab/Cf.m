function Cf_value = Cf(x ,mu,rho, U_e,G)
    tau_value = tau(x, U_e, mu, rho, G);
    Cf_value = (2* tau_value) / (rho * (U_e^2));
end
