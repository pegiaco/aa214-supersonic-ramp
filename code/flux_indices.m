function [indices, indices_bc] = flux_indices(i,j)

global nx;
global ny;

% interior domain - without boundaries
if ~ismember(i, [1, nx]) && ~ismember(j, [1, ny])
    indices = [1,2,3,4];
    indices_bc = [];
% bottom wall - without corners
elseif j == 1 && ~ismember(i, [1, nx])
    indices = [1,2,3];
    indices_bc = [4];
% upper wall - without corners
elseif j == ny && ~ismember(i, [1, nx])
    indices = [1,3,4];
    indices_bc = [2];
% inlet - without corners
elseif i == 1 && ~ismember(j, [1, ny])
    indices = [1,2,4];
    indices_bc = [3];
% outlet - without corners
elseif i == nx && ~ismember(j, [1, ny])
    indices = [2,3,4];
    indices_bc = [1];
%corners
elseif j == 1 && i == 1
    indices = [1,2];
    indices_bc = [3,4];
elseif j == 1 && i == nx
    indices = [2,3];
    indices_bc = [1,4];
elseif j == ny && i == 1
    indices = [1,4];
    indices_bc = [2,3];
elseif j == ny && i == nx
    indices = [3,4];
    indices_bc = [1,2];
end

end

