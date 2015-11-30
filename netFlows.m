function timeSeries = simulateOneBall()

    %Given Values
    rollingFrictionCoefficient = 0.01; %
    ballMass = 0.17; %Kg
    g = 9.8;    %m/s^2
    normalForce  =ballMass * g; %Newtons
    
    %chosen Values
    
    
    %caluclated values
    
    
    function velocity = netFlows(~, state)

        x= state(1);
        y  = state(2);
        vx = state(3);
        vy = state(4);

        %Friction
        frictionForce = rollingFrictionCoefficient * normalForce;
        force_x = frictionForce * x_component(vx, vy);
        force_y = frictionFroce * y_component(vx, vy);
        
        %netFlows
        deltaX = vx;
        deltaY = vy;
        deltaVx = force_x
        deltaVy
        
    end
    
    function component = x_component(x, y)
       component = x / sqrt(x^2 +y^2);
    end

    function component = y_component(x, y)
       component = y / sqrt(x^2 +y^2);
    end

        
        