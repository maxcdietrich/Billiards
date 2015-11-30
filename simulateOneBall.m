function timeSeries = simulateOneBall(initial_x, initial_y, initial_v, angle)

    %Given Values
    rollingFrictionCoefficient = 0.01; % do more research
    ballMass = 0.17; %Kg
    g = 9.8;    %m/s^2
    normalForce  =ballMass * g; %Newtons
    ball_radius = 0.028575; %meters
    
    %chosen Values
    initial_time = 0; %seconds
    final_time = 60; %seconds
    
    %caluclated values
    initial_vx = initial_v * cosd(angle);
    initial_vy = initial_v * sind(angle);
    
    %ode45
    % higher values of refine calculates at more points
    refine = 4;
    options = odeset('Events', @events, 'Refine', refine);
    
    Time_all = [];
    X_all = [];
    Y_all = [];
    Vx_all = [];
    Vy_all = [];
        
    for i = 1:100
        [Time, Results] = ode45(@netFlows, [initial_time; final_time], [initial_x; initial_y; initial_vx; initial_vy], options);
        X = Results(:,1);
        Y = Results(:,2);
        Vx = Results(:,3);
        Vy = Results(:,4);
        
        Time_all = [Time_all; Time];
        X_all = [X_all; X];
        Y_all = [Y_all; Y];
        Vx_all = [Vx_all; Vx];
        Vy_all = [Vy_all; Vy];
        
        xEnd = X(end);
        yEnd = Y(end);
        vxEnd = Vx(end);
        vyEnd = Vy(end);
        tEnd = Time(end);
        
        initial_x = xEnd;
        initial_y = yEnd;
        initial_vx = vxEnd;
        initial_vy = vyEnd;
        initial_time = tEnd;
        
              
        if (hasBallStopped(vx, vy))
            break
        end
        if (isHittingTopWall(xEnd, yEnd, vxEnd, vyEnd, ball_radius))
            initial_vy = hitHorizontalWall(vyEnd);
        end
        if (isHittingBottomWall(xEnd, yEnd, vxEnd, vyEnd, ball_radius))
            initial_vy = hitHorizontalWall(vyEnd);
        end
        if (isHittingLeftWall(xEnd, yEnd, vxEnd, vyEnd, ball_radius))
            initial_vx = hitVerticalWall(vxEnd);
        end
        if (isHittingRightWall(xEnd, yEnd, vxEnd, vyEnd, ball_radius))
            initial_vx = hitVerticalWall(vxEnd);
        end
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

        
        