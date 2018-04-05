def message_cost_calculator(count)
  message_cost = 0.025
  ((count * message_cost) * 100).to_i #cents
end


dallas    = ["Bryan Adamas High School", "Nancy Cochran Elementary School", "Julius Dorsey Elementary School"]
mesquite  = ["B.J. Smith Elementary", "Agnew Middle School", "West Mesquite High School"]
districts = {"Dallas ISD": dallas, "Mesquite ISD": mesquite}

#create districts
districts.each do |district_name, schools|
  district = District.create!(name: district_name)



  #create schools for district
  schools.each do |school_name|
    classrooms = []
    school     = district.schools.create!(name: school_name)



    #create students for a district and school
    100.times do
      student = Student.create!(name: Faker::Name.name)
      (1..3).to_a.shuffle.first.times do
        guardian = Guardian.create!(name: Faker::Name.name)
        StudentGuardian.create!(student_id: student.id, guardian_id: guardian.id, school_id: school.id, district_id: district.id)
      end

      SchoolStudent.create!(student_id: student.id, school_id: school.id, district_id: district.id)
    end



    #create teachers within current district & school
    (4..6).to_a.shuffle.first.times do
      teacher = Teacher.create!(name: Faker::Name.name)
      SchoolTeacher.create!(teacher_id: teacher.id, school_id: school.id, district_id: district.id)



      #assign students to teachers
      teacher.schools.each do |school|
        (14..23).to_a.shuffle.first.times do
          student_id = school.students.pluck(:id).sample
          TeacherStudent.create!(student_id: student_id, teacher_id: teacher.id)
        end
      end


      #create clasroom within current district, school, and teacher
      (5..7).to_a.shuffle.first.times do
        classroom = Classroom.create!(name: "#{Faker::ProgrammingLanguage.name} #{rand(1..4)}0#{rand(1..4)}")
        SchoolClassroom.create!(classroom_id: classroom.id, district_id: district.id, school_id: school.id, teacher_id: teacher.id)


        #assign students from within the current district, school, and teacher to classrooms
        student_ids = teacher.students.pluck(:id).to_a.shuffle
        (12..24).to_a.shuffle.first.times do
          student_id = student_ids.sample
          student_ids - [student_id]
          ClassroomStudent.create!(classroom_id: classroom.id, student_id: student_id, school_id: school.id, district_id: district.id)
        end
      end



      #send messages to guardians from the teacher
      teacher.classrooms.each do |classroom|
        students        = classroom.students
        teacher_message = teacher.messages.create!(body: Faker::RickAndMorty.quote, media_url: Faker::Fillmurray.image, classroom_id: classroom.id)
        send_count = 0

        students.each do |student|
          send_count += student.guardians.count
          student.guardians.each do |guardian|
            guardian.message_recipients.create!(message_id: teacher_message.id)
          end
        end

        total_message_cost = message_cost_calculator(send_count)
        teacher.message_invoices.create!(message_id: teacher_message.id, amount: total_message_cost, payer_id: teacher.id, payer_type: teacher.class.name)

      end

    end #end teachers



    #send messages to teachers from the school
    school_message     = school.messages.create!(body: Faker::DrWho.quote, media_url: Faker::Fillmurray.image)
    total_message_cost = message_cost_calculator(school.teachers.count)

    school.teachers.each do |teacher|
      teacher.message_recipients.create!(message_id: school_message.id)
    end

    school.message_invoices.create!(message_id: school_message.id, amount: total_message_cost, payer_id: school.id, payer_type: school.class.name)
  end #end schools



  #send messages to schools from the district
  district_message   = district.messages.create!(body: Faker::VentureBros.quote, media_url: Faker::Fillmurray.image)
  total_message_cost = message_cost_calculator(district.schools.count)

  district.schools.each do |school|
    school.message_recipients.create!(message_id: district_message.id)
  end

  district.message_invoices.create!(message_id: district_message.id, amount: total_message_cost, payer_id: district.id, payer_type: district.class.name)
