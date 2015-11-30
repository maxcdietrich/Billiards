function isCollisionHappening = isHittingRightWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius)
%   Determines if a ball is colliding with the bottom wall
    tableWallThickness = 0.1016; %in meters
    tableWidth = 1.2192;
    rightWall_x = tableWidth - tableWallThickness;
    distanceToWall = rightWall_x - ball_x;
    isBallMovingTowardWall = ball_vx > 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end