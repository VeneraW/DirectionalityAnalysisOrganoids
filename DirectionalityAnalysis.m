function [phi, dir] = DirectionalityAnalysis(file, centre)

% This Matlab script provides a quick analysis of tracks in terms of directionality for single cell trajectories in fish organoids. The script is written by no IT specialists. 
% The script requires *.xml file with tracks of single cells obtained with Trackmate plugin for Fiji and matlab script for fast loading and analysis of these tracks, called MSDanalyzer. Both tools were developed previously by J-Y Tinevez et al., please find references below for documentation and references. 
% The script assumes axis specification in the data such that z coordinate can be omitted, and sample is positioned in X and Y plane.  
% The input parameters for the script are:
% file – path and filename, i.e. My/Own/Path/Tracks.xml
% Centre – X and Y coordinated, corresponding to the centre of an organoid, i.e. [X,Y]
% The script returns:
% Phi – angle in radians of each track 
% Dir – subset of angles which are moving towards the centre of an organoid, selected based on directionality of tracks in each quadrant of a specimen. 

%% Loading tracks from trackmate xml file
[tracks, md] = importTrackMateTracks(file); %tracks structural array organized as track{trackID}(time point, x, y, z), md space and time units 
% Determin and display number of tracks
n_tracks = numel( tracks );
fprintf("Found %d tracks in the file.\n", n_tracks);

%% Finding and plotting length of each track 
for s = 1 : n_tracks
[len(s), M ]=size(tracks{s}(:,:));
end
figure
plot(len)
xlabel("Track number")
ylabel("Length in Time points")

%% Plotting all tracks
figure
hold on
c = jet(n_tracks);
for s = 1 : n_tracks
        x = tracks{s}(:, 2);
        y = tracks{s}(:, 3);
        plot(x, y, ".-", "Color", c(s, :));
end

%% Redefine center for tracks from 0,0 (left top corner of the image) to the center of an organoid, detrmined in Fiji based on 3D stack. 
Org_Cen=tracks;
for s = 1 : n_tracks
    Org_Cen{s}(:,1)=0;
    Org_Cen{s}(:,2)=centre(1);
    Org_Cen{s}(:,3)=centre(2);
    Org_Cen{s}(:,4)=0;
end 

Centered_Tracks=cellfun(@minus,tracks,Org_Cen,'un',0);

%% Angle of tracks only in X,Y plane!
for s = 1 : n_tracks
        phi(s)=atan2((Centered_Tracks{s}(end,3)-Centered_Tracks{s}(1,3)),(Centered_Tracks{s}(end,2)-Centered_Tracks{s}(1,2)));
end

%% Finding to which quadrant belongs each track, 1st quadrant cos + and sin +, 2d quadrant cos - and sin +, etc..
k=0;
for s = 1 : n_tracks
    % Condition to select tracks in the first quadrant only and based on direction of tracks assign fraction of them to inwards 
    if sign(Centered_Tracks{s}(end,3))==1 && sign(Centered_Tracks{s}(1,3))==1 && sign(Centered_Tracks{s}(end,2))==1 && sign(Centered_Tracks{s}(1,2))==1
        if sign(Centered_Tracks{s}(end,3)-Centered_Tracks{s}(1,3))==-1 && sign(Centered_Tracks{s}(end,2)-Centered_Tracks{s}(1,2))==-1
        k=k+1;
        dir(k)=phi(s);
        end
    cmap(s,:)=[1,0,0];
    % Condition to select tracks in the second quadrant only and based on direction of tracks assign fraction of them to inwards 
    elseif sign(Centered_Tracks{s}(end,3))==-1 && sign(Centered_Tracks{s}(1,3))==-1 && sign(Centered_Tracks{s}(end,2))==1 && sign(Centered_Tracks{s}(1,2))==1
        if sign(Centered_Tracks{s}(end,3)-Centered_Tracks{s}(1,3))==-1 && sign(Centered_Tracks{s}(end,2)-Centered_Tracks{s}(1,2))==1
        k=k+1;
        dir(k)=phi(s);
        end
    cmap(s,:)=[1,1,0];
    % Condition to select tracks in the third quadrant only and based on direction of tracks assign fraction of them to inwards 
    elseif sign(Centered_Tracks{s}(end,3))==-1 && sign(Centered_Tracks{s}(1,3))==-1 && sign(Centered_Tracks{s}(end,2))==-1 && sign(Centered_Tracks{s}(1,2))==-1
        if sign(Centered_Tracks{s}(end,3)-Centered_Tracks{s}(1,3))==1 && sign(Centered_Tracks{s}(end,2)-Centered_Tracks{s}(1,2))==1
        k=k+1;
        dir(k)=phi(s);
        end
    cmap(s,:)=[0,1,0];
    % Condition to select tracks in the forth quadrant only and based on direction of tracks assign fraction of them to inwards 
    elseif sign(Centered_Tracks{s}(end,3))==1 && sign(Centered_Tracks{s}(1,3))==1 && sign(Centered_Tracks{s}(end,2))==-1 && sign(Centered_Tracks{s}(1,2))==-1
        if sign(Centered_Tracks{s}(end,3)-Centered_Tracks{s}(1,3))==1 && sign(Centered_Tracks{s}(end,2)-Centered_Tracks{s}(1,2))==-1
        k=k+1;
        dir(k)=phi(s);
        end
    cmap(s,:)=[0,1,1];
    end
end

figure
hold on
for s = 1 : n_tracks
%    if len(s)>=Len_Thr
        x = Centered_Tracks{s}(:, 2);
        y = Centered_Tracks{s}(:, 3);
        plot(x, y, ".-", "Color", cmap(s, :));
%    end
end


%% Plotting outwards and inwards movements. +180 or pi shift comes on the accound of how Fiji takes X and Y coordinates
figure
BinNum=20;
str = '#b8b8b8';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
str = '#5e5e5e';
color2 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
figure(1)
polarhistogram(phi,BinNum,'FaceColor',color)
hold on
polarhistogram(dir,BinNum,'FaceColor',color2,'FaceAlpha',0.8)
hold off
ax = gca;
