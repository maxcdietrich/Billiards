function isBallStopped = hasBallStopped(vx, vy)
%   determines if a ball is stopped
    isBallStopped = abs(vx) + abs(vy) == 0; 
end