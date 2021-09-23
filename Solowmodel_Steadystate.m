% Despite this method will give you the solution, this is not recommended. 
[alpha, s, delta] = deal(0.5, 0.3, 0.1) ;  %Parameter , Savings Rate and Depreciation rate
% define production function
f = @(k) k.^alpha;
h = @(k) s*f(k)-delta*k;
k0 = input("Enter the value of initial Capital Stock = "); % inital guess
options = optimset('Display','iter'); % display iterations
ksteady = fsolve(h,k0,options);

