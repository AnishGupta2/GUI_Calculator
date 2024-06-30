function Calculator()
    % Create main figure window
    mainFigure = figure('Name', 'CLL122 Calculator', 'NumberTitle', 'off', 'Position', [100, 100, 600, 600], 'Color', '#E1D2A6');

    % Main text
    uicontrol('Style', 'text', 'String', 'Department of Chemical Engineering IITD', 'FontSize', 13, 'FontWeight', 'bold', ...
              'BackgroundColor', '#E1D2A6', 'HorizontalAlignment', 'center', 'Position', [100, 410, 400, 40]);
    uicontrol('Style', 'text', 'String', 'CLL122 Calculator on PFR/CSTR/PBR Reactor', 'FontSize', 12, ...
              'BackgroundColor', '#E1D2A6', 'HorizontalAlignment', 'center', 'Position', [100, 395, 400, 30]);

    % Display Image
    axes('Position', [0.3, 0.8, 0.4, 0.175]); % Adjust size and location appropriately
    img = imread('logo.png'); % Ensure 'logo.png' is in MATLAB's current directory or provide full path
    imshow(img)
    % Display Image
    % axes('Units', 'normalized', 'Position', [0.3, 0.5, 0.4, 0.175]); % Adjust size and location appropriately
    % img = imread('logo.png'); % Ensure 'logo.png' is in MATLAB's current directory or provide full path
    % imshow(img, 'Parent', gca, 'Border', 'tight'); % Display the image in the current axes
    % fig=uifigure;
    % in=uiimage(fig);
    % in.ImageSource='logo.png';    

    % Information text
    infoText = sprintf('This calculator is designed for the course CLL122 and allows you to analyze PFR (Plug Flow Reactor), CSTR (Continuous Stirred Tank Reactor) and PBR (Packed Bed Reactor) with liquid or gas phase reactions.');
    uicontrol('Style', 'text', 'String', infoText, 'FontSize', 10, 'HorizontalAlignment', 'center', ...
              'Position', [50, 303, 500, 60], 'BackgroundColor', '#E1D2A6');

    % Project information
    projectText = sprintf('Project made by:');
    uicontrol('Style', 'text', 'String', projectText, 'FontSize', 12, 'HorizontalAlignment', 'center', ...
              'Position', [50, 65, 500, 50], 'BackgroundColor', '#E1D2A6');
              projectText = sprintf('Anish Gupta, Siddhant Jain, Suchir Kohli, Varaprasad');
    uicontrol('Style', 'text', 'String', projectText, 'FontSize', 12, 'HorizontalAlignment', 'center', ...
              'Position', [50, 45, 500, 50], 'BackgroundColor', '#E1D2A6');

    % Dropdown for reactor type
    reactorMenu = uicontrol('Style', 'popupmenu', 'String', {'PFR', 'CSTR','PBR'}, ...
                            'Position', [150, 225, 300, 40], 'FontSize', 12, 'BackgroundColor', '#b4a884');


    % Submit button
    submitButton = uicontrol('Style', 'pushbutton', 'String', 'Submit', ...
                             'Position', [250, 160, 100, 30],'BackgroundColor', '#b4a884', 'FontSize', 12, 'Callback', @submitCallback);

    function submitCallback(~, ~)
        selectedReactorIndex = get(reactorMenu, 'Value');
        selectedReactor = get(reactorMenu, 'String');
        reactorWindow(selectedReactor{selectedReactorIndex});
    end

    function reactorWindow(reactorType)
        % Create personalized reactor window based on the selected reactor type
        if strcmp(reactorType, 'PFR')
            pfrWindow();
        elseif strcmp(reactorType, 'CSTR')
            cstrWindow();
        elseif strcmp(reactorType, 'PBR')
            pbrWindow();
        end
    end

    function pfrWindow()
        % Create PFR reactor window
        pfrFigure = figure('Name', 'PFR Reactor Calculator', 'NumberTitle', 'off', 'Position', [200, 200, 600, 500], 'Color', 'white');
        uicontrol('Style', 'text', 'String', 'Welcome to the PFR Reactor Calculator', 'FontSize', 11, ...
                  'HorizontalAlignment', 'center', 'Position', [150, 460, 300, 30], 'BackgroundColor', 'white');
        
        uicontrol('Style', 'text', 'String', 'aA   +   bB   =>   cC   +   dD', 'FontSize', 11, ...
                  'HorizontalAlignment', 'center', 'Position', [150, 440, 300, 30], 'BackgroundColor', 'white');       


        % Input fields specific to CSTR reactor
        createInputField('Flow rate of A (mol/s):', 420, 'flowRateAEdit');
        createInputField('Flow rate of B (mol/s):', 390, 'flowRateBEdit');
        createInputField('Flow rate of C (mol/s):', 360, 'flowRateCEdit');
        createInputField('Flow rate of D (mol/s):', 330, 'flowRateDEdit');
        
        createInputField('Coefficient of A (a):', 300, 'volumeaEdit');
        createInputField('Coefficient of B (b):', 270, 'volumebEdit');
        createInputField('Coefficient of C (c):', 240, 'volumecEdit');
        createInputField('Coefficient of D (d):', 210, 'volumedEdit');
        createInputField('Volumetric flowrate:', 180, 'volumeEdit');
        createInputField('Rate Constant:', 150, 'rateconstant');

        
        % Dropdown for liquid or gas phase
        phaseMenu = uicontrol('Style', 'popupmenu', 'String', {'Liquid Phase', 'Gas Phase'}, ...
            'Position', [150, 50, 300, 40], 'FontSize', 12);
        createInputField('Gas Mole fraction of A:', 30, 'yaEdit')
        phaseValue = get(phaseMenu, 'Value');
        phaseStrings = get(phaseMenu, 'String');
        selectedPhase1 = phaseStrings{phaseValue};
        % Calculate button for CSTR reactor
        plotButton = uicontrol('Style', 'pushbutton', 'String', 'Calculate', ...
                               'Position', [250, 100, 90, 30], 'FontSize', 12, 'BackgroundColor', '#ADD8E6', 'Callback', @calculatePFR);

        function calculatePFR(~, ~)
            
            % Fetch input values specific to PFR reactor
            flowRateAEdit= str2double(get(findobj('Tag', 'flowRateAEdit'), 'String'));
            flowRateBEdit= str2double(get(findobj('Tag', 'flowRateBEdit'), 'String'));
            flowRateCEdit= str2double(get(findobj('Tag', 'flowRateCEdit'), 'String'));
            flowRateDEdit= str2double(get(findobj('Tag', 'flowRateDEdit'), 'String'));
            a = str2double(get(findobj('Tag', 'volumeaEdit'), 'String'));
            b = str2double(get(findobj('Tag', 'volumebEdit'), 'String'));
            c = str2double(get(findobj('Tag', 'volumecEdit'), 'String'));
            d = str2double(get(findobj('Tag', 'volumedEdit'), 'String'));

            ya = str2double(get(findobj('Tag', 'yaEdit'), 'String'));
            volume = str2double(get(findobj('Tag', 'volumeEdit'), 'String'));
            k = str2double(get(findobj('Tag', 'rateconstant'), 'String'));
            
            % Inside the calculatePFR function, after getting the selected phase value
            phaseValue = get(phaseMenu, 'Value');
            phaseStrings = get(phaseMenu, 'String');
            selectedPhase1 = phaseStrings{phaseValue};

            flowRateAEdit= flowRateAEdit(1);
            flowRateBEdit= flowRateBEdit(1);
            flowRateCEdit= flowRateCEdit(1);
            flowRateDEdit= flowRateDEdit(1);
            a = a(1);
            b = b(1);
            c = c(1);
            d = d(1);
            ya = ya(1);
            volume = volume(1);
            k = k(1);
            


            conversion = linspace(0.00001, 0.8, 100);
            
            Cao = flowRateAEdit/volume;
            thetaB = flowRateBEdit/flowRateAEdit;
            thetaC = flowRateCEdit/flowRateAEdit;
            thetaD = flowRateDEdit/flowRateAEdit;

            if flowRateAEdit == 0 & flowRateBEdit == 0;
                error('Inavalid Input')
           

            if strcmp(selectedPhase1, 'Liquid Phase')
                
                Ca = Cao*(1-conversion);
                Cb = Cao.*(thetaB - (b/a).*conversion);
                Cc = Cao.*(thetaC + (c/a).*conversion);
                Cd = Cao.*(thetaD + (d/a).*conversion);

                rA = k*(((Cao)^(a+b)) .* ((1-conversion).^(a)) .* (thetaB - (b/a).*conversion).^b);
                

                V = rA;
                F = @(t) (flowRateAEdit./((((Cao)^(a+b)) .* ((1-t).^(a)) .* (thetaB - (b/a).*t).^b)))/k;
                for i = 1:length(conversion)
                    V(i) = integral(F,0,conversion(i));
                end



                
                
                

                % Plot results
                figure;

                % Subplot 1: Levenspiel Plot (PFR)
                subplot(3,1,1);
                plot(conversion, (flowRateAEdit)./rA, 'b-');
                title('Levenspiel Plot (PFR)');
                xlabel('Conversion');
                ylabel('-Fa0 / rA (%)');
                
                % Subplot 2: Concentration vs Volume (PFR)
                subplot(3,1,2);
                plot(V, Ca, 'r-', V, Cb, 'g-', V, Cc, 'b-', V, Cd, 'k-');
                legend({'a', 'b', 'c', 'd'}, 'Location', 'northeast');
                title('Concentration vs Volume (PFR)');
                xlabel('Volume (L)');
                ylabel('Concentration (mol/L)');
                
                % Subplot 3: Conversion vs Volume (PFR)
                subplot(3,1,3);
                plot(conversion, V, 'r-');
                title('Conversion vs Volume (PFR)');
                ylabel('Volume (L)');
                xlabel('Conversion');
                
                % Adjust the size of the figure window
                set(gcf, 'Position', [100, 100, 800, 800]); % [left bottom width height]

                



            end

            if strcmp(selectedPhase1, 'Gas Phase')
                
                delta = (c/a + d/a - b/a - 1);
                epsilon = delta*ya;
                Ca = Cao.*(1-conversion)./(1+epsilon.*conversion);
                Cb = Cao.*(thetaB - (b/a).*conversion)./(1+epsilon.*conversion);
                Cc = Cao.*(thetaC + (c/a).*conversion)./(1+epsilon.*conversion);
                Cd = Cao.*(thetaD + (d/a).*conversion)./(1+epsilon.*conversion);
            
                rA = k.*((((Cao).^(a+b)) .* ((1-conversion).^(a)) .* ((thetaB - (b/a).*conversion).^b) ./ (1+epsilon.*conversion).^(a+b)));
                
                V = rA;
                F = @(t) (flowRateAEdit.*(1+epsilon.*t).^(a+b))./(k*(((Cao)^(a+b)) .* ((1-t).^(a)) .* (thetaB - (b/a).*t).^b));
                for i = 1:length(conversion)
                    V(i) = integral(F,0,conversion(i));
                end
                
                

                % Plot results
                

                figure;

                % Subplot 1: Levenspiel Plot (PFR)
                subplot(3,1,1);
                plot(conversion, (flowRateAEdit)./rA, 'b-');
                title('Levenspiel Plot (PFR)');
                xlabel('Conversion');
                ylabel('-Fa0 / rA (%)');
                
                % Subplot 2: Concentration vs Volume (PFR)
                subplot(3,1,2);
                plot(V, Ca, 'r-', V, Cb, 'g-', V, Cc, 'b-', V, Cd, 'k-');
                legend({'a', 'b', 'c', 'd'}, 'Location', 'northeast');
                title('Concentration vs Volume (PFR)');
                xlabel('Volume (L)');
                ylabel('Concentration (mol/L)');
                
                % Subplot 3: Conversion vs Volume (PFR)
                subplot(3,1,3);
                plot(conversion, V, 'r-');
                title('Conversion vs Volume (PFR)');
                ylabel('Volume (L)');
                xlabel('Conversion');
                
                % Adjust the size of the figure window
                set(gcf, 'Position', [100, 100, 800, 800]); % [left bottom width height]
            end            
        end
    end

    function cstrWindow()
        % Create CSTR reactor window
        cstrFigure = figure('Name', 'CSTR Reactor Calculator', 'NumberTitle', 'off', 'Position', [200, 200, 600, 500], 'Color', 'white');
        uicontrol('Style', 'text', 'String', 'Welcome to the CSTR Reactor Calculator', 'FontSize', 10.5, ...
                  'HorizontalAlignment', 'center', 'Position', [150, 460, 300, 30], 'BackgroundColor', 'white');
        uicontrol('Style', 'text', 'String', 'aA + bB => cC + dD', 'FontSize', 10.5, ...
                  'HorizontalAlignment', 'center', 'Position', [150, 440, 300, 30], 'BackgroundColor', 'white');

        % Input fields specific to CSTR reactor
        createInputField('Flow rate of A (mol/s):', 420, 'flowRateAEdit');
        createInputField('Flow rate of B (mol/s):', 390, 'flowRateBEdit');
        createInputField('Flow rate of C (mol/s):', 360, 'flowRateCEdit');
        createInputField('Flow rate of D (mol/s):', 330, 'flowRateDEdit');
        
        createInputField('Coefficient of A:', 300, 'volumeaEdit');
        createInputField('Coefficient of B:', 270, 'volumebEdit');
        createInputField('Coefficient of C:', 240, 'volumecEdit');
        createInputField('Coefficient of D:', 210, 'volumedEdit');
        createInputField('Volumetric flowrate:', 180, 'volumeEdit');
        createInputField('Rate Constant:', 150, 'rateconstant');
        createInputField('Expected Conversion:', 130, 'conve');


        % Display Image
        % axes('Units', 'normalized', 'Position', [0.3, 0.8, 0.4, 0.175]); % Adjust size and location appropriately
        % img = imread('cstr.png'); 
        % imshow(img, 'Parent', gca, 'Border', 'tight'); % Display the image in the current axes

