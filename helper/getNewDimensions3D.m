function [U1, U2, U3] = getNewDimensions3D(I1, I2, I3, lvl)
    if (lvl == 1)
        U1 = I1; 
        U2 = I2;
        U3 = I3;
    else
        sum = 0;
        for i = 1 : lvl-1
            sum = sum + 2^(i-1);
        end
        U1 = 2^(lvl-1)*I1 - sum;
        U2 = 2^(lvl-1)*I2 - sum;
        U3 = 2^(lvl-1)*I3 - sum;
    end
    
end