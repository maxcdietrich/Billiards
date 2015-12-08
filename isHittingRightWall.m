function isCollisionHappening = isHittingRightWall(ball_x, ball_y, ball_vx, ball_vy, ball_radius, tableWidth, tableWallThickness)
    %checks to see if the ball is coliding with the right wall
    rightWall_x = tableWidth - tableWallThickness;
    distanceToWall = rightWall_x - ball_x;
    isBallMovingTowardWall = ball_vx > 0 ;
    isBallIntersectingWall = distanceToWall <= ball_radius;
    isCollisionHappening = isBallMovingTowardWall && isBallIntersectingWall;
end