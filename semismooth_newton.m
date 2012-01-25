## Function: [x,it] = semismooth_newton(f,gradf,hessf,lamda,a,b,x0,itmax,tol)
##
##  Semismooth-Newton-Method solves the problem
##        min ( f(x) + (lambda/2)*|x|^2 )
##         x
##        s.t. a <= x <= b
##
##  Let f : R^n -> R
##  lambda a real number
##  a and b in R^n

function [x,it] = semismooth_newton(f,gradf,hessf,lambda,a,b,x0,itmax,tol)
	x = x0;
	it = 0;
	stop = false;
	
	## Check the stop criteria for x0
	if (norm(feval(gradf,x)) < tol)
		stop = true;
	endif

	while( ~stop )
		it = it + 1;
		A = gra
		b = x - projection( (-1/lambda)*feval(gradf,x), a, b );
		d = feval(hessf,x) \ -feval(gradf,x);
		##sigma = armijo_schrittweite(f, gradf, x, d, 0.75, 4, 0.5);
		##sigma = powell_schrittweite(f, gradf, x, d, 0.01, 0.9);
		x = x + d;
		## Check the stop criteria
		if (norm(feval(gradf,x)) < tol)
			stop = true;
		endif
		% If there are too many iterations
		if (it >= itmax)
			stop = true;
		endif
	endwhile

endfunction


function w = projection(v,a,b)
	## return max(a,min(v,b));
	n = length(v);
	if (length(a) ~= n || length(b) ~= n)
		error ("We have dimension problem here.");
	endif
	for k=1:n
		if (a(k) > b(k))
			error ("It should be a <= b.");
		endif
	endfor
	w = max(a,min(v,b));
endfunction

function w = grad_projection(v,a,b)
	## w_k := 1 if the projection of v_k equals to v_k
	## otherwise w_k := 0
	## for k in {1,...,n}
	w = projection(v,a,b);
	n = length(v);
	for k=1:n
		if (w(k) == v(k))
			w(k) = 1;
		else
			w(k) = 0;
		endif
	endfor
endfunction