function eta_value = Eta_func(x,y,U_e, nu)

    nux = nu .* x;
    Unux = U_e * (nux .^ -1);
    eta_value = y. * sqrt(Unux_T);

end
