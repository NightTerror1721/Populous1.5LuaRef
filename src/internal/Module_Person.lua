---@meta


---@param person Thing
---@param tribe integer
---@return boolean
function is_person_selectable(person, tribe) end

---@param thing Thing
---@param arg1 integer
---@return boolean
function is_aod2_post_swoop_path_valid(thing, arg1) end

---@param spy Thing
---@return boolean
function is_spy_in_process_of_disguising(spy) end

---@param thing Thing
---@param arg1 integer
---@return boolean
function is_person_a_spy_disguised_as_me(thing, arg1) end

---@param person Thing
---@return boolean
function is_person_guarding(person) end

---@param person Thing
---@return boolean
function is_person_preaching(person) end

---@param person Thing
---@return boolean
function is_person_currently_praying_at_head(person) end

---@param person Thing
---@return boolean
function is_person_currently_attacking_a_building(person) end

---@param thing1 Thing
---@param thing2 Thing
---@return boolean
function is_aod2_swoop_path_valid(thing1, thing2) end

---@param person Thing
---@return boolean
function is_person_currently_watching_a_fight(person) end

---@param person Thing
---@param map_idx integer
---@return boolean
function is_person_guarding_map_idx(person, map_idx) end

---@return boolean
function is_a_new_wild_man_allowed() end

---@param person Thing
---@return boolean
function is_person_available_for_auto_employment(person) end

---@param elem MapElement
---@return boolean
function is_map_elem_waitable_on(elem) end

---@param freeThingInfo unknown
---@param thing Thing
---@return boolean
function is_free_space_point_waitable_on(freeThingInfo, thing) end

---@param thing1 Thing
---@param thing2 Thing
---@return boolean
function is_target_an_ally(thing1, thing2) end

---@param person Thing
---@return boolean
function is_person_in_any_vehicle(person) end

---@param person Thing
---@return boolean
function is_person_in_drum_tower(person) end

---@param person Thing
---@return boolean
function is_person_in_bldg_training(person) end

---@param person Thing
---@return boolean
function is_person_in_training_bldg(person) end

---@param thing Thing
---@return boolean
function is_thing_targetable(thing) end

---@param person Thing
---@param target Thing
---@return boolean
function is_person_valid_fight_target(person, target) end

---@param person Thing
---@param target Thing
---@return boolean
function is_person_valid_fight_target_for_person_type(person, target) end

---@param person Thing
---@param target Thing
---@return boolean
function is_person_airborne_valid_fight_target(person, target) end

---@param person Thing
---@return boolean
function is_person_in_fight_targetable_state(person) end

---@param person Thing
---@return boolean
function is_person_in_bldg_valid_preacher_target(person) end

---@param fighter Thing
---@return boolean
function is_fighter_in_valid_state(fighter) end

---@param person Thing
---@return boolean
function is_person_on_a_shape(person) end

---@param person Thing
---@return boolean
function is_person_on_a_building(person) end

---@param person Thing
---@return Thing
function is_person_on_a_shape_or_building(person) end

---@param person Thing
---@return boolean
function is_person_stationery(person) end

---@param person Thing
---@return boolean
function is_person_accepting_commands(person) end

---@param person Thing
---@return boolean
function is_person_in_boat(person) end

---@param person Thing
---@return boolean
function is_person_in_airship(person) end

---@param person Thing
---@return boolean
function is_person_driver_in_any_vehicle(person) end

---@param vehicle Thing
---@param person_model integer
---@return boolean
function does_vehicle_contain_given_person_model(vehicle, person_model) end

---@param person Thing
---@return integer
function get_person_unemployed_state(person) end

---@param spy Thing
---@return integer
function get_final_spy_disguise_owner(spy) end

---@param spy Thing
---@return integer
function get_spy_disguise_owner(spy) end

---@param aod Thing
---@param arg1 integer
---@param arg2 integer reference
---@param coords Coord2D
function get_aod2_path_info(aod, arg1, arg2, coords) end

---@param thing Thing
---@param arg1 integer
---@return Thing
function get_first_person_using_guard_beacon(thing, arg1) end

---@param person Thing
---@param out_coords Coord2D
---@return boolean
function get_nearest_valid_person_base_coord(person, out_coords) end

---@param person Thing
---@return integer
function get_person_top_state(person) end

---@param arg0 integer
---@param coords Coord2D
---@param arg2 integer
function set_near_people_suprised_by_player_event(arg0, coords, arg2) end

---@param aod Thing
---@param arg1 integer
---@param arg2 integer
function set_aod2_draw_info(aod, arg1, arg2) end

---@param spy Thing
---@param disguise_owner integer
function set_final_spy_disguise_owner(spy, disguise_owner) end

