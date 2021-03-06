% Design of Square Footing
clc;
clear all;
load input.mat
load value.mat
% All the variable are defined in their respective functions
disp("Design of square footing")
area_footing = area_footing(P,Sw,Sp);
[L,B]=L_B_footing(area_footing,b,d);
Net_upward_pressure = Net_upward_pressure(P,L,B);
disp("\n")
[d_moment,D_moment,Mux,Muy] = d_moment(Net_upward_pressure,L,B,d,b,fck,fy,Cc);
d_oneway_shear =  d_oneway_shear(L,B,b,d,fck,pt,D_moment,Net_upward_pressure);
d_twoway_shear = d_twoway_shear(L,B,b,d,d_oneway_shear,Net_upward_pressure,fck);
depth = [d_moment d_oneway_shear d_twoway_shear];
eff_d = max(depth)
Overall_D = round((eff_d+Cc+dia)/10)*10
eff_d_x = Overall_D-Cc
eff_d_y = eff_d_x-dia
disp("\n")
[Ast_x,Ast_y] =  Ast(L,B,fck,fy,Mux,Muy,eff_d_x,eff_d_y);
[Area_one_bar]=Area_one_bar(dia);
[No_of_Reinforced_Bars_x,No_of_Reinforced_Bars_y]=no_bars(Ast_x,Ast_y,Area_one_bar)
disp("\n")
[Development_length,Length_Available_of_Bars_x,Length_Available_of_Bars_y] = Development_length(L,B,b,d,fck,fy,dia,Sc);
disp("\n")
Bearing_stress(P,b,d,Overall_D,fck)
disp("\n")
disp("Cost Analysis of steel")
[Total_length_of_bars] = Total_length_of_bars(L,B,Sc,No_of_Reinforced_Bars_x,No_of_Reinforced_Bars_y);
[Weight_of_bar_per_meter,Total_weight_of_bars]=Weight_of_bar(dia,Total_length_of_bars);
Total_cost_of_steel = Cost_of_steel*Total_weight_of_bars;
printf("Total_cost_of_steel = Rs.%d \n",Total_cost_of_steel)
disp("\n")
disp("Cost Analysis of concrete")
[Volume_of_concrete] = Volume_of_concrete(L,B,Overall_D,dia,Total_length_of_bars);
[No_of_cement_bag,Volume_of_sand,Volume_of_coarse_aggregate] = Quantities(Volume_of_concrete,Ratio_cement,Ratio_sand,Ratio_coarse_aggregate,Volume_of_one_bag_cement);
Cost_of_total_cement_bags = Cost_of_concrete_bag*No_of_cement_bag
Cost_of_sand_per_cubic_meter = Cost_of_sand*Volume_of_sand
Cost_of_coarse_aggregate = Cost_of_coarse_aggregate*Volume_of_coarse_aggregate