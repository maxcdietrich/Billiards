function timeSeries = simulateOneBall(initial_x, initial_y, initial_v, angle)

    %Given Values
    rollingFrictionCoefficient = 0.1; % do more research
    ballMass = 0.17; %Kg
    g = 9.8;    %m/s^2
    normalForce  =ballMass * g; %Newtons
    ball_radius = 0.028575; %meters
    
    %chosen Values
    initial_time = 0; %seconds
    final_time = 30; %seconds
    time_step = 0.001; %seconds
    tolerance = 0.0002; % threshold velocity to consider a ball stopped. m/s
    
    %caluclated values
    initial_vx = initial_v * cosd(angle);
    initial_vy = initial_v * sind(angle);
    

    Time_all = (initial_time: time_step: final_time)';
    X_all = zeros(length(Time_all), 1);
    Y_all = zeros(length(Time_all), 1);
    Vx_all = zeros(length(Time_all), 1);
    Vy_all = zeros(length(Time_all), 1);
    X_all(1) = initial_x;
    Y_all(1) = initial_y;
    Vx_all(1) = initial_vx;
    Vy_all(1) = initial_vy;
    
        
    for t = 2:length(Time_all)
        
 
        previous_x = X_all(t-1);
        previous_y = Y_all(t-1);
        previous_Vx = Vx_all(t-1);
        previous_Vy = Vy_all(t-1);
        
        %Friction
        frictionForce = -rollingFrictionCoefficient * normalForce;
        force_x = frictionForce * x_component(previous_Vx, previous_Vy);
        force_y = frictionForce * y_component(previous_Vx, previous_Vy);
        
        
        %netFlows
        deltaX = previous_Vx;
        deltaY = previous_Vy;
        deltaVx = force_x/ballMass;
        deltaVy = force_y/ballMass;
        

        
        x = previous_x + deltaX * time_step;
        y = previous_y + deltaY * time_step;
        vx = previous_Vx + deltaVx * time_step;
        vy = previous_Vy + deltaVy * time_step;     
         
        
        if (hasBallStopped(vx, vy, tolerance))
             break
        end
        if (isHittingTopWall(x, y, vx, vy, ball_radius))
            [vx, vy] = hitHorizontalWall(vx, vy);
        end
        if (isHittingBottomWall(x, y, vx, vy, ball_radius))
            [vx, vy] = hitHorizontalWall(vx, vy);
        end
        if (isHittingLeftWall(x, y, vx, vy, ball_radius))
            [vx, vy] = hitVerticalWall(vx, vy);
        end
        if (isHittingRightWall(x, y, vx, vy, ball_radius))
            [vx, vy] = hitVerticalWall(vx, vy);
        end
        
        X_all(t) = x;
        Y_all(t) = y;
        Vx_all(t) = vx;
        Vy_all(t) = vy;
        
    end    
       
    timeSeries = [Time_all, X_all, Y_all, Vx_all, Vy_all];
    
    function [value, isterminal, direction] = events(~, State)
        x = State(1);
        y = State(2);
        vx = State(3);
        vy = State(4);
                      
        %when ball velocity equals 0
        value(1) = hasBallStopped(vx, vy) + 0;
        %when ball hits top wall
        %isHittingTopWall returns logical which need to be converted to int
        value(2) = ~isHittingTopWall(x, y, vx, vy, ball_radius) + 0;
        %when ball hits bottom wall
        %isHittingBottomWall returns logical which need to be converted to int
        value(3) = ~isHittingBottomWall(x, y, vx, vy, ball_radius) + 0; 
        %when ball hits left wall
        %isHittingLeftWall returns logical which need to be converted to int
        value(4) = ~isHittingLeftWall(x, y, vx, vy, ball_radius) + 0;
        %when ball hits right wall
        %isHittingRightWall returns logical which need to be converted to int
        value(5) = ~isHittingRightWall(x, y, vx, vy, ball_radius) + 0; 
        
        %all isterminals are true.
        %length of isterminal vector is equal to length of value vector
        isterminal = ones(size(value));
        %all direction are zero.
        %length of direction vector is equal to length of value vector
        direction = zeros(size(value));

    end
    
    function Flows = netFlows(~, State)
        % state = [x, y, vx, vy]

        vx = State(3);
        vy = State(4);

        %Friction
        frictionForce = -rollingFrictionCoefficient * normalForce;
        force_x = frictionForce * x_component(vx, vy);
        force_y = frictionForce * y_component(vx, vy);
        
        
        %netFlows
        deltaX = vx;
        deltaY = vy;
        deltaVx = force_x/ballMass;
        deltaVy = force_y/ballMass;
        
        Flows = [deltaX; deltaY; deltaVx; deltaVy];  
    end
    
    function component = x_component(x, y)
       component = x / sqrt(x^2 +y^2);
    end

    function component = y_component(x, y)
       component = y / sqrt(x^2 +y^2);
    end
end

        
        