end #end districts



#extras



#make a teachers invoice payable by the teachers school
teacher_message = Message.where(message_sendable_type: "Teacher").first
message_invoice = teacher_message.message_invoice
message_teacher = teacher_message.message_sendable
teacher_school  = message_teacher.schools.first

message_invoice.update!(payer_id: teacher_school.id, payer_type: teacher_school.class.name)



#now make the same invoice payable by the teachers district instead
message_invoice.update!(payer_id: teacher_school.district.id, payer_type: teacher_school.district.class.name)



#assign a teacher to all schools in their first district (nurses rotate)
teacher          = Teacher.first
teacher_district = teacher.districts.first
teacher_schools  = teacher.school_teachers.where(district_id: teacher_district.id)
new_school_ids   = teacher_district.schools.where.not(id: teacher_schools).pluck(:id)

new_school_ids.each do |id|
  SchoolTeacher.create!(teacher_id: teacher.id, school_id: id, district_id: teacher_district.id)
end





###
#district_methods

#list all schools assigned to the first district
District.first.schools

#list all teachers assigned to first district
District.first.teachers.uniq

#list all students assigned to first district
District.first.students.uniq

#list all guardians assigned to first district
District.first.guardians.uniq

#list all messages the district has sent
District.first.messages

#list all message invoices the district is assigned to pay
District.first.message_payers





###
#school methods

#show district school is assigned to
School.first.district

#list all teachers assigned to first district
School.first.teachers.uniq

#list all students assigned to first district
School.first.students.uniq

#list all guardians assigned to first district
School.first.guardians.uniq

#list all messages the school has sent
School.first.messages

#list all message invoices
School.first.message_invoices

#list all message invoices the school is assigned to pay
School.first.message_payers





###
#teacher methods

#list all schools a teacher is assigned to
Teacher.first.schools

#list all districts a teacher is assigned to
Teacher.first.districts.uniq

#list all students assigned to teacher
Teacher.first.students

#list all teacher classrooms
Teacher.first.classrooms

#list all teacher classrooms at first school
school        = Teacher.first.schools.first
classroom_ids = Teacher.first.school_classrooms.where(school_id: school.id).pluck(:classroom_id)
classrooms    = Classroom.where(id: classroom_ids)

#list all messages the teacher has sent
Teacher.first.messages

#list all message invoices
Teacher.first.message_invoices

#list all message invoices the teacher is assigned to pay
Teacher.first.message_payers





###
#student methods

#list all schools a student is assigned to
Student.first.schools

#list all districts a student is assigned to
Student.first.districts.uniq

#list all teachers assigned to student
Student.first.teachers.uniq

#list all student classrooms
Student.first.classrooms

#list all student classrooms at first school
school        = Student.first.schools.first
classroom_ids = Student.first.classroom_students.where(school_id: school.id).pluck(:classroom_id)
classrooms    = Classroom.where(id: classroom_ids)

#list all student guardians
Student.first.guardians





###
#guardian methods

#list all guardians students
Guardian.first.students

#list all messages received by the guardian
Guardian.first.messages

#list who sent a message
Guardian.first.messages.first.message_sendable

#list students the message applies to
guardian = Guardian.last
message  = guardian.messages.first
sender   = message.message_sendable
students = sender.class.name.constantize.find(sender.id).students.where(id: guardian.students.pluck(:id))





###
#classroom methods

#list all classroom districts
Classroom.first.districts

#list all classroom schools
Classroom.first.schools

#list all classroom teachers
Classroom.first.teachers

#list all classroom students
Classroom.first.students

#list all classroom messages
Classroom.first.messages





###
#message methods

#list all recipients
Message.first.message_recipients

#list message classroom (if applicable)
Message.first.classroom

#show message invoice
Message.first.message_invoice

#show who sent the message
Message.first.message_sendable
