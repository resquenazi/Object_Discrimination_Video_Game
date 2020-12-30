extends Node

var list = range(0,10)
var sample =[]
var distractor_object = []
var target_objects = []
var pics = []

var bowl = preload("res://Sprites/Objects/bowl.png")
var bread = preload("res://Sprites/Objects/bread.png")
var cheese_grater = preload("res://Sprites/Objects/cheese_grater.png")
var clock= preload("res://Sprites/Objects/clock.png")
var cup = preload("res://Sprites/Objects/cup.png")
var pot = preload("res://Sprites/Objects/pot.png")
var straws = preload("res://Sprites/Objects/straws.png")
var tissue_paper = preload("res://Sprites/Objects/tissue_paper.png")
var toilet_paper = preload("res://Sprites/Objects/toilet_paper.png")
var tooth_paste = preload("res://Sprites/Objects/tooth_paste.png")


var tex_ref_array = [bowl, bread, cheese_grater, clock, cup, pot, straws, tissue_paper,
 toilet_paper, tooth_paste]

func _ready():
	randomize()
	for i in range(4):
		var x = randi()%list.size()
		sample.append(list[x])
		list.remove(x)
	print("Array is " + str(sample))
	target_objects = sample.slice(0,2)
	print("Target objects are " + str(target_objects))
	distractor_object = sample[3]
	print("Distractor object is " + str(distractor_object))
	
	var path = "res://Sprites/Objects/size_15/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			#if !file_name.ends_with(".import"):
			pics.append(load(path + "/" + file_name))
	dir.list_dir_end()
	print(pics)
	

















#var alarm_clock_15 = preload("res://Sprites/Objects/size_15/ALARM_CLOCK_scFac_15_Rot_30.png")
#var book_15 = preload("res://Sprites/Objects/size_15/BOOK_scFac_15_Rot_34.png")
#var bowl_15 = preload("res://Sprites/Objects/size_15/BOWL_scFac_15_Rot_60.png")
#var cake_pan_15 = preload("res://Sprites/Objects/size_15/CAKE_PAN_scFac_15_Rot_29.png")
#var cd_15 = preload("res://Sprites/Objects/size_15/CD_scFac_15_Rot_51.png")
#var cheese_grater_15 = preload("res://Sprites/Objects/size_15/CHEESE_GRATER_scFac_15_Rot_38.png")
#var clock_15 = preload("res://Sprites/Objects/size_15/CLOCK_scFac_15_Rot_35.png")
#var cupcake_liners_15 = preload("res://Sprites/Objects/size_15/CUPCAKE_LINERS_scFac_15_Rot_37.png")
#var cup_15 = preload("res://Sprites/Objects/size_15/CUP_scFac_15_Rot_30.png")
#var cutting_board_15 = preload("res://Sprites/Objects/size_15/CUTTING_BOARD_scFac_15_Rot_13.png")
#var dish_towel_15 = preload("res://Sprites/Objects/size_15/DISH_TOWEL_scFac_15_Rot_33.png")
#var dvd_cover_15 = preload("res://Sprites/Objects/size_15/DVD_COVER_scFac_15_Rot_30.png")
#var egg_carton_15 = preload("res://Sprites/Objects/size_15/EGG_CARTON_scFac_15_Rot_39.png")
#var hairband_15 = preload("res://Sprites/Objects/size_15/HAIRBAND_scFac_15_Rot_9.png")
#var hat_15 = preload("res://Sprites/Objects/size_15/HAT_scFac_15_Rot_44.png")
#var helmet_15 = preload("res://Sprites/Objects/size_15/HELMET_scFac_15_Rot_52.png")
#var oven_mitt_15 = preload("res://Sprites/Objects/size_15/OVEN_MITT_scFac_15_Rot_39.png")
#var phone_15 = preload("res://Sprites/Objects/size_15/PHONE_scFac_15_Rot_27.png")
#var pillow_15 = preload("res://Sprites/Objects/size_15/PILLOW_scFac_15_Rot_8.png")
#var plate_15 = preload("res://Sprites/Objects/size_15/PLATE_scFac_15_Rot_25.png")
#var pot_15 = preload("res://Sprites/Objects/size_15/POT_scFac_15_Rot_22.png")
#var remote_control_15 = preload("res://Sprites/Objects/size_15/REMOTE_CONTROL_scFac_15_Rot_13.png")
#var rolling_pin_15 = preload("res://Sprites/Objects/size_15/ROLLING_PIN_scFac_15_Rot_1.png")
#var ruler_15 = preload("res://Sprites/Objects/size_15/RULER_scFac_15_Rot_7.png")
#var sandal_15 = preload("res://Sprites/Objects/size_15/SANDAL_scFac_15_Rot_55.png")
#var soap_dispenser_15 = preload("res://Sprites/Objects/size_15/SOAP_DISPENSER_scFac_15_Rot_2.png")
#var strainer_15 = preload("res://Sprites/Objects/size_15/STRAINER_scFac_15_Rot_45.png")
#var tissue_box_15 = preload("res://Sprites/Objects/size_15/TISSUE_BOX_scFac_15_Rot_3.png")
#var toast_15 = preload("res://Sprites/Objects/size_15/TOAST_scFac_15_Rot_47.png")
#var toilet_brush_15 = preload("res://Sprites/Objects/size_15/TOILET_BRUSH_scFac_15_Rot_18.png")
#var toilet_paper_15 = preload("res://Sprites/Objects/size_15/TOILET_PAPER_ROLL_scFac_15_Rot_32.png")
#var toothpaste_bottle_15 = preload("res://Sprites/Objects/size_15/TOOTHPASTE_BOTTLE_scFac_15_Rot_34.png")
#var vase_15 = preload("res://Sprites/Objects/size_15/VASE_scFac_15_Rot_45.png")
#var washcloth_15 = preload("res://Sprites/Objects/size_15/WASHCLOTH_scFac_15_Rot_48.png")

