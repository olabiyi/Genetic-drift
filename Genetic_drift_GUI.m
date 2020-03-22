function Genetic_drift_GUI

% This program builds a graphical user interface for simulating genetic
% drift of a population with any number of alleles of a fictional gene.
% Write the desired population size, number of alleles and number of
% generations in the edit boxes then click on the run push button.
%pushing the button plots the simulation of genetic drift in the axes. In
%the topmost axis to the left you have the simualtion of all alleles while
%in the botttom axis to the left you have the simulation of one allele. The
%bar graph to the right shows the mean generation time to fixation of
%population sizes 20,200,2000,20000 after a specified number of
%generations.

%clear the command window and all open figures
clc
close all %close all open figures

%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Unit','norm','Name', 'Genetic Drift GUI', 'Position', [0.05 0.02 0.85 0.85],'NumberTitle','off');

%constructing the components and getting the handles needed

%creating the alleles components
h_panel_alleles = uipanel('Unit','norm','Position',[0.02 0 0.48 0.99],...
    'backgroundColor',[0.8 0.8 0.8],'Tag','panel');
uicontrol('Parent',h_panel_alleles,'Style','text','Unit','norm',...
    'Position',[0 0.89 0.15 0.09],...
    'backgroundColor',[0.8 0.8 0.8],'String','Population Size','fontsize',8,...
    'fontWeight','bold','Tag', 'pop_size_text', 'callback', '');
h_pop_size = uicontrol('Parent',h_panel_alleles,'Style','edit','Unit','norm',...
    'Position',[0.14 0.92 0.12 0.06],...
    'backgroundColor',[1 1 1],'String','100','fontsize',10,'Value',100,...
    'fontWeight','bold', 'Tag', 'pop_size', 'callback', {@edit_boxes_callback});
uicontrol('Parent',h_panel_alleles,'Style','text','Unit','norm',...
    'Position',[0.27 0.9 0.2 0.08],...
    'backgroundColor',[0.8 0.8 0.8],'String','Number of generations','fontsize',8,...
    'fontWeight','bold','Tag','Number_gen_text', 'callback', '');
h_generation_number = uicontrol('Parent',h_panel_alleles,'Style','edit','Unit','norm',...
    'Position',[0.47 0.92 0.12 0.06],...
    'backgroundColor',[1 1 1],'String','100','fontsize',10,'Value',100,...
    'fontWeight','bold', 'Tag', 'number_of_gen', 'callback', {@edit_boxes_callback});

uicontrol('Parent',h_panel_alleles,'Style','text','Unit','norm',...
    'Position',[0.6 0.9 0.15 0.08],...
    'backgroundColor',[0.8 0.8 0.8],'String','Number of alleles','fontsize',8,...
    'fontWeight','bold','Tag','Number_allele_text', 'callback', '');
h_allele_number = uicontrol('Parent',h_panel_alleles,'Style','edit','Unit','norm',...
    'Position',[0.75 0.92 0.12 0.06],...
    'backgroundColor',[1 1 1],'String','7','fontsize',10, 'Value',7,...
    'fontWeight','bold', 'Tag', 'number_of_allele', 'callback', {@edit_boxes_callback});



h_axis_all_alleles = axes('Parent',h_panel_alleles,'Units','norm',...
    'Position',[0.15 0.58  0.8  0.259],'Tag','drift_axis');
h_axis_one_allele = axes('Parent',h_panel_alleles,'Units','norm',...
    'Position',[0.15 0.15  0.8  0.259],'Tag','drift_axis');
run_drift=uicontrol('Parent',h_panel_alleles,'Style','pushbutton',...
    'Unit','norm','Position',[0.89 0.92 0.1 0.07],...
    'backgroundColor',[0.8 0.8 0.8],'String','Run','fontsize',10,...
    'fontWeight','bold', 'Tag', 'run','UserData',1,'callback', {@run_Genetic_drift});
uicontrol('Parent',h_panel_alleles,'Style','pushbutton','Unit','norm',...
    'Position',[0.8 0.01 0.15 0.07],...
    'backgroundColor',[1 0 0],'String','Stop','fontsize',10,...
    'fontWeight','bold', 'Tag', 'Stop_allele', 'callback', {@stop_allele});

uicontrol('Parent',h_panel_alleles,'Style','pushbutton','Unit','norm',...
    'Position',[0.5 0.01 0.15 0.07],...
    'backgroundColor',[0.8 0.8 0.8],'String','Clear Axis','fontsize',10,...
    'fontWeight','bold', 'Tag', 'clear_axis', 'callback', {@clear_axis});


% creating the fixation time components
h_panel_fixation = uipanel('Unit','norm','Position',[0.52 0 0.46 0.99],...
    'backgroundColor',[0.8 0.8 0.8],'Tag','panel');
uicontrol('Parent',h_panel_fixation,'Style','text','Unit','norm',...
    'Position',[0 0.89 0.15 0.09],...
    'backgroundColor',[0.8 0.8 0.8],'String','Number of alleles','fontsize',8,...
    'fontWeight','bold','Tag', 'fix_allele_numbe_text', 'callback', '');
h_fix_allele_number = uicontrol('Parent',h_panel_fixation,'Style','edit','Unit','norm',...
    'Position',[0.14 0.92 0.12 0.06],...
    'backgroundColor',[1 1 1],'String','7','fontsize',10,'Value',7,...
    'fontWeight','bold', 'Tag', 'fix_allele_number', 'callback', {@edit_boxes_callback});