---@param spy Thing
---@param process integer
function set_spy_in_process_of_disguising(spy, process) end

---@param spy Thing
---@param disguise_owner integer
function set_spy_disguise_owner(spy, disguise_owner) end

---@param arg0 integer
function set_shamans_base_pos_toward_players_camera(arg0) end

---@param person Thing
---@param arg1 integer
function set_person_draw_info_by_ptai_with_airborne_checking(person, arg1) end

---@param person Thing
---@param arg1 integer
function set_person_varied_stand_or_cheer_anim(person, arg1) end

---@param person Thing
function set_person_cheering_speed_and_anim(person) end

---@param arg0 integer
---@param arg1 integer
function set_all_players_people_flag(arg0, arg1) end

---@param person Thing
function set_person_standing_speed_and_anim(person) end

---@param person Thing
function set_person_drowning_speed_and_anim(person) end

---@param person Thing
function set_person_running_speed_and_anim(person) end

---@param person Thing
function set_person_attacking_speed_and_anim(person) end

---@param person Thing
function set_person_working_speed_and_anim(person) end

---@param person Thing
---@param tribe integer
function set_person_last_damaging_player(person, tribe) end

---@param preacher Thing
function set_preacher_preaching(preacher) end

---@param thing Thing
---@param arg1 integer
---@param thing_out Thing reference
---@return integer
function set_selected_status_of_all_in_vehicle(thing, arg1, thing_out) end

---@param person Thing
---@return boolean
function set_person_top_state(person) end

---@param person Thing
---@param state integer
---@return boolean
function set_person_new_state(person, state) end

---@param person Thing
function set_person_lost_control(person) end

---@param person Thing
function set_person_fast_self_power_speed(person) end

---@param person Thing
function set_person_standing_anim(person) end

---@param person Thing
function set_person_drowning_anim(person) end

---@param person Thing
function set_person_running_anim(person) end

---@param person Thing
function set_person_fleeing_anim(person) end

---@param person Thing
function set_person_flying_anim(person) end

---@param person Thing
function set_person_working_anim(person) end

---@param person Thing
---@return boolean
function set_person_jumping_anim(person) end

---@param person Thing
function set_person_punching_anim(person) end

---@param person Thing
function set_person_flinching_anim(person) end

---@param person Thing
function set_person_pushing_anim(person) end

---@param person Thing
function set_person_pushed_anim(person) end

---@param person Thing
---@return integer
function set_person_sitting_anim(person) end

---@param person Thing
function set_person_kicking_anim(person) end

---@param person Thing
function set_special_person_fire_missile_anim(person) end

---@param person Thing
---@param coords Coord2D
function set_person_valid_curr_base_coord(person, coords) end

---@param person Thing
---@param flags integer
function set_special_move_case_flag(person, flags) end

---@param person Thing
function set_person_failed_navigation(person) end

---@param spy Thing
function unmask_spy(spy) end

---@param aod Thing
function explode_angel_of_death(aod) end

---@param thing Thing
---@return integer
function people_see_if_should_help_build_house(thing) end

---@param wildman Thing
---@param tribe integer
---@param coords Coord2D
---@return Thing
function convert_wild_man_into_brave(wildman, tribe, coords) end

---@param enemy Thing
---@return boolean
function check_enemy_presence_alert_triggering(enemy) end

---@param wildman_converted_effect Thing
---@param coords Coord2D
function create_wild_man_converted_effect(wildman_converted_effect, coords) end

---@param thing Thing
---@return boolean
function check_moving_thing_in_control(thing) end

---@param coords1 Coord2D
---@param coords2 Coord2D
---@param arg2 integer
---@param arg3 integer
---@return boolean
function search_map_for_drinking_point(coords1, coords2, arg2, arg3) end

---@param thing Thing
---@param arg1 integer
---@return Thing
function search_map_food_for_person(thing, arg1) end

---@param person Thing
---@param status integer
function change_persons_bldg_dwelling_status(person, status) end

---@param person Thing
---@param status integer
function change_persons_vehicle_occupancy_status(person, status) end

---@param person Thing
---@param flag boolean
function person_drop_carrying_wood(person, flag) end

---@param victim Thing
---@param damaging_tribe integer
---@param damage_value integer
---@param ignore_shield boolean|integer
function damage_person(victim, damaging_tribe, damage_value, ignore_shield) end

---@param target Thing
function validate_any_return_fire_target(target) end

---@param tribe integer
---@param coords Coord3D
---@return Thing
function create_brave_person_thing(tribe, coords) end

---@param person Thing
---@param arg1 bool
---@param point Coord2D
function person_goto_point(person, arg1, point) end
