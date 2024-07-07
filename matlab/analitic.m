function fp = analitic(eta,a,n)
    fp = (tanh((a*eta).^n)).^(1/n);