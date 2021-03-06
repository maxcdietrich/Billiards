function isCollisionHappening = isHittingBottomWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius, tableLength, tableWallThickness)
%   Determines if a ball is colliding with the bottom wall
    bottomWall_y = 0 + tableWallThickness;
    distanceToWall = ball_y - bottomWall_y;
    isBallMovingTowardWall = ball_vy < 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end

    
