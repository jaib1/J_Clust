function [hide_spks_scat_wires] = hide_spks_wires(unit_pts, edit_cl, val, chan_disp, feature, hide_spks_scat_wires, Channel_Scatter)

%Description: This .m file is called via the 'Hide Spikes' toggle button in the main GUI, and depending on the toggle state, either 1) hides spikes 
%belonging to a paritcular cluster(s) on the 'Time_Scatter' axis by removing their cluster-associated color(s), or 2) reveals cluster(s) that have 
%been hidden
%
%Input: 'unit_pts' = points belonging to all current units,  'edit_cl' = vector containing info on which cluster(s) to hide, 'val' = toggle state
%of 'Hide Cluster' button, 'chan_disp' = current channels displayed on axis, 'feature' = current feature displayed on axis, 'hide_spks_scat_wires' = 
%scatter plot that hides spikes on axis, 'Channel_Scatter' = axis
%
%Output: 'unit_pts' = updated 'unit_pts'
%

cl_to_hide = find(edit_cl);

axes(Channel_Scatter)

if val
    hold on
    for i = 1:length(cl_to_hide)
        if cl_to_hide(i) > 13
            all_pts = [1:length(feature)];
            unit_pts_all = [];
            for j = 1:length(unit_pts)
                unit_pts_all = [unit_pts_all, unit_pts{j}];
            end
            cur_cl_to_hide = all_pts;
            cur_cl_to_hide(unit_pts_all) = [];
        elseif cl_to_hide(i) > 12
            cur_cl_to_hide = get_selected_pts();
        else
            cur_cl_to_hide = unit_pts{cl_to_hide(i)};
        end
        if length(chan_disp) > 2
            hide_spks_scat_wires{i} = scatter3(feature(chan_disp(1), cur_cl_to_hide), feature(chan_disp(2), cur_cl_to_hide), feature(chan_disp(3), cur_cl_to_hide), 36, 'w.');
        else %length(chan_disp) == 2
            hide_spks_scat_wires{i} = scatter(feature(chan_disp(1), cur_cl_to_hide), feature(chan_disp(2), cur_cl_to_hide), 36, 'w.');
        end
    end
    hold off
else
    for i = 1:length(cl_to_hide)
        delete(hide_spks_scat_wires{i});
    end
end

end