

clc
clear
close all
global beta alpha delta A sigma 

%Parameters given in question
beta=0.99;             
alpha=0.34;     
sigma=2;
A=1;
delta=0.025;

%Calculating Steady State
ks=((A*alpha*beta)/(1-beta+(delta*beta)))^(1/(1-alpha)); %From (3) solution
klb=0.1*ks; %Defining lower bound for ktgrid
kub=2*ks; %Defining upper bound for ktgrid
SS=['The value of the steady state: ', num2str(ks)];
disp(SS);
in=zeros(1,100);

%initializing arrays
nk=100;
kt=linspace(klb,kub,nk); %grid for capital
cons=zeros(1,100); %matrix for consumption for every k and k' or k(i) and k(j) value
vext=zeros(1,100); %Belman Equation
v=zeros(1,100); 
tv=zeros(1,100);
u=[0,0,0,0,0,0,0,0,0,0];
v=repelem(u, 10); %starting guess of 0 for all values of k 

%Answer 4: Value Function Iteration
e=1; 
iter=0; %initialize iteration counter
  while(e>0.000001)
    for i=1:100
        vext=zeros(1,100);
        for j=1:100
          c=A*(kt(i)^alpha)+ (1-delta)*kt(i) - kt(j); %calculating consumption
        if c<=0
         cons(j)=0; %storing value in consumption matrix
        else 
         cons(j)=c; %storing value in consumption matrix
        end
         vext(j)=((cons(j)^(1-sigma))/(1-sigma)) + (beta*v(j)); %updating V grid
        end
        tv(i)=max(vext); 
   
    for j=1:100
            if tv(i)==vext(j)
               in(i)=j;
            end  
        end
     end
    e=norm(tv-v); %updating distance 
    v=tv;  %updating value function guess 
    iter=iter+1; %updating iteration
  end
  
  for i=1:100
      g(i)=kt(in(i)); %updating policy function
  end
  
  Iter=['Iterations needed to converge: ', num2str(iter)];
  disp(Iter);      

  
%Question 6: Graph for VFI
figure(1)
subplot(1,2,1)
plot(kt,g,'r',kt,kt,'b','LineWidth',2)
title('Decision rule for k')
xlabel('k') 
ylabel('g(k)') 
legend("approximate k'",'k')
subplot(1,2,2)
plot(kt,v,'LineWidth',2)
title('Value Function')
legend('Solved V(k)')
xlabel('k') 
ylabel('V(k)') 


%Question 7: Simulation for VFI Model
k0 = 0.1*ks; %given k0
kdash=zeros(1,200); %capital grid
ct=zeros(1,200); %consumption grid
kdash(1)=k0; %initializing kdash 
t=linspace(1,200,200); %grid for time

for i=1:200 %updating ct and kt for every t from 1 to 200
    [val,idx]=min(abs(kt-kdash(i))); %finding closest value in kt to simulated k
    kdash(i+1)=g(idx); %storing value of policy function simulated k
    ct(i)=cons(idx); %storing value of consumption for simulated k
end
kdash(201) = []; %deleting extra element from kdash array

%plotting graph
figure(1)
plot(t,ct,'g',t,kdash,'b','LineWidth',1)
title('Consumption and Capital Stock Simulation')
xlabel('time') 
ylabel('ct and kt') 
legend("consumption c(t)'",'capital k(t)')

%end
