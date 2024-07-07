function dydt = blasius(eta, y)
       dy1dt = y(2);
       dy2dt = y(3);
       dy3dt = -0.5 * y(1) * y(3);
       dydt = [dy1dt; dy2dt; dy3dt];