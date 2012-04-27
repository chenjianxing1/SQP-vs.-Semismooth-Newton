function [x_ssn,it_ssn,t_ssn,x_sqp,it_sqp,t_sqp] = test_rosenbrock_func(show)
    lambda = 0.001;
    a = [-10; -10];
    b = [10; 10];
    x0 = [-1; 2];
    m0 = zeros(2,1);
    tol = 0.0000001;
    itmax = 100;
    tic;
    %[x_ssn,fval_ssn,it_ssn] = active_set_strategy('rosenbrock_func','grad_rosenbrock_func','hess_rosenbrock_func',lambda,a,b,x0,m0,itmax,tol);
    %[x_ssn,fval_ssn,it_ssn] = semismooth_newton('rosenbrock_func','grad_rosenbrock_func','hess_rosenbrock_func',lambda,a,b,x0,itmax,tol);
    [x_ssn,fval_ssn,it_ssn] = ssn('rosenbrock_func','grad_rosenbrock_func','hess_rosenbrock_func',lambda,a,b,x0,itmax,tol);
    t_ssn = toc;
    x1 = sprintf('%.3f ',x_ssn);
    f1 = sprintf('f(x_ssn) = %.3f',fval_ssn);
    t1 = sprintf('solved in %.2f ms.',t_ssn*1000);
    str1 = ['x_ssn = [ ', x1, '], ', f1, ', it = ', num2str(it_ssn), ', ', t1];
    A = [ -eye(length(a)); eye(length(b)) ];
    c = [ -a; b ];
    tic;
    [x_sqp,fval_sqp,it_sqp] = seq_quad_prog('rosenbrock_func_v0','grad_rosenbrock_func_v0','hess_rosenbrock_func_v0',A,c,x0,itmax,tol);
    t_sqp = toc;
    x2 = sprintf('%.3f ',x_sqp);
    f2 = sprintf('f(x_sqp) = %.3f',fval_sqp);
    t2 = sprintf('solved in %.2f ms.',t_sqp*1000);
    str2 = ['x_sqp = [ ', x2, '], ', f2, ', it = ', num2str(it_sqp), ', ', t2];
    if ( nargin == 0 )
        show = 1;
    end
    if ( show == 1 )
        a = sprintf('%.3f ',a);
        b = sprintf('%.3f ',b);
        x0 = sprintf('%.3f ',x0);
        str0 = ['a = [ ', a, '], b = [ ', b, '], x0 = [ ', x0, ']'];
        disp(str0);
        disp(str1);
        disp(str2);
    end
end
