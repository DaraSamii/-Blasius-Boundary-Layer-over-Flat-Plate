function root = shootingMethod(inputFunction, initialGuess, tolerance)
    % Input:
    %   inputFunction: The function whose root needs to be found.
    %   initialGuess: An initial guess for the root.
    %   tolerance: Tolerance for the root-finding algorithm.
    % Output:
    %   root: The root of the input function.

    % Initialize variables
    x0 = initialGuess;
    dx = 1e-6; % Step size for numerical differentiation
    maxIterations = 1000;

    % Main loop of shooting method
    for iteration = 1:maxIterations
        % Evaluate the function and its derivative at the current guess
        f = inputFunction(x0);
        dfdx = (inputFunction(x0 + dx) - f) / dx;

        % Update the guess using the Newton-Raphson method
        x0 = x0 - f / dfdx;

        % Check for convergence
        if abs(f) < tolerance
            root = x0;
            return;
        end
    end
end