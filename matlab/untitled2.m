x = [0.001:0.001:1];
y = [0.001:0.001:0.1];

U_e = 50;
nu = 1.2 * (10^ -4) / 1.2;

[X,Y] = meshgrid(x,y);
eta = Eta_func(X,Y,U_e,nu);


contourf(x,y,log10(eta),50,'edgecolor','none');
cb = colorbar('Ticks',[0,1,2,3,4],...
         'TickLabels',{'0', '10^1','10^2','10^3','10^4'});
cb.Label.String = '\eta';
cb.Label.FontSize=18;
colormap turbo;
xlabel('x','FontSize',16);
ylabel('y','FontSize',16);
