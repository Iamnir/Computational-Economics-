%%Solution_Niranjan_Assignment_4_Part-d 

%Given Variables 
beta = 0.99;         %subjective discounting factor
sigma = 2;           %Elasticity of intemporal substitution (1/sigma)
alpha = 0.34;        %parameter or capital share in production function 
delta = 0.025;       %depreciation rate 
n_grid = 100;        %Number of grid points 
K_lower = 0.01;      %Lower bound of Capital 
K_upper= 5;          %Upper bound of Capital 
Z = [1.0 0.1]; 

%linearly spaced K
K_grid = linspace(K_lower, K_upper, n_grid);

%Transition probability matrix 
Pi = [0.9 0.1; 0.1 0.9];

%Grids initialization 
V_in = zeros(2,n_grid);                  %Initial Value of Value function 
C_grid= zeros(1,n_grid);                 %Initialzation of Consumption Matrix 
V_Out=zeros(1,n_grid);                       %Bellman's equation LHS value function
i_matrix = zeros(2,n_grid);              %To index the values of Policy function 
Tv = zeros(2,n_grid);                    %Maximum values of V_in matrix


%convergence parameters
prec = [0.00001 0.00001];              %precision 
dist = 2*prec     ;                      %distance matrix initializd for condition 
count =0;                                %parameter to count number of iterations 
tic
while(lt(prec,dist))
    count = count+1; 
    V_new= Pi*V_in;                                %Expected Value Function 
     for p = 1:2                                  %First for loop which will run for Nz=2 (Number of states) 
        for i=1:n_grid
                V_OutN= V_Out;                     
                for j=1:n_grid
                    C_New=Z(p)*(K_grid(i)^alpha)+ (1-delta)*K_grid(i) - K_grid(j);
                    if (C_New>=0) && (K_grid(j)<=Z(p)*(K_grid(i)^alpha)+(1-delta)*K_grid(i)) %Checking for constraints on c and k
                       C_grid(j)=C_New; 
                    else 
                       C_grid(j)=0;
                    end
                    V_OutN(j)=((C_grid(j)^(1-sigma))/(1-sigma)) + (beta*V_new(p,j));           %Bellman equation
                end
             [Tv(p,i), i_matrix(p,i)]=max(V_OutN);        %Storing maximum value of Bellman equation
        end
     end 
    for m =1:2
     dist(m) = norm(Tv(m)-V_in(m));                    %Measuring the distance between Tv and V_in vectors 
    end 
     V_in= Tv;                                         %Update the value of V_in
end 
toc 
%%Plot Part-d 
%Making Mesh for Value Function
subplot(2,1,1)
mesh(Z', K_grid',V_in');                               %Taking Transpose of vetors to make the figure similar to one in notes
title('Mesh Plot of Value function with Uncertainity');
ax = gca;
ax.FontSize = 10;
xlabel('Z');
ylabel('K');
zlabel('V(Z,K)');
xlim([0,1])
ylim([0,5])
grid on 
   
 %%Plot part-e 
 %%Now using the i_matrix we have got from max(V_Out), we find policy
 %%function 
  for m=1:2
  for p=1:n_grid
      G(m,p)=K_grid(i_matrix(m,p));                    
  end
  end
  
 subplot(2,1,2)
 mesh(Z', K_grid',G');                               %Taking Transpose of vetors to make the figure similar to one in notes
 title('Mesh Plot of Policy Function with uncertainity');
   ax = gca;
   ax.FontSize = 10;
   xlabel('Z');
   ylabel('K');
   zlabel('G(Z,K)');
   xlim([0,1])
   ylim([0,5])
   grid on 
 
   
 
   
   

   