uicontrol('Parent',h_panel_fixation,'Style','text','Unit','norm',...
    'Position',[0.27 0.9 0.2 0.08],...
    'backgroundColor',[0.8 0.8 0.8],'String','Number of generations','fontsize',8,...
    'fontWeight','bold','Tag','fix_Number_gen_text', 'callback', '');
h_num_gen = uicontrol('Parent',h_panel_fixation,'Style','edit','Unit','norm',...
    'Position',[0.47 0.92 0.12 0.06],...
    'backgroundColor',[1 1 1],'String','1000','fontsize',10,'Value',1000,...
    'fontWeight','bold', 'Tag', 'fix_number_of_gen', 'callback', {@edit_boxes_callback});

uicontrol('Parent',h_panel_fixation,'Style','text','Unit','norm',...
    'Position',[0.6 0.9 0.15 0.08],...
    'backgroundColor',[0.8 0.8 0.8],'String','Number of repetitions','fontsize',8,...
    'fontWeight','bold','Tag','Number_of_rep_text', 'callback', '');
h_number_of_repititions = uicontrol('Parent',h_panel_fixation,'Style','edit','Unit','norm',...
    'Position',[0.75 0.92 0.12 0.06],...
    'backgroundColor',[1 1 1],'String','10','fontsize',10,'Value',10,...
    'fontWeight','bold', 'Tag', 'number_of_repetitions', 'callback', {@edit_boxes_callback});


h_axis_fixation = axes('Parent',h_panel_fixation,'Units','norm',...
    'Position',[0.1 0.15  0.8  0.7],'Tag','drift_axis');

run_fixat = uicontrol('Parent',h_panel_fixation,'Style','pushbutton',...
    'Unit','norm','Position',[0.89 0.92 0.1 0.07],...
    'backgroundColor',[0.8 0.8 0.8],'String','Go','fontsize',10,...
    'fontWeight','bold', 'Tag', 'Go','UserData',1, 'callback', {@run_fixation});

uicontrol('Parent',h_panel_fixation,'Style','pushbutton','Unit','norm',...
    'Position',[0.5 0.01 0.15 0.07],...
    'backgroundColor',[1 0 0],'String','Stop','fontsize',10,...
    'fontWeight','bold', 'Tag', 'Stop_fixation', 'callback', {@stop_fixation});
%create teh close button
uicontrol('Parent',h_panel_fixation,'Style','pushbutton',...
    'Unit','norm','Position',[0.83 0.01 0.16 0.07],...
    'backgroundColor',[0.8 0.8 0.8],'String','Close','fontsize',10,...
    'fontWeight','bold', 'Tag', 'close', 'callback', {@close_button_callback});

pop_size_vec = [20,200,2000,20000]; %population size vector for running fixation statistics

% Make the GUI visible.
set(f,'Color',[1 1 1],'Visible','on');

% Call back fuctions

%call back function for edit boxes
    function edit_boxes_callback(source,~)
        population_size = get(source,'String');
        value = str2double(population_size);
        set(source,'Value', ceil(value));
    end

%callback fuction for run button
    function run_Genetic_drift(source,~)
        set(source,'UserData',1)
        pop_size = get(h_pop_size,'Value');
        number_of_generations = get(h_generation_number,'Value');
        number_of_alleles = get(h_allele_number,'Value');
        
        if isnan(pop_size) == 1 || isnan(number_of_generations) || isnan(number_of_alleles)% check if there are enough input arguements for the simulation
            msgbox('All parameters must be entered','Error','error');% throw a message box if there are not enough input arguements
            return
        else
            axes_handle = [h_axis_all_alleles,h_axis_one_allele];
            tag_name = get(run_drift,'Tag');
            proportion_matrix= genetic_drift(pop_size,number_of_generations,number_of_alleles,tag_name);
            [~,col] = size(proportion_matrix);
            if isempty(proportion_matrix) == 1%if proportion matrix is empty
                return
            else
                if col == 2
                    cla(h_axis_all_alleles)% clear the top line plot axis if the there is only one allele
                end
                draw_plot(proportion_matrix,axes_handle(1),pop_size,number_of_generations)% draw plot of multiple alleles
                draw_plot(proportion_matrix(:,1:2),axes_handle(2),pop_size,number_of_generations)%draw plot of blue allele
            end
        end
        
    end

%callback fuction for Go button
    function run_fixation(source,~)
        set(source,'UserData',1)
        number_of_generations = get(h_num_gen,'Value');
        number_of_alleles = get(h_fix_allele_number,'Value');
        number_of_repetitions = get(h_number_of_repititions,'Value');
        
        if isnan(number_of_repetitions) == 1 || isnan(number_of_generations) || isnan(number_of_alleles)% check if there are enough input arguements for the simulation
            msgbox('All parameters must be entered','Error','error');% throw a message box if there are not enough input arguements
            return
        else
            axes_handle = h_axis_fixation;
            tag_name = get(run_fixat,'Tag');
            [avg_fix_vec,standard_error] = fixationStat(pop_size_vec,number_of_generations,...
                number_of_repetitions,number_of_alleles, tag_name);
            if isempty(avg_fix_vec)==1
                return
            else
                drawFixationBar(axes_handle,avg_fix_vec,standard_error, pop_size_vec)
            end
        end
    end

%stop allele simulation button callback
    function stop_allele(~,~)
        set(run_drift,'UserData',0)
    end
%clear single allele axis simulation button callback
    function clear_axis(~,~)
        cla(h_axis_one_allele)
    end
%stop fixation button callback
    function stop_fixation(~,~)
        set(run_fixat,'UserData',0)
    end
%call back function for the close button
    function close_button_callback(~,~)
        close(f)
    end
end