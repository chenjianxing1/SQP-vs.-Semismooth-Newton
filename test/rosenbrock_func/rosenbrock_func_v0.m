function y = rosenbrock_func_v0(x)
	lambda = 0.000000001;
	y = rosenbrock_func(x) + (lambda/2)*norm(x)^2;
end