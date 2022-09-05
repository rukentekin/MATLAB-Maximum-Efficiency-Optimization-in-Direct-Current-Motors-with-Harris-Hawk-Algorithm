clc;
clear;
close all;
tic
%% Problem Definition

CostFunction = @(x)Sphere(x);  % Cost Function

nVar = 3;  %  Number of unkoown variable

VarSize = [1 nVar];   % Matrix size of Decision Veriables

VarMin = [0 0 0] ;       % Lower Bound of Decision Variables 
VarMax = [1 1 1] ;       % Upper Bound of Decision Variables

%% Parameter of PSO

MaxIt = 50;            %Maximum number of Iterations

nPop = 50;              % Population Size

w =1 ;    % Inirtia Coefficient 
wdamp= 0.99; % Damping of inirtia Coefficient
c1 = 2 ;  % Persional accelration coefficient
c2 = 2 ;  % Global Accelaration Coefficient


%% Initilization 

% The Partical Template 
empty_partical.Position =[];
empty_partical.Velocity = [];
empty_parical.Cost = [] ;
empty_partical.Best.Position = [];
empty_partical.Best.Cost = [];

% Create Population Array
partical =repmat(empty_partical,nPop,1);

% Initialize Global Best
GlobalBest.Cost= inf ;

% Initilication of Population
for i=1:nPop
    % Genrate Random Solution 
    partical(i).Position = unifrnd( VarMin, VarMax, VarSize); 
    
    % Initilization of Velocity 
    partical(i).Velocity = zeros(VarSize);
    
    % Evaluation 
    partical(i).Cost = CostFunction(partical(i).Position);
    
    % Update the position Best 
    partical(i).Best.Position = partical(i).Position;
    partical(i).Best.Cost = partical(i).Cost;
    
    % Update the Global Best
    if partical(i).Best.Cost < GlobalBest.Cost  
        GlobalBest= partical(i).Best;
    end
    
end

% Array to Hold Best Cost Value in each Iteration
BestCosts = zeros(MaxIt,1);

%% Main Loop of PSO

for it=1:MaxIt
    
    for i= 1:nPop
       % Update Velocity
        partical(i).Velocity = w*partical(i).Velocity ...
           + c1*rand(VarSize).*(partical(i).Best.Position-partical(i).Position)...
           + c2*rand(VarSize).*(GlobalBest.Position-partical(i).Position);
       
       % Update Position
       partical(i).Position = partical(i).Position + partical(i).Velocity;
      
       partical(i).Position = round(partical(i).Position,10);
       % Evaluation
       partical(i).Cost= CostFunction(partical(i).Position);
       
       % Update Personal Best
       if partical(i).Cost < partical(i).Best.Cost
           
           partical(i).Best.Position = partical(i).Position;
           partical(i).Best.Cost = partical(i).Cost;
          
           % Update the Global Best
           if partical(i).Best.Cost < GlobalBest.Cost  
                GlobalBest= partical(i).Best;
           end
           
       end
       
    end
    % Store Best Cost Value
    BestCosts(it) = GlobalBest.Cost;
    
    % Display Itration Information
    disp(['Iteration ' num2str(it) ': Best Cost =' num2str(BestCosts(it))]);
    
    % Damping of Inirtia Coefficient
    w=wdamp*w;
end

%% Results

figure;
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
toc
