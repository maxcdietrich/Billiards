function timeSeries = simulateTwoBalls(Initial_X, Initial_Y, Initial_V, Angle, tableWidth, tableLength, tableWallThickness)

    %Given Values
    rollingFrictionCoefficient = 0.4; % do more research
    ballMass = 0.17; %Kg
    g = 9.8;    %m/s^2
    normalForce  =ballMass * g; %Newtons
    ball_radius = 0.028575; %meters
    
    %chosen Values
    initial_time = 0; %seconds
    final_time = 30; %seconds
    time_step = 0.001; %seconds
    tolerance = 0.02; % threshold velocity to consider a ball stopped. m/s
    
    %caluclated values
    Initial_Vx = Initial_V * cosd(Angle);
    Initial_Vy = Initial_V * sind(Angle);
    number_of_balls = length(Initial_X);
    
    Time_all = (initial_time: time_step: final_time)';
    X_all = zeros(length(Time_all), 1, number_of_balls);
    Y_all = zeros(length(Time_all), 1, number_of_balls);
    Vx_all = zeros(length(Time_all), 1, number_of_balls);
    Vy_all = zeros(length(Time_all), 1, number_of_balls);
    X_all(1) = Initial_X;
    Y_all(1) = Initial_Y;
    Vx_all(1) = Initial_Vx;
    Vy_all(1) = Initial_Vy;
    
        
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
        if (isHittingTopWall(x, y, vx, vy, ball_radius, tableLength, tableWallThickness))
            [vx, vy] = hitHorizontalWall(vx, vy);
        end
        if (isHittingBottomWall(x, y, vx, vy, ball_radius, tableLength, tableWallThickness))
            [vx, vy] = hitHorizontalWall(vx, vy);
        end
        if (isHittingLeftWall(x, y, vx, vy, ball_radius, tableWidth, tableWallThickness))
            [vx, vy] = hitVerticalWall(vx, vy);
        end
        if (isHittingRightWall(x, y, vx, vy, ball_radius, tableWidth, tableWallThickness))
            [vx, vy] = hitVerticalWall(vx, vy);
        end
        
        X_all(t) = x;
        Y_all(t) = y;
        Vx_all(t) = vx;
        Vy_all(t) = vy;
        
    end  
    
    % For loop breaks after t steps.
    % We want the first t-1 elements of each vector
    Time =  Time_all(1 : t-1);
    X = X_all(1 : t-1);
    Y = Y_all(1 : t-1);
    Vx = Vx_all(1 : t-1);
    Vy = Vy_all(1 : t-1);
    timeSeries = [Time, X, Y, Vx, Vy];
                        
       
    function component = x_component(x, y)
       component = x / sqrt(x^2 +y^2);
    end

    function component = y_component(x, y)
       component = y / sqrt(x^2 +y^2);
    end
end