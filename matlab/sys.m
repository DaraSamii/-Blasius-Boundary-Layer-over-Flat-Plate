%% cleaing 
close all;clear;clc
format long

%% SETTING hyperparameters and constant values
L = 1;
H = 0.02;
dy = 0.0001;
dx = 0.001;
x = 0.001:dx:L;
y = 0.001:dy:H;





U_e = 50;
rho = 1.2;
mu =  1.7 * (10^ -4);
nu =mu / rho;
%x= [0.05,0.1,0.15,0.2,0.25];
%H = tickness(x,U_e,nu);
%y = 0:H/5000:H*20;




%% Generating meshgrid and computing eta
[X,Y] = meshgrid(x,y);
eta = Eta_func(X,Y,U_e,nu);

tol = 0.00001;
G = shootingMethod(@G_find,1,tol)

%% solivng with different methods
sol23 = ode23(@blasius,[0 10],[0;0;G]);
sol45 = ode45(@blasius,[0 10],[0;0;G]);
sol78 = ode78(@blasius,[0 10],[0;0;G]);
sol89 = ode89(@blasius,[0 10],[0;0;G]);
t = linspace(0,10,1000);
f23 = deval(sol23,t);
f45 = deval(sol45,t);
f78 = deval(sol78,t);
f89 = deval(sol89,t);
f_analytic = analitic(t,G,3/2);

%% compute root mean squeres
RMSE23 = sqrt(mean((f23(2,:) - f_analytic).^2));
RMSE45 = sqrt(mean((f45(2,:) - f_analytic).^2));
RMSE78 = sqrt(mean((f78(2,:) - f_analytic).^2));
RMSE89 = sqrt(mean((f89(2,:) - f_analytic).^2));

%% finding the eta_max
criteria = 0.00000001;
index_eta_max = find(diff(f89(2,:))./f89(2,2:end)<criteria,1);
eta_max = t(index_eta_max);
%% ploting eta values
%{
contourf(x,y,log10(eta),50,'edgecolor','none');
cb = colorbar('Ticks',[0,1,2,3,4],'TickLabels',{'0', '10^1','10^2','10^3','10^4'});
cb.Label.String = '\eta';
cb.Label.FontSize=18;
colormap turbo;
xlabel('x','FontSize',16);
ylabel('y','FontSize',16);
%}
%% ploting f, fp
%{
hold on
plot(t,f89(2,:),'-o','MarkerIndices',1:20:length(f89(2,:)),'LineWidth',2,'DisplayName','f''(\eta)');
plot(t,f89(3,:),'-*','MarkerIndices',1:20:length(f89(3,:)),'LineWidth',2,'DisplayName','f''''(\eta)');
xlabel('\eta','FontSize',16);
ylabel('F','FontSize',16);
lgd = legend();

lgd.FontSize = 18;
%}
%% ploting errors
%{
hold on
plot(t,(f23(2,:)-f_analytic),'r-','DisplayName','ODE23','LineWidth',2);
plot(t,(f45(2,:)-f_analytic),'y-','DisplayName','ODE45','LineWidth',2);
plot(t,(f78(2,:)-f_analytic),'g-','DisplayName','ODE78','LineWidth',2);
plot(t,(f89(2,:)-f_analytic),'b-','DisplayName','ODE89','LineWidth',2);
lgd = legend();
lgd.FontSize = 18;

%title("Numerical methods error in comparison to Analyitcal Solution",'FontSize',18)
xlabel('\eta','FontSize',16);
ylabel('error','FontSize',16);
%}
%% Computing u and v
fp1 = eta > eta_max;

F = f89(2,1:index_eta_max);
T = t(1:index_eta_max);

fp2 = zeros(size(eta,1), size(eta,2));
f = zeros(size(eta,1), size(eta,2));
for i=1:1:size(eta,2)
    fp2(:,i) = interp1(T,F,eta(:,i)) .* (eta(:,i) < eta_max);
    f(:,i) = interp1(T,F,eta(:,i));
end

fp1(isnan(fp1))=0;
fp2(isnan(fp2))=0;
f(isnan(f))=0;

fp = fp1 + fp2;

u = U_e .* fp;
v = nu .* tickness(x,U_e,nu) .* (eta .* fp - f);

U_mag = sqrt(u.^2 + v.^2);

%% Plotting u
%{
hold on
contourf(x,y,u,50,'edgecolor','none');
cb = colorbar;
cb.Label.String = 'u';
cb.Label.FontSize=18;
colormap spring;
xlabel('x','FontSize',16);
ylabel('y','FontSize',16);
%}
%% Plotting v
%{
hold on
contourf(x,y,v,50,'edgecolor','none');
cb = colorbar;
cb.Label.String = 'v';
cb.Label.FontSize=18;
colormap spring;
xlabel('x','FontSize',16);
ylabel('y','FontSize',16);
%}

%% shear stress
%{
taus = tau(x,U_e,1.7*(10^-5),1.2,G);
plot(x,taus,'LineWidth',2);
xlabel('x','FontSize',16);
ylabel('\tau','FontSize',16);
%}
%% Cf

CF = Cf(x ,mu,rho, U_e,G);
plot(x,CF,'LineWidth',2);
ylabel('C_f','FontSize',16);
xlabel('x','FontSize',16);

%% Integran
fun = @(nx) tau(nx,U_e,1.7*(10^-5),1.2,G);

q = integral(fun,0.00,1);

%%
%{
plot(u,y,'LineWidth',2)
legend('x = 0.05 m','x = 0.10 m', 'x = 0.15 m', 'x = 0.20 m','x = 0.25 m','FontSize',16)
xlabel('U(m/s)',"FontSize",18);
ylabel("y(m)","FontSize",18);
%}