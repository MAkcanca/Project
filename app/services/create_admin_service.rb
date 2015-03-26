class CreateAdminService
  def call
    admin = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |admin|
      admin.first_name = Rails.application.secrets.admin_first_name
			admin.last_name = Rails.application.secrets.admin_last_name
      admin.password = Rails.application.secrets.admin_password
      admin.password_confirmation = Rails.application.secrets.admin_password
			admin.department_id = Rails.application.secrets.department_id
      admin.admin!
    end
    instructor = User.find_or_create_by!(email: Rails.application.secrets.instructor_email) do |instructor|
      instructor.first_name = Rails.application.secrets.instructor_first_name
			instructor.last_name = Rails.application.secrets.instructor_last_name
      instructor.password = Rails.application.secrets.instructor_password
      instructor.password_confirmation = Rails.application.secrets.instructor_password
			instructor.department_id = Rails.application.secrets.department_id
      instructor.instructor!
    end
    instructor2 = User.find_or_create_by!(email: Rails.application.secrets.instructor2_email) do |instructor2|
      instructor2.first_name = Rails.application.secrets.instructor2_first_name
			instructor2.last_name = Rails.application.secrets.instructor2_last_name
      instructor2.password = Rails.application.secrets.instructor2_password
      instructor2.password_confirmation = Rails.application.secrets.instructor2_password
			instructor2.department_id = Rails.application.secrets.department_id
      instructor2.instructor!
    end
    librarian = User.find_or_create_by!(email: Rails.application.secrets.librarian_email) do |librarian|
      librarian.first_name = Rails.application.secrets.librarian_first_name
			librarian.last_name = Rails.application.secrets.librarian_last_name
      librarian.password = Rails.application.secrets.librarian_password
      librarian.password_confirmation = Rails.application.secrets.librarian_password
			librarian.department_id = Rails.application.secrets.department_id
      librarian.librarian!
    end
    student = User.find_or_create_by!(email: Rails.application.secrets.student_email) do |student|
      student.first_name = Rails.application.secrets.student_first_name
			student.last_name = Rails.application.secrets.student_last_name
      student.password = Rails.application.secrets.student_password
      student.password_confirmation = Rails.application.secrets.student_password
			student.department_id = Rails.application.secrets.department_id
      student.student!
    end    
		student2 = User.find_or_create_by!(email: Rails.application.secrets.student2_email) do |student2|
      student2.first_name = Rails.application.secrets.student2_first_name
			student2.last_name = Rails.application.secrets.student2_last_name
      student2.password = Rails.application.secrets.student2_password
      student2.password_confirmation = Rails.application.secrets.student2_password
			student2.department_id = Rails.application.secrets.department_id
      student2.student!
    end

  end
end
