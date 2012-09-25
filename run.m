function run(All)
%run all

if (nargin == 0)
    All = 0;
else
    All = 1;
end

%Check wether 'prepair' have run
global CL;
global TestP;

if (isempty(CL))
    fprintf('Run "prepair" first!\n');
else
    fprintf('Creating jwd.txt...\n');
    jwd
    fprintf('Computing the winds on 5 points...\n');
    Wind(TestP);
    fprintf('Computing the region [46, 126]x[40, 40] will take a lot of time\n');
    if (~All)
         fprintf('Assume the data is stored in "WindPreComputedData.mat".  Skip computing.\nuse "run(1) to compute all\n');
    else
        RegionWind([46, 126], [-40,40]);
    end
    
    %Filter points
    W = importdata('WindPreComputedData.mat');
    CheckWind(W);
    fprintf('Computing the pressure...\n');
    t = importdata('temp3.mat');
    PIndex(W, t);
    fprintf('Creating table...\n');
    CreateWindIndexTable(W, 'winsh.txt');
    fprintf('Painting wind flags...\n');
    DrawGoodWindFlags(W);
    %save files
    %fprintf('Saving picture to "winsp.jpg"\n');
    %saveas(gcf, 'winsp.jpg');
end