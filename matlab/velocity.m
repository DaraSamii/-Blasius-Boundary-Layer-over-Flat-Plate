function [u,v] = velocity(x,y,U_e, nu)

G = fzero(@G_find,1);
sol89 = ode89(@blasius,[0 10],[0;0;G]);
t = linspace(0,10,1000);
f89 = deval(sol89,t);

criteria = 0.00001;
index_eta_max = find(diff(f89(2,:))./f89(2,2:end)<criteria,1);
eta_max = t(index_eta_max);

eta = Eta_func(x,y,U_e,nu);

fp1 = eta > eta_max;
fp2 = interp1(t(1:eta_max),f89(2,1:eta_max),eta) .* (eta < eta_max);

f = interp1(t,f89(1,:));
fp = fp1 + fp2;

u = U_e .* fp;
v = nu .* tickness(x,U_e,nu) .* (eta .* fp - f);

