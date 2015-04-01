# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

department_list = [
  ['Undeclared', 'un'],
	['Computer Science','cs'],
	['Electrical and Computer Engineering','ece'],
	['Civil and Environmental Engineering','cee'],
	['Chemical and Biochemical Engineering','cbe'],
	['Mechanical and Industrial Engineering','mie'],
	['Biomedical Engineering','bme']
]
department_list.each do |title, abbreviation|
	Department.create(title:title,abbreviation:abbreviation)
	puts 'CREATED NEW DEPARTMENT: ' << title
end

user = CreateAdminService.new.call
puts 'CREATED USERS'

semester_list = [
	['Fall 2014', Date.new(2014, 8, 25), Date.new(2014, 12, 19)],
	['Spring 2015', Date.new(2015, 1, 19), Date.new(2015, 5, 15)],
	['Fall 2015', Date.new(2015, 8, 24), Date.new(2015, 12, 18)],
	['Spring 2016', Date.new(2016, 1, 18), Date.new(2016, 5, 13)]
]
semester_list.each do |title,start_date,end_date|
	Semester.create(title:title,start_date:start_date,end_date:end_date)
	puts 'CREATED NEW SEMESTER: ' << title
end

# Title
# Description
# Enrolled, Capacity
# Semester, Department
# Instructor 
# Course Number
# Monday, Tuesday, Wednesday, Thursday, Friday
course_list = [
	[
		'Computer Science I',
		'Computer Science I Description',
		0,100,
		1,2,
		2,
		1,
		true,false,true,false,true
	],
	[
		'Computer Science II',
		'Computer Science II Description',
		0,100,
		1,2,
		2,
		2,
		false,true,false,true,false
	],
	[
		'Database Systems',
		'Database Systems Description',
		0,100,
		4,2,
		3,
		3,
		false,false,true,false,false
	],
	[
		'Software Engineering Languages and Tools',
		'SELT Description',
		0,100,
		4,2,
		3,
		4,
		true,false,true,false,true
	]
]

course_list.each do |title,description,enrolled,capacity,semester,department,instructor,course_number,m,t,w,r,f|
	Course.create(title:title,description:description,enrolled:enrolled,capacity:capacity,semester_id:semester,department_id:department,instructor_id:instructor,course_number:course_number,m:m,t:t,w:w,r:r,f:f)	
	puts 'CREATED NEW COURSE: ' << title
end

category_list = [
	'Uncategorized',
	'Psychology',
	'Health',
	'Biographies',
	'Nonfiction',
	'Fiction'
]
category_list.each do |title| 
	Category.create(title:title)
	puts 'CREATED NEW CATEGORY: ' << title
end

book_list = [
	[
		'Animals in Translation: Using the Mysteries of Autism to Decode Animal Behavior',  
		'Temple Grandin, Catherine Johnson',
		358,
		'0156031442',
		1,
		'Harcourt',
		Date.new(2006,1,2)
	],
	[
		'Nudge: Improving Decisions About Health, Wealth, and Happiness',
		'Richard H. Thaler,Cass R. Sunstein',
		304,
		'0300122233',
		1,
		'Yale University Press',
		Date.new(2008,4,8)
	],
	[ 
		'Bettyville: A Memoir',
		'George Hodgman',
		288,
		'0525427201',
		3,
		'Viking',
		Date.new(2015,3,10)
	],
	[
		'Dead Wake: The Last Crossing of the Lusitania',
		'Erik Larson',
		488,
		'0307408868',
		3,
		'Crown',
		Date.new(2015,3,10)
	],
	[
		'The Wright Brothers',
		'David McCullough',
		368,
		'1476728747',
		3,
		'Simon and Schuster',
		Date.new(2015,5,5)
	]
]

home_description = [
	[
		'Welcome!',
		'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac dolor sed libero pretium suscipit ac vitae augue. Nunc viverra velit et sapien volutpat, eget semper felis cursus. Vivamus ac nunc auctor urna gravida euismod eu non dui. Etiam in scelerisque sem. Pellentesque laoreet erat ac nulla molestie placerat. Nam euismod sapien vel enim efficitur imperdiet. Suspendisse potenti. Phasellus ultrices consectetur varius. Proin massa mauris, consectetur quis tincidunt vitae, auctor a enim. Nunc finibus lacus quis iaculis posuere. Sed ac tellus dictum, semper dolor eu, feugiat diam. Ut id erat est. Vivamus convallis ex lorem, ut aliquam ex fermentum ac. Sed eget commodo elit. Proin ac pulvinar magna, sit amet cursus odio. Cras eu turpis nunc. '
	]
]
home_description.each do |title,description|
	Home.create(title:title, description:description)
	puts 'CREATED NEW HOME DESCRIPTION: ' << title
end 
