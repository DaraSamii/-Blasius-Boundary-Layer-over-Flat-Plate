function shear = tau(x,U_e,mu, rho,G)

nu = mu /rho;

g = sqrt(U_e ./ ( nu * x));

shear = mu * U_e * g * G;


end


