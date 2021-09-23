% Despite this method will give you the solution very quickly,  this is not recommended because there could be a case (Initial Value of Initial Capital Stock) for which it won't solve.  

[alpha, s, delta] = deal(0.5, 0.3, 0.1) ;  %Parameter , Savings Rate and Depreciation rate
% define production function
f = @(k) k.^alpha;
h = @(k) s*f(k)-delta*k;
k0 = input("Enter the value of initial Capital Stock = "); % inital guess
options = optimset('Display','iter'); % display iterations
ksteady = fsolve(h,k0,options);

