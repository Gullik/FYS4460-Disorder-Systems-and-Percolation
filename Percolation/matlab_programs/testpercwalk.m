%
% testpercwalk.m
% Modified to also find log R^2 as a function of the number of steps it has taken
% and do it several times to produce plots
%
% Generate spanning cluster (l-r spanning)

%Clear all figures and databanks
close all




lx = 100;
ly = 100;
p = 0.59274;
% p = 1.0;
trialCounter = 0;
probabilityCounter = 1;
N = 4;      %The number of probabilities we want to try

nstep = 1e5;
nnstep = nstep + 1;
rSquaredValues = zeros(N,1e5 + 1);


probToTry = zeros(0,N);



for i = 1:N
    probToTry(i) = p;
    p = p + 0.1;
end

% % We need to cycle through different sets of probability values
for k = 1:N
    
    p = probToTry(k);
    rSquared = zeros(1,nnstep);


    
%Starts tests which continues for N trials, then the results are averaged
%to produce smoother plots
    
    
    trialcounter = 0;
    for N = 1:1000
        
        
        ncount = 0;
        perc = [];
        while (size(perc,1)==0)
            ncount = ncount + 1;

            if (ncount>1000)
                return
            end
            z=rand(lx,ly)<p;
            [lw,num]=bwlabel(z,4);

            perc_x = intersect(lw(1,:),lw(lx,:));
        %     'Self avoiding paths'
            perc = find(perc_x>0);
        end

        s = regionprops(lw,'Area');

        clusterareas = cat(1,s.Area);
        maxarea = max(clusterareas);
        i = find(clusterareas==maxarea);
        zz = lw == i;
        % zz now contains only the spanning cluster
%         imagesc(zz),axis equal,axis tight

        rz = 1.0*zz;
        n = 1;
        while (n<=1)
            r = rand(nnstep,1);
    %         fprintf(' \n Hello \n \n')
            [w,n] = percwalk(rz,r,0);
        end

        %Note to self: x and y is the positions at step n
        x = w(1,:);
        y = w(2,:);

%         hold on   
%         plot(y,x);
%         hold off

        %Finds out how long it has travelled and the finds R^2
        rx = x - x(1);
        ry = y - y(1);
        rSquared = rSquared + sqrt(rx.^2 + ry.^2);
        trialCounter = trialCounter + 1;
        
    end
%     rSquared = rSquared./trialCounter;
    rSquaredValues(probabilityCounter,:) = 1*rSquared;
    probabilityCounter = probabilityCounter + 1 ;
    
end

    nSpace = linspace(0,n,n);
    
    %Regular plot
    figure()
    plot(nSpace,rSquaredValues(1,:));
    
    hold on
    plot(nSpace,rSquaredValues(2,:));
    plot(nSpace,rSquaredValues(3,:));
    plot(nSpace,rSquaredValues(4,:));
    legend(sprintf('p = %f', probToTry(1)), sprintf('p = %f', probToTry(2)) ,sprintf('p = %f', probToTry(3)), sprintf('p = %f', probToTry(4)))
    hold off
    
    
    %Log plot
    figure()
    semilogy(nSpace,rSquaredValues(1,:));
    
    hold on
    semilogy(nSpace,rSquaredValues(2,:));
    semilogy(nSpace,rSquaredValues(3,:));
    semilogy(nSpace,rSquaredValues(4,:));
    legend(sprintf('p = %f', probToTry(1)), sprintf('p = %f', probToTry(2)) ,sprintf('p = %f', probToTry(3)), sprintf('p = %f', probToTry(4)))
    hold off
    
    %LogLog plot
    figure()
    loglog(nSpace,rSquaredValues(1,:))
    hold on

    loglog(nSpace,rSquaredValues(2,:));
    loglog(nSpace,rSquaredValues(3,:));
    loglog(nSpace,rSquaredValues(4,:));
    legend(sprintf('p = %f', probToTry(1)), sprintf('p = %f', probToTry(2)) ,sprintf('p = %f', probToTry(3)), sprintf('p = %f', probToTry(4)))
    hold off

    
    


