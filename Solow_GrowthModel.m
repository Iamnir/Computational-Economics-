%Program to plot simple solow's growth model (Without labor and technolgy growth) 

clear;
close all;

alpha = 0.5;            %Parameter 
s=0.3;                  %Savings Rate 
delta = 0.1;            %Depreciation rate
Nk =20;                   %Number of gridpoints 
K_t = linspace(0,12,Nk);  %Range of Capital Stock in [0, 12] equally spaced 20 values or gridpoints in [0,12] 

% Answer Part-a (i)

% Calculate Yt for every grid point 
Y_t = K_t.^alpha;           %Output function & (.) for element wise array operation 

% Calculate Kt+1 for every grid point 
K_tplus1 = (1-delta)*K_t+s*Y_t;  %K_[t+1] or Next period capital stock equation 

%Answer Part-a, (ii) Phase diagram 
figure(1);   
plot(K_t, K_tplus1,'k' ,'Linewidth',2); 
hold on 
plot (K_t, K_t,'color', 'r', 'LineStyle','--' );
hold off

%In above line, first K_t vs K_tplus1 is plotted. To Plot 45 degree line along with this
%we have multiple ways. Here I have plotted  grid in equal space. Other
%ways to do that like 'plot(1, max(K_t))' etc. 

legend('K_{t+1}', '45º line', 'Location', 'southeast')
title ('Phase Diagram associated with K_{t}');
xlabel('K_t')
ylabel('K_{t+1}')
axis equal 
xlim([0 12])
xticks([0 6 12])
xticklabels({'K_t = 0','K_t= 6','K_t= 12'}) %labelling x-axis or K_t at these three points
ylim([0,12])
hold on 


% Combine Plots for Total Savings, Total Depreciation & Total Output Vs K_{t}
figure (2) ;
total_savings = s*Y_t;               %Total Savings 
total_depreciation = delta*K_t;      %Total deperication 
total_output = Y_t;                  %Total Output 

tiledlayout(3,1)                 
%To combine three plots in one figure we can use this in-built function
%'tiledlayout(m,n)' where m*n figures can be shown in one kernal but here it is redundent since I'm plotting on same K_{t} scale.

plot (K_t, total_savings, 'm', K_t, total_depreciation,'k', K_t, total_output, 'c','Linewidth', 2);
legend('Total Savings','Total Depreciation','Total Output', 'Location', 'southeast');
title('Total Savings, Total Depreciation & Total Output Vs K_{t}') 
xlabel('K_{t}')
ylabel('Savings, Depreciation & Output')
xlim([0,12])
ylim([0,4])

%part-b 
% K_tplus1 = K_t = Kss and we solve for Kss(Steady-State Capital Stock) 
% Kss = (1-delta)Kss+ s*((K_t)^alpha)
% (1-1+delta)*Kss = s*((K_t)^alpha)

%Extraa
Kss = power(s/delta, 2);   %steady state capital stock after solving above equation
wgt =1;
prec = 0.00001;
dist = 2*prec;
Kss2 = 1;
while(dist>prec) 
    TKss2 = (1-delta)*Kss2 + s*Kss2.^alpha; 
    dist = abs(TKss2- Kss2); 
    Kss2 = wgt*TKss2+(1-wgt)*Kss2;  
    disp(dist);
    fprintf('Steady state convergence distance = %.8f\n', dist)
end
format long % Just to show how precise steady state output and consumption is
disp(TKss2) %display steady state capital using this convergence method
Yss2 = TKss2^alpha; %Steady-state Output value using steady-state capital TKss2 (derived using intial value Kss2=1)
Css2 = (1-s)*Yss2; %Steady-state consumption value 

Y = sprintf('%s is steady-state output and %d steady-state consumption.\n',Yss2,Css2);
% To display steady-state output and steady-state consumption together 
disp(Y);

Kss3 = 12;
wgt =1;
prec = 0.00001;
dist = 2*prec;

while(dist>prec) 
    TKss3 = (1-delta)*Kss3 + s*Kss3.^alpha; 
    dist = abs(TKss3- Kss3); 
    Kss3 = wgt*TKss3+(1-wgt)*Kss3;  
    disp(dist);
    fprintf('Steady state convergence distance = %.8f\n', dist)
end 
disp(TKss3) %display steady state capital using this convergence method

Yss3 = TKss3^alpha; %Steady-state Output value using steady-state capital TKss2 (derived using intial value Kss2=1)
Css3 = (1-s)*Yss3; 
%No,the answer does not change when we change intial guess to 12. In Workspace we can see 
%that value of TKss2 and TKss3 are equal also steady-state output and
%steady-state consumption is same. This also tells us that steady-state is
%globally stable so irrespective of initial point(K_t>0) in the long run we
%will move to steady-state. 
X = sprintf('%s is steady-state output and %d steady-state consumption.\n',Yss3,Css3); 
% To display steady-state output and steady-state consumption together
disp(X);








 
