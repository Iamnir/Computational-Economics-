
%Assignment-3_PFI_by_Niranjan [2021, Oct] 
% Aditi & I discussed this. 

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

cnew=zeros(1,Nk); 
V=zeros(1,Nk); 
TV=zeros(1,Nk); 
P=zeros(1,Nk); 
gext=zeros(1,100); 

 %%Solving the model using value function iteration method.

  for j=1:3
    for i=1:100
        Vext=zeros(1,100); %Bellman's equation LHS value function
        for j=1:100
          c=A*(k(i)^alpha)+ (1-delta)*k(i) - k(j);  %consumption
        if c<=0  %if statement to reject negative values of c
         cnew(j)=0;
        else 
         cnew(j)=c;
        end
         Vext(j)=((cnew(j)^(1-sigma))/(1-sigma)) + (beta*V(j)); %Bellman equation
        end
        TV(i)=max(Vext); %Storing maximum value of Bellman equation
   
    for j=1:100
            if TV(i)==Vext(j)
               P(i)=j; %Collecting all indexes where V was maximum to retrieve policy function at the end 
            end  
        end
    end
    V=TV;  %Updating the guess
  end
  
   for i=1:100  
      g(i)=k(P(i)); %Retrieving the policy function from our partial TV's convergence so have a good guess
   end

  error=1; %Just want to make the outer while loop run once.
  newerror=1; %Just want to make the 2nd while loop run once
  itnew=0; %To count the number of iterations
  
 while (dist>0.00001) 
    while(dist>0.00001)
 
       %Using g(i) and v(index(i)) to approximate TV
        for i=1:100
        c=A*(k(i)^alpha)+ (1-delta)*k(i) - g(i);
        if c<=0
         cnew(i)=0;
        else 
         cnew(i)=c;
        end
         TV(i)=((cnew(i)^(1-sigma))/(1-sigma)) + (beta*V(P(i)));
        end
        
         error=norm(TV-V);
         V=TV;
    end 
 end 
 for i=1:100
         Vext=zeros(1,100); 
            for j=1:100
            c=A*(k(i)^alpha)+ (1-delta)*k(i) - k(j);  %consumption
              if c<=0  %if statement to reject negative values of c
              cnew(j)=0;
              else 
              cnew(j)=c;
              end
              Vext(j)=((cnew(j)^(1-sigma))/(1-sigma)) + (beta*V(j)); %Bellman equation
             end
        TV(i)=max(Vext); %Storing maximum value of Bellman equation
   
       for j=1:100
            if TV(i)==Vext(j)
               P(i)=j; %Collecting all indexes where V was maximum to retrieve policy function at the end 
               gext(i)=k(j);
            end 
        end
         end
       err=norm(TV-V);
       V=TV;
    
         
    newerr=norm(gext-g);         
       g=gext;
       itnew=itnew+1; 
   
    X=['Converge after ', num2str(itnew), ' iterations'];
  disp(X);