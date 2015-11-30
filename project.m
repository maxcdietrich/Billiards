function projection = project(A, B)
%   Takes the projection of a vector A onto vector B
%   Will be used to find direction and magnitude of velocity in the
%   direction of the wall

    projection = (dot(A, B) / dot(B, B)) * B;
end
