function y = schuldt_func_v0(x)
	lambda = 0.0001;
	y = schuldt_func(x) + (lambda/2)*norm(x)^2;
end