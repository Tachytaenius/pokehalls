KrissHouse2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .InitializeRoom

.InitializeRoom:
	checkevent EVENT_INITIALIZED_EVENTS
	iftrue .SkipInizialization
	jumpstd initializeevents
.SkipInizialization
	return

BloodScript:
	jumptext .Text_ItLooksFresh
.Text_ItLooksFresh
	text "Blood. It looks"
	line "fresh."
	done

EmilyScript:
	pause 15
	opentext
	writetext .Text_WakeHerUp
	yesorno
	iffalse .Done
	setlasttalked 2
	appear 2
	disappear 3
	faceplayer
	writetext .Text_What
.loop
	buttonsound
	loadmenudata .Menu_DoWhat
	verticalmenu
	closewindow
	if_equal 1, .Result_1
	if_equal 2, .Result_2
	if_equal 4, .Result_4
.cont
	writetext .Text_PleaseHelpMeUp
	pause 30
	writetext .Text_Thanks
	setevent EVENT_105
	clearevent EVENT_106
	follownotexact PLAYER, 2
	writetext .Text_HeyWhatsThis
	giveitem CARD_KEY
.Done
	closetext
	end
.Text_PleaseHelpMeUp
	text "Please help me up."
	prompt
.Text_Thanks
	text "Thanks…"
	prompt
.Text_HeyWhatsThis
	text "Hey, what's this?"
	line "There's a key in"
	para "my pocket. Here."
	line "You're not wounded,"
	cont "so you take it."
	prompt
.Result_1
	writetext .Text_ImInPain
	jump .loop
.Text_ImInPain
	text "Uhn… my arm hurts."
	done
.Result_2
	writetext .Text_IDontKnow
	jump .loop
.Text_IDontKnow
	text "I don't know."
	done
.Result_4
	writetext .Text_IHaveNoIdea
	jump .cont
.Text_IHaveNoIdea
	text "I have no idea."
	prompt
.Text_WakeHerUp
	text "You see a girl,"
	line "maybe 14 or 15,"
	para "lying unconscious"
	line "against a tree."
	para "She has a bleeding"
	line "cut on her arm."
	para "She looks pale."
	
	para "Wake her up?"
	prompt
.Text_What
	text "H… huh? Ugh… ow…"
	done
.Menu_DoWhat
	db $40 ; flags
	db 00, 00 ; start coords
	db 11, 19 ; end coords
	dw .Menu_DoWhat2
	db 1 ; default option
.Menu_DoWhat2
	db $81 ; flags
	db 4 ; items
	db "Are you OK?@"
	db "Who are you?@"
	db "Can I help you?@"
	db "Where are we?@"
DoorScript:
	checkevent EVENT_105
	iffalse .fail
	disappear 4
	setevent EVENT_107
	jumptext .DoorWillOpen
.DoorWillOpen
	text "You open the door"
	line "with the Hell key."
	done
.fail
	jumptext .DoorWillNotOpen
.DoorWillNotOpen
	text "It is locked."
	done
HouseSign:
	checkevent EVENT_105
	iftrue .AdvancedHouseSign
	jumptext .Text_House
.AdvancedHouseSign
	opentext
	writetext .Text_House
	pause 5
	showemote EMOTE_FISH, 2, 15
	follownotexact PLAYER, 2
	jumptext .Text_WhatTheHeck
.Text_House
	text "The sign reads:"
	
	para "House of the Hell"
	line "Barons."
	done
.Text_WhatTheHeck
	text "What…?"
	done

WalkScript:
	jumpstd pokecenternurse

KrissHouse2F_MapEventHeader:: db 0, 0

.Warps: db 0

.CoordEvents: db 0

.BGEvents: db 1
	signpost 25, 27, SIGNPOST_READ, HouseSign

.ObjectEvents: db 11
	person_event SPRITE_KRIS, 7, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, WalkScript, EVENT_106
	person_event SPRITE_KRIS_BIKE, 7, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, EmilyScript, EVENT_105
	person_event SPRITE_FAMICOM, 25, 29, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, DoorScript, EVENT_107
	person_event SPRITE_SNES, 7, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 4, 29, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 0, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 1, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 3, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 7, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 12, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
	person_event SPRITE_SNES, 17, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, BloodScript, -1
