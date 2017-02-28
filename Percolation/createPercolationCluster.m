%This function takes a given probability and size and returns a filled
%percolation cluster array, it can also plot the 


function [lw,num] = createPercolationCluster(prob, z, size, plot)

    r = rand(size,size);
%     r = z;
    
    
    z = r < prob;
    
    [lw,num] = bwlabel(z,4);
    
    if(plot)
       %Plotting to see that it check out
        img = label2rgb(lw,'jet','k','shuffle');
        image(img);
    end

    