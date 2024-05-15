classdef SystemPlotter
    
    properties
        goalPos
        leaderPos
        followerPos
        leaderPred
        followerPred
        leaderParams
        followerParams
        obstaclesPos
        leaderLoadPos
        followerLoadPos
    end
    
    methods
        
        function obj = SystemPlotter(...
                leader_params, follower_params, x0_l, x0_f, N, obstacles)
            % eventually set to def parameters
            if nargin ~= 4
                obj.leaderParams = leader_params;
                obj.followerParams = follower_params;
            else
                obj.leaderParams.pos_color = "red";
                obj.leaderParams.pred_color = "magenta";
                obj.leaderParams.constraint_color = "yellow";
                obj.leaderParams.show_predictions = false;
                obj.leaderParams.keep_predictions = false;
                obj.leaderParams.show_constraints = false;
                obj.followerParams.pos_color = "blue";
                obj.followerParams.pred_color = "cyan";
                obj.followerParams.constraint_color = "green";
                obj.followerParams.show_predictions = false;
                obj.followerParams.show_constraints = false;
                obj.followerParams.keep_predictions = false;
                obj.leaderParams.robotShape = [];
                obj.followerParams.robotShape = [];
            end
            
            
            % create goal plot
            x_goal = [0;0];
            obj.goalPos = plot(x_goal(1), x_goal(2), ...
                "Marker", "x", "Color", "black");
             
            % create robot positions plot
            obj.leaderPos = plot(x0_l(1), x0_l(2), ...
                "Marker", "o", "Color", obj.leaderParams.pos_color);
            if ~isempty(x0_f)
                obj.followerPos = plot(x0_f(1), x0_f(2), ...
                    "Marker", "o", "Color", obj.followerParams.pos_color);
            end
            
            % eventually create robot predictions plot
            if obj.leaderParams.show_predictions
                obj.leaderPred = plot(x0_l(1)*ones([N,1]), x0_l(2)*ones([N,1]), ...
                    "Marker", "o", "Color", obj.leaderParams.pred_color);
            else
                obj.leaderPred = 0;
            end
            if obj.followerParams.show_predictions
                obj.followerPred = plot(x0_f(1)*ones([N,1]), x0_f(2)*ones([N,1]), ...
                    "Marker", "o", "Color", obj.followerParams.pred_color);
            else
                obj.followerPred = 0;
            end
            
            % draw the load, leader part
            if ~isempty(obj.leaderParams.robotShape)
                obj.leaderLoadPos = plot(...
                    polyshape(x0_l(1)+obj.leaderParams.robotShape(1,:),...
                              x0_l(2)+obj.leaderParams.robotShape(2,:)),...
                    'FaceColor',obj.leaderParams.pos_color,'FaceAlpha',0.5);
            else
                obj.leaderLoadPos = 0;
            end
            % follower part
            if ~isempty(obj.followerParams.robotShape)
                obj.followerLoadPos = plot(...
                    polyshape(x0_f(1)+obj.followerParams.robotShape(1,:),...
                              x0_f(2)+obj.followerParams.robotShape(2,:)),...
                    'FaceColor',obj.followerParams.pos_color,'FaceAlpha',0.5);
            else
                obj.followerLoadPos = 0;
            end
            
            % draw obstacles
            if ~isempty(obstacles)
                obj.obstaclesPos = plotObstacles(obstacles);
            end
            
            hold off;
            
            refreshdata;
            drawnow;
        end
        
        function updateLeaderPath(obj, x_now, x_pred)
            obj.leaderPos.XData = [obj.leaderPos.XData, x_now(1)];
            obj.leaderPos.YData = [obj.leaderPos.YData, x_now(2)];
            if obj.leaderParams.show_predictions
                if obj.leaderParams.keep_predictions
                    obj.leaderPred.XData = [obj.leaderPred.XData, x_pred(1, :)];
                    obj.leaderPred.YData = [obj.leaderPred.YData, x_pred(2, :)];
                else
                    obj.leaderPred.XData = x_pred(1, :);
                    obj.leaderPred.YData = x_pred(2, :);
                end
            end
        end
        
        function updateFollowerPath(obj, x_now, x_pred)
            obj.followerPos.XData = [obj.followerPos.XData, x_now(1)];
            obj.followerPos.YData = [obj.followerPos.YData, x_now(2)];
            if obj.followerParams.show_predictions
                if obj.followerParams.keep_predictions
                    obj.followerPred.XData = [obj.followerPred.XData, x_pred(1, :)];
                    obj.followerPred.YData = [obj.followerPred.YData, x_pred(2, :)];
                else
                    obj.followerPred.XData = x_pred(1, :);
                    obj.followerPred.YData = x_pred(2, :);
                end
            end
        end
        
        function updateLoadPos(obj, x_now_l, x_now_f, loadTheta)
            obj.leaderLoadPos.Shape.Vertices = ...
                (x_now_l(1:2) + Rmat(loadTheta)*obj.leaderParams.robotShape)';
            obj.followerLoadPos.Shape.Vertices = ...
                 (x_now_f(1:2) + Rmat(loadTheta)*obj.followerParams.robotShape)';
        end
        
        function updateObstacles(obj, obstacles, to_redraw)
            for i = 1:to_redraw
                c = obstacles{i}.center;
                r = obstacles{i}.radius;
                obj.obstaclesPos{2*i-1}.XData = c(1);
                obj.obstaclesPos{2*i-1}.YData = c(2);
                l = length(obj.obstaclesPos{2*i}.Children(1).XData);
                th = (0:l-1)/l*2*pi;
                obj.obstaclesPos{2*i}.Children(1).XData = c(1)+r*cos(th);
                obj.obstaclesPos{2*i}.Children(1).YData = c(2)+r*sin(th);
                obj.obstaclesPos{2*i}.Children(2).XData = c(1)+r*cos(th);
                obj.obstaclesPos{2*i}.Children(2).YData = c(2)+r*sin(th);
            end
        end
        
        function redraw(obj)
            refreshdata;
            drawnow;
        end
    end
end

