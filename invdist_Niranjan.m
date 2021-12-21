

%Solution_Niranjan_Assignment-4 
%part-d 


%%Construct a function which takes any input 

function invdi= invdist(Pi, Nz)
tic
%take user input for Pi(Transition Matrix) and Nz(Number of states)
Pi = input ('Enter Pi =');    %%Enter the given Pi matrix = [0.9 0.1; 0.1 0.9]
Nz = input('Enter Nz =');     %%Enter the given Nz value  =  2 

%rand (m,n )command in matlab generates matrix of size m*n of random entries. 
  Z_random = rand(1, Nz);
  
%bsxfun works as a element-wise binary operator to do multiple things. Here @times has
%operation is getting performed on array Z and new array whose elements are
%1/sum of Z in each column.  

% Here we are adding random matrix Z elements and then writing it [1/sum, 1/sum] and multiplying with it's transpose to Z. 
  Z_guess = bsxfun(@times,Z_random,1./sum(Z_random,2));
  
 %%parameters 
  i =0;    %iteration parameter
  prec = 0.00001;   %parameter 
  dist = 2*prec;
  %Loop condition for matrix where Z will converge 
while (dist>prec)
    
   Z_new = Z_guess ;   %%Saving new Z each time in Z_new 
   Z_guess = Z_new*Pi; %%Transition matrix (Markov Process)
   
   %Checking for convergence
   dist = norm(Z_guess - Z_new); 
   
end
   % Function will return finally as output 
   invdi=Z_new;
   toc
end 


    





       
 