#var tex_ref_array_15 = [alarm_clock_15, book_15, bowl_15, cake_pan_15, cd_15, cheese_grater_15,
#clock_15, cupcake_liners_15, cup_15, cutting_board_15, dish_towel_15, dvd_cover_15, 
#egg_carton_15, hairband_15, hat_15, helmet_15, oven_mitt_15, phone_15, pillow_15,
#plate_15, pot_15, remote_control_15, rolling_pin_15, ruler_15, sandal_15, soap_dispenser_15,
#strainer_15, tissue_box_15, toast_15, toilet_brush_15, toilet_paper_roll_15, toothpaste_bottle_15,
#vase_15, washcloth_15]

#var alarm_clock_19 = preload("res://Sprites/Objects/size_19/ALARM_CLOCK_scFac_19_Rot_12.png")
#var book_19 = preload("res://Sprites/Objects/size_19/BOOK_scFac_19_Rot_56.png")
#var bowl_19 = preload("res://Sprites/Objects/size_19/BOWL_scFac_19_Rot_1.png")
#var cake_pan_19 = preload("res://Sprites/Objects/size_19/CAKE_PAN_scFac_19_Rot_49.png")
#var cd_19 = preload("res://Sprites/Objects/size_19/CD_scFac_19_Rot_45.png")
#var cheese_grater_19 = preload("res://Sprites/Objects/size_19/CHEESE_GRATER_scFac_19_Rot_40.png")
#var clock_19 = preload("res://Sprites/Objects/size_19/CLOCK_scFac_19_Rot_56.png")
#var cupcake_liners_19 = preload("res://Sprites/Objects/size_19/CUPCAKE_LINERS_scFac_19_Rot_22.png")
#var cup_19 = preload("res://Sprites/Objects/size_19/CUP_scFac_19_Rot_51.png")
#var cutting_board_19 = preload("res://Sprites/Objects/size_19/CUTTING_BOARD_scFac_19_Rot_9.png")
#var dish_towel_19 = preload("res://Sprites/Objects/size_19/DISH_TOWEL_scFac_19_Rot_42.png")
#var dvd_cover_19 = preload("res://Sprites/Objects/size_19/DVD_COVER_scFac_19_Rot_52.png")
#var egg_carton_19 = preload("res://Sprites/Objects/size_19/EGG_CARTON_scFac_19_Rot_26.png")
#var hairband_19 = preload("res://Sprites/Objects/size_19/HAIRBAND_scFac_19_Rot_10.png")
#var hat_19 = preload("res://Sprites/Objects/size_19/HAT_scFac_19_Rot_45.png")
#var helmet_19 = preload("res://Sprites/Objects/size_19/HELMET_scFac_19_Rot_48.png")
#var oven_mitt_19 = preload("res://Sprites/Objects/size_19/OVEN_MITT_scFac_19_Rot_2.png")
#var phone_19 = preload("res://Sprites/Objects/size_19/PHONE_scFac_19_Rot_4.png")
#var pillow_19 = preload("res://Sprites/Objects/size_19/PILLOW_scFac_19_Rot_60.png")
#var plate_19 = preload("res://Sprites/Objects/size_19/PLATE_scFac_19_Rot_28.png")
#var pot_19 = preload("res://Sprites/Objects/size_19/POT_scFac_19_Rot_4.png")
#var remote_control_19 = preload("res://Sprites/Objects/size_19/REMOTE_CONTROL_scFac_19_Rot_54.png")
#var rolling_pin_19 = preload("res://Sprites/Objects/size_19/ROLLING_PIN_scFac_19_Rot_54.png")
#var ruler_19 = preload("res://Sprites/Objects/size_19/RULER_scFac_19_Rot_60.png")
#var sandal_19 = preload("res://Sprites/Objects/size_19/SANDAL_scFac_19_Rot_41.png")
#var soap_dispenser_19 = preload("res://Sprites/Objects/size_19/SOAP_DISPENSER_scFac_19_Rot_57.png")
#var strainer_19 = preload("res://Sprites/Objects/size_19/STRAINER_scFac_19_Rot_34.png")
#var tissue_box_19 = preload("res://Sprites/Objects/size_19/TISSUE_BOX_scFac_19_Rot_31.png")
#var toast_19 = preload("res://Sprites/Objects/size_19/TOAST_scFac_19_Rot_55.png")
#var toilet_brush_19 = preload("res://Sprites/Objects/size_19/TOILET_BRUSH_scFac_19_Rot_45.png")
#var toilet_paper_roll_19 = preload("res://Sprites/Objects/size_19/TOILET_PAPER_ROLL_scFac_19_Rot_44.png")
#var toothpaste_bottle_19 = preload("res://Sprites/Objects/size_19/TOOTHPASTE_BOTTLE_scFac_19_Rot_24.png")
#var vase_19 = preload("res://Sprites/Objects/size_19/VASE_scFac_19_Rot_7.png")
#var washcloth_19 = preload("res://Sprites/Objects/size_19/WASHCLOTH_scFac_19_Rot_45.png")

#var tex_ref_array_19 = [alarm_clock_19, book_19, bowl_19, cake_pan_19, cd_19, cheese_grater_19,
#clock_19, cupcake_liners_19, cup_19, cutting_board_19, dish_towel_19, dvd_cover_19, 
#egg_carton_19, hairband_19, hat_19, helmet_19, oven_mitt_19, phone_19, pillow_19,
#plate_19, pot_19, remote_control_19, rolling_pin_19, ruler_19, sandal_19, soap_dispenser_19,
#strainer_19, tissue_box_19, toast_19, toilet_brush_19, toilet_paper_roll_19, toothpaste_bottle_19,
#vase_19, washcloth_19]
