function [x0, obstacles] = setupEnvironment(setupString)
    switch setupString
        case "no_obs"
            % Setup 01: No obstacles and p(0) = (20, 20)
            x0 = [20; 10; 0; 0];
            obstacles = {};
            
        case "one_obs"
            %Setup 02 one obstacles and p(0) = (10, 14)
            x0 = [10; 14; 0; 0];
            obstacle1.type = "circle";
            obstacle1.center = [5, 7]';
            obstacle1.radius = 3;
            obstacle1.velocity = [0, 0]'; % obstacle velocity in [m/s]
            obstacles = {obstacle1};
            
        case "two_obs"
            % Setup 03 LF one obstacles and p(0) = (10, 14)
            x0 = [10; 14; 0; 0];
            obstacle1.type = "circle";
            obstacle1.center = [3, 12]';
            obstacle1.radius = 3;
            obstacle1.velocity = [0, 0]';
            
            obstacle2.type = "circle";
            obstacle2.center = [6, 5]';
            obstacle2.radius = 3;
            obstacle2.velocity = [0, 0]';
            
            obstacles = {obstacle1,obstacle2};
            
        case "three_obs"
            % Setup 03 one obstacles and p(0) = (10, 14)
            x0 = [10; 14; 0; 0];
            obstacle1.type = "circle";
            obstacle1.center = [5, 11]';
            obstacle1.radius = 3;
            obstacle1.velocity = [0, 0]';

            obstacle2.type = "circle";
            obstacle2.center = [7, 4]';
            obstacle2.radius = 3;
            obstacle2.velocity = [0, 0]';

            obstacle3.type = "circle";
            obstacle3.center = [1, 3]';
            obstacle3.radius = 1;
            obstacle3.velocity = [0, 0]';

            obstacles = {obstacle1,obstacle2,obstacle3};
            
        case "pathological"
            % Pathological cases
            x0 = [10; 10; 0; 0];
            obstacle1.type = "circle";
            obstacle1.center = [5, 5]';
            obstacle1.radius = 2;
            obstacle1.velocity = [0, 0]';
            obstacles = {obstacle1};
            
        case "six_obs"
            % Complex Map, six obstacles
            x0 = [40; 5; 0; 0];
            obstacle1.type = "circle";
            obstacle1.center = [35, 4]';
            obstacle1.radius = 2;
            obstacle1.velocity = [0, 0]';
            
            obstacle2.type = "circle";
            obstacle2.center = [30, -1]';
            obstacle2.radius = 3;
            obstacle2.velocity = [0, 0]';
            
            obstacle3.type = "circle";
            obstacle3.center = [25, 5]';
            obstacle3.radius = 3;
            obstacle3.velocity = [0, 0]';
            
            obstacle4.type = "circle";
            obstacle4.center = [18, 0]';
            obstacle4.radius = 1;
            obstacle4.velocity = [0, 0]';
            
            obstacle5.type = "circle";
            obstacle5.center = [5, -1]';
            obstacle5.radius = 1;
            obstacle5.velocity = [0, 0]';

            obstacle6.type = "circle";
            obstacle6.center = [10, 4]';
            obstacle6.radius = 3;
            obstacle6.velocity = [0, 0]';
            
            obstacles = {obstacle1, obstacle2, obstacle3, obstacle4, obstacle5, obstacle6};

        case "valzer"
            % Complex Map-variable
            x0 = [39.5; 22; 0; 0];

            %corridor circle 1st wall
            obstacle1.type = "circle";
            obstacle1.center = [40, 20]';
            obstacle1.radius = 1;
            obstacle1.velocity = [0, 0]';

            obstacle2.type = "circle";
            obstacle2.center = [39.5, 18.5]';
            obstacle2.radius = 1;
            obstacle2.velocity = [0, 0]';

            obstacle3.type = "circle";
            obstacle3.center = [39,17]';
            obstacle3.radius = 1;
            obstacle3.velocity = [0, 0]';

            obstacle4.type = "circle";
            obstacle4.center = [38.5,15.5]';
            obstacle4.radius = 1;
            obstacle4.velocity = [0, 0]';

            obstacle5.type = "circle";
            obstacle5.center = [38, 14]';
            obstacle5.radius = 1;
            obstacle5.velocity = [0, 0]';

            obstacle6.type = "circle";
            obstacle6.center = [37, 13]';
            obstacle6.radius = 1;
            obstacle6.velocity = [0, 0]';

            obstacle7.type = "circle";
            obstacle7.center = [36, 12]';
            obstacle7.radius = 1;
            obstacle7.velocity = [0, 0]';

            obstacle8.type = "circle";
            obstacle8.center = [34.5, 12]';
            obstacle8.radius = 1;
            obstacle8.velocity = [0, 0]';

            obstacle9.type = "circle";
            obstacle9.center = [33, 12]';
            obstacle9.radius = 1;
            obstacle9.velocity = [0, 0]';
            
            %corridor circle 2nd wall
            obstacle10.type = "circle";
            obstacle10.center = [38-1, 23]';
            obstacle10.radius = 1;
            obstacle10.velocity = [0, 0]';

            obstacle11.type = "circle";
            obstacle11.center = [37.5-1, 21.5]';
            obstacle11.radius = 1;
            obstacle11.velocity = [0, 0]';

            obstacle12.type = "circle";
            obstacle12.center = [37-1,20]';
            obstacle12.radius = 1;
            obstacle12.velocity = [0, 0]';

            obstacle13.type = "circle";
            obstacle13.center = [36.5-1,18.5]';
            obstacle13.radius = 1;
            obstacle13.velocity = [0, 0]';

            obstacle14.type = "circle";
            obstacle14.center = [36-1, 17]';
            obstacle14.radius = 1;
            obstacle14.velocity = [0, 0]';

            obstacle15.type = "circle";
            obstacle15.center = [35-1, 16]';
            obstacle15.radius = 1;
            obstacle15.velocity = [0, 0]';

            obstacle16.type = "circle";
            obstacle16.center = [33.5-1, 16]';
            obstacle16.radius = 1;
            obstacle16.velocity = [0, 0]';

            obstacle17.type = "circle";
            obstacle17.center = [32-1, 16]';
            obstacle17.radius = 1;
            obstacle17.velocity = [0, 0]';

            %Machinery1
            obstacle18.type = "circle";
            obstacle18.center = [25, 13]';
            obstacle18.radius = 4;
            obstacle18.velocity = [0, 0]';
            %Machinery2
            obstacle19.type = "circle";
            obstacle19.center = [25, 2]';
            obstacle19.radius = 4;
            obstacle19.velocity = [0, 0]';
            %person
            obstacle20.type = "circle";
            obstacle20.center = [12, 23]';
            obstacle20.radius = 1;
            obstacle20.velocity = [0, -1]'; % (1 m/s)


            %stock 1
            obstacle21.type = "circle";
            obstacle21.center = [0, 2]';
            obstacle21.radius = 1;
            obstacle21.velocity = [0, 0]';
            %stock2
            obstacle22.type = "circle";
            obstacle22.center = [0, 4]';
            obstacle22.radius = 1;
            obstacle22.velocity = [0, 0]';
            %stock3
            obstacle23.type = "circle";
            obstacle23.center = [0, -2]';
            obstacle23.radius = 1;
            obstacle23.velocity = [0, 0]';
            %stock3
            obstacle24.type = "circle";
            obstacle24.center = [0, -4]';
            obstacle24.radius = 1;
            obstacle24.velocity = [0, 0]';
            obstacles = {obstacle1, obstacle2, obstacle3, obstacle4, obstacle5, obstacle6, obstacle7,...
                obstacle8, obstacle9,obstacle10, obstacle11, obstacle12, obstacle13, obstacle14,...
                obstacle15, obstacle16, obstacle17, obstacle18, obstacle19, obstacle20, obstacle21,...
                obstacle22, obstacle23, obstacle24};
        otherwise
            x0 = [0 0 0 0]';
            obstacles = {};
    end
end

