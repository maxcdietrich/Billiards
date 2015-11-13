function isBallSunk = isInPocket(ball_x, ball_y, pocket_x, pocket_y, pocket_radius)
%   Determines if a ball is sunk in a pocket
    isBallSunk = isInCircle(ball_x, ball_y, pocket_x, pocket_y, pocket_radius);
end