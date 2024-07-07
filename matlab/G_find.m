function res = G_find(G)

    [~,f89] = ode89(@blasius,[0 10],[0;0;G]);
    res = f89(end,2) -1;


