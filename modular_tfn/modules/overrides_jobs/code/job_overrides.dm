// Anarch Jobs
/datum/job/vampire/baron
	exp_requirements = 1200
	exp_required_type = EXP_TYPE_ANARCH
	exp_required_type_department = EXP_TYPE_ANARCH
	exp_granted_type = EXP_TYPE_ANARCH

/datum/job/vampire/reeve
	exp_requirements = 900
	exp_required_type = EXP_TYPE_ANARCH
	exp_required_type_department = EXP_TYPE_ANARCH
	exp_granted_type = EXP_TYPE_ANARCH

/datum/job/vampire/bruiser
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_ANARCH

/datum/job/vampire/emissary
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_ANARCH

/datum/job/vampire/sweeper
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_ANARCH

/datum/job/vampire/tapster
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_ANARCH

// Camarilla Jobs
/datum/job/vampire/primogen_banu
	exp_requirements = 1200

/datum/job/vampire/primogen_toreador
	exp_requirements = 1200

/datum/job/vampire/primogen_ventrue
	exp_requirements = 1200

/datum/job/vampire/primogen_nosferatu
	exp_requirements = 1200

/datum/job/vampire/primogen_brujah
	exp_requirements = 1200

/datum/job/vampire/primogen_malkavian
	exp_requirements = 1200

/datum/job/vampire/hound
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA

/datum/job/vampire/harpy
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA

/datum/job/vampire/towerwork
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_CAMARILLA

/datum/job/vampire/clerk
	exp_requirements = 1200

/datum/job/vampire/sheriff
	exp_requirements = 900

// Clinic Jobs
/datum/job/vampire/clinic_director
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CLINIC
	exp_required_type_department = EXP_TYPE_CLINIC
	exp_granted_type = EXP_TYPE_CLINIC

/datum/job/vampire/doctor
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_CLINIC

// Garou Jobs
/datum/job/vampire/councillor
	exp_requirements = 1200

/datum/job/vampire/warder
	exp_requirements = 900

/datum/job/vampire/truthcatcher
	exp_requirements = 900

/datum/job/vampire/keeper
	exp_requirements = 0

/datum/job/vampire/guardian
	exp_requirements = 0

// Giovanni Jobs
/datum/job/vampire/capo
	exp_requirements = 1200
	exp_required_type = EXP_TYPE_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI
	exp_granted_type = EXP_TYPE_GIOVANNI

/datum/job/vampire/famiglia
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_GIOVANNI

/datum/job/vampire/squadra
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_GIOVANNI

// Hunter Jobs
#define EXP_TYPE_SOCIETY "Society of Leopold"

/datum/job/vampire/abbe
	exp_requirements = 900
	exp_required_type = EXP_TYPE_SOCIETY
	exp_required_type_department = EXP_TYPE_SOCIETY
	exp_granted_type = EXP_TYPE_SOCIETY

/datum/job/vampire/condottieri
	exp_requirements = 600
	exp_required_type = EXP_TYPE_SOCIETY
	exp_required_type_department = EXP_TYPE_SOCIETY
	exp_granted_type = EXP_TYPE_SOCIETY

/datum/job/vampire/inquisitor
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_SOCIETY

/datum/job/vampire/novice
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_SOCIETY

// Magadon Jobs
/datum/job/vampire/branch_lead
	exp_requirements = 1200
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL

	alt_titles = list(
		"Magadon Branch Lead",
		"Magadon Branch Director",
		"Magadon Regional Director",
		"Magadon Operations Director"
	)

/datum/job/vampire/affairs
	exp_requirements = 900
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL

/datum/job/vampire/secchief
	exp_requirements = 900
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL

/datum/job/vampire/executive
	exp_requirements = 900
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL

	alt_titles = list(
		"Magadon Executive",
		"Magadon Regional Manager",
		"Magadon Manager",
		"Magadon Marketing Director",
		"Magadon Public Relations Manager",
		"Magadon Deputy Branch Director",
		"Magadon Chief Innovation Officer",
		"Magadon Chief Science Officer",
		"Magadon Chief Financial Officer"
	)

/datum/job/vampire/pentex_sec
	exp_requirements = 600
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL

/datum/job/vampire/employee
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_SPIRAL

	alt_titles = list(
		"Magadon Employee",
		"Magadon Janitor",
		"Magadon Secretary",
		"Magadon Researcher",
		"Magadon Labourer"
	)

// Police Jobs
/datum/job/vampire/police_captain
	exp_requirements = 900
	exp_required_type = EXP_TYPE_POLICE
	exp_required_type_department = EXP_TYPE_POLICE
	exp_granted_type = EXP_TYPE_POLICE

/datum/job/vampire/dispatcher
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_POLICE

/datum/job/vampire/fbi
	exp_requirements = 300
	exp_required_type = EXP_TYPE_POLICE
	exp_required_type_department = EXP_TYPE_POLICE

/datum/job/vampire/police_sergeant
	exp_requirements = 600
	exp_required_type = EXP_TYPE_POLICE
	exp_required_type_department = EXP_TYPE_POLICE
	exp_granted_type = EXP_TYPE_POLICE

/datum/job/vampire/police_officer
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_POLICE

// Sabbat Jobs
/datum/job/vampire/sabbatductus
	exp_requirements = 1200
	exp_required_type = EXP_TYPE_SABBAT
	exp_required_type_department = EXP_TYPE_SABBAT
	exp_granted_type = EXP_TYPE_SABBAT

/datum/job/vampire/sabbatpack
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_SABBAT

/datum/job/vampire/sabbatpriest
	exp_requirements = 900
	exp_required_type = EXP_TYPE_SABBAT
	exp_required_type_department = EXP_TYPE_SABBAT
	exp_granted_type = EXP_TYPE_SABBAT

/datum/job/vampire/bishop
	exp_requirements = 1200
	exp_required_type = EXP_TYPE_SABBAT
	exp_required_type_department = EXP_TYPE_SABBAT
	exp_granted_type = EXP_TYPE_SABBAT

/datum/job/vampire/paladin
	exp_requirements = 600
	exp_required_type = EXP_TYPE_SABBAT
	exp_required_type_department = EXP_TYPE_SABBAT
	exp_granted_type = EXP_TYPE_SABBAT

/datum/job/vampire/true_sabbat
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_SABBAT

/datum/job/vampire/revenant
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_SABBAT

// Supply Jobs
/datum/job/vampire/setite
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_WAREHOUSE

/datum/job/vampire/setite/faithful
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_WAREHOUSE

/datum/job/vampire/setite/ward
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_WAREHOUSE

/datum/job/vampire/setite/faithful/high_priest
	exp_requirements = 900
	exp_required_type = EXP_TYPE_WAREHOUSE
	exp_required_type_department = EXP_TYPE_WAREHOUSE
	exp_granted_type = EXP_TYPE_WAREHOUSE

// Tremere Jobs
/datum/job/vampire/archivist
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_CHANTRY

/datum/job/vampire/gargoyle
	exp_requirements = 0
	exp_granted_type = EXP_TYPE_CHANTRY

/datum/job/vampire/regent
	exp_requirements = 1200
	exp_required_type = EXP_TYPE_CHANTRY
	exp_required_type_department = EXP_TYPE_CHANTRY
	exp_granted_type = EXP_TYPE_CHANTRY

#undef EXP_TYPE_SOCIETY
