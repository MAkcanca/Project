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

occupation_list = [
	'Writer',				#1
	'Director',			#2
	'Producer',			#3
	'Screenwriter',	#4
	'Actor',				#5
	'Economist',		#6
	'Lawyer'				#7
]

occupation_list.each do |title|
	Occupation.create(title:title)
	puts 'CREATED NEW OCCUPATION: ' << title
end 

person_list = [
	['Temple Grandin',Date.new(1947,8,29), false, 1],				#1
	['Catherine Johnson',Date.new(1962,1,1), false, 1],			#2
	['Richard H. Thaler',Date.new(1945,9,12), true, 6],			#3
	['Cass R. Sunstein', Date.new(1954,9,21), true, 7],			#4
	['George Hodgman', Date.new(1956,1,1), true, 1],				#5
	['Erik Larson', Date.new(1954,1,3), true, 1],						#6
	['David McCullough', Date.new(1933,7,7), true, 1],			#7
	['Joss Whedon', Date.new(1964,6,23), true, 4],					#8
	['Kevin Feige', Date.new(1973,6,2), true, 2],						#9
	['Robert Downey Jr.', Date.new(1965,4,4), true, 5],			#10
	['Chris Evans', Date.new(1981,6,13), true, 5],					#11
	['Mark Ruffalo', Date.new(1967,11,22), true, 5],				#12
	['Chris Hemsworth', Date.new(1983,8,11), true, 5],			#13
	['Scarlett Johansson', Date.new(1984,11,22), false, 5],	#14
	['Jeremy Renner', Date.new(1971,1,7), true, 5],					#15
	['Tom Hiddleston', Date.new(1981,2,9), true, 5],				#16
	['Clark Gregg', Date.new(1962,4,2), true, 5],						#17
	['Cobie Smulders', Date.new(1982,4,3), false, 5],				#18
	['Stellan Skarsgard', Date.new(1951,6,13), true, 5],		#19
	['Samuel L. Jackson', Date.new(1948,12,21), true, 5]		#20
]
person_list.each do |name, birthday, sex, occupation_id|
	puts 'CREATED NEW PERSON: ' << name
	Person.create(full_name:name, birthday:birthday, sex:sex, occupation_id:occupation_id)
end
book_list = [
	[
		'Animals in Translation: Using the Mysteries of Autism to Decode Animal Behavior',  
		[1,2],
		358,
		'0156031442',
		1,
		'Harcourt',
		Date.new(2006,1,2)
	],
	[
		'Nudge: Improving Decisions About Health, Wealth, and Happiness',
		[3,4],
		304,
		'0300122233',
		1,
		'Yale University Press',
		Date.new(2008,4,8)
	],
	[ 
		'Bettyville: A Memoir',
		[5],
		288,
		'0525427201',
		3,
		'Viking',
		Date.new(2015,3,10)
	],
	[
		'Dead Wake: The Last Crossing of the Lusitania',
		[6],
		488,
		'0307408868',
		3,
		'Crown',
		Date.new(2015,3,10)
	],
	[
		'The Wright Brothers',
		[7],
		368,
		'1476728747',
		3,
		'Simon and Schuster',
		Date.new(2015,5,5)
	]
]
book_list.each do |title,author,pages,isbn,category_id,publisher,publish_date|
	Book.create(title:title, author:author, pages:pages, isbn:isbn, category_id:category_id, publisher:publisher, publish_date:publish_date)
	puts 'CREATED NEW BOOK: ' << title
end
movie_list = [
	[
		'The Avengers',
		[10,11,12,13,14,15,16,17,18,19,20],
		8,
		9,
		8
	]
]
movie_list.each do |title, cast, director, producer, screenplay_writer|
	Video.create(title:title,director:director,producer:producer,screenplay_writer:screenplay_writer,cast:cast)
	puts 'CREATED NEW MOVIE: ' << title
end

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
