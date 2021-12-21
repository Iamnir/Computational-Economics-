clc
clear
close all
global sigma

%start timer to measure execution time (excluding figures)
tic

%parameters
sigma=2;
alpha=0.34;
beta=0.99;
delta=0.025;

%define grid size for k
nk=100;
maxiter=500;

%initialize grids
k=zeros(1,nk);
v=zeros(1,nk);
g=zeros(1,nk);
vext=zeros(nk,nk);
vnew = zeros(1,nk);

%steady state capital and bounds on grid
kss = ((1-beta*(1-delta))/(alpha*beta))^(1/(alpha-1)); 
klb=0.1;
kub=40;

%define grid for k, compute true value and policy
for i=1:nk
    k(i)=klb+(i-1)*(kub-klb)/(nk-1); 
end
%Start value function iteration
enditer=0;
iter=0;
while (enditer==0)
    iter=iter+1;
    
    for i=1:nk
        for j=1:nk
            c= max((k(i))^alpha - k(j) + (1-delta)*k(i),0);
            vext(i,j)= ((c^(1-sigma))/(1-sigma)) + beta*v(j);
        end
    end
    
    for i=1:nk
        [vnew(i),g(i)]=max(vext(i,:));
    end
    conver=max(abs(v-vnew));
    v=vnew;
    fprintf('Convergence of V (max) = %.8f\n', conver)
    
    if (conver < 10^(-5) || iter>maxiter)
        enditer=1;
    end
end

for i=1:nk
    policy(i)=k(g(i));
end


toc

figure(1)
subplot(1,2,1)
plot(k(1:nk),g(1:nk),'r',k(1:nk),k(1:nk),'k',k(1:nk),policy(1:nk),'b','LineWidth',2)
legend('k^\prime','k','approximate k^/prime')
title('Decision rule for the grid for k')
xlabel('k') 
ylabel('g(k)') 
subplot(1,2,2)
plot(k(1:nk),v(1:nk),'*r',k(1:nk),v(1:nk),'LineWidth',2)
legend('v','approximate v')
title('Value Function')
xlabel('k') 
ylabel('v(k)') 
axis([k(1) k(nk) v(1) v(nk)])