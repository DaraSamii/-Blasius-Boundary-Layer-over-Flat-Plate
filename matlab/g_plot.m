x = linspace(0,1,100);

Y = zeros(1,100);
for i=1:size(x,2)
    Y(1,i) = G_find(x(i))+ 1;


end

hold on
plot(x,Y,'LineWidth',2);
plot(0.332057334445899,1,'r*') 
xline(0.332057334445899,'--');
yline(1,'--')
xlabel("initial f''''(\eta=0)");
ylabel("\eta_{final}")

