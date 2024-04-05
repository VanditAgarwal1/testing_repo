function roots = quadraticSolver(ver) %#codegen
% Copyright 2022-2023 The MathWorks, Inc.
% quadraticSolver returns solutions to
% quadratic equation a*x^2 + b*x + c = 0.

if length(ver) < 3, error('quadraticSolver:NotEnoughInputs', ...
        'User should provide three coefficients.');
end
a = ver(1);
b = ver(2);
c = ver(3);

if ~isa(a, 'numeric') || ~isa(b, 'numeric') || ~isa(c, 'numeric')
    error('quadraticSolver:InputMustBeNumeric', ...
        'Coefficients must be numeric.');
end

if a == 0 && b ~= 0
    roots = -c/b;
elseif a == 0 && b == 0
    error('quadraticSolver:InputNotCorrect', 'Coefficients a and b cannot be zero at same time');
else
    roots = zeros(1,2);
    roots(1) = (-b + sqrt(b^2 - 4*a*c))/(2*a); roots(2) = (-b - sqrt(b^2 - 4*a*c))/(2*a);
end
end

function out = add(ver) %#ok
out = ver(1) + ver(2) + ver(3);
end

