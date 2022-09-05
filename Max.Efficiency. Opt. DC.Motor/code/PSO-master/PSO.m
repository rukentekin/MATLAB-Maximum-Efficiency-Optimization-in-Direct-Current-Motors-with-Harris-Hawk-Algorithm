function out = PSO(problem,params)
%% Problem Definition

  % Cost Function

nVar = 3;                 %  Number of unkoown variable

VarSize = [1 nVar];                  % Matrix size of Decision Veriables

VarMin = [0 0 0] ;            % Lower Bound of Decision Variables 
VarMax = [ 1 1 1] ;          % Upper Bound of Decision Variables

%% Parameter of PSO

MaxIt = 50;               %Maximum number of Iterations

nPop = 50;                 % Population Size

w = 1 ;                      % Inirtia Coefficient 

c1 = 2 ;                     % Persional accelration coefficient
c2 = 2 ;                     % Global Accelaration Coefficient
% The Flag For Showing Iteration Info

MaxVelocity = 0.2*(VarMax-VarMin);
MinVelocity = -MaxVelocity ;

%% Initilization

% The Particle Template 
empty_particle.Position =[];
empty_particle.Velocity = [];
empty_paricale.Cost = [] ;
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

% Create Population Array
particle =repmat(empty_particle,nPop,1);

% Initialize Global Best
GlobalBest.Cost= inf ;

% Initilication of Population
for i=1:nPop
    % Genrate Random Solution 
    particle(i).Position = unifrnd( VarMin, VarMax, VarSize); 
    
    % Initilization of Velocity 
    particle(i).Velocity = zeros(VarSize);
    
    % Evaluation 
    particle(i).Cost = CostFunction(particle(i).Position);
    
    % Update the position Best 
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    
    % Update the Global Best
    if particle(i).Best.Cost < GlobalBest.Cost  
        GlobalBest= particle(i).Best;
    end
    
end

% Array to Hold Best Cost Value in each Iteration
BestCosts = zeros(MaxIt,1);

%% Main Loop of PSO

for it=1:MaxIt
    
    for i= 1:nPop
       % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
           + c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position)...
           + c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
       % Apply Velocity Limits
       particle(i).Velocity = max(particle(i).Velocity,MinVelocity);
       particle(i).Velocity = min(particle(i).Velocity,MaxVelocity );
       
       % Update Position
       particle(i).Position = particle(i).Position + particle(i).Velocity;
       
       % Apply Lower and Upper Bound Limits
       particle(i).Position = max(particle(i).Position,VarMin);
       particle(i).Position = min(particle(i).Position,VarMax);
       
       % Evaluation
       particle(i).Cost= CostFunction(particle(i).Position);
       
       % Update Personal Best
       if particle(i).Cost < particle(i).Best.Cost
           
           particle(i).Best.Position = particle(i).Position;
           particle(i).Best.Cost = particle(i).Cost;
          
           % Update the Global Best
           if particle(i).Best.Cost < GlobalBest.Cost  
                GlobalBest= particle(i).Best;
           end
           
       end
       
    end
    % Store Best Cost Value
    BestCosts(it) = GlobalBest.Cost;
    
    if ShowItrInfo
    % Display Itration Information
    disp(['Iteration ' num2str(it) ': Best Cost =' num2str(BestCosts(it))]);
    end
    
    % Damping of Inirtia Coefficient
    w=wdamp*w;
end
  out.population = particle;
  out.BestSol  = GlobalBest;
  out.BestCosts  = BestCosts;
end