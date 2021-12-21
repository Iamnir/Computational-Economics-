
%Assignment-3_VFI_by_Niranjan [2021, Oct] 
%%Question 4 
clear; 
clc

% Given Data 
global beta alpha delta A sigma 
beta = 0.99;                         % Subjective Discouting Factor 
alpha = 0.34;                        % parameter or capital share in production function 
delta = 0.025;                       % depreciation rate
A        = 1;                        % parameter 
sigma = 2 ;                          % 1/sigma  = elasticity of intemporal substitution 
Nk = 100 ;                           % Number of gridpoints 

Ks = ((A.*alpha)./((1/beta)-(1-delta))).^(1/(1-alpha));  % Steady state capital 

kmin = 0.005*Ks;                                %Minimum value of capital to start with effectively zero
kmax = 5*Ks  ;                                  % Maximal or upper bound on K grid 

k = linspace (kmin, kmax, Nk); 

% Convergence tolerance parameters 

prec = 0.0000001;           %precision for which we will apply convergence technique     
dist = 0;                   %distance as  another variable to check the tolerance 
iter =0;                    %defining a variable that we will use in loop 
enditeration = 0;
maxiteration =1000;


%Utility function given 
u= @(c) c^(1-sigma)/(1-sigma); 

% Initialize some vectors to save future calculations 

TV      = zeros(1,Nk);            %An array to store new Value Function or Maximum Value Function
G       = zeros(1,Nk);            %An array to store 
TF      = zeros(1,Nk);
Vext    = zeros(1,Nk);
V       = zeros(1,Nk);

while(enditeration==0)
    iter=iter+1;
    
    for i=1:Nk
        for j=1:Nk
            %compute consumption 
            c= max(k(i)^(alpha)+(1-delta)*k(i)-k(j),0);
            
            %compute value function 
            [Vext(i,j)]= u(c)+beta*V(j);
        end
    end
    
    for i=1:Nk
        %find the maximum value of Vext at K_j 
        [TV(i),G(i)]=max(Vext(i,:));
    end
    
    dist=max(abs(V-TV)); 
 
   %save TV in V array  
    V=TV;
    
    %print distance V(max) for each value of K_j
    fprintf('convergence of V(max)= %.8f\n',dist)
    if (dist <prec || iter>maxiteration)
        enditeration=1;   
    end
    
end

format long                         % Just to show how precise V(max) we can get 

for i=1:Nk
    policy(i) = k(G(i));
end 


% Question 6 Solution 

% Graph the solutions 

figure(1)                                % Name of the kernal which prompts image 
subplot(1,2,1)                           % Subplot to plot multiple (here 2) graphs on one kernal 

%%Plot the graph of approx value of k_prime 

plot(k(1:Nk), G(1:Nk),'k', k(1:Nk),k(1:Nk),'r', k(1:Nk),policy(1:Nk),'b','LineWidth',2)   
hold on 
legend('k^\prime','45^°','Approx values of k^\prime', 'Location', 'southeast')
title('Decision rule for the grid for k')
xlabel('k') 
ylabel('Decision Rule') 
hold off 
xlim([0 200])
ylim([0,200])

%%plot the graph of value function 
subplot(1,2,2)
plot(k(1:Nk),V(1:Nk),'g',k(1:Nk),V(1:Nk),'LineWidth',2)
hold on 
legend('V','approximate V','LineStyle', 'Dash', 'Location', 'southeast')
title('Value Function Vs K')
xlabel('k') 
ylabel('V(k)') 
axis([k(1) k(Nk) V(1) V(Nk)])
hold off

