function isBallStopped = hasBallStopped(vx, vy, tolerance)
%   determines if a ball is stopped
    isBallStopped = abs(vx) + abs(vy) <= tolerance; 
end