% Adjust size and location appropriately
        


        % Dropdown for liquid or gas phase
        phaseMenu = uicontrol('Style', 'popupmenu', 'String', {'Liquid Phase', 'Gas Phase'}, ...
            'Position', [150, 50, 300, 40], 'FontSize', 12);
        createInputField('Gas Mole fraction of A:', 30, 'yaEdit');
        phaseValue = get(phaseMenu, 'Value');
        phaseStrings = get(phaseMenu, 'String');
        selectedPhase = phaseStrings{phaseValue};
        % Calculate button for CSTR reactor
        plotButton = uicontrol('Style', 'pushbutton', 'String', 'Calculate', ...
                               'Position', [250, 100, 90, 30], 'FontSize', 12, 'BackgroundColor', '#ADD8E6', 'Callback', @calculateCSTR);

        function calculateCSTR(~, ~)
            % Fetch input values specific to CSTR reactor
            flowRateAEdit= str2double(get(findobj('Tag', 'flowRateAEdit'), 'String'));
            flowRateBEdit= str2double(get(findobj('Tag', 'flowRateBEdit'), 'String'));
            flowRateCEdit= str2double(get(findobj('Tag', 'flowRateCEdit'), 'String'));
            flowRateDEdit= str2double(get(findobj('Tag', 'flowRateDEdit'), 'String'));
            a = str2double(get(findobj('Tag', 'volumeaEdit'), 'String'));
            b = str2double(get(findobj('Tag', 'volumebEdit'), 'String'));
            c = str2double(get(findobj('Tag', 'volumecEdit'), 'String'));
            d = str2double(get(findobj('Tag', 'volumedEdit'), 'String'));

            ya = str2double(get(findobj('Tag', 'yaEdit'), 'String'));
            volume = str2double(get(findobj('Tag', 'volumeEdit'), 'String'));
            k = str2double(get(findobj('Tag', 'rateconstant'), 'String'));
            conve = str2double(get(findobj('Tag', 'conve'), 'String'));


            flowRateAEdit= flowRateAEdit(1);
            flowRateBEdit= flowRateBEdit(1);
            flowRateCEdit= flowRateCEdit(1);
            flowRateDEdit= flowRateDEdit(1);
            a = a(1);
            b = b(1);
            c = c(1);
            d = d(1);
            ya = ya(1);
            volume = volume(1);
            k = k(1);
            conve = conve(1);

            % Inside the calculatePFR function, after getting the selected phase value
            phaseValue = get(phaseMenu, 'Value');
            phaseStrings = get(phaseMenu, 'String');
            selectedPhase = phaseStrings{phaseValue};

            
    

            conversion = linspace(0.00001, 0.8, 100);
            
            Cao = flowRateAEdit/volume;
            thetaB = flowRateBEdit/flowRateAEdit;
            thetaC = flowRateCEdit/flowRateAEdit;
            thetaD = flowRateDEdit/flowRateAEdit;

            if strcmp(selectedPhase, 'Liquid Phase')
                Ca = Cao*(1-conversion);
                Cb = Cao.*(thetaB - (b/a).*conversion);
                Cc = Cao.*(thetaC + (c/a).*conversion);
                Cd = Cao.*(thetaD + (d/a).*conversion);

                rA = k*(((Cao)^(a+b)) .* ((1-conversion).^(a)) .* (thetaB - (b/a).*conversion).^b);
                V = (flowRateAEdit .* conversion)./(rA);

                rA0 = k*(((Cao)^(a+b)) .* ((1-conve).^(a)) .* (thetaB - (b/a).*conve).^b);
                V0 = (flowRateAEdit .* conve)./(rA0);
                

            

                % Plot results
                figure;
                % Subplot 1: Levenspiel Plot 
                subplot(3,1,1);
                plot(conversion, (flowRateAEdit)./rA, 'b-');
                title('Levenspiel Plot (CSTR)');
                xlabel('Conversion');
                ylabel('-Fa0 / rA (%)');
                
                textString = sprintf('Volume (in L): %.2f', V0);
                annotation('textbox', [0.15, 0.90, 0.1, 0.1], 'String', textString, 'EdgeColor', 'none', 'FontSize', 14);
                % Subplot 2: Concentration vs Volume 
                subplot(3,1,2);
                plot(V, Ca, 'r-', V, Cb, 'g-', V, Cc, 'b-', V, Cd, 'k-');
                legend({'a', 'b', 'c', 'd'}, 'Location', 'northeast');
                title('Concentration vs Volume (CSTR)');
                xlabel('Volume (L)');
                ylabel('Concentration (mol/L)');
                
                % Subplot 3: Conversion vs Volume 
                subplot(3,1,3);
                plot(conversion, V, 'r-');
                title('Conversion vs Volume (CSTR)');
                ylabel('Volume (L)');
                xlabel('Conversion');
                
                % Adjust the size of the figure window
                set(gcf, 'Position', [100, 100, 800, 800]); % [left bottom width height]



            end

            if strcmp(selectedPhase, 'Gas Phase')
                delta = (c/a + d/a - b/a - 1);
                epsilon = delta*ya;
                Ca = Cao.*(1-conversion)./(1+epsilon.*conversion);
                Cb = Cao.*(thetaB - (b/a).*conversion)./(1+epsilon.*conversion);
                Cc = Cao.*(thetaC + (c/a).*conversion)./(1+epsilon.*conversion);
                Cd = Cao.*(thetaD + (d/a).*conversion)./(1+epsilon.*conversion);

                rA = k.*((((Cao).^(a+b)) .* ((1 -conversion).^(a)) .* ((thetaB - (b./a).*conversion).^b) ./ (1+epsilon.*conversion).^(a+b)));
                V = (flowRateAEdit .* conversion)./(rA);

                %rA0 = k*(-1*(((Cao)^(a+b)) * ((1-conve)^(a)) * ((thetaB - (b/a)*conve)^b) / (1+epsilon*conversion)^(a+b)));
                %V0 = (flowRateAEdit .* conversion)./(rA);
                
            

                % Plot results
                figure;
                % Subplot 1: Levenspiel Plot 
                subplot(3,1,1);
                plot(conversion, (flowRateAEdit)./rA, 'b-');
                title('Levenspiel Plot (CSTR)');
                xlabel('Conversion');
                ylabel('-Fa0 / rA (%)');
                
                % Subplot 2: Concentration vs Volume 
                %textString = sprintf('Volume (in L): %.2f', V0);
                %annotation('textbox', [0.15, 0.90, 0.1, 0.1], 'String', textString, 'EdgeColor', 'none', 'FontSize', 14);
                subplot(3,1,2);
                plot(V, Ca, 'r-', V, Cb, 'g-', V, Cc, 'b-', V, Cd, 'k-');
                legend({'a', 'b', 'c', 'd'}, 'Location', 'northeast');
                title('Concentration vs Volume (CSTR)');
                xlabel('Volume (L)');
                ylabel('Concentration (mol/L)');
                
                % Subplot 3: Conversion vs Volume 
                subplot(3,1,3);
                plot(conversion, V, 'r-');
                title('Conversion vs Volume (CSTR)');
                ylabel('Volume (L)');
                xlabel('Conversion');
                
                % Adjust the size of the figure window
                set(gcf, 'Position', [100, 100, 800, 800]); % [left bottom width height]
            end
           
        end
    end

    function pbrWindow()
        % Create PFR reactor window
        pbrFigure = figure('Name', 'PBR Reactor Calculator', 'NumberTitle', 'off', 'Position', [200, 200, 600, 500], 'Color', 'white');
        uicontrol('Style', 'text', 'String', 'Welcome to the PBR Reactor Calculator', 'FontSize', 11, ...
                  'HorizontalAlignment', 'center', 'Position', [150, 460, 300, 30], 'BackgroundColor', 'white');
        uicontrol('Style', 'text', 'String', 'aA + bB => cC + dD', 'FontSize', 11, ...
                  'HorizontalAlignment', 'center', 'Position', [150, 440, 300, 30], 'BackgroundColor', 'white');


        % Input fields specific to CSTR reactor
        createInputField('Flow rate of A (mol/s):', 420, 'flowRateAEdit');
        createInputField('Flow rate of B (mol/s):', 390, 'flowRateBEdit');
        createInputField('Flow rate of C (mol/s):', 360, 'flowRateCEdit');
        createInputField('Flow rate of D (mol/s):', 330, 'flowRateDEdit');
        
        createInputField('Coefficient of A:', 300, 'volumeaEdit');
        createInputField('Coefficient of B:', 270, 'volumebEdit');
        createInputField('Coefficient of C:', 240, 'volumecEdit');
        createInputField('Coefficient of D:', 210, 'volumedEdit');
        createInputField('Volumetric flowrate:', 180, 'volumeEdit');
        createInputField('Rate Constant:', 150, 'rateconstant');


        % Dropdown for liquid or gas phase
        phaseMenu = uicontrol('Style', 'popupmenu', 'String', {'Liquid Phase', 'Gas Phase'}, ...
            'Position', [150, 55, 300, 40], 'FontSize', 12);
        createInputField('Gas Mole fraction of A:', 30, 'yaEdit');
        phaseValue = get(phaseMenu, 'Value');
        phaseStrings = get(phaseMenu, 'String');
        selectedPhase = phaseStrings{phaseValue};
        % Calculate button for CSTR reactor
        plotButton = uicontrol('Style', 'pushbutton', 'String', 'Calculate', ...
                               'Position', [250, 105, 90, 30], 'FontSize', 12, 'BackgroundColor', '#ADD8E6', 'Callback', @calculatePBR);

        function calculatePBR(~, ~)
            % Fetch input values specific to PFR reactor
            flowRateAEdit= str2double(get(findobj('Tag', 'flowRateAEdit'), 'String'));
            flowRateBEdit= str2double(get(findobj('Tag', 'flowRateBEdit'), 'String'));
            flowRateCEdit= str2double(get(findobj('Tag', 'flowRateCEdit'), 'String'));
            flowRateDEdit= str2double(get(findobj('Tag', 'flowRateDEdit'), 'String'));
            a = str2double(get(findobj('Tag', 'volumeaEdit'), 'String'));
            b = str2double(get(findobj('Tag', 'volumebEdit'), 'String'));
            c = str2double(get(findobj('Tag', 'volumecEdit'), 'String'));
            d = str2double(get(findobj('Tag', 'volumedEdit'), 'String'));

            ya = str2double(get(findobj('Tag', 'yaEdit'), 'String'));
            volume = str2double(get(findobj('Tag', 'volumeEdit'), 'String'));
            k = str2double(get(findobj('Tag', 'rateconstant'), 'String'));

            phaseValue = get(phaseMenu, 'Value');
            phaseStrings = get(phaseMenu, 'String');
            selectedPhase = phaseStrings{phaseValue};
            

            flowRateAEdit= flowRateAEdit(1);
            flowRateBEdit= flowRateBEdit(1);
            flowRateCEdit= flowRateCEdit(1);
            flowRateDEdit= flowRateDEdit(1);
            a = a(1);
            b = b(1);
            c = c(1);
            d = d(1);
            ya = ya(1);
            volume = volume(1);
            k = k(1);
            


            conversion = linspace(0.00001, 0.8, 100);
            
            Cao = flowRateAEdit/volume;
            thetaB = flowRateBEdit/flowRateAEdit;
            thetaC = flowRateCEdit/flowRateAEdit;
            thetaD = flowRateDEdit/flowRateAEdit;

            if strcmp(selectedPhase, 'Liquid Phase')
                Ca = Cao*(1-conversion);
                Cb = Cao.*(thetaB - (b/a).*conversion);
                Cc = Cao.*(thetaC + (c/a).*conversion);
                Cd = Cao.*(thetaD + (d/a).*conversion);

                rA = k*(((Cao)^(a+b)) .* ((1-conversion).^(a)) .* (thetaB - (b/a).*conversion).^b);
                

                V = rA;
                F = @(t) (flowRateAEdit./((((Cao)^(a+b)) .* ((1-t).^(a)) .* (thetaB - (b/a).*t).^b)))/k;
                for i = 1:length(conversion)
                    V(i) = integral(F,0,conversion(i));
                end



                
                
                

                % Plot results
                figure;

                % Subplot 1: Levenspiel Plot (PFR)
                subplot(3,1,1);
                plot(conversion, (flowRateAEdit)./rA, 'b-');
                title('Levenspiel Plot (PBR)');
                xlabel('Conversion');
                ylabel('-Fa0 / rA (%)');
                
                % Subplot 2: Concentration vs Volume (PFR)
                subplot(3,1,2);
                plot(V, Ca, 'r-', V, Cb, 'g-', V, Cc, 'b-', V, Cd, 'k-');
                legend({'a', 'b', 'c', 'd'}, 'Location', 'northeast');
                title('Concentration vs Volume (PBR)');
                xlabel('Weight');
                ylabel('Concentration ');
                
                % Subplot 3: Conversion vs Volume (PFR)
                subplot(3,1,3);
                plot(conversion, V, 'r-');
                title('Conversion vs Weight (PBR)');
                ylabel('Weight');
                xlabel('Conversion');
                
                % Adjust the size of the figure window
                set(gcf, 'Position', [100, 100, 800, 800]); % [left bottom width height]

                



            end

            if strcmp(selectedPhase, 'Gas Phase')
                delta = (c/a + d/a - b/a - 1);
                epsilon = delta*ya;
                Ca = Cao.*(1-conversion)./(1+epsilon.*conversion);
                Cb = Cao.*(thetaB - (b/a).*conversion)./(1+epsilon.*conversion);
                Cc = Cao.*(thetaC + (c/a).*conversion)./(1+epsilon.*conversion);
                Cd = Cao.*(thetaD + (d/a).*conversion)./(1+epsilon.*conversion);

                rA = k.*((((Cao).^(a+b)) .* ((1-conversion).^(a)) .* ((thetaB - (b/a).*conversion).^b) ./ (1+epsilon.*conversion).^(a+b)));
                
                V = rA;
                F = @(t) (flowRateAEdit.*(1+epsilon.*t).^(a+b))./(k*(((Cao)^(a+b)) .* ((1-t).^(a)) .* (thetaB - (b/a).*t).^b));
                for i = 1:length(conversion)
                    V(i) = integral(F,0,conversion(i));
                end
                
                

                % Plot results
                

                figure;

                % Subplot 1: Levenspiel Plot (PFR)
                subplot(3,1,1);
                plot(conversion, (flowRateAEdit)./rA, 'b-');
                title('Levenspiel Plot (PBR)');
                xlabel('Conversion');
                ylabel('-Fa0 / rA (%)');
                
                % Subplot 2: Concentration vs Volume (PbR)
                subplot(3,1,2);
                plot(V, Ca, 'r-', V, Cb, 'g-', V, Cc, 'b-', V, Cd, 'k-');
                legend({'a', 'b', 'c', 'd'}, 'Location', 'northeast');
                title('Concentration vs Weight (PBR)');
                xlabel('Weight');
                ylabel('Concentration ');
                
                % Subplot 3: Conversion vs Volume (PFR)
                subplot(3,1,3);
                plot(conversion, V, 'r-');
                title('Conversion vs Volume (PBR)');
                ylabel('Weight');
                xlabel('Conversion');
                
                % Adjust the size of the figure window
                set(gcf, 'Position', [100, 100, 800, 800]); % [left bottom width height]
            end            
        end
    end

    function createInputField(label, yPos, varName)
        uicontrol('Style', 'text', 'String', label, 'FontSize', 12, ...
                  'HorizontalAlignment', 'left', 'Position', [50, yPos, 200, 20], 'BackgroundColor', 'white');
        uicontrol('Style', 'edit', 'String', '', 'FontSize', 12, 'Tag', varName, ...
                  'HorizontalAlignment', 'left', 'Position', [250, yPos, 100, 20], 'BackgroundColor', 'white');
    end
end